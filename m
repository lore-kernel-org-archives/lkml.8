Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E95CC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271122072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiJ7j2KJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgCSRCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:02:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48909 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727235AbgCSRCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584637331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcptVRAiRJzuVIh/GlEcDrXPm4fcrg5LC9wzz8mwMkA=;
        b=hiJ7j2KJXY9hxirrKyCt/EeQ4eyVSP3JYZHSqHYUDkzJBYImEimsX3T7dARHo2UFf62B57
        7lpM9npNJ6/rkg4yroV3iOdVHG2UkvK0W21V2/fuOzwIzWuxf/vlrCETp0c7ztYx2Z5E4z
        /M8RM16VlluAVlJH+VeVjy+4YbrCI2w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Oaog_YhOMhK9VeFzz-7how-1; Thu, 19 Mar 2020 13:02:10 -0400
X-MC-Unique: Oaog_YhOMhK9VeFzz-7how-1
Received: by mail-wr1-f69.google.com with SMTP id o9so1306567wrw.14
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcptVRAiRJzuVIh/GlEcDrXPm4fcrg5LC9wzz8mwMkA=;
        b=Oe5kyqd9Uz0GyUX+4BL6Xct+8WmtJ2wiBa4OVem9HVEyUcqLBm/IwSGR88aho1WtIk
         4U/s9rb2TLUw/H6cT31eY8IhwYfnF1eFySZPsv45qczWrTJXgriqISW5/eIAWjjMf3xB
         YkiZ8FsRpXR6UOaWlIbPD7QDNeXMrt9Sqyo2XAwZpiCDyMdKNqz2ux1xD62kXZEiM/+B
         CPkrFKqJg3N0uN15xXfMGGrc2iujHjcVk7yVtMN6uJ+aNc2B2SYCyVXGEPbK/tNSp37n
         AoPSJ4kLMNN0ybJImJWkDzrGYcvn/bDI5lrb46DTe7NcEZ8P92VQrcefMeR5h7MSotIg
         ZPaQ==
X-Gm-Message-State: ANhLgQ0zJI7DXw5+HrI7PMqEIAs4sGlSTY2Zy3OtU65hkLuEmz20G4Vg
        kfQMziV0hsILbScv8wBC5TAdj7cxi42rOofVTHGodZs63lPabHNYnY0/bc9SityPcyn2bV2/vNy
        vY85/EmCarAolUB0QHztKjtmr
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr4782574wma.122.1584637327683;
        Thu, 19 Mar 2020 10:02:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsi9VPiZWxLt0oHTo1rX4JelGxRAWlaC5KYb5zXFBMD8y3tgBSoJTkpKrPnAHuKniGG0Q9H/w==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr4782450wma.122.1584637326515;
        Thu, 19 Mar 2020 10:02:06 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id e9sm4186074wrw.30.2020.03.19.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:02:05 -0700 (PDT)
Date:   Thu, 19 Mar 2020 13:02:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 12/14] KVM: selftests: Add dirty ring buffer test
Message-ID: <20200319170201.GC127076@xz-x1>
References: <20200318163720.93929-1-peterx@redhat.com>
 <20200318163720.93929-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200318163720.93929-13-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:37:18PM -0400, Peter Xu wrote:
> +static void dirty_ring_collect_dirty_pages(struct kvm_vm *vm, int slot,
> +					   void *bitmap, uint32_t num_pages)
> +{
> +	/* We only have one vcpu */
> +	static uint32_t fetch_index = 0;
> +	uint32_t count = 0, cleared;
> +
> +	/*
> +	 * Before fetching the dirty pages, we need a vmexit of the
> +	 * worker vcpu to make sure the hardware dirty buffers were
> +	 * flushed.  This is not needed for dirty-log/clear-log tests
> +	 * because get dirty log will natually do so.
> +	 *
> +	 * For now we do it in the simple way - we simply wait until
> +	 * the vcpu uses up the soft dirty ring, then it'll always
> +	 * do a vmexit to make sure that PML buffers will be flushed.
> +	 * In real hypervisors, we probably need a vcpu kick or to
> +	 * stop the vcpus (before the final sync) to make sure we'll
> +	 * get all the existing dirty PFNs even cached in hardware.
> +	 */
> +	sem_wait(&dirty_ring_vcpu_stop);
> +
> +	/* Only have one vcpu */
> +	count = dirty_ring_collect_one(vcpu_map_dirty_ring(vm, VCPU_ID),
> +				       slot, bitmap, num_pages, &fetch_index);
> +
> +	cleared = kvm_vm_reset_dirty_ring(vm);
> +
> +	/* Cleared pages should be the same as collected */
> +	TEST_ASSERT(cleared == count, "Reset dirty pages (%u) mismatch "
> +		    "with collected (%u)", cleared, count);
> +
> +	DEBUG("Notifying vcpu to continue\n");

This line is removed later so hidden from my eyes too... but it'll
also break the bisection.  Fixed now.

> +	sem_post(&dirty_ring_vcpu_cont);
> +
> +	pr_info("Iteration %ld collected %u pages\n", iteration, count);
> +}

-- 
Peter Xu

