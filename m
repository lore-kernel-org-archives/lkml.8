Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB27C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 06:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E635220663
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 06:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgASGaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 01:30:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:6092 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgASGaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 01:30:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 22:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,337,1574150400"; 
   d="scan'208";a="214929065"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138]) ([10.239.159.138])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2020 22:30:43 -0800
Cc:     baolu.lu@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] iommu: Preallocate iommu group when probing
 devices
To:     Joerg Roedel <joro@8bytes.org>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
 <20200101052648.14295-4-baolu.lu@linux.intel.com>
 <20200117102151.GF15760@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <25e2e7fa-487c-f951-4b2c-27bac5e30815@linux.intel.com>
Date:   Sun, 19 Jan 2020 14:29:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117102151.GF15760@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 1/17/20 6:21 PM, Joerg Roedel wrote:
> On Wed, Jan 01, 2020 at 01:26:47PM +0800, Lu Baolu wrote:
>> This splits iommu group allocation from adding devices. This makes
>> it possible to determine the default domain type for each group as
>> all devices belonging to the group have been determined.
> 
> I think its better to keep group allocation as it is and just defer
> default domain allocation after each device is in its group. But take

I tried defering default domain allocation, but it seems not possible.

The call path of adding devices into their groups:

iommu_probe_device
-> ops->add_device(dev)
    -> (iommu vendor driver) iommu_group_get_for_dev(dev)

After doing this, the vendor driver will get the default domain and
apply dma_ops according to the domain type. If we defer the domain
allocation, they will get a NULL default domain and cause panic in
the vendor driver.

Any suggestions?

Best regards,
baolu

> care about the device hotplug path which might add new devices to groups
> which already have a default domain, or add new groups that might need a
> default domain too.

