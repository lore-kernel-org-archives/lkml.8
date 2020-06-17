Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69504C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B17221501
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dw/RBQQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgFQHmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:42:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38616 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQHmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:42:03 -0400
Received: from zn.tnic (p200300ec2f0bb00001a9c67a3ce5c424.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:1a9:c67a:3ce5:c424])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A2D11EC0284;
        Wed, 17 Jun 2020 09:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592379721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lt4ISuhnyW/yTfCzgW3xtWJbReNdoUR46XiPyLceBNs=;
        b=Dw/RBQQYVOZW88yPd7pbjw23ap5UzbI8KXwLVy6rzZrf3W1/cmRoUncwbkl4DLX5RsAM6B
        cRpkHVu2tISjy9F6Ci3z3zkqXnPGpk28gKRQ6v/onzlAX4DpOI38JQtxlDJQgfrJQhGjxZ
        kW38HbwoutTlbjvHd3C7VY1BHQF4ilQ=
Date:   Wed, 17 Jun 2020 09:41:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Message-ID: <20200617074158.GB10118@zn.tnic>
References: <20200615184056.26531-1-tony.luck@intel.com>
 <20200616192952.GO13515@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F670974@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F670974@ORSMSX115.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:33:08PM +0000, Luck, Tony wrote:
> If the BIOS option is left in the default setting, uncorrectable errors found
> by the patrol scrubber are reported with a machine check. Those MSCOD
> and MCACOD signatures are the same ... but that's not important because
> MCi_STATUS.UC==1. So Linux doesn't need to jump through hoops to
> "upgrade" the severity.

No, this is not what I meant: I meant when you have the setting enabled
to downgrade those errors, can they be detected as part of another MCE
being raised...

> > If so, then the adjusting needs to happen inside mce_log().
> So no, this adjust only needs to happen when polling the banks from
> CMCI or periodic timer.

... but since those downgraded errors raise CMCI then the answer to my
question is no.

> The point was to avoid the runtime test for CPU model on every error. But
> this isn't a performance critical path, so we can refactor if you think that
> looks cleaner.

Yes please.

> There is some new set of validation tests running now to check the effectiveness
> of this BIOS + OS change. So it may be a while before updated version is
> posted.

Ok, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
