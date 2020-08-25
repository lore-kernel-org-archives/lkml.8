Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE3A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHYCGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:06:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:22502 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgHYCGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:06:20 -0400
IronPort-SDR: nY5AJJUihEOJMWen1N4GIuFx8gOEXN/kjkIZPq9uT4dPhGzsKT0sUaNRGLYWb+Klqjj4ydsp1p
 0YrPNqv6o0Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="240842061"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="240842061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 19:06:17 -0700
IronPort-SDR: HYdsVlnoJ91iiAQGAlXli/r/WWrNT8Utc6wNaact7bwI3XMdBlMtXIYiqvMBN9k11ezV0TXIdg
 GqTEz9oQCepw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="298931072"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2020 19:06:19 -0700
Received: from [10.213.45.180] (vramuthx-MOBL1.gar.corp.intel.com [10.213.45.180])
        by linux.intel.com (Postfix) with ESMTP id A75095805EB;
        Mon, 24 Aug 2020 19:06:16 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200817070009.4631-1-krzk@kernel.org>
 <2879914d-7ad6-4d98-8b9c-a7646719f766@linux.intel.com>
 <20200824103841.GA26466@kozik-lap>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <46e18f5e-8b5d-676b-19dd-51a57ff83de3@linux.intel.com>
Date:   Tue, 25 Aug 2020 10:06:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824103841.GA26466@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/8/2020 6:38 pm, Krzysztof Kozlowski wrote:
> On Mon, Aug 24, 2020 at 06:36:04PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> Hi,
>>
>>   Thank you for the patches and optimized the code as well.
>>   I have applied your patches and tested, it's working fine
>>   with few minor changes as per Intel's LGM board.
>>
>>   can I send the patches along with patches or we need to wait until
>>   your patch get merge?
> 
> You can just base your patches on top of mine, send them and mention in
> cover letter that they are based on these series (with link to
> discussion).
Thank you very for the confirmation, sure will do the rebase over your 
patch and sent.

Regards
Vadivel
> 
> Best regards,
> Krzysztof
> 
