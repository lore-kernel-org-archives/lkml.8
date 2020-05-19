Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C250DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9238A207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNjmuoW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgESHKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:10:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55744 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726893AbgESHKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589872201;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=X/KmdOdFxUdbyg6uVeDwn3rmdrmoPPzdKKlBwCaZDW8=;
        b=WNjmuoW/PIJ1hRvYgLOlGXSIEnUUHJPCFf16hhkOQmcoCtimpUZrNHmQtFV1FfDcG/5cSY
        E3aF7mENkE5nfsXds8KKUucHy8YYJKdqpCv2LeO/Z1iCocOK9keiRklxgZoaLIrzgyF/0R
        6bDzH21+jKCEEGTnwLDLPo0Zv3qRHCU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-XcNjyHlMNnmQIc9_pP9iwA-1; Tue, 19 May 2020 03:09:57 -0400
X-MC-Unique: XcNjyHlMNnmQIc9_pP9iwA-1
Received: by mail-qk1-f199.google.com with SMTP id y64so13713450qkc.19
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=X/KmdOdFxUdbyg6uVeDwn3rmdrmoPPzdKKlBwCaZDW8=;
        b=fuynEO2q4omzBIwA6x27RXeFRYFQRE/sVp8vKAZDT8TGFeKzhbqO+R6VglJhNFpnQF
         FX9TwTWW6aKDCsOHBDSMQ+5UYbn4UVBy5oceofGQsVqsA57cbSEnphq+enh0adn8UdgC
         WwZ5vkzl4zqvBWOd6M+wL7U1LDVhveGTAcDgUgvFU2oArecicg/t4bm1xFM5NxY/KNC/
         x75nHTpTTbxexrr1ulveibVU8RysDcBVbqw7VqSqMCBVOg/6rMmsFZVb/YFoClFq/BA7
         L68qdTQNby1CcojpIqb1mLIoSn9iTg4vj5hBsZI0z9ubFnpcz4pMz1B6fEtfIleKvCsH
         hPNw==
X-Gm-Message-State: AOAM531E84uXGGqlNUHtVFMVL1gT5A44+4nC9wUfHFVJm8O5p2IsB2RJ
        BDZv+gCaYIUx+oh6qKps06BmITHQI8OMX2Hj7VUaRWNFbTdBX0rGQfsl/1PjDup90B8Ki2mI+ye
        E0RGVWW01LspeS17GB8Q68sMk
X-Received: by 2002:ac8:1416:: with SMTP id k22mr20425544qtj.205.1589872196663;
        Tue, 19 May 2020 00:09:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0YMv2+wLa6G/v8B+VuLF5wHB7dK7W95KBy80WPMbmb/VrIkRFFWmt1lxr/8MBtjeVz988yg==
X-Received: by 2002:ac8:1416:: with SMTP id k22mr20425523qtj.205.1589872196359;
        Tue, 19 May 2020 00:09:56 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t88sm11138889qtd.5.2020.05.19.00.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 00:09:55 -0700 (PDT)
Date:   Tue, 19 May 2020 00:09:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200519070953.dj46pvdqvqdglr4p@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
 <20200515182600.GJ8135@suse.de>
 <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
 <20200518132656.GL8135@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200518132656.GL8135@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon May 18 20, Joerg Roedel wrote:
>On Fri, May 15, 2020 at 08:23:13PM +0100, Robin Murphy wrote:
>> But that's not what this is; this is (supposed to be) the exact same "don't
>> actually perform the attach yet" logic as before, just restricting it to
>> default domains in the one place that it actually needs to be, so as not to
>> fundamentally bugger up iommu_attach_device() in a way that prevents it from
>> working as expected at the correct point later.
>
>You are right, that is better. I tested it and it seems to work. Updated
>diff attached, with a minor cleanup included. Mind sending it as a
>proper patch I can send upstream?
>
>Thanks,
>
>	Joerg
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 7b375421afba..a9d02bc3ab5b 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -693,6 +693,15 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
> 	return ret;
> }
>
>+static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>+				     struct device *dev)
>+{
>+	if (domain->ops->is_attach_deferred)
>+		return domain->ops->is_attach_deferred(domain, dev);
>+
>+	return false;
>+}
>+
> /**
>  * iommu_group_add_device - add a device to an iommu group
>  * @group: the group into which to add the device (reference should be held)
>@@ -705,6 +714,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
> {
> 	int ret, i = 0;
> 	struct group_device *device;
>+	struct iommu_domain *domain;
>
> 	device = kzalloc(sizeof(*device), GFP_KERNEL);
> 	if (!device)
>@@ -747,7 +757,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>
> 	mutex_lock(&group->mutex);
> 	list_add_tail(&device->list, &group->devices);
>-	if (group->domain)
>+	domain = group->domain;
>+	if (domain  && !iommu_is_attach_deferred(domain, dev))
> 		ret = __iommu_attach_device(group->domain, dev);
> 	mutex_unlock(&group->mutex);
> 	if (ret)
>@@ -1653,9 +1664,6 @@ static int __iommu_attach_device(struct iommu_domain *domain,
> 				 struct device *dev)
> {
> 	int ret;
>-	if ((domain->ops->is_attach_deferred != NULL) &&
>-	    domain->ops->is_attach_deferred(domain, dev))
>-		return 0;
>
> 	if (unlikely(domain->ops->attach_dev == NULL))
> 		return -ENODEV;
>@@ -1727,8 +1735,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> static void __iommu_detach_device(struct iommu_domain *domain,
> 				  struct device *dev)
> {
>-	if ((domain->ops->is_attach_deferred != NULL) &&
>-	    domain->ops->is_attach_deferred(domain, dev))
>+	if (iommu_is_attach_deferred(domain, dev))
> 		return;
>
> 	if (unlikely(domain->ops->detach_dev == NULL))
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

This worked for me as well.

