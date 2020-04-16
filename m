Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BF0C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4129722241
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y31rxYOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395257AbgDPP2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:28:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47947 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898442AbgDPNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587044666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNwYgeif6SS8pR2Shi4E6mQu99cc3aS7IJK5cTr/jMU=;
        b=Y31rxYOX6a5ie4Vcllyg+ubkQekwhnPQbcta1uZXhI+eqVtzyPxOmvsKVwppDFMCpwkknU
        Ni9OSMvNVexBYOve4bc4J9Ji3ZQNAs0QVSPLBTqWt57OywnbnIajaaRNnArvLALZ+r2i4m
        ZaBy8dWdpLBXuNEztEfKtQc3CLbzZ0M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-9eDRhbKIOHyWmyAlGo8qgg-1; Thu, 16 Apr 2020 09:44:09 -0400
X-MC-Unique: 9eDRhbKIOHyWmyAlGo8qgg-1
Received: by mail-wr1-f71.google.com with SMTP id f2so1732581wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VNwYgeif6SS8pR2Shi4E6mQu99cc3aS7IJK5cTr/jMU=;
        b=HyBDvEcihdarhppNJJnco55JIYHaz3o94q/W2jpRLlgiMCYSoqaUOej885tzMd6ASR
         bFNJHyDlOVNX+U8GQZ2oQhI+fFxbeXVVj98eMNA297buoXM87oijzk61/JSdYfXWJppB
         0VByS6sWOpCVRMpwWmiQBLomL6BLtVpgCPBzcoztaV3IOlPnGcVHDkg7nkDY96f59kFs
         Z/Q1f9qG24tu2OvMcOB1upzvKH0h/cUiXxxu629h7CI6WMeYKjMLOv44BwfFYBGl+BA7
         V7hS5nO1u0B9BfgUekSp2hT7yUIMkxwUwFrsHRbLZck/vxPR5ueFuv85M714zTeBYtdv
         jaLw==
X-Gm-Message-State: AGi0PuYSiy8kXVlFX+WsAN/WDn/+Gi6yM6hPI98dm4+YvcdPJPumrik+
        YsCCPRcgLAOIBm7I5UmdfJIk0YSf91tSfvIhWe4IQnAwMP52RhNHAhYDfxB9Z0VwGnUouQW5Zjw
        SzhPfML4MGSiJ1pOLODvDIskl
X-Received: by 2002:a1c:9e42:: with SMTP id h63mr4711036wme.115.1587044648698;
        Thu, 16 Apr 2020 06:44:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbJo3jezBS7NrZjbC7U3OMTYgi+dwQqgaUpndr48EWx/XnTEuvdzSDmjn7g2cPMV+vyM9+Dg==
X-Received: by 2002:a1c:9e42:: with SMTP id h63mr4711010wme.115.1587044648389;
        Thu, 16 Apr 2020 06:44:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id s24sm3860611wmj.28.2020.04.16.06.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 06:44:07 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] KVM: VMX: Unionize vcpu_vmx.exit_reason
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200415175519.14230-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a77ca940-afe4-a94a-2698-6cda0f95ba5c@redhat.com>
Date:   Thu, 16 Apr 2020 15:44:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415175519.14230-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 19:55, Sean Christopherson wrote:
> Convert the exit_reason field in struct vcpu_vmx from a vanilla u32 to a
> union, (ab)using the union to provide access to the basic exit reason and
> flags.
> 
> There is a fairly substantial delta relative to v1, as I ran with Vitaly's
> suggestion to split nested_vmx_exit_reflected() into VM-Fail, "L0 wants"
> and "L1 wants", and move the tracepoint into nested_vmx_reflect_vmexit().
> IMO, this yields cleaner and more understandable code overall, and helps
> eliminate caching the basic exit reason (see below) by avoiding large
> functions that repeatedly query the basic exit reason.  The refactoring
> isn't strictly related to making exit_reason a union, but the code would
> conflict horribly and the end code nicely demonstrates the value of using
> a union for the exit reason.
> 
> There are three motivating factors for making exit_reason a union:
> 
>   - Help avoid bugs where a basic exit reason is compared against the full
>     exit reason, e.g. there have been two bugs where MCE_DURING_VMENTRY
>     was incorrectly compared against the full exit reason.
> 
>   - Clarify the intent of related flows, e.g. exit_reason is used for both
>     "basic exit reason" and "full exit reason", and it's not always clear
>     which of the two is intended without a fair bit of digging.
> 
>   - Prepare for future Intel features, e.g. SGX, that add new exit flags
>     that are less restricted than FAILED_VMENTRY, i.e. can be set on what
>     is otherwise a standard VM-Exit.
> 
> v2:
>   - Don't snapshot the basic exit reason, i.e. either use vmx->exit_reason
>     directly or snapshot the whole thing.  The resulting code is similar
>     to Xiaoyao's original patch, e.g. vmx_handle_exit() now uses
>     "exit_reason.basic" instead of "exit_reason" to reference the basic
>     exit reason.
>   - Split nested_vmx_exit_reflected() into VM-Fail, "L0 wants" and "L1
>     wants", and move the tracepoint into nested_vmx_reflect_vmexit().
>     [Vitaly]
>   - Use a "union vmx_exit_reason exit_reason" to handle a consistency
>     check VM-Exit on VM-Enter in nested_vmx_enter_non_root_mode() to avoid
>     some implicit casting shenanigans. [Vitaly]
>   - Collect tags. [Vitaly]
> 
> v1: https://lkml.kernel.org/r/20200312184521.24579-1-sean.j.christopherson@intel.com

For now I committed only patches 1-9, just to limit the conflicts with
the other series.  I would like to understand how you think the
conflicts should be fixed with the union.

Paolo

