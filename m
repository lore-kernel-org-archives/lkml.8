Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B0820829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QA9aCMGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgERLey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:34:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgERLex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589801692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axzfvw01wKGMv0XjT3WxiaIUsh/NNhfJTMtM8xCVCPM=;
        b=QA9aCMGY3bJDy6m2I2svakduPdfsD+31OcneLp6bfVaizFlFGkjdN5oWCtf3pVsKdkOOPq
        fn5G2dhzttd6f9bkJOswU2kDenNFDh2pWNGwkDl7PNj71SHYhoQR/lrEcIWReUL+i9tQoq
        z1FWPhANeU677gzQg32y0AhkytnK6tY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-c0bH51AyMhaUko4ZCwkNQw-1; Mon, 18 May 2020 07:34:48 -0400
X-MC-Unique: c0bH51AyMhaUko4ZCwkNQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15009A0BD7;
        Mon, 18 May 2020 11:34:46 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 415415C1B5;
        Mon, 18 May 2020 11:34:39 +0000 (UTC)
Message-ID: <680e86ca19dd9270b95917da1d65e4b4d2bb18a9.camel@redhat.com>
Subject: Re: [PATCH 0/2] Expose KVM API to Linux Kernel
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Anastassios Nanos <ananos@nubificus.co.uk>,
        Marc Zyngier <maz@kernel.org>
Cc:     kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Date:   Mon, 18 May 2020 14:34:38 +0300
In-Reply-To: <760e0927-d3a7-a8c6-b769-55f43a65e095@redhat.com>
References: <cover.1589784221.git.ananos@nubificus.co.uk>
         <c1124c27293769f8e4836fb8fdbd5adf@kernel.org>
         <CALRTab90UyMq2hMxCdCmC3GwPWFn2tK_uKMYQP2YBRcHwzkEUQ@mail.gmail.com>
         <760e0927-d3a7-a8c6-b769-55f43a65e095@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 13:18 +0200, Paolo Bonzini wrote:
> On 18/05/20 10:45, Anastassios Nanos wrote:
> > Being in the kernel saves us from doing unneccessary mode switches.
> > Of course there are optimizations for handling I/O on QEMU/KVM VMs
> > (virtio/vhost), but essentially what happens is removing mode-switches (and
> > exits) for I/O operations -- is there a good reason not to address that
> > directly? a guest running in the kernel exits because of an I/O request,
> > which gets processed and forwarded directly to the relevant subsystem *in*
> > the kernel (net/block etc.).
> 
> In high-performance configurations, most of the time virtio devices are
> processed in another thread that polls on the virtio rings.  In this
> setup, the rings are configured to not cause a vmexit at all; this has
> much smaller latency than even a lightweight (kernel-only) vmexit,
> basically corresponding to writing an L1 cache line back to L2.
> 
> Paolo
> 
This can be used to run kernel drivers inside a very thin VM IMHO to break up the stigma,
that kernel driver is always a bad thing to and should be by all means replaced by a userspace driver,
something I see a lot lately, and what was the ground for rejection of my nvme-mdev proposal.


Best regards,
	Maxim Levitsky


