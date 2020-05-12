Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D73BCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DBF206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clatA++v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgELQrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:47:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F80C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:47:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so24215446wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jyNo/FD8DQaK2ucnwvUAdPJG4owWhdE2wKYx5rVGxYI=;
        b=clatA++vihr5sTI7dUupzacVS/N7lCVLYB3yV/N5dBG1B2tTi3SyMIL+AT9rTNF4RM
         whaaPPqLKdjztbhQ6G88AUdB+KZ6RgutaBFsYMakAU5CewEq5W5Z2IKQNcDNtMNOdJia
         S+Wi+0vcoouQSemfz+P2d3pyqaWJGMB1Teackt4osIMCTle/Q/wCH0Ojbm5v82RWocy0
         gxsD8/lNkUdxZjnAAheAO7kqpIMxV9U2axJMnC1aeKnEubwnt8djZJ4/U1FMtzNtqjSj
         9bb/GI48q0BZqY/mg0V1iXr6dJRTXCAScM395uW6IHfakeiexg7rOaqobfoR4E0ezkNz
         gIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyNo/FD8DQaK2ucnwvUAdPJG4owWhdE2wKYx5rVGxYI=;
        b=SjZUSTUCDBj2k1pcUQNp93GPmeKLdIBa5LnBzj0O932lCcJ4AvS0URiRmT+EH15zDo
         C38cV+isqMdg21amQ2FUxlIK48Z5BTuS62Lxk/laR6Q0AC3T0l49/RbbMBLGk042QA68
         BsWErn5tZU3RvpzJSBdnH9dxFnHC7dw+qJTqYU80N38ZZ8D3zFuVVwIEYLYcsl8JIggQ
         sVEe9dPppakEnRyamc/kMwArSvh1ZfzPwUr+Sq5FvOB4vUa7e7R4Ae2i9jsAzNZIrLBF
         b8PkDGadqz1seLPM1pN0i0MYWypwzgAauwQayzhrDLgRJ76Rxv6AplZysDfjXU97PP7F
         bJUg==
X-Gm-Message-State: AGi0PuZ9dXKsAVXynKwrjikJuTYlnLlVMz42q6jUAyx+ada4VuOfuwJs
        DmVBpv/YUeT0GPcUV9ipeBlnIQ==
X-Google-Smtp-Source: APiQypK91Q773XCjNUOrLaxJtSW2iijZMl+ZhfoxDdGoHWSVwaGxx48FOaDpn4r3TPN8Hn4Crs5OJA==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr36930985wmc.76.1589302033401;
        Tue, 12 May 2020 09:47:13 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id a8sm23851429wrg.85.2020.05.12.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:47:12 -0700 (PDT)
Date:   Tue, 12 May 2020 18:47:03 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Bharat Bhushan <bbhushan2@marvell.com>, joro@8bytes.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger.pro@gmail.com, eric.auger@redhat.com
Subject: Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200512164703.GA1902@myrica>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200512105149-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512105149-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:53:39AM -0400, Michael S. Tsirkin wrote:
> >  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >  			       struct virtio_iommu_probe_resv_mem *mem,
> >  			       size_t len)
> > @@ -499,6 +513,9 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
> >  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> >  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> >  			break;
> > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > +			break;
> >  		default:
> >  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> >  		}
> 
> So given this is necessary early in boot, how about we
> add this in the config space? And maybe ACPI too ...

A page_size_mask field is already in the config space and applies to all
endpoints. Here we add a property to override the global value for
individual endpoints. It can be necessary when mixing physical (pass-
through) and virtual endpoints under the same virtio-iommu device.

Thanks,
Jean
