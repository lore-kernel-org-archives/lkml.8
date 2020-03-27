Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B67C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637A120716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSlpCw4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgC0QGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:06:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42672 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgC0QGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585325170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rADClTuM8rDCPwa+pftuZtYBhIX2IPiWqkZ05BPZYE0=;
        b=JSlpCw4VB06QDfm6nFl/AWgn1sohEQ4OEc+rSk558Ro4vZJC9F32OyVpZSrECO8YxUiqVy
        4k2fVAR4YGxtfF9/WEKDjSFE3UIj55kcTGRBxFt4xMl6wOAwdFNTWR3b8b96kcTEKBXE1L
        3/8R7OIUh1s4bSnANnNrXhOzeSMYrEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-K_ZuWAB8M42Xkd9Far-IRA-1; Fri, 27 Mar 2020 12:06:05 -0400
X-MC-Unique: K_ZuWAB8M42Xkd9Far-IRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5251A8018A1;
        Fri, 27 Mar 2020 16:06:03 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 957C460304;
        Fri, 27 Mar 2020 16:05:54 +0000 (UTC)
Subject: Re: [PATCH V10 04/11] iommu/vt-d: Use helper function to skip agaw
 for SL
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED91C@SHSMSX104.ccr.corp.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <310693c3-9bd2-a764-2053-cd785d329ee6@redhat.com>
Date:   Fri, 27 Mar 2020 17:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED91C@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 3/27/20 12:55 PM, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Saturday, March 21, 2020 7:28 AM
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> ---
>>  drivers/iommu/intel-pasid.c | 14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index 191508c7c03e..9bdb7ee228b6 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -544,17 +544,11 @@ int intel_pasid_setup_second_level(struct
>> intel_iommu *iommu,
>>  		return -EINVAL;
>>  	}
>>
>> -	/*
>> -	 * Skip top levels of page tables for iommu which has less agaw
>> -	 * than default. Unnecessary for PT mode.
>> -	 */
>>  	pgd = domain->pgd;
>> -	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
>> -		pgd = phys_to_virt(dma_pte_addr(pgd));
>> -		if (!dma_pte_present(pgd)) {
>> -			dev_err(dev, "Invalid domain page table\n");
>> -			return -EINVAL;
>> -		}
>> +	agaw = iommu_skip_agaw(domain, iommu, &pgd);
>> +	if (agaw < 0) {
>> +		dev_err(dev, "Invalid domain page table\n");
is the dev_err() really requested. I see in domain_setup_first_level(),
there is none.
>> +		return -EINVAL;
>>  	}
> 
> ok, I see how it is used. possibly combine last and this one together since
> it's mostly moving code...

I tend to agree with Kevin. May be better squash the 2 patches. Also not
sure the inline of iommu_skip_agaw() is meaningful then. Also Add commit
messages on the resulting patch.

Note domain_setup_first_level() also could use the helper while we are
it (if declaration moved to common helper). Only the error code differs
in case !dma_pte_present(pgd), ie. -ENOMEM. May be good to align.

Otherwise those stuff may be done in a fixup patch.

Thanks

Eric
> 
>>
>>  	pgd_val = virt_to_phys(pgd);
>> --
>> 2.7.4
> 

