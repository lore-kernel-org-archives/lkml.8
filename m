Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED81BC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FC72075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="f6xUb0CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgEKJJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:09:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2AC061A0C;
        Mon, 11 May 2020 02:09:09 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3349023E50;
        Mon, 11 May 2020 11:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1589188146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYiBpFWVppKd294LTd9vUa0KsvmfWdjfxWQ8LrUsrj4=;
        b=f6xUb0CZa5gRppVvuuzdVssw51YwDLUpFH/2hOk7zy3nS2DkjuGw35aY4HcwiTiCA8kfj/
        QakS1wGwxdbCdCvps1WmznVZDb41Ew5+Lt9dNoejGoj304qs5dJBxhfo5VOfncp3MUfz2e
        dCPI1ovbk7PVarPmfEmMEdswWVgPXEA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 May 2020 11:08:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: dma: fsl-edma: fix ls1028a-edma
 compatible
In-Reply-To: <20200413141830.GA4722@dragon>
References: <20200306205403.29881-1-michael@walle.cc>
 <20200413141830.GA4722@dragon>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <de4a40b03858930c15724302b3bf7bd0@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn Guo,

Am 2020-04-13 16:18, schrieb Shawn Guo:
> On Fri, Mar 06, 2020 at 09:54:02PM +0100, Michael Walle wrote:
>> The bootloader will fix up the IOMMU entries only on nodes with the
>> compatible "fsl,vf610-edma". Thus make this compatible string 
>> mandatory
>> for the ls1028a-edma.
>> 
>> While at it, fix the "fsl,fsl," typo.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> Fixes: d8c1bdb5288d ("dt-bindings: dma: fsl-edma: add new 
>> fsl,fsl,ls1028a-edma")
> 
> Applied both.  Will try to send for 5.7-rc inclusion.

Are there any news on the inclusion? Unfortunately, I also forgot the 
fixes
tag on patch 2/2, so it won't end up in v5.7.x.

-michael
