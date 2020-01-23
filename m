Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B38C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 00:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0400021569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 00:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJX9Th+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAWApM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 19:45:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45595 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWApL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 19:45:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so1715373qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 16:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SjT/+iv4Oysvj1Adxey1awc4Ekn9woQQ3e5HKZBrgj0=;
        b=nJX9Th+eJgumVzdvIu09OaEmqZomQv5Zr6PPZSnv6rtRKI3O8lIYw3DnBBOOKVGjRq
         lZ6deD0Zq6sczErH2zxSU3Zt2LsSeReOnEBJtx9UwJaBuSvWpTa4MfHGqIHcEzA0Uzqz
         lsh/HnzXc7eSeYKiFr9kkr3ww/PMVCoHy7RvhXgb4xkMvtOvQwToZQ6rXXHj5/vyW/0Y
         uemCg5mBnN9OxPJ4ZgONWM8fWNbOP83coykbmPvksDyRzqdI7iSGL2M+wDkeTwgB9gSH
         TUYdI+0oaYXvAzjRu2S0b0P4AI+pz0mnnUFrYFSxATl14iAjn6K8HlxlhuPOao7ZppMK
         FgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SjT/+iv4Oysvj1Adxey1awc4Ekn9woQQ3e5HKZBrgj0=;
        b=SoLxVqu9UmUWH6NP5P8Lc7MIIMuYUUhs8AOY19hi0WjdZcRoBqO8n4XrVD4eeMmAre
         jkS8OZWwSKbNVgpSox8bCFiBnKHBh1/IxhtNeJkpRh64PrZDjhDIW1/KFw3OfwJ/elUo
         EJt9QrCdhTT2v1SLi3bUu1NKfGmMf6+HyPZSLpYEkVA4XzNjhG4JxmhPvt1ywMGxGldl
         CqLIXQXPEoxmja/rPu/aJoTwOIwaYPp0zeJPJoBpMg08HHFpRAq/DAVrkTYFCE32meHE
         x7eQ7jaIlF75MNj+FDnrXziw/24t1JcXmPG91hsYPURpZRjwBOjVqSnxJMETo175qmQk
         bG8g==
X-Gm-Message-State: APjAAAXyKDX1V8P6GYAghKj8YXkjPpj78ghpf0/5rqTWGaziJrXbvt/t
        iWiWB3vcRLwYt61rr8pv8VJEnwMouLY=
X-Google-Smtp-Source: APXvYqyN62MYiIENf6NONpOoKOUW268ss0emSAX2JDP/kE4tNyzQA/Y0AU8cMhBeLyQa9gkTUVcsZQ==
X-Received: by 2002:a37:7b84:: with SMTP id w126mr13282740qkc.280.1579740310952;
        Wed, 22 Jan 2020 16:45:10 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c16sm155456qka.18.2020.01.22.16.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 16:45:10 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 22 Jan 2020 19:45:08 -0500
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v12] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200123004507.GA2403906@rani.riverdale.lan>
References: <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:24:34PM +0000, Luck, Tony wrote:
> >> +static enum split_lock_detect_state sld_state = sld_warn;
> >> +
> >
> > This sets sld_state to sld_warn even on CPUs that don't support
> > split-lock detection. split_lock_init will then try to read/write the
> > MSR to turn it on. Would it be better to initialize it to sld_off and
> > set it to sld_warn in split_lock_setup instead, which is only called if
> > the CPU supports the feature?
> 
> I've lost some bits of this patch series somewhere along the way :-(  There
> was once code to decide whether the feature was supported (either with
> x86_match_cpu() for a couple of models, or using the architectural test
> based on some MSR bits.  I need to dig that out and put it back in. Then
> stuff can check X86_FEATURE_SPLIT_LOCK before wandering into code
> that messes with MSRs

That code is still there (cpu_set_core_cap_bits). The issue is that with
the initialization here, nothing ever sets sld_state to sld_off if the
feature isn't supported.

v10 had a corresponding split_lock_detect_enabled that was
0-initialized, but Peter's patch as he sent out had the flag initialized
to sld_warn.

> 
> >> +	if (!split_lock_detect_enabled())
> >> +		return;
> >
> > This misses one comment from Sean [1] that this check should be dropped,
> > otherwise user-space alignment check via EFLAGS.AC will get ignored when
> > split lock detection is disabled.
> 
> Ah yes. Good catch.  Will fix.
> 
> Thanks for the review.
> 
> -Tony
