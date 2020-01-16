Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B37DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EF92072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579204559;
	bh=zM7/G9ohZ7x8DUpojw8GrOGYq51OWhRQLpYwpfjjy0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NyCONm44entuCtKLoOfJ8WqPFrRcBd6FMS2Lx1seggEDH8Syl6Kf8ucMWn9Rk0cpP
	 QqhBc2gb2pg3IowbieaRhgReE0J5haUYzJ1zzhMEMxMiGpK8DE1s06HNgPhluA0flj
	 Ooz1PmTetQE7B22gUl3TOcz8X9AAZxhG2tgmPv8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgAPTz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbgAPTz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:55:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621EA2072B;
        Thu, 16 Jan 2020 19:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579204557;
        bh=zM7/G9ohZ7x8DUpojw8GrOGYq51OWhRQLpYwpfjjy0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0u3rY60HIEMozuN0foQT8KUIpmrYCrzo7TtX6Dz4//bc9UoDTlwXD7V1f1zkVreZ2
         Zy8GNaJnVlI5xVu8DzkZlg9ajwE6vBbN9YJ21kmTw2OvnWv9AcOxxPyWsrQH+FKeSc
         lCqU6x71qo6drhhU0++qEZwskiHykkdQ7vi5R1MM=
Date:   Thu, 16 Jan 2020 20:55:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.6
Message-ID: <20200116195524.GA1096827@kroah.com>
References: <20200116110515.20480-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116110515.20480-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 04:35:15PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.6 merge window below.
> 
> PHY core now creates a device link between PHY consumer and PHY
> provider required for suspend/resume ordering and also adds support
> for DisplayPort controller to pass configuration parameters to PHY.
> 
> It includes new PHY drivers for TI's J721E SoC (PCIe and USB), eMMC
> PHY driver for Intel's LGM SoC and USB PHY driver for Broadcom
> SoC.
> 
> For the detailed list of changes, please see the tag message below.
> All these changes have been in linux -next for a while now.
> Consider merging this for the next merge window and let me know if I
> have to change something.

I got the following warning, which linux-next should also reported:
Commit: 56b337ef505d ("phy: ti: j721e-wiz: Fix return value check in wiz_probe()")
	Fixes tag: Fixes: b46f531313a4 ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
	Has these problem(s):
	        - Target SHA1 does not exist

Maybe I am merging into the wrong tree?

Anyway, I'll take this, hopefully that id shows up somewhere :)

thanks,

greg k-h
