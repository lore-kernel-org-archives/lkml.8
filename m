Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B539C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207572098B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="el4jZtFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHaKfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:35:13 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:34312 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbgHaKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:35:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4AB3B535F4;
        Mon, 31 Aug 2020 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1598870107; x=1600684508; bh=0VeHPiaZvmXhvT8L0B+62aDY+
        CfD9GT+ShogVgL+t5U=; b=el4jZtFPa2eA0Frb34kzBlWeZJFpu6vmRd2cjaBhR
        Z75GF1kTCnzfpBkaqalOd+Oroc5ZNdG1Rl3AZGlYtTO373d9mzq30UyAitYJk/03
        8G1FjxYGFbNeSAeHijFCSI57QRqXKvk0//0AkpHa/nDGEM7mY8g8Hng240YR6UOJ
        iE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a0OIJ2ihJJKe; Mon, 31 Aug 2020 13:35:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D9E275718C;
        Mon, 31 Aug 2020 13:35:06 +0300 (MSK)
Received: from localhost.localdomain (10.199.3.42) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 31
 Aug 2020 13:35:06 +0300
Message-ID: <6a9ce70135805862b93fdfea07418b0b248445d4.camel@yadro.com>
Subject: Re: [PATCH 0/2] enable lock interface for macronix chips
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Mon, 31 Aug 2020 13:38:21 +0300
In-Reply-To: <20200812151818.16699-1-i.mikhaylov@yadro.com>
References: <20200812151818.16699-1-i.mikhaylov@yadro.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.3.42]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 18:18 +0300, Ivan Mikhaylov wrote:
> TB(Top/Bottome protection bit) is not present in the status register for
> macronix chips, do not touch TB bit in status register in this case.
> Enable lock interface for most of macronix chips which are suitable for it.
> 
> Tested only mx25l51245g (BP0-3).
> 
> Ivan Mikhaylov (2):
>   mtd: spi-nor: do not touch TB bit without SPI_NOR_HAS_TB
>   mtd: spi-nor: enable lock interface for macronix chips
> 
>  drivers/mtd/spi-nor/core.c     | 22 +++++++---
>  drivers/mtd/spi-nor/macronix.c | 75 ++++++++++++++++++++++------------
>  2 files changed, 66 insertions(+), 31 deletions(-)
> 

ping

