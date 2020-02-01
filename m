Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10EFC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 20:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7475720643
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 20:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580587391;
	bh=GFHDrtDrOQaTllRtsYDI6O/S6mLDYlusAGVy5stXSbA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=o3rJ2oeCXKl3Bl3dHFaJRTMgJNm+BcEDpBQmNmz07SE4iNONfsDMELxyxJbYkHItm
	 NB1kTZGEEVwF1F9s/Gdgd06YMSSUXkWaDwfQcGgLdDS2n+osl3Dr7hVHW3JN7aAdTk
	 EbM9912IScAaH1wdRrHa/kEip7njJaeoiIusYLUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBAUDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 15:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBAUDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 15:03:10 -0500
Received: from gamestarV3L (c-71-237-40-145.hsd1.co.comcast.net [71.237.40.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20F720643;
        Sat,  1 Feb 2020 20:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580587390;
        bh=GFHDrtDrOQaTllRtsYDI6O/S6mLDYlusAGVy5stXSbA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nTH/BvzK2+KDTLTlyT5SX746N5F60UiqQyLNNElIKAHLW/Dlxfc1b1mkbbC5AeOdi
         bGwAYIAdXaXGlWycxat1T6+SHCgdQI8I6Q5Pu15aahm0q+oly8/5d1LKmYXSMOeGAb
         qiSCx6Un5obLMz98b9tRlEHlLrsfjHspIcHnVE/w=
Message-ID: <0e09387cd5f2df5f19c9aa5494cc9be2ff7c14de.camel@kernel.org>
Subject: Re: [PATCH RFC] MAINTAINERS: clarify maintenance of nvdimm testing
 tool
From:   Vishal Verma <vishal@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Feb 2020 13:03:08 -0700
In-Reply-To: <20200201170933.924-1-lukas.bulwahn@gmail.com>
References: <20200201170933.924-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-01 at 18:09 +0100, Lukas Bulwahn wrote:
> The git history shows that the files under ./tools/testing/nvdimm are
> being developed and maintained by the LIBNVDIMM maintainers.
> 
> This was identified with a small script that finds all files only
> belonging to "THE REST" according to the current MAINTAINERS file, and I
> acted upon its output.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> This is a RFC patch based on what I could see as an outsider to nvdimm.
> Dan, please pick this patch if it reflects the real responsibilities.
> 
> applies cleanly on current master and next-20200131
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Looks good, thanks for catching this, Lukas.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f77fb8cdde3..929386123257 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9564,6 +9564,7 @@ F:	drivers/acpi/nfit/*
>  F:	include/linux/nd.h
>  F:	include/linux/libnvdimm.h
>  F:	include/uapi/linux/ndctl.h
> +F:	tools/testing/nvdimm/
>  
>  LICENSES and SPDX stuff
>  M:	Thomas Gleixner <tglx@linutronix.de>


