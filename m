Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5546C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6DB20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586948514;
	bh=CREoP6ow54O+9uP6Nr3jiB5GlPGFSrwpvxq54PH6zc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RuKsmzJlvhfdXdgRHnzgzCV9MwemkMTCd4d9HtkucA6AY5pT7tdcbI4CoYW2cZahF
	 PleLBXHVJKevGaZww56Sp1GmUs8R2GzNEp+MYu06JLo2OpHUuCQoHglM155iqfV4Hw
	 xh/kEfeSi8NVK6r9hnRzIKGbOvM5mwTcVKRFtsmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896699AbgDOLBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896684AbgDOK7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:59:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8202320737;
        Wed, 15 Apr 2020 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586948329;
        bh=CREoP6ow54O+9uP6Nr3jiB5GlPGFSrwpvxq54PH6zc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1HhYnu9MIHu7uBu8iCaGrYgjMczZnXow3gS6bknWEk7L7PWw+q2APHOMia1+mGGLl
         SeoGP0GOp/cUK6gieqe9hrTGnTwDXpsnQ4vKEuUWPGomRvlRUSVx75sQcfMiG5xmdY
         mIKao2F9HAVTn5ug8w4JpxJQ8EpXIeSKzfpfVzLg=
Date:   Wed, 15 Apr 2020 11:58:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
Subject: Re: [PATCH 7/8] arm64: cpufeature: Relax checks for AArch32 support
 at EL[0-2]
Message-ID: <20200415105843.GE12621@willie-the-truck>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-8-will@kernel.org>
 <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:50:58AM +0100, Suzuki K Poulose wrote:
> On 04/14/2020 10:31 PM, Will Deacon wrote:
> > We don't need to be quite as strict about mismatched AArch32 support,
> > which is good because the friendly hardware folks have been busy
> > mismatching this to their hearts' content.
> > 
> >    * We don't care about EL2 or EL3 (there are silly comments concerning
> >      the latter, so remove those)
> > 
> >    * EL1 support is gated by the ARM64_HAS_32BIT_EL1 capability and handled
> >      gracefully when a mismatch occurs
> > 
> >    * EL1 support is gated by the ARM64_HAS_32BIT_EL0 capability and handled
> 
> s/EL1/EL0
> 
> >      gracefully when a mismatch occurs
> > 
> > Relax the AArch32 checks to FTR_NONSTRICT.
> 
> Agreed. We should do something similar for the features exposed by the
> ELF_HWCAP, of course in a separate series.

Hmm, I didn't think we needed to touch the HWCAPs, as they're derived from
the sanitised feature register values. What am I missing?

Will
