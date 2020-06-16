Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A9FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E192080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q/o1bC3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbgFPSJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgFPSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:09:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA4AC061573;
        Tue, 16 Jun 2020 11:09:42 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c001d7e5f403e90d72b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:1d7e:5f40:3e90:d72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FEE91EC035B;
        Tue, 16 Jun 2020 20:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592330981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SusYPV5JN1ZwZMIRc08goZbNx6nDU4gupG+y+bDao5Q=;
        b=Q/o1bC3BIr6GovBONPUvNnKr/YdZZ/Bl9aGUxGcrPGiMYK/OElTbvbNA91LlYszY62meAH
        0LxINwi2z68aS7HiGIHtq8yJ7Irnsmgq9ZK7Z3GewePQa2g4NZlk6MtxtPk0CIJoauPlgs
        eSLc17cg850urC6GJ7x9/p9KEIeFaG0=
Date:   Tue, 16 Jun 2020 20:09:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacky Hu <hengqing.hu@gmail.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 2/2] EDAC/amd64: Add family ops for Family 17h Models
 60h-6Fh
Message-ID: <20200616180940.GN13515@zn.tnic>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
 <20200607043709.48178-3-hengqing.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200607043709.48178-3-hengqing.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 12:37:09PM +0800, Jacky Hu wrote:
> Add family ops to support AMD Family 17h, Models 60h-6Fh systems.
> 
> Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
> ---
>  drivers/edac/amd64_edac.c | 14 ++++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  2 files changed, 17 insertions(+)

b6bea24d4151 ("EDAC/amd64: Add AMD family 17h model 60h PCI IDs")

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
