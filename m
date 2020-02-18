Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5363C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C2D207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQHiDiSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:53:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726373AbgBRPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582041203;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Q+LvgNaJ530nPcNkzsaYj3wiY+FNtaDd/w1XVB2i/Z8=;
        b=RQHiDiSJKdxFItonq5XUCHEVV+fB+qM38c9nBpBfGwU7gRbG4uJxcTdQxbcemzU7RiZEDZ
        KrDBCazsbfUY57AtC/ipE8yO+f9yEveVjV5syrKeYY+69qBsG0Ej8H1K3HdNaKkm75Efke
        9gcdt5v2UOdTXskOqgmE6yjuSne5ksk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-szdE0gK1MwSFkEVpoRqaOg-1; Tue, 18 Feb 2020 10:53:14 -0500
X-MC-Unique: szdE0gK1MwSFkEVpoRqaOg-1
Received: by mail-qt1-f197.google.com with SMTP id x8so13379677qtq.14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 07:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Q+LvgNaJ530nPcNkzsaYj3wiY+FNtaDd/w1XVB2i/Z8=;
        b=clYN3Eo3Mm9Jw7sx+CJ71msHIKYROcQe4Xyprx3PhgFibOQFUoxFLA/+PDid1wZydo
         AyS9yaGRJ54A0o/cIE2y/2MoJ28BbZ5s+KppBnfC4o5DI4X4XVWqVXnN7zM+YYmoIQTC
         54W7GhStlBlgP0kbQeZHrQ7NRHtKW/SsoTWEzkW51/2kdsNAhPCqp7H66Lgwf3naTQ7L
         3FkSen5ZEUXzDcvhWwlqzNQ7jfYIPYfxqrUz0ClcYOss2JkUGD187Ls4Q2t+U1ePPI1H
         lw/y1t6nh64yBx22j5oj2nV5FwHkOAGZ0b5hD1xhYAeHCB27bfDdzzGmcVlAtfKWGA0s
         1jSw==
X-Gm-Message-State: APjAAAXU+ylo1G7agnl7QpJTKcHyAokOsU4QnO88TUKtce67YBY49dh4
        jX2r/UrwOruMEfHhv2eui+mZNeZCKV38bz1RagiKUQHaNhjg/qSFq4aoZ8WQiyXqMgvhU9Y9Dq8
        /n4Pkk4WPmHb5QUEKeRfBFEJF
X-Received: by 2002:ac8:2a55:: with SMTP id l21mr18262804qtl.111.1582041193920;
        Tue, 18 Feb 2020 07:53:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxx86PkNdwWLfRNVUu9A9AJPwjH27gBb/xg1DG+ZjwS9PDON2cDdI1BbzPHkVEt5g0bAtA72w==
X-Received: by 2002:ac8:2a55:: with SMTP id l21mr18262775qtl.111.1582041193542;
        Tue, 18 Feb 2020 07:53:13 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x3sm2037808qts.35.2020.02.18.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 07:53:12 -0800 (PST)
Date:   Tue, 18 Feb 2020 08:53:11 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, jroedel@suse.de,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5 v2] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()
Message-ID: <20200218155311.kt6fd25odl2gzu2t@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, jroedel@suse.de,
        David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-4-joro@8bytes.org>
 <83b21e50-9097-06db-d404-8fe400134bac@linux.intel.com>
 <20200218092827.tp3pq67adzr56k7e@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200218092827.tp3pq67adzr56k7e@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Feb 18 20, Joerg Roedel wrote:
>Hi Baolu,
>
>On Tue, Feb 18, 2020 at 10:38:14AM +0800, Lu Baolu wrote:
>> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> > index 42cdcce1602e..32f43695a22b 100644
>> > --- a/drivers/iommu/intel-iommu.c
>> > +++ b/drivers/iommu/intel-iommu.c
>> > @@ -2541,9 +2541,6 @@ static void do_deferred_attach(struct device *dev)
>> >   static struct dmar_domain *deferred_attach_domain(struct device *dev)
>> >   {
>> > -	if (unlikely(attach_deferred(dev)))
>> > -		do_deferred_attach(dev);
>> > -
>>
>> This should also be moved to the call place of deferred_attach_domain()
>> in bounce_map_single().
>>
>> bounce_map_single() assumes that devices always use DMA domain, so it
>> doesn't call iommu_need_mapping(). We could do_deferred_attach() there
>> manually.
>
>Good point, thanks for your review. Updated patch below.
>
>From 3a5b8a66d288d86ac1fd45092e7d96f842d0cccf Mon Sep 17 00:00:00 2001
>From: Joerg Roedel <jroedel@suse.de>
>Date: Mon, 17 Feb 2020 17:20:59 +0100
>Subject: [PATCH 3/5] iommu/vt-d: Do deferred attachment in
> iommu_need_mapping()
>
>The attachment of deferred devices needs to happen before the check
>whether the device is identity mapped or not. Otherwise the check will
>return wrong results, cause warnings boot failures in kdump kernels, like
>
>	WARNING: CPU: 0 PID: 318 at ../drivers/iommu/intel-iommu.c:592 domain_get_iommu+0x61/0x70
>
>	[...]
>
>	 Call Trace:
>	  __intel_map_single+0x55/0x190
>	  intel_alloc_coherent+0xac/0x110
>	  dmam_alloc_attrs+0x50/0xa0
>	  ahci_port_start+0xfb/0x1f0 [libahci]
>	  ata_host_start.part.39+0x104/0x1e0 [libata]
>
>With the earlier check the kdump boot succeeds and a crashdump is written.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

