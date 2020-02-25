Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B194FC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B3C20658
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXBsPQor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgBYPRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:17:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53171 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731023AbgBYPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582643848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/yFAqfpxVmH5UTQfRfW6zAd8tz7j2iw367lWQfVNPk=;
        b=AXBsPQorYB1F3aL9JYgnf6dcwwkSQpXVhWE1AyPsGX2soRAxymVOUcKHcag3Hq04TfZbX8
        r6MtEdD7DhfG2qzRKhWcWe4QKgba8VLSFk2yT7uVr7iJ4z+q7gv6NXcORRUvn1kp98fHzt
        IIUN2u0146Y8l6o/w+ngacLz8bsaPwI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-W2UjKJ0TNuWPeoSy4UOIYQ-1; Tue, 25 Feb 2020 10:17:26 -0500
X-MC-Unique: W2UjKJ0TNuWPeoSy4UOIYQ-1
Received: by mail-wm1-f70.google.com with SMTP id w12so1161807wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/yFAqfpxVmH5UTQfRfW6zAd8tz7j2iw367lWQfVNPk=;
        b=X7U9fXRkm0EBoeLwe1sqRGGC2Ww7xNNFTYYmIDbPwQiRZDAar53MesE6C3qurKb3kE
         8LhvnJSII7+0ymCM0XEiDyubdLyGLj7jccGkPUC48DaFQxwg11FeIo51d5/3HS2phYKB
         qhNKoPeAUJR9g4lHMr3kw9aMTIhC8gtoXPg0yWBH0Rf9IvSkcklZjagJRLoETHZj6gpd
         L6INlzrMkgiyj6YDhfFKJw3lO0ztcE852oshpBnzfnooheou6Olx4VMbdh98MzoDOQQ+
         KOeSh8RQ5BRGs+qrz8NrF7fWJLALdBUXljZ7D+bwL4Yfw7Sc3q9CO9gsoIU6gcsP1J2R
         J0KQ==
X-Gm-Message-State: APjAAAXocXpJaTtD4ewCDCnpXYqo9/pO4LFFV1/1vHYforg9Iiiw8tpb
        u8qDJyK6f8Lj0RZnUBeow2ZiBeLQUDQFq57r/fsu7qJ4/p+Vk4BuY6Qd8lwxkR6G2/8BkHLJ+q/
        RQZYX+s4Fqb7vuTrrQHiohfsS
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr5936231wmj.100.1582643845565;
        Tue, 25 Feb 2020 07:17:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnv2zkbFggigvr5DyT5aMoH4G11gKX7bHhsbezuWPB5EkRH1YMqErhxeP/eJJb9QJJcdcNjA==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr5936205wmj.100.1582643845295;
        Tue, 25 Feb 2020 07:17:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id e1sm23938141wrt.84.2020.02.25.07.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:17:24 -0800 (PST)
Subject: Re: [PATCH 47/61] KVM: x86: Squash CPUID 0x2.0 insanity for modern
 CPUs
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-48-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21b4346e-def0-9343-3368-e81b89ffb152@redhat.com>
Date:   Tue, 25 Feb 2020 16:17:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200201185218.24473-48-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/20 19:52, Sean Christopherson wrote:
> Although it's _extremely_ tempting to yank KVM's stateful code, leave it
> in for now but annotate all its code paths as "unlikely".  The code is
> relatively contained, and if by some miracle there is someone running KVM
> on a CPU with a stateful CPUID 0x2, more power to 'em.

I suppose the only way that could happen is with nested virtualization.
 I would just drop it.

Paolo

