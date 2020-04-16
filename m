Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F57C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F62206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnRMAWgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506204AbgDPLKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:10:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2506026AbgDPLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587035070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=663Ng6YS73plx9PBQ6c4/yXjrAwiTI7oew+JgnDni+g=;
        b=EnRMAWgDBRo47YvKNCgcyA9M9UPLdbjAkR82PikdQJID6FKK1pPa3h/zEm9ZaWR/oPn3eM
        YVKvutQEX8eEoUytV4WYF8BuSfRjxtS8UnVQO4RiYvsvz/oNVbH91Vj0i16B9NCzMijEPq
        DKS2CXGnCZxNclQ6p2ngC+mBA8SliqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-8WfVj1OmOPmB33JsuWl5mw-1; Thu, 16 Apr 2020 06:46:16 -0400
X-MC-Unique: 8WfVj1OmOPmB33JsuWl5mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94445107ACC4;
        Thu, 16 Apr 2020 10:46:14 +0000 (UTC)
Received: from [10.36.115.53] (ovpn-115-53.ams2.redhat.com [10.36.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C98402719A;
        Thu, 16 Apr 2020 10:46:08 +0000 (UTC)
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Yi L <yi.l.liu@linux.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
 <20200410140604.403cb5b2@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d5c4181f-4542-e8bc-adb6-35eb3d8f5b21@redhat.com>
Date:   Thu, 16 Apr 2020 12:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200410140604.403cb5b2@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/10/20 11:06 PM, Jacob Pan wrote:
> Hi Eric,
> 
> Missed a few things in the last reply.
> 
> On Thu, 9 Apr 2020 09:41:32 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>>> +			intel_pasid_tear_down_entry(iommu, dev,
>>> svm->pasid);  
>> intel_svm_unbind_mm() calls intel_flush_svm_range_dev(svm, sdev, 0,
>> -1, 0); Don't we need to flush the (DEV-)IOTLBs as well?
> Right, pasid tear down should always include (DEV-)IOTLB flush, I
> initially thought it is taken care of by intel_pasid_tear_down_entry().
> 
>>> +			/* TODO: Drain in flight PRQ for the PASID
>>> since it
>>> +			 * may get reused soon, we don't want to
>>> +			 * confuse with its previous life.
>>> +			 * intel_svm_drain_prq(dev, pasid);
>>> +			 */
>>> +			kfree_rcu(sdev, rcu);
>>> +
>>> +			if (list_empty(&svm->devs)) {
>>> +				/*
>>> +				 * We do not free the IOASID here
>>> in that
>>> +				 * IOMMU driver did not allocate
>>> it.  
>> s/in/as?
> I meant to say "in that" as "for the reason that"
ok sorry
> 
>>> +				 * Unlike native SVM, IOASID for
>>> guest use was
>>> +				 * allocated prior to the bind
>>> call.> +				 * In any case, if the free
>>> call comes before
>>> +				 * the unbind, IOMMU driver will
>>> get notified
>>> +				 * and perform cleanup.
>>> +				 */
>>> +				ioasid_set_data(pasid, NULL);
>>> +				kfree(svm);
>>> +			}  
>> nit: you may use intel_svm_free_if_empty()
> True, but I meant to insert ioasid_notifier under the list_empty
> condition in the following ioasid patch.
ok

Thanks

Eric
> 
> 
> Thanks,
> 
> Jacob
> 

