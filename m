Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B3C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EC221582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589042817;
	bh=RQCaGPcUSf2wX4c1mQUerOavb42qIV3tR7GhKSgNP2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2WII+GikbZ7sVCLmVOXxckN+MmidM7Gd3CyNP10rdORidqt41C/W1ZXPcmUpfb/K6
	 STvOI2+ndLpSsx/JBEXDiYPof/3TwKo4+MYMXwvL8+6L5equVi5VU3H4M4RYTndKiq
	 3OCMdsxd0HyErdgKHxWAXDmhh8PccMC6zU3n7Y8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgEIQq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 12:46:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38219 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgEIQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 12:46:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so2055693plt.5;
        Sat, 09 May 2020 09:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mhrQ8y2FH4n1dOBOxJ/uopAIZn1sf0TmroEx/VojIDc=;
        b=RpacMCyUatbwRSd3/t0CD4iSdOzpAvK/lmY34XQgGErk299eGshv8yU9aD0OxVfj3W
         OebRrg1S64YYaqA5IEl4fHDreoqeBIaCcqU/a/CI2dGtwYDaWJL+Azk3amG7MpuTlmNu
         hfmL8Lrz2kmv8BFOoirBYjFW63W1iKl4+1IDtxA7bKPc7EznbBdNlP+R2TVspWBhQui+
         m4j5OFjiVrkOfoWvptc/Ixp4v3D4GPNznCRz5xQ76tqkbOYXBwQIpBLrDMyHXFC0wygt
         Gn2C42D+DSKy9SRnR4Sh4VRGs+bwM1HIMgghuRCUmBMXpk2Cj+rWVuzO8LK+1uIivPFo
         WyXg==
X-Gm-Message-State: AGi0Puab0NNu903mesSgo9rDuDjQQfVYkNzfLmfYiU4T1pbW7+iX+3pS
        JFyoPBvzpX/RywXiJrjZN3k=
X-Google-Smtp-Source: APiQypJZKFXO25FoS2oviejDqu06AfiNGv3f/9UDCTAxJaP7/5DVk1cph6VUQwJ6SPGp0pET7i7Z9g==
X-Received: by 2002:a17:90a:22e8:: with SMTP id s95mr12239536pjc.219.1589042815749;
        Sat, 09 May 2020 09:46:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h12sm4001219pgi.5.2020.05.09.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 09:46:54 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id ACB9840605; Sat,  9 May 2020 16:46:53 +0000 (UTC)
Date:   Sat, 9 May 2020 16:46:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, cai@lca.pw,
        dyoung@redhat.com, bhe@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, gpiccoli@canonical.com, pmladek@suse.com,
        tiwai@suse.de, schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] taint: add module firmware crash taint support
Message-ID: <20200509164653.GK11244@42.do-not-panic.com>
References: <20200509043552.8745-1-mcgrof@kernel.org>
 <20200509043552.8745-2-mcgrof@kernel.org>
 <20200509151829.GB6704@x1-fbsd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509151829.GB6704@x1-fbsd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 11:18:29AM -0400, Rafael Aquini wrote:
> We are still missing the documentation bits for this
> new flag, though.

Ah yeah sorry about that.

> How about having a blurb similar to:
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 71e9184a9079..5c6a9e2478b0 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>   15  _/K   32768  kernel has been live patched
>   16  _/X   65536  auxiliary taint, defined for and used by distros
>   17  _/T  131072  kernel was built with the struct randomization plugin
> + 18  _/Q  262144  driver firmware crash annotation
>  ===  ===  ======  ========================================================
> 
>  Note: The character ``_`` is representing a blank in this table to make reading
> @@ -162,3 +163,7 @@ More detailed explanation for tainting
>       produce extremely unusual kernel structure layouts (even performance
>       pathological ones), which is important to know when debugging. Set at
>       build time.
> +
> + 18) ``Q`` Device drivers might annotate the kernel with this taint, in cases
> +     their firmware might have crashed leaving the driver in a crippled and
> +     potentially useless state.

Sure, I'll modify it a bit to add the use case to help with support
issues, ie, to help rule out firmware issues.

I'm starting to think that to make this even more usesul later we may
want to add a uevent to add_taint() so that userspace can decide to look
into this, ignore it, or report something to the user, say on their
desktop.

  Luis
