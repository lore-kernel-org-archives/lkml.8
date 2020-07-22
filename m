Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681D6C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E62020657
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbgGVM7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:59:05 -0400
Received: from 8bytes.org ([81.169.241.247]:58572 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVM7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 231822C8; Wed, 22 Jul 2020 14:59:03 +0200 (CEST)
Date:   Wed, 22 Jul 2020 14:59:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 0/2] iommu/ipmmu-vmsa: Add entry for R8A774E1 and r8a77961
Message-ID: <20200722125901.GA27672@8bytes.org>
References: <1594722055-9298-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594722055-9298-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:20:53AM +0100, Lad Prabhakar wrote:
> Lad Prabhakar (1):
>   iommu/ipmmu-vmsa: Add an entry for r8a77961 in soc_rcar_gen3[]
> 
> Marian-Cristian Rotariu (1):
>   iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code

Applied, thanks.
