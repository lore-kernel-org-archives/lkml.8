Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09153C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCC12074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMaF0p1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgCZQbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:31:35 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40812 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgCZQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:31:35 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so2616124pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDF6On+HDyMfQFFmOzj2HQxDo1MqPfrIkTej+3BhvlQ=;
        b=fMaF0p1e3sw4WUqlnz+78vbRi0z7dyl2McMHXTD+sd1/6njnlDhaPruhcC8Rm/PONY
         h/KIZx8kfstf2SInDgM8Ia8ACWComL6cz15SRdgw2ZqSeVFDj6jKGl1qdbKgSajR39p6
         OWi/cobumFsmvp3qDjKwP7CpsIHjb95Q2VwBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDF6On+HDyMfQFFmOzj2HQxDo1MqPfrIkTej+3BhvlQ=;
        b=M2SAPDb84aVDLTL9BizdPUN7eoYOGDsZlKMl1Q0qDCzq6kkxxUfveRoRqQwivxl0c3
         N4tbrq4BMhnHhnLUnNFYzTbHUKMye3AQWOLieqmzK7ghD/qSy3BvXo28QUgGaEd4GBpB
         yTE2FBlMSU2SAnFwSPoZxNtttm5OPQ1d2ZNVHRjqz/rJ8K3bGtAtZFWiW7rSxc0aAFKZ
         jlRZQSDLqsTaTz0VAI+sWaYADrR+I8fEDQ/x7/agQnOC7By4TZURH62/keb8hrOFM+2c
         DgYzB/sB19HmZi9Us/ShWAFSioOKF33Ev2VCVd7U1LO2p5vGia8dLVnHdKHeqJ3f/7Av
         HQjA==
X-Gm-Message-State: ANhLgQ27gh2dlAtra+UDvqpY1oauYId/lavth9VnYRWtpbaCg86pRsuL
        7+vtNTc3WY2D375vqaBc8N1kfw==
X-Google-Smtp-Source: ADFU+vuLwI1ER/8Bbsjtmss9W6jlCzZe3fmKIOXRb2Ju4TVJZ9hfmc4Ba4cmo4/+h6Vgp2PYRi2lvA==
X-Received: by 2002:a17:90a:2541:: with SMTP id j59mr883153pje.128.1585240294536;
        Thu, 26 Mar 2020 09:31:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t60sm2044703pjb.9.2020.03.26.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:31:33 -0700 (PDT)
Date:   Thu, 26 Mar 2020 09:31:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: entry: Enable random_kstack_offset support
Message-ID: <202003260926.83BC44B@keescook>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-6-keescook@chromium.org>
 <20200325132127.GB12236@lakrids.cambridge.arm.com>
 <202003251319.AECA788D63@keescook>
 <20200326111521.GA72909@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326111521.GA72909@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 11:15:21AM +0000, Mark Rutland wrote:
> On Wed, Mar 25, 2020 at 01:22:07PM -0700, Kees Cook wrote:
> > On Wed, Mar 25, 2020 at 01:21:27PM +0000, Mark Rutland wrote:
> > > On Tue, Mar 24, 2020 at 01:32:31PM -0700, Kees Cook wrote:
> > > > Allow for a randomized stack offset on a per-syscall basis, with roughly
> > > > 5 bits of entropy.
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Just to check, do you have an idea of the impact on arm64? Patch 3 had
> > > figures for x86 where it reads the TSC, and it's unclear to me how
> > > get_random_int() compares to that.
> > 
> > I didn't do a measurement on arm64 since I don't have a good bare-metal
> > test environment. I know Andy Lutomirki has plans for making
> > get_random_get() as fast as possible, so that's why I used it here.
> 
> Ok. I suspect I also won't get the chance to test that in the next few
> days, but if I do I'll try to share the results.

Okay, thanks! I can try a rough estimate under emulation, but I assume
that'll be mostly useless. :)

> My concern here was that, get_random_int() has to grab a spinlock and
> mess with IRQ masking, so has the potential to block for much longer,
> but that might not be an issue in practice, and I don't think that
> should block these patches.

Gotcha. I was already surprised by how "heavy" the per-cpu access was
when I looked at the resulting assembly (there looked to be preempt
stuff, etc). But my hope was that this is configurable so people can
measure for themselves if they want it, and most people who want this
feature have a high tolerance for performance trade-offs. ;)

> > I couldn't figure out if there was a comparable instruction like rdtsc
> > in aarch64 (it seems there's a cycle counter, but I found nothing in
> > the kernel that seemed to actually use it)?
> 
> AArch64 doesn't have a direct equivalent. The generic counter
> (CNTxCT_EL0) is the closest thing, but its nominal frequency is
> typically much lower than the nominal CPU clock frequency (unlike TSC
> where they're the same). The cycle counter (PMCCNTR_EL0) is part of the
> PMU, and can't be relied on in the same way (e.g. as perf reprograms it
> to generate overflow events, and it can stop for things like WFI/WFE).

Okay, cool; thanks for the details! It's always nice to confirm I didn't
miss some glaringly obvious solution. ;)

For a potential v2, should I add your reviewed-by or wait for your
timing analysis, etc?

-- 
Kees Cook
