Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E432DC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE60D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578643333;
	bh=EGGrFg82AwWBngiHY+ftg7F0R1HyNOaQp8gvY2ISO+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QsmCe9PCPt12Sg44pxtWxn7TscYWCsWt2sulni2bTuvBnJp8Ig/2wY1n+NNTMT3vw
	 cQgxUoLANSi4o8lpiR2n/ITnH36fgr21SwZ+TQipnDk4sgx6i3lxu0Sk3tnbxCaxgK
	 EL7paox5fazwXf5UcNHYlhe90gj4A+wGQzL97UMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgAJICN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgAJICM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:02:12 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B1320678;
        Fri, 10 Jan 2020 08:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578643332;
        bh=EGGrFg82AwWBngiHY+ftg7F0R1HyNOaQp8gvY2ISO+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u0L3uzcmQqZZM6x9wv0Y7nfmO3uZwSBsIuGcuVnBO/opMAojueHHAOkK03CZ7Faaj
         Iov7lqHgklf9rtbq3N+HLmG94IvqUgy/rF/MQH6WWFiPKoWfD+I6nEKKtrfEl2Rqo1
         iEmuf/kkc7kUlQpjJOMY7r1rkSL3mBwBxpEGxywA=
Date:   Fri, 10 Jan 2020 13:31:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 2/2] dmaengine: uniphier-xdmac: Add UniPhier external DMA
 controller driver
Message-ID: <20200110080156.GG2818@vkoul-mobl>
References: <1576630620-1977-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20191227063411.GG3006@vkoul-mobl>
 <20200109211219.57FC.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109211219.57FC.4A936039@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-20, 21:12, Kunihiko Hayashi wrote:
> Hi Vinod,
> 
> Thank you for your comment.
> 
> On Fri, 27 Dec 2019 12:04:11 +0530 <vkoul@kernel.org> wrote:
> 
> > On 18-12-19, 09:57, Kunihiko Hayashi wrote:
> > > This adds external DMA controller driver implemented in Socionext
> > > UniPhier SoCs. This driver supports DMA_MEMCPY and DMA_SLAVE modes.
> > > 
> > > Since this driver does not support the the way to transfer size
> > > unaligned to burst width, 'src_maxburst' or 'dst_maxburst' of
> > 
> > You mean driver does not support any unaligned bursts?
> 
> Yes. If transfer size is unaligned to burst size, the final transfer
> will be overrun.

That is fine, you shoudl return error for bursts which are not aligned
when preparing the descriptors

-- 
~Vinod
