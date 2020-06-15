Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE91C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248DE20707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JbV+t55X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgFOMAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:00:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2554C061A0E;
        Mon, 15 Jun 2020 05:00:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f063c0085fbd8d4455f52fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:85fb:d8d4:455f:52fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7AC991EC0299;
        Mon, 15 Jun 2020 13:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592222399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4enB91kRD9rJWobEi4WugDt9+vQpQho4vn9V6hTQAw=;
        b=JbV+t55Xum04E2Lc3Yd19X2GBeJQla5k2LMCa4LhzY9G9XnpNrf9NjTCGZ3TrQ7c3tShef
        u1jPfBtFjWHXd1etGWGfRyR8cbkgV388pZtgVdZ5vOa7iCMhdqpiXEDFOq5qwjwXj/TFmi
        f6YgJN/7o7TQPUkScj8Hv353pzb3qAE=
Date:   Mon, 15 Jun 2020 13:59:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacky Hu <hengqing.hu@gmail.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/2] MCA and EDAC updates for AMD Family 17h, Model 60h
Message-ID: <20200615115950.GG14668@zn.tnic>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200607043709.48178-1-hengqing.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Yazen and linux-hwmon.

On Sun, Jun 07, 2020 at 12:37:07PM +0800, Jacky Hu wrote:
> This patchset adds MCA and EDAC support for AMD Family 17h, Model 60h.
> 
> Also k10temp works with 4800h
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:         1.55 V
> Vsoc:          1.55 V
> Tctl:         +49.6°C
> Tdie:         +49.6°C
> Icore:         0.00 A
> Isoc:          0.00 A
> 
> Jacky Hu (2):
>   x86/amd_nb: Add Family 17h, Model 60h PCI IDs
>   EDAC/amd64: Add family ops for Family 17h Models 60h-6Fh
> 
>  arch/x86/kernel/amd_nb.c  |  5 +++++
>  drivers/edac/amd64_edac.c | 14 ++++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  drivers/hwmon/k10temp.c   |  2 ++
>  include/linux/pci_ids.h   |  1 +
>  5 files changed, 25 insertions(+)
> 
> -- 
> 2.27.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
