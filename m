Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD07CC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975712074D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU/k2AOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgC0CxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:53:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46551 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0CxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:53:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id u4so9405660qkj.13;
        Thu, 26 Mar 2020 19:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w4++N08RVpCiGlHmC7RmsL50uQ3EATHmFpjCdBVUENY=;
        b=hU/k2AOMFDZW0xf2BTOdavbWpT9pJTPn5Tt4E+qgd05wDRKScCPi5YUt4C2mnhe21M
         F21+rftavAYTzxByOFilILMoJbIE175BynuHXmWruxcIPbN7DOX5lP37uLkfw03+KgwX
         Hd6BSisFfdsCA5HA7M8BIN3ZC/NtCWP5FaZ1oxYDH4c1+/nhdFkEhy7PlRqWrzmtcwpk
         zOXU5VqpQRmPT/hkmdV4ORqorxMdaQ5EZC0LaPwLIBCNz1DGgckKhDKITXUsjwjQvXzv
         uc2lHt8V33efHdZYETB4LrqnYCrXVJfdrs30w1mBuqFvcqwvAPKZhSj+38hyZSz5uk73
         KH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w4++N08RVpCiGlHmC7RmsL50uQ3EATHmFpjCdBVUENY=;
        b=foXecZ+4/IvhRbuUEZBHC5j8rbd+PHQYQVJyPe9vbLnD5vR11WjDrHoY6dsYW5IMlV
         qMChK6Q+8ShAxj1rnLekcMvtUbiNo8SO8m5vZxH9pgOwowRBqFaJ7SE6EhxlDFR8Bal+
         WT4tTWI5E714X+cEwwQ5nWUpmaKu7jmdzvK1r9NXE8EDH5EWV1hSl56QefQzAxKjdazk
         3dUPpjVXKDkdmfoLULt9/lahaDJ8WZbQMZ4jyZnvzD25D7d0B4C4ccYUSGjXEmcX8Pvz
         SfI/G34y1j9Be2att5FNea39Vh60D5t/LgerNKPFKKNvB3bprsSehD4VEkyVKbvzzO8J
         vQGg==
X-Gm-Message-State: ANhLgQ0BRzmbIHB8GqE/0emA5T3ChLUK/OqbsXx9J4y5UoSZ16PX9QWt
        Kgs9bndYWKbodnfGyjlp+jg=
X-Google-Smtp-Source: ADFU+vsf/uspcYVH7mYPhpWkrWzKtSPs3tfZK62tZ0tvai+h5fvS+c9Q7eIoUvlSOoguHooVlFmCEw==
X-Received: by 2002:a37:e109:: with SMTP id c9mr12347525qkm.348.1585277596566;
        Thu, 26 Mar 2020 19:53:16 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 69sm2659196qki.131.2020.03.26.19.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 19:53:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id DB83F27C0054;
        Thu, 26 Mar 2020 22:53:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 26 Mar 2020 22:53:14 -0400
X-ME-Sender: <xms:mWp9XsCdBgR7RtDU8pZ5DqzQDRqDRyK9oPZwjHulUVZ8OUKMVKzWqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehjedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghes
    ghhmrghilhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephe
    dvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:mWp9XlUdsCleGvywe-HEdp0lhcdz8ahRrAVhkMS2RNi9lp0kii6i3Q>
    <xmx:mWp9XgzPzUq2vm3FSFBB4Eij0Wh9eL5ziWI-av4T62ScEu7919dMrg>
    <xmx:mWp9XghLzByYNCNeaUseak4SfsK3YDjdybxKrhr7y8vKiYd4LMVMiQ>
    <xmx:mmp9XniXl81qomo-VsCMXK2kITOVEIBnzCeBa9_mpZhkaNl1srVe7iNqNgw>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id D982F306B4EE;
        Thu, 26 Mar 2020 22:53:12 -0400 (EDT)
Date:   Fri, 27 Mar 2020 10:53:11 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        pkondeti@codeaurora.org, jpoimboe@redhat.com, pavel@ucw.cz,
        konrad.wilk@oracle.com, mojha@codeaurora.org, jkosina@suse.cz,
        mingo@kernel.org, hpa@zytor.com, rjw@rjwysocki.net
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:smp/hotplug] cpu/hotplug: Abort disabling secondary CPUs if
 wakeup is pending
Message-ID: <20200327025311.GA58760@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org>
 <tip-a66d955e910ab0e598d7a7450cbe6139f52befe7@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-a66d955e910ab0e598d7a7450cbe6139f52befe7@git.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Pavankumar,

I have a question about this patch, please see below:

On Wed, Jun 12, 2019 at 05:34:08AM -0700, tip-bot for Pavankumar Kondeti wrote:
> Commit-ID:  a66d955e910ab0e598d7a7450cbe6139f52befe7
> Gitweb:     https://git.kernel.org/tip/a66d955e910ab0e598d7a7450cbe6139f52befe7
> Author:     Pavankumar Kondeti <pkondeti@codeaurora.org>
> AuthorDate: Mon, 3 Jun 2019 10:01:03 +0530
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Wed, 12 Jun 2019 11:03:05 +0200
> 
> cpu/hotplug: Abort disabling secondary CPUs if wakeup is pending
> 
> When "deep" suspend is enabled, all CPUs except the primary CPU are frozen
> via CPU hotplug one by one. After all secondary CPUs are unplugged the
> wakeup pending condition is evaluated and if pending the suspend operation
> is aborted and the secondary CPUs are brought up again.
> 
> CPU hotplug is a slow operation, so it makes sense to check for wakeup
> pending in the freezer loop before bringing down the next CPU. This
> improves the system suspend abort latency significantly.
> 

From the commit message, it makes sense to add the pm_wakeup_pending()
check if freeze_secondary_cpus() is used for system suspend. However,
freeze_secondary_cpus() is also used in kexec path on arm64:

	kernel_kexec():
	  machine_shutdown():
	    disable_nonboot_cpus():
	      freeze_secondary_cpus()

, so I wonder whether the pm_wakeup_pending() makes sense in this
situation? Because IIUC, in this case we want to reboot the system
regardlessly, the pm_wakeup_pending() checking seems to be inappropriate
then.

I'm asking this because I'm debugging a kexec failure on ARM64 guest on
Hyper-V, and I got the BUG_ON() triggered:

[  108.378016] kexec_core: Starting new kernel
[  108.378018] Disabling non-boot CPUs ...
[  108.378019] Wakeup pending. Abort CPU freeze
[  108.378020] Non-boot CPUs are not disabled
[  108.378049] ------------[ cut here ]------------
[  108.378050] kernel BUG at arch/arm64/kernel/machine_kexec.c:154!

Thanks!

Regards,
Boqun

> [ tglx: Massaged changelog and improved printk message ]
> 
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: iri Kosina <jkosina@suse.cz>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Cc: linux-pm@vger.kernel.org
> Link: https://lkml.kernel.org/r/1559536263-16472-1-git-send-email-pkondeti@codeaurora.org
> 
> ---
>  kernel/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index be82cbc11a8a..0778249cd49d 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1221,6 +1221,13 @@ int freeze_secondary_cpus(int primary)
>  	for_each_online_cpu(cpu) {
>  		if (cpu == primary)
>  			continue;
> +
> +		if (pm_wakeup_pending()) {
> +			pr_info("Wakeup pending. Abort CPU freeze\n");
> +			error = -EBUSY;
> +			break;
> +		}
> +
>  		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
>  		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
>  		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
