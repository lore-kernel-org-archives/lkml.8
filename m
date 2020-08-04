Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3972C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45802086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVctKqeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgHDIAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgHDIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:00:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 01:00:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g19so27575643ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ka4ursZWzHeHcUfmCrEOqwNJhgydKg059CXG4PMpUJs=;
        b=GVctKqeEnzKv6JRsSZhMZ2HE6w6h79tHOaCY1SYi03CdT4HFUPh3sdxTNEKwQLRLLD
         faOVMHGokNejpY9ge0Bi83TyNLyLghDLHPAWPCeEjDauGZkzDNJRp3919MugXe4nW11X
         rLA0SN4Uc8b825rKOKODkOUWijYRgih9cnG4PkXHSeVhAtPG/gq/udGOn3xJcVs2YblA
         9EFZsHbANwiYMpQfwPXYTYdwHQZHaOwcwWShTp3sAbnUUjG/vIlWYeweONtTtTDELaE+
         vhd8VIhCfQec0Qoz+9YcFoMNsigWfuSPeESXwOOYdEYrQo0DkJPMn5SzcO9lEe/5NsA7
         XQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ka4ursZWzHeHcUfmCrEOqwNJhgydKg059CXG4PMpUJs=;
        b=nCQaegK3lQ0bwHL8L9CVSGUEXfIU4lk8XfjHsiUeWyJU3KjCXQ067frL5eokwId5YM
         k0aoD33/OXR20tNqtxEDyftZCsWPl1YWB7g7Sdaukww0Sb7lVp3q5+0sctMyoDDhjEvK
         F1ELqtzCRvxoqxBReXrsi7qBUkn3aP64LRhf0+zsUQikH1yxzvLoEVRD8Z9g5eazT3xv
         kWCV4bkz/J0+Y+pursHaqJWS0M9pOmXbY9sxdw23KAonlZmq86hVI2uIX6hz6JAxfna4
         bpP9hIv2v4r/x+4Rj5k91dA9Wc5495WQP9FWTDtpHUznThqL70/fLa3a+/eYsFav8FIJ
         MD0A==
X-Gm-Message-State: AOAM532rvcBK/uUpeZzq3OagrpQY6Gh4bkWeK/2uzRfqUcbqKlZw6NBZ
        FaydXvU5qhA27Qq/pbL9YEA5tg==
X-Google-Smtp-Source: ABdhPJxrlGJh09BGvoR0QWYGdbnyOOjs0CW/dihPJP8QgqlGuW4JhFWaUSVZDKlIm9nZikFhSK1kww==
X-Received: by 2002:a17:906:990c:: with SMTP id zl12mr19610454ejb.488.1596528048284;
        Tue, 04 Aug 2020 01:00:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id 32sm9260296edf.83.2020.08.04.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 01:00:47 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:00:26 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 12/24] virtio_iommu: correct tags for config space
 fields
Message-ID: <20200804080026.GA284384@myrica>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-13-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-13-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:59:27PM -0400, Michael S. Tsirkin wrote:
> Since this is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

And tested with the latest sparse

> ---
>  include/uapi/linux/virtio_iommu.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 48e3c29223b5..237e36a280cb 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -18,24 +18,24 @@
>  #define VIRTIO_IOMMU_F_MMIO			5
>  
>  struct virtio_iommu_range_64 {
> -	__u64					start;
> -	__u64					end;
> +	__le64					start;
> +	__le64					end;
>  };
>  
>  struct virtio_iommu_range_32 {
> -	__u32					start;
> -	__u32					end;
> +	__le32					start;
> +	__le32					end;
>  };
>  
>  struct virtio_iommu_config {
>  	/* Supported page sizes */
> -	__u64					page_size_mask;
> +	__le64					page_size_mask;
>  	/* Supported IOVA range */
>  	struct virtio_iommu_range_64		input_range;
>  	/* Max domain ID size */
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
> -	__u32					probe_size;
> +	__le32					probe_size;
>  };
>  
>  /* Request types */
> -- 
> MST
> 
