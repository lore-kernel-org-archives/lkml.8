Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC18C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D603220656
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ms0zXerH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbgFWPbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:31:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55416 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733007AbgFWPbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:31:08 -0400
Received: from zn.tnic (p200300ec2f0d470028fe1155168fd3d2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4700:28fe:1155:168f:d3d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2E7D1EC0390;
        Tue, 23 Jun 2020 17:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592926266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NZdD2ncj7W0vYArIL6i0sU2UdRMEo6fFA4gPIn10UME=;
        b=ms0zXerHddN4k8ExE0TSHq6O6bx04t6pCcjrbHUJjhzuncJt5PL+I7WReYoGIM+7DITo+/
        WHRkuIB9fSmsQ2Nl0vT5tkJiy085/AgbJbcQ0Pt7UsXiRwWgL9ikHm50uLatI74Z7xeLXo
        QlD+swsByuzFPbik013A0HPLPpftQ2w=
Date:   Tue, 23 Jun 2020 17:30:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Yazen.Ghannam@amd.com, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Wei Huang <wei.huang2@amd.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce, edac/mce_amd: Print PPIN in machine check
 records
Message-ID: <20200623153058.GC32590@zn.tnic>
References: <20200623130059.8870-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623130059.8870-1-Smita.KoralahalliChannabasappa@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:00:59AM -0500, Smita Koralahalli wrote:
> For AMD processors that support Protected Processor Identification

Not only AMD processors - Intel support it too. I've made the commit
message vendor-agnostic.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
