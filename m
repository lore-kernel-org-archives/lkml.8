Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDCDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9978E207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589938339;
	bh=UdnCpd3rJLx+XaZP09pe1uMAJSPGXUD9U0sRqQDYC+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fRGnTEHaZlrDhEron37CIVw9wzsnBgJv+MkXCGfq5axmfR0CHmVkMxsfKApuh9hjQ
	 YIxBBsOeeVTAf0Ms9buX3Ki/PdD/LMGS2niZgWZG1PpY7tcu1FzSFpbGUG2x5awYOC
	 LDcuhvdS20gGOMVX/WY8+N1v1FH3APg/GmWEOAPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgETBcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgETBcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:32:18 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6CB207C4;
        Wed, 20 May 2020 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589938338;
        bh=UdnCpd3rJLx+XaZP09pe1uMAJSPGXUD9U0sRqQDYC+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ky2Q942luVtDHkGQ3XTF7gBtgmpcOAHvcFKvVOCQ1sC5B3conMaInJmAluxaFOgXP
         JFE8pZQHUZF/chgrAsvXP4EemPgrnvwtTpAeqGbURXXidAXVuktqY83tGLAmUP9cDP
         g3wGfuwS8fPZoGSQ/AY43FTpmxBGB6kckGveDEXs=
Date:   Wed, 20 May 2020 09:32:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, horia.geanta@nxp.com, peng.fan@nxp.com,
        l.stach@pengutronix.de, agx@sigxcpu.org, leonard.crestez@nxp.com,
        andrew.smirnov@gmail.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: Add src node interrupts
Message-ID: <20200520013211.GL11739@dragon>
References: <1589012271-12740-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589012271-12740-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 04:17:50PM +0800, Anson Huang wrote:
> Interrupts is a required property according to SRC binding, add
> it for SRC node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
