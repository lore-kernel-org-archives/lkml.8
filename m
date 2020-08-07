Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5826C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9709204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHGS3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:29:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34632 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:29:31 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=mussarela)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1k477H-0003VM-0J; Fri, 07 Aug 2020 18:29:19 +0000
Date:   Fri, 7 Aug 2020 15:29:11 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Chris Palmer <palmer@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Matt Denton <mpdenton@google.com>,
        Robert Sesek <rsesek@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>,
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/scm: Fix typo in SCM_RIGHTS compat refactoring
Message-ID: <20200807182911.GK4402@mussarela>
References: <202008071117.56ADE58@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008071117.56ADE58@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 11:20:05AM -0700, Kees Cook wrote:
> When refactoring the SCM_RIGHTS code, I accidentally mis-merged my
> native/compat diffs, which entirely broke using SCM_RIGHTS in compat
> mode. Use the correct helper.
> 
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Link: https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-August/216156.html
> Reported-by: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
> Link: https://lore.kernel.org/lkml/1596812929.lz7fuo8r2w.none@localhost/
> Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Fixes: c0029de50982 ("net/scm: Regularize compat handling of scm_detach_fds()")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi, Kees.

You might want to add the Teste-by line that Alex Xu sent. And if my ack adds
any value on top of Suggested-by, here it goes:

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Thanks.
Cascardo.

> ---
>  net/compat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/compat.c b/net/compat.c
> index 703acb51c698..95ce707a30a3 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -294,7 +294,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
>  		(struct compat_cmsghdr __user *)msg->msg_control;
>  	unsigned int o_flags = (msg->msg_flags & MSG_CMSG_CLOEXEC) ? O_CLOEXEC : 0;
>  	int fdmax = min_t(int, scm_max_fds_compat(msg), scm->fp->count);
> -	int __user *cmsg_data = CMSG_USER_DATA(cm);
> +	int __user *cmsg_data = CMSG_COMPAT_DATA(cm);
>  	int err = 0, i;
>  
>  	for (i = 0; i < fdmax; i++) {
> -- 
> 2.25.1
> 
> 
> -- 
> Kees Cook
