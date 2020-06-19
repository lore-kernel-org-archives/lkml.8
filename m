Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86802184D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="d6JTVPWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbgFSNWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFSNWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:22:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE3EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:22:52 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bac004d57d24caa4a0e33.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ac00:4d57:d24c:aa4a:e33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1747A1EC03D0;
        Fri, 19 Jun 2020 15:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592572970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gEMLO6KVm1oIKIAxLPOc4rRHgVZxc+y/BwsFuOfLTRE=;
        b=d6JTVPWK6JBiDGrITcwYYDhlXhKkzeVLRPbq6uoLnES4BND4yX3uHsRq2vAbtGeY+Bb0W/
        myqVvLmlEO0kJ8Y3l1WCGAo+w8vke9bE3kRcXsw3/H72OQFnS3DmGmp5Nzv/YTO3+5O5bv
        jwUx6ekS+qY6Y5iL8MGHE4RcWxm2mBQ=
Date:   Fri, 19 Jun 2020 15:22:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Message-ID: <20200619132243.GC32683@zn.tnic>
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com>
 <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <20200618220139.GH27951@zn.tnic>
 <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic>
 <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:01:36AM -0300, Daniel Gutson wrote:
> Then the user will not know that he/she could improve the security of the
> system by enabling the feature in the BIOS.

And how is the user going to know from your "module"? AFAICT, your
module loads on any system - not only on ones which have MKTME in CPUID.

> The fact that the CPU has the cap and the BIOS disables it, can
> trigger a prevention action.

I can only venture guesses what "prevention action" is - you'll have to
be more verbose here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
