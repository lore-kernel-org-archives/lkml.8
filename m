Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C41C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FDF208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgDQMt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:49:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:13467 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgDQMt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:49:58 -0400
IronPort-SDR: d25U/x8aQ1ROBIR8GmF/MVnTSSJO/15a+p5knOvCm6CoiPnhR+CA1NS08Qot4HenMIMUT/mHy+
 NZS1TXiFvwAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:49:57 -0700
IronPort-SDR: u91vT/8R96PqqOwJZ/zmjrYrVjxn5h++dhiMGTpcQXN/WIusuJSIcX+L8EUakarT17Zf+5T1Rb
 I/aeL3P+rWOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="364320718"
Received: from lzhu11-mobl1.ccr.corp.intel.com (HELO [10.254.212.68]) ([10.254.212.68])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2020 05:49:54 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/3] iommu/vt-d: Allow 32bit devices to uses DMA domain
To:     Christoph Hellwig <hch@lst.de>
References: <20200416062354.10307-1-baolu.lu@linux.intel.com>
 <20200416062354.10307-2-baolu.lu@linux.intel.com>
 <20200416070102.GA12588@lst.de>
 <e11d8138-f704-2f5e-c0b1-70b367a33d5d@linux.intel.com>
 <20200417065054.GA18880@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <741e4882-969f-b102-f91a-f2ef86b6fb90@linux.intel.com>
Date:   Fri, 17 Apr 2020 20:49:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417065054.GA18880@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2020/4/17 14:50, Christoph Hellwig wrote:
> On Thu, Apr 16, 2020 at 03:40:38PM +0800, Lu Baolu wrote:
>>> description.  I'd need to look at the final code, but it seems like
>>> this will still cause bounce buffering instead of using dynamic
>>> mapping, which still seems like an awful idea.
>>
>> Yes. If the user chooses to use identity domain by default through
>> kernel command, identity domain will be applied for all devices. For
>> those devices with limited addressing capability, bounce buffering will
>> be used when they try to access the memory beyond their address
>> capability. This won't cause any kernel regression as far as I can see.
>>
>> Switching domain during runtime with drivers loaded will cause real
>> problems as I said in the commit message. That's the reason why I am
>> proposing to remove it. If we want to keep it, we have to make sure that
>> switching domain for one device should not impact other devices which
>> share the same domain with it. Furthermore, it's better to implement it
>> in the generic layer to keep device driver behavior consistent on all
>> architectures.
> 
> I don't disagree with the technical points.  What I pointed out is that
> 
>   a) the actual technical change is not in the commit log, which it
>      should be

Sorry! I should make the commit message more comprehensive.

>   b) that I still think taking away the ability to dynamically map
>      devices in the identify domain after all the time we allowed for
>      that is going to cause nasty regressions.
> 

This change just asks Intel IOMMU driver to use the default domain
specified by the generic default domain framework, just like what other
vendor iommu drivers do. I understand that some users wants to use DMA
domain for some specific devices when the default domain type is
identity, and vice versa, use identity domain for some devices while
default one is DMA. I think Sai's patch series posted at

https://www.spinics.net/lists/iommu/msg41680.html

is a good start. It changes the default domain with all device drivers
unbound in the generic layer, hence every vendor iommu driver could
benefit from it.

Best regards,
baolu
