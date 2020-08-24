Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CCE206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z6zELyB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgHXLp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:45:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37342 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHXLpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:45:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07OBj08r105878;
        Mon, 24 Aug 2020 06:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598269501;
        bh=PfK8wdX2Jnph9XILBjap48TEeqd6pmQM+CiieufI1bA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z6zELyB56pyb7y+8Y+Rx7nfvYhWXsV7ZpjmYGMV/qyPkTIyLVFmuf+91WfAPqEn8I
         pzPKlG+IYJ2KojEVNY2H75I3WBVlvZcp3n9Eo1J8ND8u2KLrJWW9Th1jbKuOTRV9gQ
         JWACCDuB7CgnJdYSWqVGc3mNkLhrgCK+Z1t+j3dk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07OBj0tT084776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 06:45:00 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 06:45:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 06:45:00 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07OBiuUm088539;
        Mon, 24 Aug 2020 06:44:57 -0500
Subject: Re: [RESEND PATCH v3 7/8] mtd: spi-nor: Convert cadence-quadspi to
 use spi-mem framework
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200601070444.16923-8-vigneshr@ti.com>
 <a86aebbc-943d-6cb3-191c-797709692f80@siemens.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <00394d38-20d9-60a5-0068-5f9f023520c2@ti.com>
Date:   Mon, 24 Aug 2020 17:14:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a86aebbc-943d-6cb3-191c-797709692f80@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 8/24/20 11:25 AM, Jan Kiszka wrote:
[...]

>> +MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
>>
> On the AM65x, this changes mtd->name (thus mtd-id for
> parser/cmdlinepart) from 47040000.spi.0 to spi7.0. The besides having to
> deal with both names now, "spi7" sounds like it could easily change
> again if someone plugs or unplugs some other SPI device. Is this intended?
> 

You could use DT aliases to make sure OSPI0 is always at given bus num
(say spi7):

        aliases {
                spi7 = &ospi0;
        };

Regards
Vignesh
