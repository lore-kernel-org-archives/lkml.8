Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C55C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B277207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBI/P+6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFSAxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:53:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47244 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726926AbgFSAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592528030;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=OzO0DZvXOyrs2UoWemzcvke5bgA0xlYm3qpRtsparnk=;
        b=TBI/P+6P3KO3sM8YAQiKhC61le5W4Z6id5z42aAvGxN+WrHiM8K2eyU+dMUn+ff4H/HwCK
        y6h+WhiKZFtd6CGCvjYFOkz/z8YuzVzoPX4vB2MVLSwpqYQSKDpkMRWRqF8iEM3ozQUe8A
        9C3851v8ha0JZ4Z1G6bPCiSRAYuQ+no=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-h2Yb40AUNjWauPfmd-LYGw-1; Thu, 18 Jun 2020 20:53:49 -0400
X-MC-Unique: h2Yb40AUNjWauPfmd-LYGw-1
Received: by mail-qv1-f69.google.com with SMTP id j4so5433226qvt.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=OzO0DZvXOyrs2UoWemzcvke5bgA0xlYm3qpRtsparnk=;
        b=g0wtl2JEDrS2KEa/zwX0HgLZBRaLhJOXc88hsfMla8tFyMyqQf5eJOnidB2lJZTUlU
         vhj0v+B/zOyYXJ0+MrtAmO1VWjQonhcKLH3StkXuUvLa7XNvxUNgA5Jj6xi45QEP0FIT
         wAPernGsVVYugsB8DW0jxMnzJ7no1G9peZm4Q1lZcur1krS5fUQl85JJrB6AFI/lTTyn
         ghQ7Uuyzruw4TeU0As09/VGWJknSHryjUm54wl0CieJVgvDE3FSk7fTtDVNDuCYqSNE+
         gK1yVKrxagH8TLaChuk37S+qzvRsETat6U/w3Yw/bywY3sChXJpnrEBnlLmClNMvOFTF
         sqxQ==
X-Gm-Message-State: AOAM532e2YSpY6/9JCRB7z/+sTipeFjj4f/eiOPViTY9grVweOOzUCjQ
        58/8IPMMF4kNv/wNXhbJQWp7h4TzQKhQOmNSiRWFSPShTjAcbFDR9ZVUIdtJXUvdC6q6Cfas412
        /I14o4BS/aSbLKmfY06RfKtD/
X-Received: by 2002:a37:8fc4:: with SMTP id r187mr866379qkd.101.1592528028648;
        Thu, 18 Jun 2020 17:53:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiA+6cMQVXFq5FeGfedcN1zN2nB+rxmpe65HllqoVigwROBWuwpKS7U3/P27ciI3EUh+2wXQ==
X-Received: by 2002:a37:8fc4:: with SMTP id r187mr866367qkd.101.1592528028392;
        Thu, 18 Jun 2020 17:53:48 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id f3sm4364250qta.44.2020.06.18.17.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 17:53:47 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:53:46 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix misuse of iommu_domain_identity_map()
Message-ID: <20200619005346.2myy4lwbquxuch76@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
        linux-kernel@vger.kernel.org
References: <20200618233650.9214-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200618233650.9214-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 19 20, Lu Baolu wrote:
>The iommu_domain_identity_map() helper takes start/end PFN as arguments.
>Fix a misuse case where the start and end addresses are passed.
>
>Fixes: e70b081c6f376 ("iommu/vt-d: Remove IOVA handling code from the non-dma_ops path")
>Cc: Tom Murphy <murphyt7@tcd.ie>
>Reported-by: Alex Williamson <alex.williamson@redhat.com>
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

