Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56866C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34903207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595226934;
	bh=nOyt9zgAM348tGfcEVMGIE0son8XaFt62InAZ5uCd0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BzfvibqOkb7YyWprH0x7mVjPtIuiicQnETUPJMDZRIDSji2fA8cZFJw8oYravGeFv
	 VCIUFUezVeB/8U4H/o1x7WYrtXnp+AclT6sQyiR8VAE7g6jGVT0C4zmOP1B06Mqu3g
	 hwROmSmkBp/0L3AME0jlPTj4QEFk6BeCQY1W9DBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgGTGfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGTGfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:35:31 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA5EB207EA;
        Mon, 20 Jul 2020 06:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595226931;
        bh=nOyt9zgAM348tGfcEVMGIE0son8XaFt62InAZ5uCd0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFfNFxfI4ChTAIt4t2cNiUemslZVtxxW9AM0ma54l9O1SBKh8md97FQ7ykOtaZCQQ
         VQD+Y5M1dJaHvNsLphLOegIi7w826j/SnB0jmaVpmpJg7c2ua0pMYv1i4HzD6R8dg4
         0luUXfPuRau+Yl2wL5nQaMqshgLDKopXoCCQKYA0=
Date:   Mon, 20 Jul 2020 12:05:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Niklas <niklas.soderlund@ragnatech.se>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 09/20] dt-bindings: phy: renesas,usb3-phy: Add r8a774e1
 support
Message-ID: <20200720063527.GF12965@vkoul-mobl>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594919915-5225-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-20, 18:18, Lad Prabhakar wrote:
> Document RZ/G2H (R8A774E1) SoC bindings.

Applied, thanks

-- 
~Vinod
