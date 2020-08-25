Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444ADC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B00207DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598369856;
	bh=A0hNpMnV1b6qRm4pZRusQY0GV5RU079gfbvhqvOfrgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i3OTYHhjits5sdmbOBwgj7ZmcvBe9wrNq/DDPbmsYuHe6Q8qWLYrOUBi7U82O7aIx
	 uylTSOJjruXoPBDwJLPJeJmdivaJr9drIUMdW6v5DexcbgUjnFrX0Dx3tVBhpzscKU
	 puh9uys+GBG2gdvZanaFksKnjFYyxoHq2dhqpVC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHYPha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHYPh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:37:26 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6684420782;
        Tue, 25 Aug 2020 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598369846;
        bh=A0hNpMnV1b6qRm4pZRusQY0GV5RU079gfbvhqvOfrgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JRPhmo6bGT0hsRlvDavbKomectz6Sx6p3xDanZoQfzsRTm8n47SYOMBIPigouj171
         1a12vqP1rUfqWDOPVUqHjAwHbZMJKa/9U6h6biI8ovoAhOURmSBEf4wyeSdlfmjTS0
         yxTQ1kZrmh9QGLveUWAGRD9BEtwC7ENNSHeZh1uA=
Date:   Tue, 25 Aug 2020 21:07:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, dan.j.williams@intel.com, ardeleanalex@gmail.com
Subject: Re: [RESEND PATCH v2 0/6] dmaengine: axi-dmac: add support for
 reading bus attributes from register
Message-ID: <20200825153722.GU2639@vkoul-mobl>
References: <20200825151950.57605-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825151950.57605-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-20, 18:19, Alexandru Ardelean wrote:
> The series adds support for reading the DMA bus attributes from the
> INTERFACE_DESCRIPTION (0x10) register.
> 
> The first 5 changes are a bit of rework prior to adding the actual
> change in patch 6, as things need to be shifted around a bit, to enable 
> the clock to be enabled earlier, to be able to read the version
> register.

Applied, thanks

-- 
~Vinod
