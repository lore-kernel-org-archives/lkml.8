Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EB2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2258A216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIIBs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:48:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:27213 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIIBs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:48:58 -0400
IronPort-SDR: dl9OiB639T105wpa2hfuLPkWy15wpnJOxctgUKv8jTNuWz+Q8iGM9pIIsoP/4H6DGW6iJM04Pi
 nlFAvInmUqVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145969381"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="145969381"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:48:58 -0700
IronPort-SDR: iu1TM291fKLzW13YkpPo+t+WTXhU6OwMMLl9NaOEaJe/bkV8fk4PoCH/IQPpFihFj7CFCpN+QZ
 QO3ApYZpMMQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="407316380"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2020 18:48:55 -0700
Cc:     baolu.lu@linux.intel.com, Tom Murphy <murphyt7@tcd.ie>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
To:     Christoph Hellwig <hch@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org> <20200908055510.GA19078@infradead.org>
 <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
 <20200908062326.GB20774@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a10026ea-6de5-b7b1-80af-8000dfd4601b@linux.intel.com>
Date:   Wed, 9 Sep 2020 09:43:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908062326.GB20774@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 9/8/20 2:23 PM, Christoph Hellwig wrote:
> On Tue, Sep 08, 2020 at 02:04:53PM +0800, Lu Baolu wrote:
>> Do you mind telling where can I find Marek's series?
> 
> [PATCH v10 00/30] DRM: fix struct sg_table nents vs. orig_nents misuse
> 
> on various lists including the iommu one.
> 

It seems that more work is needed in i915 driver. I will added below
quirk as you suggested.

--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -851,6 +851,31 @@ static int __finalise_sg(struct device *dev, struct 
scatterlist *sg, int nents,
         unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
         int i, count = 0;

+       /*
+        * The Intel graphic device driver is used to assume that the 
returned
+        * sg list is not combound. This blocks the efforts of 
converting the
+        * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
+        * device driver work and should be removed once it's fixed in i915
+        * driver.
+        */
+       if (dev_is_pci(dev) &&
+           to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
+           (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
+               for_each_sg(sg, s, nents, i) {
+                       unsigned int s_iova_off = sg_dma_address(s);
+                       unsigned int s_length = sg_dma_len(s);
+                       unsigned int s_iova_len = s->length;
+
+                       s->offset += s_iova_off;
+                       s->length = s_length;
+                       sg_dma_address(s) = dma_addr + s_iova_off;
+                       sg_dma_len(s) = s_length;
+                       dma_addr += s_iova_len;
+               }
+
+               return nents;
+       }
+

Best regards,
baolu
