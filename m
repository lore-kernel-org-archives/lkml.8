Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305E3C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015D92064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNMpfKdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgBYPZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:25:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729501AbgBYPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582644338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHRKxD00cTyT09o9LKocptIN+yLA1rFAZrxjnmWX1Ls=;
        b=WNMpfKdukjxhCFt1UUbjJLFvMSTivED30oixJvjCA+2tZV837fc8heq/dLPSC/+7UwKK/f
        jac6OuCUq/4VdlDlOJPamih3rsHnyWGBtj0bmhcD9FP2msItsBKEnqlqFVoVv1qEtAbsis
        UKQSWueL1LS/MDzSViuod7TCWLvH/pY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-mSYxfuJ2OnS7Xlgf1SNXPg-1; Tue, 25 Feb 2020 10:25:36 -0500
X-MC-Unique: mSYxfuJ2OnS7Xlgf1SNXPg-1
Received: by mail-wr1-f72.google.com with SMTP id t14so899526wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XHRKxD00cTyT09o9LKocptIN+yLA1rFAZrxjnmWX1Ls=;
        b=efNG1e9fZSRXv5JmA3/5CupL9/ccJBIy0tkDVXIXQ/Ed/4MwvVaQlW44MUrpRrz5xT
         /SLFJSNrVLWE+rO9999BF+JnAm5fdAXDoZS3azUc4NXJkbHFoE66mzIqbe756f1HSHXE
         BcxB4E7+XFL+yJPp+pn+hXwy6TtshPU1aVjXQLHDNzQl8xdpBREz7K8yxMFvKIIy0exc
         3h0GqPonhs/wydyEYORT388BHEsNbl3WM1Q1C81P4POlsBZORqGHI0rT8v7dPpZiAeBG
         FwUHOe7Dyc/PcX2TsxD0wPKcC036Ai4CYJJQAgAbhXLp+S8gXqtJJPFYB/Jxa5mx+JQj
         k/9Q==
X-Gm-Message-State: APjAAAWqfn/Lwe52ftMSMjlhJnws0PSI5/r1edNT3CCpYVsCwBSwHOs0
        9kkBvsgWBg1VvNujnIzSgC4PxsD1mh+2+EFTRGdAiVZJY0XCgzfUtq1CBqlQ6N+RxgYFE5jIWKL
        6mVONXgvXeTanhOCoE6imEgug
X-Received: by 2002:a1c:491:: with SMTP id 139mr5904258wme.117.1582644334822;
        Tue, 25 Feb 2020 07:25:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOEO5FTObReQwSnlZOzVoqdfjaEIdHk/sbsxSJs1qE1hoP1ta5zdOmm+8U8vuRcLcMmb2wTA==
X-Received: by 2002:a1c:491:: with SMTP id 139mr5904230wme.117.1582644334563;
        Tue, 25 Feb 2020 07:25:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id z21sm4445966wml.5.2020.02.25.07.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:25:33 -0800 (PST)
Subject: Re: [PATCH 00/61] KVM: x86: Introduce KVM cpu caps
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <87wo8ak84x.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a52b3d92-5df6-39bd-f3e7-2cdd4f3be6cb@redhat.com>
Date:   Tue, 25 Feb 2020 16:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87wo8ak84x.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/20 16:18, Vitaly Kuznetsov wrote:
> Would it be better or worse if we eliminate set_supported_cpuid() hook
> completely by doing an ugly hack like (completely untested):

Yes, it makes sense.

Paolo

