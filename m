Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A76C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD2921556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuJM0aLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgCCK1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:27:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgCCK1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583231226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3meacGVL2hG/N2ilO5Ew4SwZwYsirTCzCeIbnNcDdw8=;
        b=WuJM0aLGKmxL5U4g7jlajXRhZbE5jSpUAxjKDzcS/fIwh8lUM4mH8TqhMw6hf99CDXn2YX
        VdJqidEeqHMchlt6jk/y4BrjfLY0bZB7sBg4zaFlBoOabxKaFrUjHCFx+MbaT5wdeb0VZ+
        70kPCyh5aEb+G1/YLDVCeXp/VA0/T+s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-dI60o_uaPGyTsa0yGLAOiw-1; Tue, 03 Mar 2020 05:27:05 -0500
X-MC-Unique: dI60o_uaPGyTsa0yGLAOiw-1
Received: by mail-wm1-f70.google.com with SMTP id j130so881083wmj.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3meacGVL2hG/N2ilO5Ew4SwZwYsirTCzCeIbnNcDdw8=;
        b=pplYLLPwcashpcvjP1pI3LDCPxK9m0bYietzDjjaY4LlsnlgbvzygY24OZRnIxwCKD
         GHlVH8NaPaMtd5kmKqJCfiwquYddZR2Q88TrfeNDi6H6toWZSWoT9ZlcDAL8DbizqVGo
         vqBcGJFKg+QVWBz6xcxPQPxrDiheaqvLv2LFLe63Y1w4sXvqPGvAZ+XQUYIEhqaEZTYC
         S2ffmieFAouIfXhFlHsWf4+v/P5M8/2s15YNXfpUf/L4zBNJa9nGautRd5zcTh92e6Nb
         xrJKiar7zxW4uwfOMuRHqssACWJqyMMVmJl9W7gbVK6jVPy1VdoYdccLyCeJFDDZlmV/
         FKTw==
X-Gm-Message-State: ANhLgQ1HVhvHTBGwwppPFvxy6pv1Pak+5xd5JGZNE3DYMuvPkBuUpykp
        S91dcB/wLqEWh7POunRMMJo29bbigceZoPnEO/pIXqO/0dYIotU6avCaMU1W+F8KoGIymMclU4Z
        YxHDAST88+u9OuKcho+XRBPrA
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr3505336wme.153.1583231224076;
        Tue, 03 Mar 2020 02:27:04 -0800 (PST)
X-Google-Smtp-Source: ADFU+vucRdkYw1PkKF0aTRDgOm7ysVdj5DbiWFq3slbOlAX8zuizt+zhEdWIemdtp7SSZntZe3drag==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr3505308wme.153.1583231223856;
        Tue, 03 Mar 2020 02:27:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id p16sm32702712wrw.15.2020.03.03.02.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:27:03 -0800 (PST)
Subject: Re: [PATCH v2 09/13] KVM: x86: Move kvm_emulate.h into KVM's private
 directory
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218232953.5724-1-sean.j.christopherson@intel.com>
 <20200218232953.5724-10-sean.j.christopherson@intel.com>
 <87tv3di70f.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05ead265-d50d-43de-47d2-3c8ae24b8a3a@redhat.com>
Date:   Tue, 3 Mar 2020 11:27:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87tv3di70f.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/20 18:38, Vitaly Kuznetsov wrote:
> Not this patchset's problem (and particular forward declaration is
> likely needed), but 
> 
> $ grep 'struct x86_emulate_ctxt' arch/x86/include/asm/kvm_host.h
> struct x86_emulate_ctxt;
> 	struct x86_emulate_ctxt *emulate_ctxt;
> struct x86_emulate_ctxt;
> 
> The second forward declaration is not needed and this patch (or
> patchset) may be a good place to get rid of it)
> 

Squashed, thanks.

Paolo

