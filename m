Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD1AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2324A206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgGVN0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:26:34 -0400
Received: from 8bytes.org ([81.169.241.247]:58624 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgGVN0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:26:34 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8632C2C8; Wed, 22 Jul 2020 15:26:33 +0200 (CEST)
Date:   Wed, 22 Jul 2020 15:26:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Libing Zhou <libing.zhou@nokia-sbell.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drv: iommu: amd: Remove double zero check
Message-ID: <20200722132632.GF27672@8bytes.org>
References: <20200722064450.GA63618@hzling02.china.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722064450.GA63618@hzling02.china.nsn-net.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 02:44:50PM +0800, Libing Zhou wrote:
> The free_pages() does zero check, therefore remove double zero
> check here.
> 
> Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
> ---
>  drivers/iommu/amd/init.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Applied, thanks.
