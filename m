Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDABC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B76206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgIDJ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgIDJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:26:06 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33EC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:26:06 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5C9749CE; Fri,  4 Sep 2020 11:26:04 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:26:03 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 0/2] r8a7742 SoC add IPMMU support
Message-ID: <20200904092602.GK6714@8bytes.org>
References: <20200825141805.27105-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825141805.27105-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 03:18:03PM +0100, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series adds IPMMU support to R8A7742 (RZ/G1H)
> SoC dtsi.
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (2):
>   dt-bindings: iommu: renesas,ipmmu-vmsa: Add r8a7742 support
>   ARM: dts: r8a7742: Add IPMMU DT nodes

Applied, thanks.
