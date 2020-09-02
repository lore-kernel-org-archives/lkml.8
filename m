Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02553206EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBBdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:33:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45418 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgIBBdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:33:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F2592F6DE85F97DE57CD;
        Wed,  2 Sep 2020 09:33:08 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Sep 2020
 09:33:06 +0800
Subject: Re: [PATCH v2 1/1] samples/seccomp: eliminate two compile warnings in
 user-trap.c
To:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200901083903.2083-1-thunder.leizhen@huawei.com>
 <20200901083903.2083-2-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <973a1752-7609-bac9-758a-1a977e6fb1f0@huawei.com>
Date:   Wed, 2 Sep 2020 09:33:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200901083903.2083-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't anyone care about this? Or is it that everyone hasn't encountered this problem?
Why do these two warnings occur every time I compiled?

On 2020/9/1 16:39, Zhen Lei wrote:
> samples/seccomp/user-trap.c is compiled with $(userccflags), and the
> latter does not contain -fno-strict-aliasing, so the warnings reported as
> below. Due to add "userccflags += -fno-strict-aliasing" will impact other
> files, so use __attribute__((__may_alias__)) to suppress it exactly.
> 
> My gcc version is 5.5.0 20171010.
> 
> ----------
> samples/seccomp/user-trap.c: In function ‘send_fd’:
> samples/seccomp/user-trap.c:50:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>   *((int *)CMSG_DATA(cmsg)) = fd;
>   ^
> samples/seccomp/user-trap.c: In function ‘recv_fd’:
> samples/seccomp/user-trap.c:83:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>   return *((int *)CMSG_DATA(cmsg));
>   ^
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  samples/seccomp/user-trap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> index 20291ec6489f31e..e36696b7f41517f 100644
> --- a/samples/seccomp/user-trap.c
> +++ b/samples/seccomp/user-trap.c
> @@ -23,6 +23,8 @@
>  
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
>  
> +typedef int __attribute__((__may_alias__)) __int_alias_t;
> +
>  static int seccomp(unsigned int op, unsigned int flags, void *args)
>  {
>  	errno = 0;
> @@ -47,7 +49,7 @@ static int send_fd(int sock, int fd)
>  	cmsg->cmsg_level = SOL_SOCKET;
>  	cmsg->cmsg_type = SCM_RIGHTS;
>  	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
> -	*((int *)CMSG_DATA(cmsg)) = fd;
> +	*(__int_alias_t *)CMSG_DATA(cmsg) = fd;
>  	msg.msg_controllen = cmsg->cmsg_len;
>  
>  	if (sendmsg(sock, &msg, 0) < 0) {
> @@ -80,7 +82,7 @@ static int recv_fd(int sock)
>  
>  	cmsg = CMSG_FIRSTHDR(&msg);
>  
> -	return *((int *)CMSG_DATA(cmsg));
> +	return *(__int_alias_t *)CMSG_DATA(cmsg);
>  }
>  
>  static int user_trap_syscall(int nr, unsigned int flags)
> 

