Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1AFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E76B206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gbYAiJuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGOE0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOE0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:26:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5212FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 21:26:47 -0700 (PDT)
Received: from nazgul.tnic (77-85-108-148.ip.btc-net.bg [77.85.108.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2D5A1EC03CF;
        Wed, 15 Jul 2020 06:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1594787203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CiZcICc9wZD5zsp7FjRnYyHRTcDwcJ2rY6S08MFi6gE=;
        b=gbYAiJuw92F8awLzJrsH7FNd3JfJGdCdjzUwzQIQdT1cC1e3DZv94XbeNSEQvyJCotp8CV
        5wru2AvQpPQk9Hmm0fnnLbYnKgZPqMDYX9ix+tKVhhGRyricBOu2PKKItkhKKS8ah/YEnf
        VDYSm1kVXcasuLQ/h8/0J2xM6bbmpUs=
Date:   Wed, 15 Jul 2020 06:26:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org, kernel-team@fb.com,
        Matthew Garrett <matthewgarrett@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        erpalma <palmarini@unive.it>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200715042645.GD4228@nazgul.tnic>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <20200714165621.GA3622@nazgul.tnic>
 <e33ebe71317b0a09ca40e97fb76ff57313c0444c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e33ebe71317b0a09ca40e97fb76ff57313c0444c.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:52:47AM -0700, Srinivas Pandruvada wrote:
> > As to the power issue, lemme CC some Intel folks I found in
> > MAINTAINERS.
> > 
> > Intel folks, pls check the link above and upthread: Why TF do people
> > need to use some luserspace daemon which pokes at MSRs which the
> > kernel
> > writes to too, in order to bypass some apparently too conservative
> > throttling, AFAIU?
> For issues related to thermal or power, we don't expect to poke MSRs
> from user space by any daemon. We have sysfs interfaces for the
> required controls. This is also true for controls via MMIO space.
> Anytime if it is safe to add, we are adding controls via sysfs.
> 
> The tool in question from the link (not from Intel), when developed may
> not have TCC or RAPL-MMIO controls via sysfs. We have sysfs interfaces
> for a while. They can send email to me to justify other controls if
> any.

CCed. (I think I got the right email from the repo).

Francesco, see the whole thread starting here:

https://lkml.kernel.org/r/20200714121955.GA2080@chrisdown.name

> > And why does this work on windoze reportedly?
> This is not related to MSR or MMIO. This is related to some ACPI
> tables. In Linux, thermald will adjust these knobs like Windows. It was
> missing some ACPI details, which Matthew Garrett submitted patches to
> kernel and getting merged with 5.8 series.

Good.

Which means that that throttled tool could do the same thing thermald is
doing so that they're all on the same page. Or simply not do anything
and tell users to install thermald instead.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
