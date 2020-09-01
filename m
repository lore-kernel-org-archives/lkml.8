Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D2C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19C9206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iX43OtAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgIAO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbgIAOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598972153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ha8ceeJV++XLnGMTI8EAI1v8M0o9ZVG9VPLjJ2EiJh8=;
        b=iX43OtAU/iUosFM7/B7qME8EXS75TzkBOb9yP56tckfOP3waXo9yvHD4tCycYc/UOgfzyL
        w2e2sff1mt2wRvBBYQ4+81UcB6T62MYX5sgWzd+Fm1bOi/HfgHMzDD9dvUn0wnxNG5inG6
        EMa5SeG8A4sjI/Ct+vog8n4HSkxtXPc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-OJ7BSQ96PYqA_9FsyNJ_rA-1; Tue, 01 Sep 2020 10:55:51 -0400
X-MC-Unique: OJ7BSQ96PYqA_9FsyNJ_rA-1
Received: by mail-wr1-f71.google.com with SMTP id n15so675351wrv.23
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 07:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ha8ceeJV++XLnGMTI8EAI1v8M0o9ZVG9VPLjJ2EiJh8=;
        b=JGQV985fxUjppEsbG0Dpmq/z7bmerlHelofA2E+KPLWnRk8SOAhHdTgnb8g/X36bYh
         /nRbWBb8Dn3sbXGeOwA19IF7cpor4EwSp1YfL8AgcDUL3xMB1TUGPJdvNSk5R9uwq4oJ
         iTipYiSM2u9UAqGKtCNQcxNOrD9tCRU2uebjmOMwVl+xh4Oy4TrDXs3yuNGhyZ8y28+J
         ZAbPIESl7HZtI1pPFk5y5D2477h3LHXntNO8s57SGABUTiJt5pZMGfyt5+aCzQRUTYme
         eiLno8RYhjy35IrPLEdzLM7mqNBmWOErrTAavYQ6+eLcT2pMzNDX83QX5NNhVXF818XK
         Zi6A==
X-Gm-Message-State: AOAM533WLoqmFhxsDK43FpeSRgajGT0lwmx8P6o4QprYYYMDMGAry3PD
        61uep6fwSj3ilyh99KrCh4oUEbVlG2t2xpyzoZnw1LuXcjOCrnbKvk3llMC5LR6FVfJ2jtTnl+7
        kC+fzy2Mflf3n76t0pQqZNIm0
X-Received: by 2002:a5d:5261:: with SMTP id l1mr2303738wrc.193.1598972150673;
        Tue, 01 Sep 2020 07:55:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0/d8/Yxd2dCD06xdpMy8cay26xVfJk8tZTMxMCzO6R2TkC1wQy0bxfE6FRVZFbEmTC91rOw==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr2303723wrc.193.1598972150439;
        Tue, 01 Sep 2020 07:55:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l15sm2777902wrt.81.2020.09.01.07.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:55:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Jon Doron <arilou@gmail.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/7] KVM: x86: hyper-v: make KVM_GET_SUPPORTED_HV_CPUID more useful
In-Reply-To: <20200807083946.377654-1-vkuznets@redhat.com>
References: <20200807083946.377654-1-vkuznets@redhat.com>
Date:   Tue, 01 Sep 2020 16:55:48 +0200
Message-ID: <87blipwnpn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> KVM_GET_SUPPORTED_HV_CPUID was initially implemented as a vCPU ioctl but
> this is not very useful when VMM is just trying to query which Hyper-V
> features are supported by the host prior to creating VM/vCPUs. The data
> in KVM_GET_SUPPORTED_HV_CPUID is mostly static with a few exceptions but
> it seems we can change this. Add support for KVM_GET_SUPPORTED_HV_CPUID as
> a system ioctl as well.
>
> QEMU specific description:
> In some cases QEMU needs to collect the information about which Hyper-V
> features are supported by KVM and pass it up the stack. For non-hyper-v
> features this is done with system-wide KVM_GET_SUPPORTED_CPUID/
> KVM_GET_MSRS ioctls but Hyper-V specific features don't get in the output
> (as Hyper-V CPUIDs intersect with KVM's). In QEMU, CPU feature expansion
> happens before any KVM vcpus are created so KVM_GET_SUPPORTED_HV_CPUID
> can't be used in its current shape.
>

Ping ;-)

I know Hyper-V emulation in KVM is a very specific topic so it's not
very easy to find reviewers but I'd be very happy if someone could
provide any feedback on the idea (above) in general.

-- 
Vitaly

