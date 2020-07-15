Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F422FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05A820672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kYphxsBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGOP0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGOP0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:26:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BCEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:26:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so3129738pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OVseGDlS5NduALoUhVbQMz2ayVd7lsCazvkJdrEWQVA=;
        b=kYphxsBDglzPvHIBCffGnlCguQJ5Jq0VYcOblzLx7EXfk29Rvu/bG7pBwbBpNwzFXG
         +lD2Fb60wFmiV61BCGzq/Gs9UPJEvIkYkAw7CfcZN9nq8hf6m5XYh4qRJi90dSIrkeil
         VQFSgKQ9JBDSo0SH2E//vgbDwR4wEPOwmojY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OVseGDlS5NduALoUhVbQMz2ayVd7lsCazvkJdrEWQVA=;
        b=OkHj275hPKORZc65rPcNApzs4Kx+ntaApL1LT5htE7pq0veHm40wKSc20sGr69CVhD
         E0wtu/Vl5J5oi0XMcYOTISGDVo50CypDUZdR+2qvG4YeIkbxeZ7YLKB5+wBXMvgQw4lF
         xSAbmHoHjhxiyicDkS5ll+6VxgaA1UqAEelqQC3AiH+iZUyWBUxDo4OS9LtDMLQlFkiJ
         V4H1MMLTtA+3KeU33cqGlks9/gj0kB4Fck9dzAM705kNYdv2RBCItYEKX7uz+tQx8yTq
         YSzF4rQk+BOpI528+A9t6WwowAe/4wFz1r2MD6AFH/t8a1ayrGqYZO599Wl/7M8wYG9q
         xtlA==
X-Gm-Message-State: AOAM5326O+LPaQodZRVM5uBbnBo+aNhkBgiccPpRn6EXUFoxCg2UA548
        pID9V1Ffa4PJIocia/csQWL8Hg==
X-Google-Smtp-Source: ABdhPJztkAQ9Aa2pbyAHIkXtH9WpSQcQHYyGPARbbSQPgrfyf6qes0+MO+jyCy83QwcUYG4c4hENOg==
X-Received: by 2002:a17:90a:e987:: with SMTP id v7mr185305pjy.56.1594826776564;
        Wed, 15 Jul 2020 08:26:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j17sm2463861pgn.87.2020.07.15.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:26:15 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:26:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 70/75] x86/head/64: Don't call verify_cpu() on
 starting APs
Message-ID: <202007150815.A81E879@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-71-joro@8bytes.org>
 <202007141837.2B93BBD78@keescook>
 <20200715092638.GJ16200@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715092638.GJ16200@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:26:38AM +0200, Joerg Roedel wrote:
> Hi Kees,
> 
> thanks for your reviews!
> 
> On Tue, Jul 14, 2020 at 06:40:30PM -0700, Kees Cook wrote:
> > Eek, no. MSR_IA32_MISC_ENABLE_XD_DISABLE needs to be cleared very early
> > during CPU startup; this can't just be skipped.
> 
> That MSR is Intel-only, right? The boot-path installed here is only used
> for SEV-ES guests, running on AMD systems, so this MSR is not even
> accessed during boot on those VMs.

Oh, hrm, yes, that's true. If other x86 maintainers are comfortable with
this, then okay. My sense is that changing the early CPU startup paths
will cause trouble down the line.

> The alternative is to set up exception handling prior to calling
> verify_cpu, including segments, stack and IDT. Given that verify_cpu()
> does not add much value to SEV-ES guests, I'd like to avoid adding this
> complexity.

So, going back to the requirements here ... what things in verify_cpu()
can cause exceptions? AFAICT, cpuid is safely handled (i.e. it is
detected and only run in a way to avoid exceptions and the MSR
reads/writes are similarly bound by CPU family/id range checks). I must
be missing something. :)

> 
> > Also, is UNWIND_HINT_EMPTY needed for the new target?
> 
> Yes, I think it is, will add it in the next version.
> 
> Regards,
> 
> 	Joerg

-- 
Kees Cook
