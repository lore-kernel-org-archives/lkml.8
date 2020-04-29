Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCCC83009
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D2A2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD2P3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:29:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:51969 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2P3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:29:36 -0400
IronPort-SDR: ZbHsZ18bGBlN0FU7L68dy+01UZi695KSWoDdpV/tyVtdLTRHUddhYxEWYJ+DgpxtZ5xnuRpwA7
 o3w5WM+9kOWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:29:35 -0700
IronPort-SDR: wHf8dhSjYq1ovl6/KJN6kiRcTLDiQ66kPnQ15/b7VAWrefT12q7R2zmrmTVy6hxv4qabvPobuF
 ghmfu4hGXVAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="432595853"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2020 08:29:35 -0700
Received: from [10.255.166.42] (vramuthx-mobl1.gar.corp.intel.com [10.255.166.42])
        by linux.intel.com (Postfix) with ESMTP id B2A905802C8;
        Wed, 29 Apr 2020 08:29:30 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v4 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        qi-ming.wu@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        hauke.mehrtens@intel.com, anders.roxell@linaro.org,
        vigneshr@ti.com, arnd@arndb.de, richard@nod.at,
        brendanhiggins@google.com, linux-mips@vger.kernel.org,
        robh+dt@kernel.org, miquel.raynal@bootlin.com, tglx@linutronix.de,
        masonccyang@mxic.com.tw, andriy.shevchenko@intel.com
References: <20200429104205.18780-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200429104205.18780-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200429162249.55d38ee8@collabora.com>
 <9d77c64c-d0f9-7a13-3391-d05bf458bdb1@linux.intel.com>
 <20200429164832.6800fc70@collabora.com>
 <2e83a2f7-853c-f0e2-f686-daf1e0649eae@linux.intel.com>
Message-ID: <f5961645-fe35-7ef5-05ff-c1529c5699a1@linux.intel.com>
Date:   Wed, 29 Apr 2020 23:29:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2e83a2f7-853c-f0e2-f686-daf1e0649eae@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 29/4/2020 11:18 pm, Ramuthevar, Vadivel MuruganX wrote:
> +    writel(lower_32_bits(ebu_host->cs[ebu_host->cs_num].nand_pa) |
> +           EBU_ADDR_SEL_REGEN | EBU_ADDR_MASK,
> +           ebu_host->ebu + EBU_ADDR_SEL(reg));
> +
> +    writel(EBU_MEM_BASE_CS_0 | EBU_ADDR_MASK | EBU_ADDR_SEL_REGEN,
> +           ebu_host->ebu + EBU_ADDR_SEL(0));

Good catch!, one will be removed , Thanks !

Regards
Vadivel
