Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1122EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C058A20936
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIICUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 22:20:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbgIICUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:20:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 234CB22DEFA86AD3D325;
        Wed,  9 Sep 2020 10:20:07 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 10:20:02 +0800
Subject: Re: [PATCH v2 1/1] samples/seccomp: eliminate two compile warnings in
 user-trap.c
To:     Kees Cook <keescook@chromium.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200901083903.2083-1-thunder.leizhen@huawei.com>
 <20200901083903.2083-2-thunder.leizhen@huawei.com>
 <973a1752-7609-bac9-758a-1a977e6fb1f0@huawei.com>
 <202009081633.CC35635@keescook>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <06f11309-7088-f528-0779-ffa2efa210d1@huawei.com>
Date:   Wed, 9 Sep 2020 10:20:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202009081633.CC35635@keescook>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/9 7:42, Kees Cook wrote:
> On Wed, Sep 02, 2020 at 09:33:06AM +0800, Leizhen (ThunderTown) wrote:
>> On 2020/9/1 16:39, Zhen Lei wrote:
>>> samples/seccomp/user-trap.c is compiled with $(userccflags), and the
>>> latter does not contain -fno-strict-aliasing, so the warnings reported as
>>> below. Due to add "userccflags += -fno-strict-aliasing" will impact other
>>> files, so use __attribute__((__may_alias__)) to suppress it exactly.
>>>
>>> My gcc version is 5.5.0 20171010.
>>>
>>> ----------
>>> samples/seccomp/user-trap.c: In function ‘send_fd’:
>>> samples/seccomp/user-trap.c:50:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>>>   *((int *)CMSG_DATA(cmsg)) = fd;
>>>   ^
>>> samples/seccomp/user-trap.c: In function ‘recv_fd’:
>>> samples/seccomp/user-trap.c:83:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>>>   return *((int *)CMSG_DATA(cmsg));
>>>   ^
>>
>> Doesn't anyone care about this? Or is it that everyone hasn't encountered this problem?
>> Why do these two warnings occur every time I compiled?
> 
> Hi!
> 
> I think the samples have been a bit ignored lately because they have a
> lot of weird build issues with regard to native vs compat and needing
> the kernel headers to be built first, etc.
> 
> That said, yes, I'd like to fix warnings. However, I can't reproduce
> this. How are you building? I tried x86_64 and cross-compiled to i386.

I can reproduce it both on X86 and ARM64.

On X86:
make distclean allmodconfig
make -j64 2>err.txt
vi err.txt

$ arch
x86_64
$ ls -l samples/seccomp/user-trap
user-trap    user-trap.c
$ gcc -v
gcc version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu5~16.04)

On ARM64:
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- distclean allmodconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j64 2>err.tx
vi err.txt

$ ls -l samples/seccomp/user-trap
user-trap    user-trap.c
$ aarch64-linux-gnu-gcc -v
gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)
> 

