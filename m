Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA1C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73B422527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx7+zkfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgA0Psl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:48:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45780 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728783AbgA0Psl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580140120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ev2DavOVeAfQ+Vr264Gj58ZrieELq0AxbNA2pCfvoOE=;
        b=Jx7+zkfquGh/wEaZ4o+i5CUhE86A8hRwTmM3Cul0EyVkRZBe+3RXUYg2s9/NHatNminO2L
        TOJYJ6JgQZrOcvAN7EwY/1oM6Co/dHXs7ES+2iUNd+2eDxl0QIcO4RxOpkgJyYFzCuuWlj
        52SAP4/F8aDOswdi/ha0UbAtFxBMt9M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-kTswgzqbMlKUPSXggGUvxQ-1; Mon, 27 Jan 2020 10:48:36 -0500
X-MC-Unique: kTswgzqbMlKUPSXggGUvxQ-1
Received: by mail-wm1-f71.google.com with SMTP id o193so1138362wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 07:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ev2DavOVeAfQ+Vr264Gj58ZrieELq0AxbNA2pCfvoOE=;
        b=hY5eFcJroUA+7KI+g49I/ijB/+zbuq3lYBEpB8c8WDpW8OxZ0V+TTQFCXY8VBimr2M
         6wGDmX/ocWwgwFTpz3GfMycL9Sk0dI/hUaGidddjvy4G9SjEU3u08R0cG1tWGs6sVxBU
         LhEcLGtP38pJiDWDZ4zOJ3iJKNO+nx/F5vO1mwwtIhp5OfNbWn13Qnv2FrJ5Heh6jkw8
         /5g118c+k6VmUjRZh3Q6TFeVh4fnFJjuRA+OJobiwgGykSdNk5PQgliFLFdh2WD36sYM
         Hrh6d1mD1Vfsve9DmQkLBcrQsHTMgwk0v20FhoWyAVTkb0r3efl6LxQhcl/OpsvSKTZs
         Vlug==
X-Gm-Message-State: APjAAAUu9VzmEnyB7JGF4d1lJkmArzGjuM4KaaFB7lNiAcB2ZVtAzRHA
        MC836ZRTNrtDgjXiIg7udMTVCPnGFb9cv5EDUI7vYYvNjAHSoWFIG+6boTYeRZ+ahz5OUBdZb5d
        ouk/nkkQXqmIfvYGarynz4MVR
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr15306294wmi.152.1580140115578;
        Mon, 27 Jan 2020 07:48:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyz7Ff2a08B/s8P5i+xjyQx3D2QYf/6C1n6kzVc+oMGzILnnFPXnRX3sq5VnGumfLVmxX4BYQ==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr15306280wmi.152.1580140115405;
        Mon, 27 Jan 2020 07:48:35 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w13sm21846893wru.38.2020.01.27.07.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:48:34 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] KVM: x86: VM alloc bug fix and cleanup
In-Reply-To: <20200127004113.25615-1-sean.j.christopherson@intel.com>
References: <20200127004113.25615-1-sean.j.christopherson@intel.com>
Date:   Mon, 27 Jan 2020 16:48:34 +0100
Message-ID: <87zhe8lx2l.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Fix a (fairly) long standing NULL pointer dereference if VM allocation
> fails, and do a bit of clean up on top.
>
> I would have preferred to omit patch 01, i.e. fix the bug via patch 02,
> but unfortunately (long term support) kernel 4.19 doesn't have the
> accounting changes, which would make backporting the fix extra annoying
> for no real benefit.
>
> Sean Christopherson (3):
>   KVM: x86: Gracefully handle __vmalloc() failure during VM allocation
>   KVM: x86: Directly return __vmalloc() result in ->vm_alloc()
>   KVM: x86: Consolidate VM allocation and free for VMX and SVM
>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

