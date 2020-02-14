Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E24C47409
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E079206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581649868;
	bh=TEYIlstObw2uDSz1d4UQtuSSdbIIhoZdfE4KAKtkNO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IPvl5auFNHejKItQTD+BsDnPx7CF21Nbp9Q+tp5OuShubcdHJ6eJeeUgRLVGx9Zhg
	 n6JW82ZotAYg8S8SgTI/V4ZJeT/KJrK2eUnkFC7ns0QRQv/JxOfmDUfuF/W7T5DNxo
	 eiHxyfGLn4x6BGbpoowhNZ0vo662Meei9a0Zg6RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgBNDLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:11:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgBNDLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:11:07 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C812168B;
        Fri, 14 Feb 2020 03:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581649866;
        bh=TEYIlstObw2uDSz1d4UQtuSSdbIIhoZdfE4KAKtkNO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDWVeR9le9MvjICefdX/Bl9flkUmrz7o98D3kpXfkmZziN5XrbDPxbAvsbKCnYqwB
         +UngDFFWGYp+02M77cXpFrcXvZI64LxCm44QGYFxawop+jROAEheQoOiNxU3uyFk5I
         HGXHlJwyOzXGR7KxvSL4zKvYAmrg0lAHac6+G4F0=
Date:   Fri, 14 Feb 2020 11:10:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, philippe.schenker@toradex.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: Re: [PATCH] ARM: dts: imx7-colibri: add gpio-line-names
Message-ID: <20200214031056.GM22842@dragon>
References: <20200129215336.417431-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129215336.417431-1-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:53:36PM +0100, Stefan Agner wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
> 
> Add Colibri SODIMM numbers as GPIO line names on module level. The GPIO
> lines with a name are all available on the SODIMM edge connector of the
> Colibri iMX7 module and therefore a customer might use it as a GPIO. The
> Toradex Evaluation Board has the SODIMM numbers printed on the silk-
> screen. This allows a customer to quickly control a GPIO on a pin-header
> by using the name printed next to it.
> 
> Putting the GPIO line name on module level makes sure that a customer
> gets a reasonable default. If more meaningful names are available on a
> custom carrier board, the user can overwrite the line names in a carrier
> board level device tree.
> 
> The eMMC based modules share all GPIO names except two GPIOs on bank 6
> which are not available on the raw NAND devices. Hence overwrite GPIO
> line names of bank 6 in the eMMC specific device tree file.
> 
> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>

Applied, thanks.
