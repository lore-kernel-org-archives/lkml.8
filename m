Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC62C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CBD206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="hv5Tpu+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgIAOHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:07:22 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49272 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728289AbgIAOEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:04:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id F272452195;
        Tue,  1 Sep 2020 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1598969019; x=1600783420; bh=Cio/AuAeW0HBrdL9zokO5x1JI
        loihymCKFdkc3tu5Rw=; b=hv5Tpu+pfEE+4TqMB+Tacv08S9E1AtZHx0I6ruCR/
        9VTvOFvazAaOvNVY2lYLMmlDfYxFPuYIMoJi0aRcIp8IHzhss3UB5BQdxCQvnaB6
        gYi5qWsqNv/jjrY6YRGBig+QP/e/B9VCTbSRcokU83k8yH4dNx25zrTTPuOHUOgz
        FM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jTjqBeJ6JhO5; Tue,  1 Sep 2020 17:03:39 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 23F644C866;
        Tue,  1 Sep 2020 17:03:39 +0300 (MSK)
Received: from localhost.localdomain (10.199.1.70) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 1 Sep
 2020 17:03:38 +0300
Message-ID: <ceb27ac19cd66e9b8f1c95a27f4c92a3029eda0c.camel@yadro.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: enable lock interface for macronix
 chips
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Tue, 1 Sep 2020 17:06:59 +0300
In-Reply-To: <ae094597-e57e-dff1-f897-bf3cc75f5511@prevas.dk>
References: <20200812151818.16699-1-i.mikhaylov@yadro.com>
         <20200812151818.16699-3-i.mikhaylov@yadro.com>
         <ae094597-e57e-dff1-f897-bf3cc75f5511@prevas.dk>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.1.70]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-31 at 12:55 +0200, Rasmus Villemoes wrote:
> On 12/08/2020 17.18, Ivan Mikhaylov wrote:
> > Add locks for whole macronix chip series with BP0-2 and BP0-3 bits.
> > 
> > Tested with mx25l51245g(BP0-3).
> 
> Hmm. I've tried adding support for locking on Macronix to U-Boot
> (
> https://patchwork.ozlabs.org/project/uboot/patch/20200326114257.1782-3-rasmus.villemoes@prevas.dk/
> ),
> but that was quite a bit more involved than this. Note in particular the
> first part of my commit message:
> 
>   Macronix chips implements locking in (power-of-two multiple of) 64K
>   blocks, not as a fraction of the chip's size.
> 
> At least, that was true for the chip I was interested in and the few
> others whose data sheets I grabbed to double-check. So I'm a bit
> skeptical that this can work out-of-the-box without introducing a new
> struct spi_nor_locking_ops.
> 
> Rasmus

Rasmus, but there is already locking of power-of-two as I see from the code,
I'll double check on hw. Also compared documentation n25q512ax3(micron, which
HAS_LOCK) to mx25l25635e(macronix) and they have same block protection table
bits for example. I'd be glad to hear from maintainers on this spot.

Thanks.

