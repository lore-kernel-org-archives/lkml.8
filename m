Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D170C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A39624688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580212212;
	bh=jW6H9OlD/jgob7HlVx2GQo9Y2WJ5ofqdPX2DH4cN0ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bzm4lPnaboamaCXJ05z99/yncM5MW3JaEP9J1Ch9Mrv3RPPrQEz9qtomJqh2tp1IE
	 KQDnjwA4jeZlbWXV7WcaIxlmr04aSSGJBTciPGvWWJumfV23XF5Q+PaKZBBKdfbTNI
	 C+idsWDA+X7VR+Klf3fjIniCdbQYNtjK+SCRWT0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgA1LuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgA1LuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:50:11 -0500
Received: from localhost (unknown [223.226.101.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C9F214AF;
        Tue, 28 Jan 2020 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580212210;
        bh=jW6H9OlD/jgob7HlVx2GQo9Y2WJ5ofqdPX2DH4cN0ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2cb1YugqwH2Kyc7TSXkHPyGqa4SajqkS1G/5EzKpQt0ER0jWrgg8B8kx41irg/+P
         BmEt88S8IfoSTGx/NcGkJg+nkUDwnlrAk26uaXIsT0nysYKSUK6RZBdYlykEVlKYRt
         KA1+RCXSefrCA4DP2Z8kNYqDDPctG8DwSf0SHbPk=
Date:   Tue, 28 Jan 2020 17:20:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com, vigneshr@ti.com
Subject: Re: [PATCH for-next 0/4] dmaengine: ti: k3-udma: Updates for next
Message-ID: <20200128115006.GT2841@vkoul-mobl>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
 <41c53cc4-fa3e-1ab1-32b8-1d516cda7341@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c53cc4-fa3e-1ab1-32b8-1d516cda7341@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-20, 12:15, Peter Ujfalusi wrote:
> Vinod,
> 
> On 27/01/2020 15.21, Peter Ujfalusi wrote:
> > Hi Vinod,
> > 
> > Based on customer reports we have identified two issues with the UDMA driver:
> > 
> > TX completion (1st patch):
> > The scheduled work based workaround for checking for completion worked well for
> > UART, but it had significant impact on SPI performance.
> > The underlying issue is coming from the fact that we have split data movement
> > architecture.
> > In order to know that the transfer is really done we need to check the remote
> > end's (PDMA) byte counter.
> > 
> > RX channel teardown with stale data in PDMA (2nd patch):
> > If we try to stop the RX DMA channel (teardown) then PDMA is trying to flush the
> > data is might received from a peripheral, but if UDMA does not have a packet to
> > use for this draining than it is going to push back on the PDMA and the flush
> > will never completes.
> > The workaround is to use a dummy descriptor for flush purposes when the channel
> > is terminated and we did not have active transfer (no descriptor for UDMA).
> > This allows UDMA to drain the data and the teardown can complete.
> > 
> > The last two patch is to use common code to set up the TR parameters for
> > slave_sg, cyclic and memcpy. The setup code is the same as we used for memcpy
> > with the change we can handle 4.2GB sg elements and periods in case of cyclic.
> > It is also nice that we have single function to do the configuration.
> 
> I have marked these patches as for-next as 5.5 was not released yet.
> Would it be possible to have these as fixes for 5.6?

Sure but are they really fixes, why cant they go for next release :)

They seem to improve things for sure, but do we want to call them as
fixes..?

-- 
~Vinod
