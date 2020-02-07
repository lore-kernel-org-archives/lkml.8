Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEBFC352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E1420726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O96wtdxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGJ3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:29:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgBGJ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581067761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOOYHtkvRPysCVjAW2MS9yml97iZ6MtUp4OwxVIj6eU=;
        b=O96wtdxbtSDwlMdADmzErnVDWS4/9U26LZGLAvh6NZkWaC/E3RlPg8SbZ5wDhfDyE//+uT
        UqVe5DyOZs72pc9JMRWsL/V4tqgsBezx5heHGV+VjuW6TWRZBWl1+zWLn0MxtgJpiAtQgl
        HxEJHgL5z/ph+i0UMP5xL38RLYzokKY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-4AD0fUrYPmqTrUXBVN9Kww-1; Fri, 07 Feb 2020 04:29:19 -0500
X-MC-Unique: 4AD0fUrYPmqTrUXBVN9Kww-1
Received: by mail-wr1-f72.google.com with SMTP id x15so946126wrl.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iOOYHtkvRPysCVjAW2MS9yml97iZ6MtUp4OwxVIj6eU=;
        b=U35XjWrrxKmOdyCwsMwgnaEoUsZNTRaCgsuwohrSrVeLxcfTrHgodUPGdihblWFDzY
         bwBfMQtNDvuTPPgywMyjClIcaXsRnixivtCOGx55UbBzZAUrlU/nB0uK4qgrC75wvw3h
         TQrovvlOOYlv5WBL5ywv4wp+TcExUK7FMMlZqw1plTDza3MH1BqxPVeHZAcq2FJHuctQ
         K8OTrAOaq7+0Jy98JCc9ivdSDBRnVLkOZrVvCL/d1SnI7oiOYLYtmot+R23OXqodEdO/
         DN+23XbXXrtsUzh4Vdw7ZCVulVONfChokRkKdwCk8iLxnIUAdbLDDY9T16dWdl9Ppt6+
         roOQ==
X-Gm-Message-State: APjAAAUyzlcE859sbrNC5pn3knFw8MGOw9o4qPWgm1OBKtQ2iWU2roHj
        trUu2+ilg/Z4KSvfzSoBeXPKdgJ3F4W3C1teQ/J2Hsd/Kb98wkc4XQ+q0aKL3tx8DCNPWRqia8H
        3mFpyrAhBtGe4GGiNtQ8nh9QJ
X-Received: by 2002:adf:b193:: with SMTP id q19mr3640664wra.78.1581067757722;
        Fri, 07 Feb 2020 01:29:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqx52CMjinFmLJOvrK2em63PNSJWTz7pU6FQlu7AlGQ+F6sZ8fFrI8mL3eJCa7Fib456Wxes2A==
X-Received: by 2002:adf:b193:: with SMTP id q19mr3640645wra.78.1581067757491;
        Fri, 07 Feb 2020 01:29:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u4sm2599245wrt.37.2020.02.07.01.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:29:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86/mmu: Avoid retpoline on ->page_fault() with TDP
In-Reply-To: <20200206221434.23790-1-sean.j.christopherson@intel.com>
References: <20200206221434.23790-1-sean.j.christopherson@intel.com>
Date:   Fri, 07 Feb 2020 10:29:16 +0100
Message-ID: <878sleg2z7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Wrap calls to ->page_fault() with a small shim to directly invoke the
> TDP fault handler when the kernel is using retpolines and TDP is being
> used.  Denote the TDP fault handler by nullifying mmu->page_fault, and
> annotate the TDP path as likely to coerce the compiler into preferring
> the TDP path.
>
> Rename tdp_page_fault() to kvm_tdp_page_fault() as it's exposed outside
> of mmu.c to allow inlining the shim.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---

Out of pure curiosity, if we do something like

if (vcpu->arch.mmu->page_fault == tdp_page_fault)
    tdp_page_fault(...)
else if (vcpu->arch.mmu->page_fault == nonpaging_page_fault)
   nonpaging_page_fault(...)
...

we also defeat the retpoline, right? Should we use this technique
... everywhere? :-)

-- 
Vitaly

