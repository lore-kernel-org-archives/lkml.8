Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D5CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499FC20786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTT5Ppmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCXLTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:19:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31623 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727186AbgCXLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585048750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgtxWIUqOe7RBV8y1HKFvXo0TcPt4L4/Y/Q8yOwJg8A=;
        b=NTT5PpmbyVx7tbxDQ31t1MxaVYgxt56kV1o7RGjtYqsNA0Q49m1D/4orPYUTORuNki+8Yf
        uXFjuysoOmxXKFVjr7DbYADNtWX3k8bA9EgCccUCWsbt6yKJuCxZHZM1ogOG2lBoqG4t2+
        601nqdXK/NruHGXhWEM8HcZDqmk4ITE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-YbKKb0PSOe6sw1ngEKEbvQ-1; Tue, 24 Mar 2020 07:19:08 -0400
X-MC-Unique: YbKKb0PSOe6sw1ngEKEbvQ-1
Received: by mail-wr1-f70.google.com with SMTP id u18so9012091wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pgtxWIUqOe7RBV8y1HKFvXo0TcPt4L4/Y/Q8yOwJg8A=;
        b=nfo+CFzDi0LEHxl2BEeWapkLKEOkQkLNeMUSBd9uV9pcQTYZaGw0jEA+auOvg3uXxx
         fWeGPznnXVzUsW32cSdz65ZndYptzPcDSR4T9Dgz0emU8EHAqWDEowaf7AjJjxLOzLmZ
         cmQnmJ1VuGhCb/+/BPLTUC6AlXVFwP67ZLKoZ5cBC4heDI42N+oxehtJGunBwPcdprbV
         Mi4VdYJnwzCxoFRA13vZFppQJqWtZaVAWiQy9cjlYJQ5Zp/6aghxBnK2nWbh0J7f1Wpu
         ue8pleBjVEFYkplJlFEqiWiuidfR2YmKl+bRVPdTlV+rp7SNXeP5NQeC6AFCxday/jrw
         AHTg==
X-Gm-Message-State: ANhLgQ12BJ6GqMH/B3uxFQUvjjW9Dq0JoDAXEfdmsBqZ5VNL9SZx+9JL
        bt4EtfxvaO5PmJPox+MN6BxgW/JWktEn6bMTP5FhmaaYdH8LpCdm6H7hKf20eTwBMwWGUSJPOUg
        d3s56cN/cDf1Ebo7EEG5Kj5RM
X-Received: by 2002:a05:600c:581:: with SMTP id o1mr5113381wmd.111.1585048747382;
        Tue, 24 Mar 2020 04:19:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtXyFp93ixS0SdKYFgvGRSwDxD5NqQm7QdTATcvy69g/jxwWIl5BkMKFytFLvaIGtv/e8sHJg==
X-Received: by 2002:a05:600c:581:: with SMTP id o1mr5113351wmd.111.1585048747127;
        Tue, 24 Mar 2020 04:19:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id r18sm28608611wro.13.2020.03.24.04.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 04:19:06 -0700 (PDT)
Subject: Re: [PATCH v3 33/37] KVM: nVMX: Skip MMU sync on nested VMX
 transition when possible
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-34-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51707375-51a6-637e-ebc5-f63f1c81f6b1@redhat.com>
Date:   Tue, 24 Mar 2020 12:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320212833.3507-34-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 22:28, Sean Christopherson wrote:
> Skip the MMU sync when reusing a cached root if EPT is enabled or L1
> enabled VPID for L2.
> 
> If EPT is enabled, guest-physical mappings aren't flushed even if VPID
> is disabled, i.e. L1 can't expect stale TLB entries to be flushed if it
> has enabled EPT and L0 isn't shadowing PTEs (for L1 or L2) if L1 has
> EPT disabled.
> 
> If VPID is enabled (and EPT is disabled), then L1 can't expect stale TLB
> entries to be flushed (for itself or L2).
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Great, just a small rephrasing here and there:

/*
 * Returns true if the MMU needs to be sync'd on nested VM-Enter/VM-Exit.
 * tl;dr: the MMU needs a sync if L0 is using shadow paging and L1 didn't
 * enable VPID for L2 (implying it expects a TLB flush on VMX transitions).
 * Here's why.
 *
 * If EPT is enabled by L0 a sync is never needed:
 * - if it is disabled by L1, then L0 is not shadowing L1 or L2 PTEs, there
 *   cannot be unsync'd SPTEs for either L1 or L2.
 *
 * - if it is also enabled by L1, then L0 doesn't need to sync on VM-Enter
 *   VM-Enter as VM-Enter isn't required to invalidate guest-physical mappings
 *   (irrespective of VPID), i.e. L1 can't rely on the (virtual) CPU to flush
 *   stale guest-physical mappings for L2 from the TLB.  And as above, L0 isn't
 *   shadowing L1 PTEs so there are no unsync'd SPTEs to sync on VM-Exit.
 *
 * If EPT is disabled by L0:
 * - if VPID is enabled by L1 (for L2), the situation is similar to when L1
 *   enables EPT: L0 doesn't need to sync as VM-Enter and VM-Exit aren't
 *   required to invalidate linear mappings (EPT is disabled so there are
 *   no combined or guest-physical mappings), i.e. L1 can't rely on the
 *   (virtual) CPU to flush stale linear mappings for either L2 or itself (L1).
 *
 * - however if VPID is disabled by L1, then a sync is needed as L1 expects all
 *   linear mappings (EPT is disabled so there are no combined or guest-physical
 *   mappings) to be invalidated on both VM-Enter and VM-Exit.
 *
 * Note, this logic is subtly different than nested_has_guest_tlb_tag(), which
 * additionally checks that L2 has been assigned a VPID (when EPT is disabled).
 * Whether or not L2 has been assigned a VPID by L0 is irrelevant with respect
 * to L1's expectations, e.g. L0 needs to invalidate hardware TLB entries if L2
 * doesn't have a unique VPID to prevent reusing L1's entries (assuming L1 has
 * been assigned a VPID), but L0 doesn't need to do a MMU sync because L1
 * doesn't expect stale (virtual) TLB entries to be flushed, i.e. L1 doesn't
 * know that L0 will flush the TLB and so L1 will do INVVPID as needed to flush
 * stale TLB entries, at which point L0 will sync L2's MMU.
 */

Paolo

