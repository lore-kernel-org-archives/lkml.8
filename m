Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E105C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4528020732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgIHGKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:10:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:46899 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbgIHGKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:10:41 -0400
IronPort-SDR: iepvQLS4qtraOKeTpuVDhJ09w8ebRiIB5BGOQrB3p1bLq6fJJyxUDRJcFo/2cD27MYJyJV9Auh
 /q+MMFxlRwxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="145789085"
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="145789085"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 23:10:40 -0700
IronPort-SDR: WV1iGX4PezN4uM+SBYmsobq8wQfeNgX5mSccINOILxX+uqqhJ1fSilEU4XPtxc6P1gSWzvsQfz
 ZmYSq5PMiL1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="407028868"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2020 23:10:38 -0700
Cc:     baolu.lu@linux.intel.com, intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
To:     Christoph Hellwig <hch@infradead.org>, Tom Murphy <murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
 <20200907070035.GA25114@infradead.org>
 <CALQxJute8_y=JsW4UV1awSccOjxT_1OyPdymq=R_PurVQzENeQ@mail.gmail.com>
 <20200908053619.GA15418@infradead.org> <20200908055510.GA19078@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9655fdc9-6ea0-e4c1-e104-a9a8981ecb1e@linux.intel.com>
Date:   Tue, 8 Sep 2020 14:04:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908055510.GA19078@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 9/8/20 1:55 PM, Christoph Hellwig wrote:
> On Tue, Sep 08, 2020 at 06:36:19AM +0100, Christoph Hellwig wrote:
>> On Mon, Sep 07, 2020 at 09:18:50PM +0100, Tom Murphy wrote:
>>> Yeah we talked about passing an attr to map_sg to disable merging at
>>> the following microconfernce:
>>> https://linuxplumbersconf.org/event/7/contributions/846/
>>> As far as I can remember everyone seemed happy with that solution. I
>>> won't be working on this though as I don't have any more time to
>>> dedicate to this. It seems Lu Baolu will take over this.
>>
>> I'm absolutely again passing a flag.  Tha just invites further
>> abuse.  We need a PCI ID based quirk or something else that can't
>> be as easily abused.
> 
> Also, I looked at i915 and there are just three dma_map_sg callers.
> The two dmabuf related ones are fixed by Marek in his series, leaving

Do you mind telling where can I find Marek's series?

Best regards,
baolu

> just the one in i915_gem_gtt_prepare_pages, which does indeed look
> very fishy.  But if that one is so hard to fix it can just be replaced
> by an open coded for_each_sg loop that contains manual dma_map_page
> calls.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
