Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D389C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4732220774
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586787536;
	bh=OCT2ifjs9eUW+Niy3jnu8CJR1EG+m0eGSCQqnJEywXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eoB6NlXQCD8/9b8xjQUP1nk44icuCasaV9lHqyO4fMGeZpxHrr5Aq3NJDxzfXjX6x
	 /vfTDIYxm3E6iIOP/2CvBRcQJC8auy6J1lGRIOaXHV49s8p3fbvbwnjhG7Arev38oi
	 M3M2xNWdb21Cxj+9vVHAEbub/6oOfNh1atg4kVRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgDMOSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730530AbgDMOSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:18:46 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1932A20774;
        Mon, 13 Apr 2020 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787525;
        bh=OCT2ifjs9eUW+Niy3jnu8CJR1EG+m0eGSCQqnJEywXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6KlRzR1iUnNaimarPvjFZAIOqAry+EbSShOBKbqgc2tfDnop5w4VEwAmVUkE+Pth
         3iyJIrLm3PaaQYRZ1ye2o6QBxFOrhwZZnlInCj2qdkHnsfUtf67k8UnU2syk404pgr
         fe+/t/eKTLZGJPEUrk5HrVVshxVY3LFUUF7B8198=
Date:   Mon, 13 Apr 2020 22:18:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: dma: fsl-edma: fix ls1028a-edma
 compatible
Message-ID: <20200413141830.GA4722@dragon>
References: <20200306205403.29881-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306205403.29881-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:54:02PM +0100, Michael Walle wrote:
> The bootloader will fix up the IOMMU entries only on nodes with the
> compatible "fsl,vf610-edma". Thus make this compatible string mandatory
> for the ls1028a-edma.
> 
> While at it, fix the "fsl,fsl," typo.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Fixes: d8c1bdb5288d ("dt-bindings: dma: fsl-edma: add new fsl,fsl,ls1028a-edma")

Applied both.  Will try to send for 5.7-rc inclusion.

Shawn
