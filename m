Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72EE2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgIHJHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:07:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:40598 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgIHJHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:07:49 -0400
IronPort-SDR: 6D1Hjyo8La0sNx4diRSXocKqkARjruxqlJZu/KuNPdlMjnsJKkbb9bMRqX1MgDa6FwiFoWqrf8
 HkUm37af6Ejw==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="159071117"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="159071117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 02:07:47 -0700
IronPort-SDR: rHwojlhVW0dFkc/kb3riPBbvzthmB+nEUSNIYk5lH7YGRccxAgSKkZK7TtpFoIs7UrFOOSmafa
 FIbPT+cfnJ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="299721582"
Received: from shiche4x-mobl.gar.corp.intel.com (HELO [10.254.211.164]) ([10.254.211.164])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2020 02:07:44 -0700
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
Message-ID: <fd4aef77-4ec6-da94-8508-49b1a21143dd@linux.intel.com>
Date:   Tue, 8 Sep 2020 17:07:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908062326.GB20774@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/8 14:23, Christoph Hellwig wrote:
> On Tue, Sep 08, 2020 at 02:04:53PM +0800, Lu Baolu wrote:
>> Do you mind telling where can I find Marek's series?
> 
> [PATCH v10 00/30] DRM: fix struct sg_table nents vs. orig_nents misuse
> 
> on various lists including the iommu one.
> 

Get it. Thank you!

Best regards,
baolu
