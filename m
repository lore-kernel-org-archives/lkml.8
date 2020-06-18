Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111ECC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D9E2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592465673;
	bh=bEC66nH8uZxGBs2rC/8tpmwdwNE+LS0BOwxCUu2uoG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZKW2CfLeMdH0r1AuG9Ze753S/K2uE0pqurd2e/OQO30PqdfC1efd4I/Gm+jrxV8+e
	 pVPrJKqmE0ytDun8tfjxGYF31y9mZxzgHl3eX/NIn2iJ1lipPa7haFEX5/DBLZmOWE
	 VuKByLEBWEUxBmBdI5OGQ83gabNtA6/25f3BFM70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgFRHec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgFRHea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:34:30 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C749421548;
        Thu, 18 Jun 2020 07:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592465670;
        bh=bEC66nH8uZxGBs2rC/8tpmwdwNE+LS0BOwxCUu2uoG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esE3gT0WCOAF3EwvdaIE2d4NeW0f9Do5pdZRhB0v68ja2WyD9FmEVe0gPl1UGJ4Wg
         JB71y6g9AOTC056v6WK+2+LiV28kxPrH3xriYvPSnKr6OoSuT/d5MZ3bomRJ4TrcjC
         kOn8C+FNivEdEnr52+ASEz9LFKgM7IaOpwqStR1c=
Date:   Thu, 18 Jun 2020 15:34:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        anson.huang@nxp.com, peng.fan@nxp.com, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v3 1/2] arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage
 range
Message-ID: <20200618073423.GF30139@dragon>
References: <1590144291-18526-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590144291-18526-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 06:44:50PM +0800, Robin Gong wrote:
> Correct ldo1 voltage range from wrong high group(3.0V~3.3V) to low group
> (1.6V~1.9V) because the ldo1 should be 1.8V. Actually, two voltage groups
> have been supported at bd718x7-regulator driver, hence, just corrrect the
> voltage range to 1.6V~3.3V. For ldo2@0.8V, correct voltage range too.
> Otherwise, ldo1 would be kept @3.0V and ldo2@0.9V which violate i.mx8mm
> datasheet as the below warning log in kernel:
> 
> [    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
> [    0.999196] LDO2: Bringing 800000uV into 900000-900000uV
> 
> Fixes: 78cc25fa265d ("arm64: dts: imx8mm-evk: Add BD71847 PMIC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied both, thanks.
