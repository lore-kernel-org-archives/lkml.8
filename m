Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57003C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A832075A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgHCV0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:26:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:61897 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHCV0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:26:20 -0400
IronPort-SDR: ssX42FjQr0Xie2qeK3Sdgt3U3gQbyeCSKNemYYN9Flo7Wq2fl7JPDFhG6poFfjLVTECWUBq3LX
 QygLZ90mVgVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="151434420"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="151434420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 14:26:19 -0700
IronPort-SDR: RulXwNywhv1eI8mAx/l2FWKIOuoPQn3y862B8fRMfSTGFJVWGCJfUoaFdi2W5KFVaVNAJJW7qT
 9QbcAWE9RiPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="314981446"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.79.119]) ([10.255.79.119])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 14:26:19 -0700
Subject: Re: [PATCH 1/2] libnvdimm/security: 'security' attr never show
 'overwrite' state
To:     Jane Chu <jane.chu@oracle.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
 <cb8c1944-f72c-ecfa-bd3d-276f504542e1@intel.com>
 <73f2eadf-3377-db62-ebd1-1eff99d4842e@oracle.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <69576669-632e-1821-2076-7bc47c0bbd85@intel.com>
Date:   Mon, 3 Aug 2020 14:26:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <73f2eadf-3377-db62-ebd1-1eff99d4842e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2020 2:10 PM, Jane Chu wrote:
> Hi, Dave,
> 
> On 8/3/2020 1:41 PM, Dave Jiang wrote:
>> On 7/24/2020 9:09 AM, Jane Chu wrote:
>>> Since
>>> commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute"),
>>> when issue
>>>   # ndctl sanitize-dimm nmem0 --overwrite
>>> then immediately check the 'security' attribute,
>>>   # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
>>>   unlocked
>>> Actually the attribute stays 'unlocked' through out the entire overwrite
>>> operation, never changed.  That's because 'nvdimm->sec.flags' is a bitmap
>>> that has both bits set indicating 'overwrite' and 'unlocked'.
>>> But security_show() checks the mutually exclusive bits before it checks
>>> the 'overwrite' bit at last. The order should be reversed.
>>>
>>> The commit also has a typo: in one occasion, 'nvdimm->sec.ext_state'
>>> assignment is replaced with 'nvdimm->sec.flags' assignment for
>>> the NVDIMM_MASTER type.
>>
>> May be best to split this fix to a different patch? Just thinking git bisect 
>> later on to track issues. Otherwise Reviewed-by: Dave Jiang 
>> <dave.jiang@intel.com>
> 
> Sure. I take it you meant to separate the typo fix from the change that tests 
> the OVERWRITE bit first?

Yep!

> 
> Regards,
> -jane
