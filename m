Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE7EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E408621D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592463881;
	bh=J0iWWMv81C8AYtplbw4a0ZJIssDKdKKp5YTdZIizseo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EjVxqcBB29MocLbTLzZ12wBBBqbzBeqWNSGFw5VAs/bALRAIRZ8T3wmBPcwry/LiB
	 HhAQTnTJbL4hQZTK+/mWBJOkuvdZBWAcIL5IHdvQsZgfr6wzymuiAfvfH0P+T5q7ov
	 GhFmEj7DTg2vqBWlySxHiY00kDaFUvabv8s/3DxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgFRHEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgFRHEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:04:39 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A3F217A0;
        Thu, 18 Jun 2020 07:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592463879;
        bh=J0iWWMv81C8AYtplbw4a0ZJIssDKdKKp5YTdZIizseo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zxd+GdV6WfcJYG0OirgFNrsDyY+p5ploVRpYCj/zuCNSMCmMyLwSG90XOhkZTbfvW
         3IV7f9pJ1n+Yd2rm2j3wxCZBf5c6VwPltBxjVA+1WkVD+arm4uGG/13VoEFF67zEWX
         lQkxI5HBtvgvrWd4JrEdNmnGpP0Pj8+UewdoIfUY=
Date:   Thu, 18 Jun 2020 15:04:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Message-ID: <20200618070425.GC30139@dragon>
References: <1589956216-22499-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589956216-22499-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:30:16PM +0800, Anson Huang wrote:
> i.MX6/7 SoCs' temperature sensor is inside anatop module from HW
> perspective, so it should be a child node of anatop.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
