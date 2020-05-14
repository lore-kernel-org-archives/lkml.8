Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E039C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E3206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjj886e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgENTDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:03:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45187 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730062AbgENTDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589482985;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=2eOJy4laohP6xg+8A1hLlhQR4abouEEHiBpBsBK1Fng=;
        b=hjj886e8k1v/bZ8eEpkK7+M+hKBrVMpHmTxP1di1/8Nxcdg0QTinEdfFiusdYJI5BbvwIQ
        3Rh36ifmXCukTxKGzxAoe3A4/5n5ndzIj3FDH5EXUe74NWtaQcND5CroEA7/l51X0hS12u
        H/RkIc8qZaos0c8tWRHoOf9Hqm1wBNI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-EAdZ_RIlOEuonFmTCBzjIw-1; Thu, 14 May 2020 15:02:55 -0400
X-MC-Unique: EAdZ_RIlOEuonFmTCBzjIw-1
Received: by mail-qt1-f197.google.com with SMTP id c20so4654533qtw.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2eOJy4laohP6xg+8A1hLlhQR4abouEEHiBpBsBK1Fng=;
        b=LC7DvrMkn5J/za4yJYST5D/9qreiO/LGNqSYN+hqtFMTf8elL6WGZbSD1Thv24BtsA
         k8uLNfcviKtyttkcmfv0oB36v2+VDdaHxCuUiFUnkoEILzvftFvWl+SC3brQm1dGUSFR
         8aFIUhf56x19/BqZMj+b5Tb+tI/j7cj3HZEeaG6J+WIu1UJLMmfdr+/IjZOHRCrmdXZo
         qAH0PTXswDMRI/k32GZ5g1bbitZrHmrXtL2TW8hlHTmkNhikiZnlDWcQ6CVmcct0EvFZ
         /15/4HOnX/Logn0lGQPL4/le9nYtN+o+BKjlcjEf+xobiTnDS9JuqowLE6GlcpUfgH2C
         gfAw==
X-Gm-Message-State: AOAM531c6oKvqX1BNuO1VmqI7u8CazdYTfvBkUYcd2PI558PYlCnd1Dy
        7PtpEf+NebSn+t5ZvidG3/mxU9ujHWuX1kzB+vE55pMgZgjD5GKTADkz440BZ/KSkyvtzjbdAnQ
        UeXGYbnERNo2G6mfl2mj6tTMV
X-Received: by 2002:ac8:1b58:: with SMTP id p24mr6333928qtk.29.1589482974703;
        Thu, 14 May 2020 12:02:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqPwbX6QW79CMjPsIoDBx8Qxq0c+7FfBXcMz8FzBF9t3LMhNJFhfsG5B/dObcvNwywLNEMVQ==
X-Received: by 2002:ac8:1b58:: with SMTP id p24mr6333894qtk.29.1589482974377;
        Thu, 14 May 2020 12:02:54 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z60sm3267882qtc.30.2020.05.14.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:02:53 -0700 (PDT)
Date:   Thu, 14 May 2020 12:02:52 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Murphy <murphyt7@tcd.ie>
Subject: Re: amd kdump failure with iommu=nopt
Message-ID: <20200514190252.ykwdpu7qwzsxjvlp@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Murphy <murphyt7@tcd.ie>
References: <20200514031838.2oklmyrc3n5it2ox@cantor>
 <20200514153623.GM18353@8bytes.org>
 <20200514154020.GN18353@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200514154020.GN18353@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 14 20, Joerg Roedel wrote:
>On Thu, May 14, 2020 at 05:36:23PM +0200, Joerg Roedel wrote:
>> This commit also removes the deferred attach of the device to its new
>> domain. Does the attached diff fix the problem for you?
>> +static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
>> +					  struct device *dev)
>> +{
>>  	if (unlikely(domain->ops->attach_dev == NULL))
>>  		return -ENODEV;
>>
>>  	ret = domain->ops->attach_dev(domain, dev);
>>  	if (!ret)
>>  		trace_attach_device_to_domain(dev);
>> +
>>  	return ret;
>>  }
>
>Sorry, this didn't compile, here is an updated version that actually
>compiles:
>
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 4050569188be..f54ebb964271 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -1889,13 +1889,19 @@ void iommu_domain_free(struct iommu_domain *domain)
> }
> EXPORT_SYMBOL_GPL(iommu_domain_free);
>
>-static int __iommu_attach_device(struct iommu_domain *domain,
>-				 struct device *dev)
>+static bool __iommu_is_attach_deferred(struct iommu_domain *domain,
>+				       struct device *dev)
>+{
>+	if (!domain->ops->is_attach_deferred)
>+		return false;
>+
>+	return domain->ops->is_attach_deferred(domain, dev);
>+}
>+
>+static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
>+					  struct device *dev)
> {
> 	int ret;
>-	if ((domain->ops->is_attach_deferred != NULL) &&
>-	    domain->ops->is_attach_deferred(domain, dev))
>-		return 0;
>
> 	if (unlikely(domain->ops->attach_dev == NULL))
> 		return -ENODEV;
>@@ -1903,9 +1909,19 @@ static int __iommu_attach_device(struct iommu_domain *domain,
> 	ret = domain->ops->attach_dev(domain, dev);
> 	if (!ret)
> 		trace_attach_device_to_domain(dev);
>+
> 	return ret;
> }
>
>+static int __iommu_attach_device(struct iommu_domain *domain,
>+				 struct device *dev)
>+{
>+	if (__iommu_is_attach_deferred(domain, dev))
>+		return 0;
>+
>+	return __iommu_attach_device_no_defer(domain, dev);
>+}
>+
> int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
> {
> 	struct iommu_group *group;
>@@ -2023,7 +2039,12 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
>  */
> struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> {
>-	return dev->iommu_group->default_domain;
>+	struct iommu_domain *domain = dev->iommu_group->default_domain;
>+
>+	if (__iommu_is_attach_deferred(domain, dev))
>+		__iommu_attach_device_no_defer(domain, dev);
>+
>+	return domain;
> }
>
> /*
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

Yes, that works.

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>

