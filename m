Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17455C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d91N+o6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbgEMXSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732161AbgEMXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:18:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:18:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so424578pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzQVGwBy98yyKuXlmBNvWD4o+eLGqCxtgVxPgKw63Do=;
        b=d91N+o6UMzxTsz1St1Hu66m8IAaS2jE1/WCro4T3FXi2sc/4AHW4ODcGwfEnvDzHjj
         /PKKX5txh+2AdFLEuJtnkNNG0IRWzECKUG3SGfFwrIcEdqW19nhO2jFicMOUMvz6T+C1
         tNR/mldiveHPbJerAbyvqheERVBHSeb8Q1lg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzQVGwBy98yyKuXlmBNvWD4o+eLGqCxtgVxPgKw63Do=;
        b=uKAL6G61MLn3QigHDWqXdG4FealbNGlsN/YKgyBiRVy+BbwX+xLaihvJztlPq1GanU
         xwJ8Pr41HA4E3KkfolxBYtct2r5FLYfFd+aJmdW007f2DJ8qf44Th/sYZOvtCXv1irQY
         CpZtmw8bVYcE0Q8irc3v8GaI7nnjozfdDxVt9jWBvXaTy2Rp8uicFCGRrjIdn0hU+LSf
         K3MCsKif1Hv2elUU4Ic0cINxnQMTS0CUPhKn2UVuCsXUldal+sj5B6BI5FpK8dh1+hK2
         URPM/V7ArOgWAgpqhTaTW2WOIsssLGLfFvmenL4Jz7BSFnX3mTWCf8h6akqb5cWJ7ASO
         wflA==
X-Gm-Message-State: AOAM530ysIkeWqmAd/MgV3Ou5VJCLljCCturqaoZNDxx0L+ORLstA7mE
        MdNqOc37PhlJvjtYGERPhKmAnnJI500=
X-Google-Smtp-Source: ABdhPJweDQubJLBs+PMMLtJakY5abNknkhRWNuRw1HhjYTGgbGdJjpzsMWRJEnyCFTWFX0XQTbTGVg==
X-Received: by 2002:aa7:83c8:: with SMTP id j8mr1556371pfn.272.1589411914316;
        Wed, 13 May 2020 16:18:34 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id x10sm635840pgq.79.2020.05.13.16.18.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:18:34 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id t11so431466pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:18:34 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr1357400vsq.109.1589411542393;
 Wed, 13 May 2020 16:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200507200850.60646-1-dianders@chromium.org> <20200507130644.v4.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
In-Reply-To: <20200507130644.v4.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 16:12:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wq1bnaMnUa09GZzQq5rZeQHUM9WAmxED3foc_Rjdsg2A@mail.gmail.com>
Message-ID: <CAD=FV=Wq1bnaMnUa09GZzQq5rZeQHUM9WAmxED3foc_Rjdsg2A@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] arm64: Add call_break_hook() to early_brk64()
 for early kgdb
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-serial@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, bp@alien8.de,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 7, 2020 at 1:09 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> In order to make early kgdb work properly we need early_brk64() to be
> able to call into it.  This is as easy as adding a call into
> call_break_hook() just like we do later in the normal brk_handler().
>
> Once we do this we can let kgdb know that it can break into the
> debugger a little earlier (specifically when parsing early_param's).
>
> NOTE: without this patch it turns out that arm64 can't do breakpoints
> even at dbg_late_init(), so if we decide something about this patch is
> wrong we might need to move dbg_late_init() a little later.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Changes in v4:
> - Add "if KGDB" to "select ARCH_HAS_EARLY_DEBUG" in Kconfig.
>
> Changes in v3:
> - Change boolean weak function to KConfig.
>
> Changes in v2: None
>
>  arch/arm64/Kconfig                      | 1 +
>  arch/arm64/include/asm/debug-monitors.h | 2 ++
>  arch/arm64/kernel/debug-monitors.c      | 2 +-
>  arch/arm64/kernel/traps.c               | 3 +++
>  4 files changed, 7 insertions(+), 1 deletion(-)

As discussed in the replies to the v3 version of this patch [1], I
have posted a replacement patch for this one [2].  After the cut in
the replacement patch I talk about different ways it could land.
Hopefully that's not too confusing.  I can also re-spam everyone with
a v5 of the whole series if that makes it clearer.

[1] https://lore.kernel.org/r/20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid
[2] https://lore.kernel.org/r/20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid

-Doug
