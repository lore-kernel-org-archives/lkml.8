Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4993FC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB0E24672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNepBQpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgBTRcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:32:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42972 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgBTRcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582219942;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhtQcGBTl4nwp8gN4Hlxs7R2XI/3YERGs+eAbVjqzyU=;
        b=HNepBQpK5p5wD9t8EY45sY1m5BeVZiQFgsJaIAia+jtlFLB5hgwxL6PLpwKkP2hRmAcvkj
        BuTqK1RS4k1tCtgyptTCIK8DDwRwC4FQrZnnmnSBUX25ROk5iEKU+IzN+N8JmSTJLC2auk
        Pb6S0E3J/+TFhv8cw6LsmE0ntYP3lsE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-C4v2X6LRPTO6ofN5xEULvA-1; Thu, 20 Feb 2020 12:32:16 -0500
X-MC-Unique: C4v2X6LRPTO6ofN5xEULvA-1
Received: by mail-qv1-f69.google.com with SMTP id c1so3043783qvw.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=qhtQcGBTl4nwp8gN4Hlxs7R2XI/3YERGs+eAbVjqzyU=;
        b=NKrQxrZPqIOJiKeozfYfo6vjkir1dM5Y5q8UPiuDLl9KZ/thMZGkCHaGTC2mL+XU3u
         61J9rz6dsTvJvZ/lbqZf6+fYZS8VsAnO7qwxLGIDbU78GC7XyHFUxinEodDbpA2p4gfD
         sH1/0AT35k5e2hOqMld1dkOSQ1hIQns66B69/ozrfhs+AsxXJqqgEtTlaBNGddg2od4k
         NgS+xBXMw7l39bcZLhSYvA89xHw8nYGve7GFNy1dfZkXio8GkBDlTIahnrxnBMT+bGcT
         nlfLswCG+dg9nXAvbJBzvWTVv4Nxhhb2dq3fc52+AYEVTbUzl2Jjm11Ci2BgIBEqxBq6
         +VkQ==
X-Gm-Message-State: APjAAAXMptHXlfH7pyPumRkGQSA0naJOfWXe0SynKwNIKi+ZzuPrcrgX
        HFNhGLWkTKj4vqm1bjsORQREt7QHJl4iElpy/KUPA5Yr2pMbsBrhiXZNYEOJODLjNlF+jEa3CB6
        ZehVpyVjbpwZ3ecisR4vKSkkm
X-Received: by 2002:ae9:c318:: with SMTP id n24mr30412679qkg.38.1582219936268;
        Thu, 20 Feb 2020 09:32:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhBKg1zI+voTYvvRjbz8lPgbIU+/Asipm4OXQD300Mfs8AbIlFl3jf+jI9oBXC1LvQU7lC9g==
X-Received: by 2002:ae9:c318:: with SMTP id n24mr30412640qkg.38.1582219935836;
        Thu, 20 Feb 2020 09:32:15 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t187sm118485qke.85.2020.02.20.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:32:15 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:32:13 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: question about iommu_need_mapping
Message-ID: <20200220173213.moynvygrdzc66zqg@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200219235516.zl44y7ydgqqja6x5@cantor>
 <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
 <20200220162441.bhnpwgsmj4vlp3ve@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220162441.bhnpwgsmj4vlp3ve@cantor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 20 20, Jerry Snitselaar wrote:
>On Thu Feb 20 20, Lu Baolu wrote:
>>Hi Jerry,
>>
>>On 2020/2/20 7:55, Jerry Snitselaar wrote:
>>>Is it possible for a device to end up with dev->archdata.iommu == NULL
>>>on iommu_need_mapping in the following instance:
>>>
>>>1. iommu_group has dma domain for default
>>>2. device gets private identity domain in intel_iommu_add_device
>>>3. iommu_need_mapping gets called with that device.
>>>4. dmar_remove_one_dev_info sets dev->archdata.iommu = NULL via 
>>>unlink_domain_info.
>>>5. request_default_domain_for_dev exits after checking that 
>>>group->default_domain
>>>   exists, and group->default_domain->type is dma.
>>>6. iommu_request_dma_domain_for_dev returns 0 from 
>>>request_default_domain_for_dev
>>>   and a private dma domain isn't created for the device.
>>>
>>
>>Yes. It's possible.
>>
>>>The case I was seeing went away with commit 9235cb13d7d1 ("iommu/vt-d:
>>>Allow devices with RMRRs to use identity domain"), because it changed
>>>which domain the group and devices were using, but it seems like it is
>>>still a possibility with the code. Baolu, you mentioned possibly
>>>removing the domain switch. Commit 98b2fffb5e27 ("iommu/vt-d: Handle
>>>32bit device with identity default domain") makes it sound like the
>>>domain switch is required.
>>
>>It's more "nice to have" than "required" if the iommu driver doesn't
>>disable swiotlb explicitly. The device access of system memory higher
>>than the device's addressing capability could go through the bounced
>>buffer implemented in swiotlb.
>>
>>Best regards,
>>baolu
>
>Hi Baolu,
>
>Would this mean switching to bounce_dma_ops instead?
>

Never mind. I see that it would go into the dma_direct code.

>Regards,
>Jerry
>
>>_______________________________________________
>>iommu mailing list
>>iommu@lists.linux-foundation.org
>>https://lists.linuxfoundation.org/mailman/listinfo/iommu

