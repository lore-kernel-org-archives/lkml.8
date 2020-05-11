Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F7C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723EF2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgEKKUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:20:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:45324 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbgEKKUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:20:17 -0400
IronPort-SDR: NpyVzT8A0pswTth/SRUcJKHBD0IB7NRDvcmyLFi7uLrUbY7FuKJpD2uKFkrPQso22wVKmLY+fy
 Oa1jZUc0IbgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 03:20:16 -0700
IronPort-SDR: GykbylfSzbmV/Ej+HXrmqwM/DP9kmXhFLxS8nBCs3aM1cZXR1XgO6RGiLYoXzJ+n6eh2RUiScd
 ecpFI6YZJogQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; 
   d="scan'208";a="340510307"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2020 03:20:16 -0700
Received: from [10.255.160.142] (vramuthx-mobl1.gar.corp.intel.com [10.255.160.142])
        by linux.intel.com (Postfix) with ESMTP id 715E4580569;
        Mon, 11 May 2020 03:20:13 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH 0/6] mtd: spi-nor: Move cadence-qaudspi to spi-mem
 framework
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, marex@denx.de
References: <20200508185411.487-1-vigneshr@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <22e0fc24-fa40-9fe9-8a1b-7b8e5c080020@linux.intel.com>
Date:   Mon, 11 May 2020 18:20:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508185411.487-1-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 9/5/2020 2:54 am, Vignesh Raghavendra wrote:
> Vadivel,
> 
> I have maintained the additional changes needed on top of this series
> for Intel platform that were part of your v12 series here (needs cleanup):
> 
> https://github.com/r-vignesh/linux.git  branch: cqspi-mig
> 
> Please use above branch to test the same.

Thank you for the sending the patches on behalf of, will do the cleanup.
also I have already prepared YAML file , will send as separate patch.

Regards
Vadivel
