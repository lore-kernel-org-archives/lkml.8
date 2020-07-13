Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEFB206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgGMN3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:29:32 -0400
Received: from 8bytes.org ([81.169.241.247]:52564 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbgGMN3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:29:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3E90736B; Mon, 13 Jul 2020 15:29:31 +0200 (CEST)
Date:   Mon, 13 Jul 2020 15:29:29 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Chao Hao <chao.hao@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        FY Yang <fy.yang@mediatek.com>, TH Yang <th.yang@mediatek.com>,
        ming-fan.chen@mediatek.com, youlin.pei@mediatek.com,
        anan.sun@mediatek.com
Subject: Re: [PATCH v6 00/10] MT6779 IOMMU SUPPORT
Message-ID: <20200713132929.GR27672@8bytes.org>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
 <20200710141349.GJ27672@8bytes.org>
 <1594451493.16172.6.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594451493.16172.6.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 03:11:33PM +0800, Yong Wu wrote:
> The SMI part always go with the IOMMU, Could you also help apply the
> mt6779 SMI basical part [1][2]. Both has already got reviewed-by from
> Rob and Matthias. and the [3] in that patchset is for performance
> improvement, it's not so necessary, it can be send in another patchset.
> 
> 
> [1] https://lore.kernel.org/patchwork/patch/1176833/
> [2] https://lore.kernel.org/patchwork/patch/1176831/

Okay, applied these two to the arm/mediatek branch.


	Joerg
