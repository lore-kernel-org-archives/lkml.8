Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2643C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93772072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpIG9cBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgCSQhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:37:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26700 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727792AbgCSQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584635850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hR8Y6gecjZrE7xBWomQNbLoun26uhWBNW6utFZRF+ls=;
        b=FpIG9cBD82zEb4PPk1N0IZlyItlOMxyzdR85jPtmK3DJ3JzO9kkmd+/VLAvBZotHyDrcNk
        dDJaMGdQaZSJSCS6SrJ+wsC7K+Tnwivojc0ZJyYL0Czute7W5mrYi9l3Hmf3v3QHNAq5yg
        rRIXZF956uuH+QtzQFR2FOgZJBlqYaE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-uaE41x3yMqSXLEDYEkrYvA-1; Thu, 19 Mar 2020 12:37:26 -0400
X-MC-Unique: uaE41x3yMqSXLEDYEkrYvA-1
Received: by mail-wm1-f71.google.com with SMTP id z16so1231894wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 09:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hR8Y6gecjZrE7xBWomQNbLoun26uhWBNW6utFZRF+ls=;
        b=kEbWec1lt976geHhl8WXM+IpgfUPlltl4dXqtGp5wUfFypZjpLd7JKUcS5ZpX5chG5
         tXGNO0Qzo2Gt1PBnwFSYN5N1eVSFJul2jkkjrajGWEaC+CLGmJFGdOSxhrM9vmq4i0Ad
         ePoikr6gRq8vTFAtyMZrJaNZYVH5W3rNBDbtdXv3kofoScms/sTykXFLtPEke1OcjND9
         9O+PUHYii+bkYD77aR3O474Xs2PkGqSqdcwqc6gLIcnNkUoRQpKDtbpaE8aLKZXWseVx
         3vI4hTEXkvp7iVQAdp3FBTAkcFpReROjAkzWRloEioRFLUfE/Md3dokj7t+xpWDTT63S
         JWHA==
X-Gm-Message-State: ANhLgQ10qRP6la5DfytXAA0/58Ap68CqB9D4NYrRz4zyQwdGhwpNoJ0c
        3DJJPBBlaP/uS4gJf6vR8J6Z6Isid4VdfZH4R8fHb9hsPhRMN0iykZ90RgVh3qZIAMhQmIjYTap
        1jpsoL/ae6D/tZ3T//IXspDGP
X-Received: by 2002:a1c:1d4d:: with SMTP id d74mr4601644wmd.123.1584635845599;
        Thu, 19 Mar 2020 09:37:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vubCFzjFjD0GRxT785xTwPdhO0M6RD6kmE9LKXB+pkLtlVm/YrjzoB6HgGKv88zSl7xxa+cUg==
X-Received: by 2002:a1c:1d4d:: with SMTP id d74mr4601627wmd.123.1584635845397;
        Thu, 19 Mar 2020 09:37:25 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id u204sm3730666wmg.40.2020.03.19.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 09:37:24 -0700 (PDT)
Date:   Thu, 19 Mar 2020 12:37:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 11/14] KVM: selftests: Introduce after_vcpu_run hook
 for dirty log test
Message-ID: <20200319163720.GB127076@xz-x1>
References: <20200318163720.93929-1-peterx@redhat.com>
 <20200318163720.93929-12-peterx@redhat.com>
 <20200319075005.hdddb4xiqzuxcqbn@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319075005.hdddb4xiqzuxcqbn@kamzik.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:50:05AM +0100, Andrew Jones wrote:
> >  static void generate_random_array(uint64_t *guest_array, uint64_t size)
> >  {
> >  	uint64_t i;
> > @@ -261,25 +282,23 @@ static void *vcpu_worker(void *data)
> >  	struct kvm_vm *vm = data;
> >  	uint64_t *guest_array;
> >  	uint64_t pages_count = 0;
> > -	struct kvm_run *run;
> > +	struct sigaction sigact;
> >  
> > -	run = vcpu_state(vm, VCPU_ID);
> > +	current_vm = vm;
> > +	vcpu_fd = vcpu_get_fd(vm, VCPU_ID);
> 
> You don't add this call until 13/14, which means bisection is broken.
> Please test the series with 'git rebase -i -x make'.

You're right... I do per-patch test but only for the initial version,
then I test the fixups as standalone changes for latter versions.
This must be a wrongly squashed fixup into the wrong patch.  Sorry.

I'll wait for some more time for another repost.  Thanks,

-- 
Peter Xu

