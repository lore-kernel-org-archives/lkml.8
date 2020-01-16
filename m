Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A5DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB012077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS+b+ACi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgAPIv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:51:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45705 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgAPIvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579164713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcKo4JN558IIRrVZSCK2Yu8wbmlLLtuVxtX8dWupKHE=;
        b=aS+b+ACiGqCXmewGwJvHRPCpvBZeHlVX7wpSKuFgwTipMRRZnsdTwmi3IikImFTO3Y9r87
        K5G5BlkPV0V3EV86rJzXuEsYeUTgheMaJDXFM0H3RrrwUE+Duk1Nsy2INix9p1GDdyPJVc
        bV9CmVtvo7Iu5/b5rbIAXUH/5/j6hqM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-IpBxmNVYO7amqdN9BoGM6Q-1; Thu, 16 Jan 2020 03:51:50 -0500
X-MC-Unique: IpBxmNVYO7amqdN9BoGM6Q-1
Received: by mail-wm1-f70.google.com with SMTP id s25so402848wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tcKo4JN558IIRrVZSCK2Yu8wbmlLLtuVxtX8dWupKHE=;
        b=Q0K4nloTFrG7BFenvbWjybcVQAVwqDpVM9wCPxmh3JPzZiAIJwAZaUyWuzc8oRF4Ya
         2Uw7BUe/bO4KbOnRfTcacPN5gg6xm/kedVEJmAuauadeIBUiBpm2o6ivUl0G6WKAA7kZ
         NIbCQUnIn513HUjchmh84v4ug/8SSCxUgT6LDYctGsy3+9VKkR2h58CdSHsJ2k4APcUz
         KKbBC9tyEZKneawktzoRZUNNRRm7qgWGLVnki5Ipys1IXYebvh1DHkqAX7o5kNpxix7m
         LMdQI4sRDLQd59gN20iSXIi54dzPf5O1ekd2wlBvNt5jte3PLxWehODfE3QM1CaEfUSi
         l+vw==
X-Gm-Message-State: APjAAAVQGOVrkBGLYb+ng6VMHTBzwk8CrZ0X+X9quHkDxEdaDTPS8P9i
        raahDN4Tj9KQ1hfBvTfI8V5ykRRJSJCaZgRVqX1OM9eJCI945/873YkCeDCpu8iz+ZTRwuaqr3p
        royhKZCSo7B0aK0voFwyeBRWJ
X-Received: by 2002:a5d:4983:: with SMTP id r3mr2097025wrq.134.1579164709172;
        Thu, 16 Jan 2020 00:51:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+FIo6m3s+4uZkSWR4hOLQFm0Wq420S+sUlfd/qMhhcLzGOztTOn+gv9OW3x8fU0i0Nu6QhA==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr2097004wrq.134.1579164708920;
        Thu, 16 Jan 2020 00:51:48 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v8sm27190979wrw.2.2020.01.16.00.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:51:48 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Liran Alon <liran.alon@oracle.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization out of nested_enable_evmcs()
In-Reply-To: <C6C4003E-0ADD-42A5-A580-09E06806E160@oracle.com>
References: <20200115171014.56405-1-vkuznets@redhat.com> <20200115171014.56405-3-vkuznets@redhat.com> <20200115232738.GB18268@linux.intel.com> <C6C4003E-0ADD-42A5-A580-09E06806E160@oracle.com>
Date:   Thu, 16 Jan 2020 09:51:47 +0100
Message-ID: <877e1riy1o.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

>> On 16 Jan 2020, at 1:27, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
>> 
>> On Wed, Jan 15, 2020 at 06:10:13PM +0100, Vitaly Kuznetsov wrote:
>>> With fine grained VMX feature enablement QEMU>=4.2 tries to do KVM_SET_MSRS
>>> with default (matching CPU model) values and in case eVMCS is also enabled,
>>> fails.
>> 
>> As in, Qemu is blindly throwing values at KVM and complains on failure?
>> That seems like a Qemu bug, especially since Qemu needs to explicitly do
>> KVM_CAP_HYPERV_ENLIGHTENED_VMCS to enable eVMCS.
>
> See: https://patchwork.kernel.org/patch/11316021/
> For more context.

Ya,

while it would certainly be possible to require that userspace takes
into account KVM_CAP_HYPERV_ENLIGHTENED_VMCS (which is an opt-in) when
doing KVM_SET_MSRS there doesn't seem to be an existing (easy) way to
figure out which VMX controls were filtered out after enabling
KVM_CAP_HYPERV_ENLIGHTENED_VMCS: KVM_GET_MSRS returns global
&vmcs_config.nested values for VMX MSRs (vmx_get_msr_feature()).

-- 
Vitaly

