Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C15207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgE0WMv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:12:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57768 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE0WMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:12:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1je4I4-0007b5-Ch; Wed, 27 May 2020 16:12:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1je4I3-0001jf-FJ; Wed, 27 May 2020 16:12:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200527134911.1024114-1-arnd@arndb.de>
Date:   Wed, 27 May 2020 17:08:57 -0500
In-Reply-To: <20200527134911.1024114-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 27 May 2020 15:49:01 +0200")
Message-ID: <877dwx3u9y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1je4I3-0001jf-FJ;;;mid=<877dwx3u9y.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18PilCsXe1U+52ZzNR11cP33Nif/W5bnxU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] binfmt_elf_fdpic: fix execfd build regression
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The change to bprm->have_execfd was incomplete, leading
> to a build failure:
>
> fs/binfmt_elf_fdpic.c: In function 'create_elf_fdpic_tables':
> fs/binfmt_elf_fdpic.c:591:27: error: 'BINPRM_FLAGS_EXECFD' undeclared
>
> Change the last user of BINPRM_FLAGS_EXECFD in a corresponding
> way.
>
> Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> Fixes: b8a61c9e7b4a ("exec: Generic execfd support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I have no idea whether this is right, I only looked briefly at
> the commit that introduced the problem.

It is correct and my fault.

Is there an easy to build-test configuration that includes
binfmt_elf_fdpic?

I have this sense that it might be smart to unify binfmt_elf
and binftm_elf_fdpic to the extent possible, and that will take build
tests.

Eric



> ---
>  fs/binfmt_elf_fdpic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index bba3ad555b94..aaf332d32326 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -588,7 +588,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	nitems = 1 + DLINFO_ITEMS + (k_platform ? 1 : 0) +
>  		(k_base_platform ? 1 : 0) + AT_VECTOR_SIZE_ARCH;
>  
> -	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD)
> +	if (bprm->have_execfd)
>  		nitems++;
>  
>  	csp = sp;
