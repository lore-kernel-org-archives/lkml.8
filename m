Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEEDC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 05:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FE2206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 05:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD2FLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 01:11:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:15025 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgD2FLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 01:11:52 -0400
IronPort-SDR: pNb6Sc6qTXVqxx4DEKtqHRJEJiRNge1ntLR2DjTcp4x5TG+EZlTBuBLhCMFhkpKwxeArP2nyFA
 W62zAqZEzNwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 22:11:52 -0700
IronPort-SDR: iynYTqi6CzjsUwo9ipu4oYhv2xW9wFSfdVNdnsmzyNXXYbJjanEjK/Ep6x4sLoFGEglmYESeV1
 SG3CjfzqQ+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="294072791"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 28 Apr 2020 22:11:52 -0700
Received: from [10.215.242.51] (ekotax-MOBL.gar.corp.intel.com [10.215.242.51])
        by linux.intel.com (Postfix) with ESMTP id BB49458062D;
        Tue, 28 Apr 2020 22:11:48 -0700 (PDT)
Subject: Re: [RESEND PATCH v6 1/4] mfd: syscon: Add fwnode_to_regmap
To:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
 <9c58aeb1561f28f302921d54aee75942545c4971.1585889042.git.eswara.kota@linux.intel.com>
 <20200417093551.GH2167633@dell>
 <d5b7eb87-7468-a1c4-bf19-d676c8e9c49d@linux.intel.com>
 <20200428100538.GM3559@dell>
 <CAK8P3a1DP2JNUKP7X=+oPypVZqOHrkByOr3hEXw+3mu2fP49Sw@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <a4396fb5-a6e7-8739-560d-9f1242a80773@linux.intel.com>
Date:   Wed, 29 Apr 2020 13:11:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1DP2JNUKP7X=+oPypVZqOHrkByOr3hEXw+3mu2fP49Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/28/2020 6:29 PM, Arnd Bergmann wrote:
> On Tue, Apr 28, 2020 at 12:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>> On Tue, 21 Apr 2020, Dilip Kota wrote:
>>> But, i feel return error for ACPI or oother, looks better because
>>> 'device_node' has fwnode pointer. And provide description
>>> in the header file, mentioning function is success for 'OF' and returns
>>> error for the rest.
>> I don't think this patch adds much to be honest.
>>
>> Better to just do:
>>
>>      device_node_get_regmap(to_of_node(fwnode), false);
>>
>> ... from the call site I think.
> Agreed, or just use the of_node pointer consistently in the driver that uses
> it and avoid the use of the fwnode interface entirely when dealing with a
> modern driver that does not need to support board files any more.
>
>        Arnd
Ok, I will do it in the driver itself and remove the fwnode_to_regmap() 
definition.

Regards,
Dilip
