Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A22C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E4B2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHXMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:07:13 -0400
Received: from gecko.sbs.de ([194.138.37.40]:57393 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgHXMHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:07:12 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07OC6lco007007
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 14:06:47 +0200
Received: from [167.87.131.75] ([167.87.131.75])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07OC6g9s024384;
        Mon, 24 Aug 2020 14:06:43 +0200
Subject: Re: [RESEND PATCH v3 7/8] mtd: spi-nor: Convert cadence-quadspi to
 use spi-mem framework
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, marex@denx.de
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200601070444.16923-8-vigneshr@ti.com>
 <a86aebbc-943d-6cb3-191c-797709692f80@siemens.com>
 <00394d38-20d9-60a5-0068-5f9f023520c2@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <26caa2e5-6c6e-09a3-902e-843cfee40158@siemens.com>
Date:   Mon, 24 Aug 2020 14:06:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <00394d38-20d9-60a5-0068-5f9f023520c2@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.20 13:44, Vignesh Raghavendra wrote:
> Hi Jan,
> 
> On 8/24/20 11:25 AM, Jan Kiszka wrote:
> [...]
> 
>>> +MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
>>>
>> On the AM65x, this changes mtd->name (thus mtd-id for
>> parser/cmdlinepart) from 47040000.spi.0 to spi7.0. The besides having to
>> deal with both names now, "spi7" sounds like it could easily change
>> again if someone plugs or unplugs some other SPI device. Is this intended?
>>
> 
> You could use DT aliases to make sure OSPI0 is always at given bus num
> (say spi7):
> 
>         aliases {
>                 spi7 = &ospi0;
>         };

Ah, looks like this is a common pattern... Thanks, will try that.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
