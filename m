Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0E1C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C754206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgD1N6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:58:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:27104 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgD1N6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:58:04 -0400
IronPort-SDR: /74rwQnrjotUXmDSSHPMkq3HGA+2Snwij6E047qaHy1ZXISuL0w13MlSuJMLEbnlFqw0ArDLgZ
 CB/UZ/E7dOcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 06:58:03 -0700
IronPort-SDR: a32MKs1Vc4Ev+5F+oxdlzBOXniz5YLkYcl5nVoILGCbw18YTPY7day0GsxsDV7PMwMEoh9s9rX
 r1jtTbxK5XnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,327,1583222400"; 
   d="scan'208";a="432192414"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2020 06:58:03 -0700
Subject: Re: [PATCH] firmware: stratix10-svc: Drop unnecessary checking for
 and populating /firmware/ node
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org
References: <20200421173256.34897-1-sudeep.holla@arm.com>
 <8ca3666f-8ff1-3c3c-d40b-81c024b37bdd@linux.intel.com>
 <20200423081149.GB18538@bogus>
 <2b2e29ec-ebbf-3ee6-acc9-3722a2fabbfb@linux.intel.com>
 <20200428083238.GA21288@bogus>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <a583b842-585d-888e-49e5-32a16dfab8a6@linux.intel.com>
Date:   Tue, 28 Apr 2020 09:14:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200428083238.GA21288@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/28/20 3:32 AM, Sudeep Holla wrote:
> On Mon, Apr 27, 2020 at 02:12:56PM -0500, Richard Gong wrote:
>> Hi Sudeep,
>>
>> In our dts, firmware is not under root node. You can refer to
>> arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi for details.
>>
>> This is why we need check and populate firmware node.
>>
> 
> Ah that's bad. One of very few DTS I see firmware node not in the root.Per the Devicetree Specification, there is no need to define firmware 
under the root node. Some examples are fsl-ls1012a.dtsi and 
hi6220-hikey.dts.

> But this driver is the only one duplicating the codethen Commit 3aa0582fdb82 should be extended to handle firmware which is 
not defined under the root node. I am not sure if it is doable.
>
Regards,
Richard
