Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C02DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C3D2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593090991;
	bh=hzVTufSqgXwAPMu2gHwPhbk4gm9XBC4oqWn21X0IZ0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dY+F2053BNMKrMZDR2nCXwYPR3tnbc9TqZegynw+Kfher0OHYAUlxu8dX6WeUkOqm
	 pIxqmApgxtdzYrrIQwhK3DsNi6ldYVO2phFwbZMkjNCK45RqHL7SlsU5adGeOev3dM
	 qXDhhKJ3MKgqee9r8nxbSJQTmCAkmodLrcHuvHJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404958AbgFYNQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404825AbgFYNQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:16:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D15206A1;
        Thu, 25 Jun 2020 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593090988;
        bh=hzVTufSqgXwAPMu2gHwPhbk4gm9XBC4oqWn21X0IZ0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctZnhPPDJHtzPcQnLaPl/EtZl6MpuCnn1PYgaWi3dOTtapIiF6TbhyNK1ocOWuY1G
         hXRLxa5J0cFLuuN1BlV+LPIHLN5IW274OeHHf7AR/iw9vE+CrPA+RAseI2FBiKMkWv
         Uu/sF2Y4eHA0lhKE885aHzMjotSnwkEezGLcmiZU=
Date:   Thu, 25 Jun 2020 14:16:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 12/13] arm64: Remove dev->archdata.iommu pointer
Message-ID: <20200625131620.GA8161@willie-the-truck>
References: <20200625130836.1916-1-joro@8bytes.org>
 <20200625130836.1916-13-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625130836.1916-13-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 03:08:35PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> There are no users left, all drivers have been converted to use the
> per-device private pointer offered by IOMMU core.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/arm64/include/asm/device.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
> index 12b778d55342..996498751318 100644
> --- a/arch/arm64/include/asm/device.h
> +++ b/arch/arm64/include/asm/device.h
> @@ -6,9 +6,6 @@
>  #define __ASM_DEVICE_H
>  
>  struct dev_archdata {
> -#ifdef CONFIG_IOMMU_API
> -	void *iommu;			/* private IOMMU data */
> -#endif
>  };

Acked-by: Will Deacon <will@kernel.org>

Thanks, Joerg.

Will
