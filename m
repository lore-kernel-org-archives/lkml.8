Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBC420748
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597051530;
	bh=hCWECxFulMLwx8A0QXoIH8ZqwiSK3iOXC6sfqduEbWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fWGDsS1SukQ9QKD5ocb37xcxISExYXcrExxswZ8Sd8k6qtJ3sVLzXdjkXCA3FZBcc
	 ibYqt5Df6yiWOb1rGWS3WGbAFLc6Onq9T4Eph4RqaR0qf5mNq/27mWJPMU78NL6aVe
	 fwIbjw1E+nLjcoGv6QLLsOxvoLZW+jopaJCykwLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHJJZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJJZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:25:28 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B385020709;
        Mon, 10 Aug 2020 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597051528;
        bh=hCWECxFulMLwx8A0QXoIH8ZqwiSK3iOXC6sfqduEbWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bhn8xKcrtJdNa0bXWMuLr2Op5DtNK695AGw2c3S/pEKU0OqAwwZPV6EnxjssOG5du
         J4YOikaRuyj2U/dBtc1ZdlqvfIg7xt9/haoz5NzjohEd5LiBwC0GFtLMo9+zh4dkSg
         xLc5D1H0LCMM7doOq46I3OI4IEtvVN8x3+Lfoqpk=
Date:   Mon, 10 Aug 2020 11:25:23 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, h@linux-8ccs
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200810092523.GA8612@linux-8ccs>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200808101222.5103093e@coco.lan>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Mauro Carvalho Chehab [08/08/20 10:12 +0200]:
[snip]
>Right now, what happens is:
>
>	# modprobe wlcore
>	modprobe: ERROR: could not insert 'wlcore': Exec format error
>
>This seems to be failing for all modules, as doesn't show anything
>probed.
>
>Btw, IMO, it would be useful to have some pr_debug() infra in order to
>explain why insmod is failing, or to have more error codes used there,
>as nothing was printed at dmesg. That makes harder to debug issues
>there. I ended losing a lot of time yesterday rebuilding the Kernel
>and checking the FS, before deciding to add some printks inside the
>Kernel ;-)
>
>In order for modprobe to start working again, I had to apply this
>dirty hack:
>
><hack>
>diff --git a/kernel/module.c b/kernel/module.c
>index 910a57640818..10d590dc48ad 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2051,11 +2051,12 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> 	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
> 	int i;
>
>+#if 0
> 	for (i = 0; i < hdr->e_shnum; i++) {
> 		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
> 			return -ENOEXEC;
> 	}
>-
>+#endif
> 	return 0;
> }
></hack>

All this hunk does it reject loading modules that have any sections
that have both the writable and executable flags. You're saying it's
happening for all modules on your setup - I am curious as to which
sections have both these flags - what does readelf -S tell you?

Thanks,

Jessica


