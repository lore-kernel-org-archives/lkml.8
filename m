Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB1C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBEB20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594809628;
	bh=tclvIja3nKQXHIcIKVHINSxF+hfzpuNOonuG/8s/O+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M2wvZwy14tb2kctp4vOy5UXoY4Jw9IYH6DrK8dIvZSvhlL4tDdUv+6PD8xsgsqQqu
	 ffaJNnJK2i3SJmR7p8LTgEBYN2FOnZiOD10GN7/haBy1GjdvykseqSFPy3MaCTMNLU
	 m608GOFiOIsuU16YRnALhOTJhThXfvAnRxQr9G6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgGOKk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731300AbgGOKk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:40:26 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D85CE20656;
        Wed, 15 Jul 2020 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594809625;
        bh=tclvIja3nKQXHIcIKVHINSxF+hfzpuNOonuG/8s/O+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKPUPtQVh86TpetcNNaX6A3SUrcSr2VetpVBZzcd/51Oc1SannqIsAotDwJ3dslDd
         eMm4K7jAnzdbp+uqyBwzeP8AADdJJxlX+6pYgTcJ3hFVY9sZ08RB0Uwo+qxeFjw4TZ
         K9ei/Ewyjvw/WsEW7J4HzQiNrq6C2iDSI2xcGaeY=
Date:   Wed, 15 Jul 2020 16:10:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 4/9] dt-bindings: dma: renesas,rcar-dmac: Document
 R8A774E1 bindings
Message-ID: <20200715104021.GH34333@vkoul-mobl>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594676120-5862-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-20, 22:35, Lad Prabhakar wrote:
> Renesas RZ/G2H (R8A774E1) SoC also has the R-Car gen3 compatible
> DMA controllers, therefore document RZ/G2H specific bindings.

Applied, thanks

-- 
~Vinod
