Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF98C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DE6206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaT0m8MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgBTQYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:24:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25041 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727709AbgBTQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582215891;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFDhWGMMz3c3KINy5m2oRHAjI8OMHRzcdj6Y8N7UCZs=;
        b=ZaT0m8MZyX0LhG7vejdTQjhegHzXC0+/T99ErcHZmxzb6Q8SGVlL4sy57GfSmZ0yn5Pclf
        Cb98N0k0dLD3iTohrjs3gv3uXX1ENb1Te+MJ08XYguBIX6yqZcvTYFFMuF/ItEdJCh04DT
        5WYuEp/cFmbxx9S40KHRmIpRn8eAvEk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-Br-T_tzhNCSqfCSYaWyiyg-1; Thu, 20 Feb 2020 11:24:44 -0500
X-MC-Unique: Br-T_tzhNCSqfCSYaWyiyg-1
Received: by mail-qt1-f199.google.com with SMTP id l25so2965087qtu.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=EFDhWGMMz3c3KINy5m2oRHAjI8OMHRzcdj6Y8N7UCZs=;
        b=nwv9GAubCg3t3jnUDaYX4gSJNd4G0ZpIsC0ZBMOqi/Zeg5KkBtlOBQmUmtUMw5ke8H
         laxhuzov9tlU3d4hGkyd79GEKn2V6PSQfOJbLgFcVOmr/wd1k8NPOmGO0sv3wKADaxlD
         ifrA4wmc1dCbUDrfLKY39mBuUVkKynNLjbxl6+Qeh78uJVzCe5uhynWWWkdGJ4TP6+je
         GyZ8HYoRsWGF5h0q37MdfAmygfLhBkV6vHNknSjtVx323DS3u5ogX3q3m2jjhrofixFj
         WC+gO2fwcmFAWQQXpJos7ikG5Xs1qvWJ1GpEhD8miZ15yapQJBCYd/9PnBHOvBAtkdrM
         qd4g==
X-Gm-Message-State: APjAAAVnAM+na6exMZIQ5+SFSwFo3Ipg4I0BrxxGv1pI52jFDBpE3MO/
        Sjg/gOe4iyUeA1wWlxUvevAniq2BEJNn3dDiAR+0RFu0YNKr1N42hCLghJ87aHzhHpTCMj2ydo8
        mlKOw0NV35el5fg7bm3u1e8Q2
X-Received: by 2002:ac8:694f:: with SMTP id n15mr27477729qtr.372.1582215883457;
        Thu, 20 Feb 2020 08:24:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyINpVliNmfQj2109URCheTtboHhJq7WugBr7svl7X1mdti4Mdwelx5BzueHntrTa2VfSINqg==
X-Received: by 2002:ac8:694f:: with SMTP id n15mr27477689qtr.372.1582215883126;
        Thu, 20 Feb 2020 08:24:43 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l25sm8111qkk.115.2020.02.20.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:24:42 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:24:41 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: question about iommu_need_mapping
Message-ID: <20200220162441.bhnpwgsmj4vlp3ve@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200219235516.zl44y7ydgqqja6x5@cantor>
 <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 20 20, Lu Baolu wrote:
>Hi Jerry,
>
>On 2020/2/20 7:55, Jerry Snitselaar wrote:
>>Is it possible for a device to end up with dev->archdata.iommu == NULL
>>on iommu_need_mapping in the following instance:
>>
>>1. iommu_group has dma domain for default
>>2. device gets private identity domain in intel_iommu_add_device
>>3. iommu_need_mapping gets called with that device.
>>4. dmar_remove_one_dev_info sets dev->archdata.iommu = NULL via 
>>unlink_domain_info.
>>5. request_default_domain_for_dev exits after checking that 
>>group->default_domain
>>    exists, and group->default_domain->type is dma.
>>6. iommu_request_dma_domain_for_dev returns 0 from 
>>request_default_domain_for_dev
>>    and a private dma domain isn't created for the device.
>>
>
>Yes. It's possible.
>
>>The case I was seeing went away with commit 9235cb13d7d1 ("iommu/vt-d:
>>Allow devices with RMRRs to use identity domain"), because it changed
>>which domain the group and devices were using, but it seems like it is
>>still a possibility with the code. Baolu, you mentioned possibly
>>removing the domain switch. Commit 98b2fffb5e27 ("iommu/vt-d: Handle
>>32bit device with identity default domain") makes it sound like the
>>domain switch is required.
>
>It's more "nice to have" than "required" if the iommu driver doesn't
>disable swiotlb explicitly. The device access of system memory higher
>than the device's addressing capability could go through the bounced
>buffer implemented in swiotlb.
>
>Best regards,
>baolu

Hi Baolu,

Would this mean switching to bounce_dma_ops instead?

Regards,
Jerry

>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

