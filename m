Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1328C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937F820823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgHFClZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:38932 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgHFClF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:05 -0400
IronPort-SDR: CHsjCrtIsrDlLqh9UgVDOh4niu0qtw+uwQI8wq4Zvg5Glw1aJ6uON5gUrqEqew0ggL3JKfSc6I
 rZyWoubSBjxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150453242"
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="150453242"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 19:41:04 -0700
IronPort-SDR: 01z1oTvHs236teqMmA01Epi/XmFNPcF8IQ33M0LLSLbhaOyWO2Oj9W7sHHgOJQRWRp6m/M79fz
 XI2g/oYpLb8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="397112923"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2020 19:41:02 -0700
Cc:     baolu.lu@linux.intel.com,
        RaymondPang-oc <RaymondPang-oc@zhaoxin.com>,
        CobeChen-oc <CobeChen-oc@zhaoxin.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSN?=
 =?UTF-8?Q?=3a_=5bPATCH=5d_iommu/vt-d=3aAdd_support_for_ACPI_device_in_RMRR?=
To:     FelixCui-oc <FelixCui-oc@zhaoxin.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20200802100735.2722-1-FelixCui-oc@zhaoxin.com>
 <73d4a1e4-f6b7-efb0-e225-2e462c838657@linux.intel.com>
 <f6759b9bb2594026b58f9a89e3ce9dc6@zhaoxin.com>
 <9f64d9b6-16e8-73ce-2186-9d8ba49c39f4@linux.intel.com>
 <44ff8f73fa1f49a183a1d8d6d9c2213c@zhaoxin.com>
 <314679b4-7653-041b-9310-73baf8117766@linux.intel.com>
 <1aea042a1b524ef88e491ca2a6d95fb7@zhaoxin.com>
 <36da53a6-00e2-1be1-91b5-d90906a6199f@linux.intel.com>
 <a5fda3f364da4e739736e7d7bc618972@zhaoxin.com>
 <a2658f9c-23fa-bb72-edba-ad61e52085cd@linux.intel.com>
 <9ba29114fcad43d58159fcc7a4d89501@zhaoxin.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1477b1dd-ac48-b49d-77f9-107bb4555b91@linux.intel.com>
Date:   Thu, 6 Aug 2020 10:36:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9ba29114fcad43d58159fcc7a4d89501@zhaoxin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

On 8/5/20 3:37 PM, FelixCui-oc wrote:
> Hi baolu,
> 		Let me talk about why acpi_device_create_direct_mappings() is needed and please tell me if there is an error.

Sure. Before that, let me sync my understanding with you. You have an
acpi namespace device in ANDD table, it also shows up in the device
scope of a RMRR. Current code doesn't enumerate that device for the
RMRR, hence iommu_create_device_direct_mappings() doesn't work for this
device.

At the same time, probe_acpi_namespace_devices() doesn't work for this
device, hence you want to add a home-made
acpi_device_create_direct_mappings() helper.

Did I get it right?

> 		In the probe_acpi_namespace_devices() function, only the device in the addev->physical_node_list is probed,
> 		but we need to establish identity mapping for the namespace device in RMRR. These are two different devices.

The namespace device has been probed and put in one drhd's device list.
Hence, it should be processed by probe_acpi_namespace_devices(). So the
question is why there are no devices in addev->physical_node_list?

> 		Therefore, the namespace device in RMRR is not mapped in probe_acpi_namespace_devices().
> 		acpi_device_create_direct_mappings() is to create direct mappings for namespace devices in RMRR.

Best regards,
baolu
