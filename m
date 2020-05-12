Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E4ACA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDF9206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cf8lJf8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgELRFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:05:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24525 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725851AbgELRFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589303111;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=NQsZdhRM5gIgPtMfQMnU66AoyPDuBpRTokOdoS4x+qA=;
        b=Cf8lJf8rqlrH91D9W5AvpkiOgYRbjUTdlX5UgT8KWcsSfMWgMlf1mxfXVQC6jvPiOF2N1k
        F0GoazS2wqfL0pEGU5HIfMGZq2il4MXBaJ6eflk0xOo9YOnQcwnGKVLVEp1j9jfcbedmf1
        F1JHLzvbCR6eGVIrcp60DcGTfdfHGrA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-CLuodWqyMNG9-8z7XolITw-1; Tue, 12 May 2020 13:05:07 -0400
X-MC-Unique: CLuodWqyMNG9-8z7XolITw-1
Received: by mail-qk1-f200.google.com with SMTP id a83so14212415qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NQsZdhRM5gIgPtMfQMnU66AoyPDuBpRTokOdoS4x+qA=;
        b=sS+feEKvfP2AuJnMM1Y4UOW5h6ICYwomRz8FZA04vnNAAtuhf+eFntSxsu8NweCPhx
         r9TrrJrkYP2wLT36UNp7bf2UEfHruMyItrvFLw79qHCbD866GdR9rqslM+uvG0SEBMVl
         zvXtcbKdFXkAmq20ujCJuGI4sUUM0QizLrpEoTXaHLWNH2me8mxOe6IyeQErJbMPOGP/
         zNeiTqiTLd+QUB0I8A4zYew7NBsHdx7xpYEqLpBjw9CwGY/XDce3ZgiK1y95uIh/8YlJ
         0iTOkOMyXDv1bzS0E6PU5bK0x/e3L9Xvb8vdvDh/D1nbYzbwevSpNkpJT9IxY31KPQR9
         sxDg==
X-Gm-Message-State: AGi0PubDr5LR7bHHMLno6pIyVvNBPIFw/fVPu4HfTKFiu81StBazFSqa
        uiQB9PsXKry4LgEmAqr3buqL0KeQ7nAaxG8QGvtqyPF7+0Y5MSV7so8LHyncr2CI/88LcZ60AkS
        iXGHjtafzLX5RcXLw1KZx/Aaa
X-Received: by 2002:a37:a8cb:: with SMTP id r194mr21225784qke.342.1589303106534;
        Tue, 12 May 2020 10:05:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLE0CmPSv9/GgTYzXzA9V5mJ2Hx5/ecjiiOjRgiYtfr9m5AwRQVkp8vhmle37LvlVE7OKuSmA==
X-Received: by 2002:a37:a8cb:: with SMTP id r194mr21225749qke.342.1589303106181;
        Tue, 12 May 2020 10:05:06 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id h12sm6069301qte.31.2020.05.12.10.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 10:05:04 -0700 (PDT)
Date:   Tue, 12 May 2020 10:05:03 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/3] Replace private domain with per-group default
 domain
Message-ID: <20200512170503.skwillhipuvocaff@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <20200506015947.28662-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200506015947.28662-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 06 20, Lu Baolu wrote:
>Some devices are required to use a specific type (identity or dma) of
>default domain when they are used with a vendor iommu. When the system
>level default domain type is different from it, the vendor iommu driver
>has to request a new default domain with either
>iommu_request_dma_domain_for_dev() or iommu_request_dm_for_dev() in the
>add_dev() callback. Unfortunately, these two helpers only work when the
>group hasn't been assigned to any other devices, hence, some vendor iommu
>driver has to use a private domain if it fails to request a new default
>one.
>
>Joerg proposed an on-going proposal which makes the default domain
>framework to support configuring per-group default domain during boot
>process.
>
>https://lkml.org/lkml/2020/4/14/616
>[This has been applied in iommu/next.]
>
>Hence, there is no need to keep the private domain implementation
>in the Intel IOMMU driver. This patch series aims to remove it.
>
>Best regards,
>baolu
>
>Change log:
>v3->v4:
> - Make the commit message of the first patch more comprehensive.
>
>v2->v3:
> - Port necessary patches on the top of Joerg's new proposal.
>   https://lkml.org/lkml/2020/4/14/616
>   The per-group default domain proposed previously in this series
>   will be deprecated due to a race concern between domain switching
>   and device driver probing.
>
>v1->v2:
> - Rename the iommu ops callback to def_domain_type
>
>Lu Baolu (3):
>  iommu/vt-d: Allow 32bit devices to uses DMA domain
>  iommu/vt-d: Allow PCI sub-hierarchy to use DMA domain
>  iommu/vt-d: Apply per-device dma_ops
>
> drivers/iommu/intel-iommu.c | 396 +++---------------------------------
> 1 file changed, 26 insertions(+), 370 deletions(-)
>
>-- 
>2.17.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

