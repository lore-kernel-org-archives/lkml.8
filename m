Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE40A20672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgG3Jv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:51:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:18339 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgG3Jv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:51:57 -0400
IronPort-SDR: UME8XL7Z3Ix6FWrQAULZXIiQCTXAdoqg7bndB7vOky0F/PSbbV6/DPdRzXR8Q6daZGHhaqX2gn
 Mqj4HXnFVKAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="213101325"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="213101325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 02:51:56 -0700
IronPort-SDR: 7NEcFv9Di871vKistPPGOVijhJOGB2pxqS93tB4fTX1Aip1gZ/21Bat8nyfrLbTk8f4800eauL
 qK2YSpU/+8HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="321021577"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2020 02:51:56 -0700
Received: from [10.215.145.173] (ekotax-MOBL.gar.corp.intel.com [10.215.145.173])
        by linux.intel.com (Postfix) with ESMTP id E5869580295;
        Thu, 30 Jul 2020 02:51:52 -0700 (PDT)
Subject: Re: [PATCH 1/1] x86/tsr: Fix tsc frequency enumeration failure on
 lightning mountain SoC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <4fcf09a0786550f5510ec3d9a8628baf7326dd39.1596084248.git.eswara.kota@linux.intel.com>
 <CAHp75VdJc58PSjgnL48jeae+=pHw28sMj3m+HTcVUZZ8kJTYqg@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <3db9ed8c-f024-676e-b048-0cd50f7b1a6d@linux.intel.com>
Date:   Thu, 30 Jul 2020 17:51:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdJc58PSjgnL48jeae+=pHw28sMj3m+HTcVUZZ8kJTYqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/30/2020 3:57 PM, Andy Shevchenko wrote:
> While at this, can you confirm (with maybe good description and
> documentation reference) that the numbers in that array are all
> correct?

Sure, i will add the description.

Regards,
Dilip

