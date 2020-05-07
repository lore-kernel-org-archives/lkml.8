Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933AAC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB2120870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVrhA0AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEGVrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:47:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35155 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgEGVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588888070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5idkJrYxhm5CKR6p7Gbs2X4uJl1eZjYfow+72g1gg4=;
        b=XVrhA0ALlpy/yMAnnpT/QFcqbFP3QwHejk3D4ONU1ABAoc3F6nnTBwqPo1sx8kdGtmdrtU
        6xyZ1yZLdOeA8/lQLF5fIkivGIVFi5i2Csvwd9nQjYua9B+K3cdigJbq+U/FWYQHzLyrGO
        0sTlC/ZUcqO9+p0yPV1RlICBargEP+0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-Ia2e86xtMJCrar6YxxQUNw-1; Thu, 07 May 2020 17:47:48 -0400
X-MC-Unique: Ia2e86xtMJCrar6YxxQUNw-1
Received: by mail-qt1-f200.google.com with SMTP id x56so8754400qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5idkJrYxhm5CKR6p7Gbs2X4uJl1eZjYfow+72g1gg4=;
        b=aoAmlUjeJpjmHeJybfmFxVGtKvuztUhcEYBMoPECaVQZPr8E0b58v6M7vg/rdYWhYr
         wt65IRtMcZ6m9tEWNwK2kKNrvK+jZ1Gd0+2fUiW99KA4TM2IpI+Ja+klc5w6FUHVlzjL
         mQcSXHfaKMBrG/efBLw2UYuoQBMYkHLH7IMoIa2kbju+tbG2TbbN8sWtPNiaH6m0xpMx
         uWxEpvC+nqcj/6mdvWro61BmUl88EjNV74TFwuR/5heV+A5MaE1auN7Vif3euBl4icES
         9KbXg6s0PMQY3bmHhJuD7W8vuHXgUgbqZemi9ZDq+uKHF0WEQfqiTgAFFsrL+f6a5mPY
         ZHIg==
X-Gm-Message-State: AGi0PuZR53q6MZGAZIopl8SqgvOePeEFjes+lUEF6g2wpw3sNFU3yayT
        I49i8CTpopnkwJAyOthcXAzWiyApzFtmMoedc4I384xiiq9pwiura1WlhbsotnwHCo0EcjY9ATY
        v1Bp1gm5clsPdBBpDb0yDkq5W
X-Received: by 2002:ac8:6f52:: with SMTP id n18mr1046852qtv.239.1588888067431;
        Thu, 07 May 2020 14:47:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypKU8dHnF+0R9W7NWKvWqdYptCothy11u6hec6e2fkEn81AVH/NON7Vco4MKd/Vk4uGjBvtn/Q==
X-Received: by 2002:ac8:6f52:: with SMTP id n18mr1046826qtv.239.1588888066982;
        Thu, 07 May 2020 14:47:46 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t67sm5214265qka.17.2020.05.07.14.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:47:45 -0700 (PDT)
Date:   Thu, 7 May 2020 17:47:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 2/3] vfio-pci: Fault mmaps to enable vma tracking
Message-ID: <20200507214744.GP228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871569380.15589.16950418949340311053.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158871569380.15589.16950418949340311053.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alex,

On Tue, May 05, 2020 at 03:54:53PM -0600, Alex Williamson wrote:
> +/*
> + * Zap mmaps on open so that we can fault them in on access and therefore
> + * our vma_list only tracks mappings accessed since last zap.
> + */
> +static void vfio_pci_mmap_open(struct vm_area_struct *vma)
> +{
> +	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);

A pure question: is this only a safety-belt or it is required in some known
scenarios?

In all cases:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

