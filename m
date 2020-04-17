Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE7C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CEE21D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgDQFKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:10:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:51848 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgDQFKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:10:50 -0400
IronPort-SDR: 23Nnya4jyXwBiGHSOaffZIpPRJVVQzmPg9jFbZy29fhO5kdMDfzOxUcQqBMen/lPYdZIfuVv6j
 AADUlfXm7vNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 22:10:49 -0700
IronPort-SDR: Ru+AzaksJhRHLDZOjcFgQYBfOUAcETbupMhsMVFpsNC8dGKJHTKDJbEIdtNPHMYgY9m8+OdLLs
 jUukL2Thokdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="244610530"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 16 Apr 2020 22:10:49 -0700
Received: from [10.255.156.142] (vramuthx-mobl1.gar.corp.intel.com [10.255.156.142])
        by linux.intel.com (Postfix) with ESMTP id 592125802C9;
        Thu, 16 Apr 2020 22:10:44 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        anders.roxell@linaro.org, arnd@arndb.de, brendanhiggins@google.com,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw, miquel.raynal@bootlin.com,
        piotrs@cadence.com, qi-ming.wu@intel.com, richard@nod.at,
        robh+dt@kernel.org, tglx@linutronix.de, vigneshr@ti.com
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
 <20200416113822.2ef326cb@collabora.com>
 <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
 <20200416122619.2c481792@collabora.com>
 <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
 <20200416131725.51259573@collabora.com>
 <20200416113250.GA185537@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <c8611110-d2ce-7d16-3acc-974d37ab116a@linux.intel.com>
Date:   Fri, 17 Apr 2020 13:10:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416113250.GA185537@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 16/4/2020 7:32 pm, Andy Shevchenko wrote:
> On Thu, Apr 16, 2020 at 01:17:25PM +0200, Boris Brezillon wrote:
>> On Thu, 16 Apr 2020 18:40:53 +0800
>> "Ramuthevar, Vadivel MuruganX"
>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>
>>>>>> we'll be happy to have one more of the existing driver converted to
>>>>>> ->exec_op() ;-).
>>>>> I have completely adapted to ->exec_op() hook up to replace the legacy
>>>>> call-back.
>>>> I suspect porting what you've done to the xway driver shouldn't be too
>>>> complicated.
>>> Not ported from xway_nand.c driver , we have developed from the scratch
>>> to make it work on
>>> Intel LGM SoC , it's new x86 ATOM based SoC, IP itself completely
>>> different and most of the registers won't match.
>>> if we port then it would be ugly and also what are the problem may occur
>>> we do not know.
>> Sorry but IMO they look similar enough to try to merge them.
> I agree. I tried to convince them internally... but here we are.

Agreed,  will do the changes as Boris and Martin suggested, Thanks!

Regards
Vadivel
