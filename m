Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AAFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8311207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AV/TTAel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCEQes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:34:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24053 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgCEQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583426086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNagLYm3IRt75F9jKpC8khl3GYIIHmvh5jxy9sQJTtk=;
        b=AV/TTAel/CjmDXkodHQcMgSfCIqxr9HoiZzOi7COhVx37z08K3b//p7f1jGNb0Sxsx8zOk
        100cLyZ+tXWSR2/TCauTmZOVLH3vJ4pBCu5eFCb5d+SxjgFF/4vK/kBF+WEdtxojD4rFab
        fCoL4umbc9ggutmkVLSOuOKl5vlKTjM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-d_ORmkYfNzyWxZrbviCGog-1; Thu, 05 Mar 2020 11:34:45 -0500
X-MC-Unique: d_ORmkYfNzyWxZrbviCGog-1
Received: by mail-wr1-f70.google.com with SMTP id n7so2517498wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WNagLYm3IRt75F9jKpC8khl3GYIIHmvh5jxy9sQJTtk=;
        b=Q5QtU1O4BUmnK6t0IyicGvgAEoK1N/U/JBCj7bDnR3XIhHzwBx7A3ORE4nb+ymbCtS
         MWDc8mlw2qqOp/FtYwYZd4/gKg9BPSiSUFOGuGpsvtub9njuKYBQNYvGf1BuPM4C3PAU
         T2RRLpOjowyULYsCD377rHe4xtoSiNXJuuZ6hlP8VFuBhM0k46jxWZLM/EmI9x9xPeUI
         nWrdblJ2v6dmtzFDvDXyoqXQrawlKp4Hb5nEUvjAsYtxgEpTnGqiwcRI8ebGC/dCVZJE
         umECVHphk+n5stzhMRj/ktJHBh2ZTRvTrKi6hOYJKSFeXSa+JDtT+K9F0OjMamNaIo/i
         hVtA==
X-Gm-Message-State: ANhLgQ149RZEV8MC0g7aR6+DjuQM8Cft4fC1FLFICRmZ80DR+hy6yE4Y
        Rj+LcXckKTlyeL2ZcE45zUhJKpv8QGXKCQ+0uxIBNdgEuWXw4zTFKcNdZ1ML5veD0GveQWT8T+t
        JjzHOM/qmulmwpFZhxOF6vB6b
X-Received: by 2002:a05:600c:54f:: with SMTP id k15mr8396966wmc.96.1583426083675;
        Thu, 05 Mar 2020 08:34:43 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtaAEVKge+gDK1MAbN9me2WDKnBCDFWySO/3/nv/fwsMFC5vi1XMuvCNCAb2I/aae/wvcGrRg==
X-Received: by 2002:a05:600c:54f:: with SMTP id k15mr8396941wmc.96.1583426083431;
        Thu, 05 Mar 2020 08:34:43 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 2sm8825636wrf.79.2020.03.05.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 08:34:42 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: VMX: untangle VMXON revision_id setting when using eVMCS
In-Reply-To: <20200305154130.GB11500@linux.intel.com>
References: <20200305100123.1013667-1-vkuznets@redhat.com> <20200305100123.1013667-3-vkuznets@redhat.com> <20200305154130.GB11500@linux.intel.com>
Date:   Thu, 05 Mar 2020 17:34:42 +0100
Message-ID: <8736amg3q5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, Mar 05, 2020 at 11:01:23AM +0100, Vitaly Kuznetsov wrote:
>> As stated in alloc_vmxon_regions(), VMXON region needs to be tagged with
>> revision id from MSR_IA32_VMX_BASIC even in case of eVMCS. The logic to
>> do so is not very straightforward: first, we set
>> hdr.revision_id = KVM_EVMCS_VERSION in alloc_vmcs_cpu() just to reset it
>> back to vmcs_config.revision_id in alloc_vmxon_regions(). Simplify this by
>> introducing 'enum vmx_area_type' parameter to what is now known as
>> alloc_vmx_area_cpu().
>
> I'd strongly prefer to keep the alloc_vmcs_cpu() name and call the new enum
> "vmcs_type".  The discrepancy could be resolved by a comment above the
> VMXON_REGION usage, e.g.
>
> 		/* The VMXON region is really just a special type of VMCS. */
> 		vmcs = alloc_vmcs_cpu(VMXON_REGION, cpu, GFP_KERNEL);

I have no strong opinion (but honestly I don't really know what VMXON
region is being used for), Paolo already said 'queued' but I think I'll
send v2 with the suggested changes (including patch prefixes :-)

-- 
Vitaly

