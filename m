Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29663C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04FD820657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j2qfngMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgGOTt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGOTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:49:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:49:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l6so2812197plt.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yppoieqawtommMNv7F4xEsaylvTK3ZvGj7dcQjgO2TY=;
        b=j2qfngMt1we3l0IhZifI4twKJ3j3kBQ/HIpn7YZ5j2qvGCpY3D4CxXVvbwFlxonJnk
         6FWAS/JQzC3Vr2RY57kmgM9BiR+ZrBL3UMBVX0Dg1AEdjzFvwUMCdolO9hvbOeEsYa6u
         jBGIyYHDqd0rQYUMQHt3Rxit3HX4mUF8GqeNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yppoieqawtommMNv7F4xEsaylvTK3ZvGj7dcQjgO2TY=;
        b=DvMLDS6npP25PVnkTLRHaU7gvmqMZFi9/PxrPay7nJMuwAMbH5dYJWL2+3N1SIdNqJ
         fBJUFP28AJWFcQsVN+5VdF5kIV2pDE9VJJE//J6mlozZSGFvV4KoqtVHFMv/0fWVyenY
         rMYaGy6iKYGUykeML3coT3/qgjIXn2y9zUHC4J5L99UCWSs3k0gapa73Q3N1bW8Y/6VV
         +//QMfwfWMFtOnBxe6RZ01iz/s4F1jDdLE1KzF1eNn9QnjyO+ja0foxvr0WVgRipmXCp
         D21cqluSWhREnvBlnuy86iAZD+/6s5MkmrAr62LCoThEkAgRJjuQF8VL9dZsnTpO06Jl
         QVPg==
X-Gm-Message-State: AOAM531Q4prjYSo6l7SthYQQUq9bna5q3V7MGWKvOxWCN47Pp82XpM/+
        UhsSxI9e1JJDem+wwpeN40ZA2g==
X-Google-Smtp-Source: ABdhPJxvA58SlKkMWKAljrVfZntLrDAODkXc0OEIDnErZntti/oMHX7TUTMJUyPo0nAVuQc7dj8q2g==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17mr825746plo.235.1594842565095;
        Wed, 15 Jul 2020 12:49:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g7sm2685716pfh.210.2020.07.15.12.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:49:24 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:49:23 -0700
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
Message-ID: <202007151244.315DCBAE@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-71-joro@8bytes.org>
 <202007141837.2B93BBD78@keescook>
 <20200715092638.GJ16200@suse.de>
 <202007150815.A81E879@keescook>
 <20200715154856.GA24822@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715154856.GA24822@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 05:48:56PM +0200, Joerg Roedel wrote:
> It is actually the CPUID instructions that cause #VC exceptions. The
> MSRs that are accessed on AMD processors are not intercepted in the
> hypervisors this code has been tested on, so these will not cause #VC
> exceptions.

Aaah. I see. Thanks for the details there. So ... can you add a bunch
more comments about why/when the new entry path is being used? I really
don't want to accidentally discover some unrelated refactoring down
the road (in months, years, unrelated to SEV, etc) starts to also skip
verify_cpu() on Intel systems. There had been a lot of BIOSes that set
this MSR to disable NX, and I don't want to repeat that pain: Linux must
never start an Intel CPU with that MSR set. :P

-- 
Kees Cook
