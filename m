Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9DDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33487207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YGk3UDD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgIBSUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:20:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F79C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:20:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d7a00603f8207b19bbcd5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7a00:603f:8207:b19b:bcd5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47C9A1EC02D2;
        Wed,  2 Sep 2020 20:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599070800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dp3JBcokrDLRGJ037IDX7hjPsAnIFR8tr4nYGXWefF4=;
        b=YGk3UDD9TdakfTY8aO3WmKmUDDJHLI7cwwcQyM8PFT0+AKjO9AmaOBIWzopMNbzRbMTi7A
        ciqbsm3Ir9R1WnLbQuFbjIK8RXY0U5Q/UMTLzzUIWhTtZt0wXhj1e4vg5q24VTRoFWFmEn
        jxaTbaTj+VlpsYjycnCO7PZr1Mf/uIU=
Date:   Wed, 2 Sep 2020 20:19:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Message-ID: <20200902181956.GD21537@zn.tnic>
References: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
 <20200902154018.GA21537@zn.tnic>
 <5ef17179-7557-b609-2e72-20caa1369d46@intel.com>
 <20200902165216.GB21537@zn.tnic>
 <98adc930-00e2-67c8-4ba3-fcb1af3aafd2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98adc930-00e2-67c8-4ba3-fcb1af3aafd2@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 10:18:38AM -0700, Dave Hansen wrote:
> All good points.
> 
> Personally, I think I'd be OK if kcpuid _focused_ on single-bit values
> only.  Those are the vast majority of the things that we need from such
> a tool.  I don't think there's nearly as much demand for the topology
> enumeration or TLB structure leaf parsing.
> 
> I also kinda doubt we can come up with a file format off the top of our
> heads that can represent all the ways data is represented in the CPUID
> space.  Single bits, sure.

Yap, agreed.

However, we should try to at least provide for some rudimentary support
for multibit fields in case we decide we need them down the road and
after the fact.

I guess it is enough if the tool dumps them and their meaning - if one
needs further info then one would go do the *actual* CPU documentation
anyway...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
