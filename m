Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F89C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EA620838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzSew+et"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgCCOQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:16:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58650 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728356AbgCCOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583244983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUTEP1p4YWjzskXYVbK6H4xhC2oS8H6SYOsK8O1eOyQ=;
        b=bzSew+et0oTss8hF+yTQBV3ff184kWxMigwSUARoJj5M8pUzzw8OvdvNwyYkXVBq0RC6fv
        EtyYNQRsJ7HXt4pIwoxZPAktxUYSaWkGN12FU/zRdP/Bj7//+1+kOQ7HkkDQokBnwvTSqC
        mxqH+5vNO0Y3oafmHY8s3JyHiICkpPc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-5TEOS0MJNLqJ4_DgIWdrhA-1; Tue, 03 Mar 2020 09:16:19 -0500
X-MC-Unique: 5TEOS0MJNLqJ4_DgIWdrhA-1
Received: by mail-wr1-f72.google.com with SMTP id f10so1283745wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MUTEP1p4YWjzskXYVbK6H4xhC2oS8H6SYOsK8O1eOyQ=;
        b=LtwYkYGu0iNB3wZSBE2VklLEZ+GkiwKk+Fg4P39y7ClTv6cqSbda6Y8IZBR1jfYz0g
         3Mit+w+BgEFkgoMkNvqCHZC4fqEOZ/Tm7d2YCwDt9yvz11+Zo2/hSjghtWS3eq8z8rN1
         R8t04l8WIDPPsQEO14Pmdgk+Rk3PiRsIfRaGp/E6mLsyMcOPdtFv3ApnJ/6/aAZBh1mg
         e9EbjCA8L4fZAysRRw95iORjvjJWm81UststkUQ2sJN2HBK7aOF7inMR0ieUcUorrcDB
         JPXpj3bujUHgb/SopUgEFluEaFAfk5OIdofawtp9pRtpaB8TsaOk0M4ePh+CYxtXvAal
         KVWg==
X-Gm-Message-State: ANhLgQ383/xFZY7w8z5Qzmg/d6f3bXx7EFYMPWGOIki+MraKyThQ//KO
        SnqOHPp3kNLNlMeFNowJNz9mMpRShAuukeCNjOCqBrdRWAVY2X+PBCnZyJGk87yPMJvEKiBpa+e
        YF3qk54CVlPKMUCVfC/U+sS0u
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr5857109wrm.246.1583244978784;
        Tue, 03 Mar 2020 06:16:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsYNg7+BUQwOf9zvxhDv8luT0LXJFS2Ip7Opm1OZwN8LJ4aJ2q/o6inCPO/0+w/9WVAKxYWiQ==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr5857091wrm.246.1583244978498;
        Tue, 03 Mar 2020 06:16:18 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id m25sm2351920wml.35.2020.03.03.06.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 06:16:18 -0800 (PST)
Subject: Re: [PATCH v2 01/66] KVM: x86: Return -E2BIG when
 KVM_GET_SUPPORTED_CPUID hits max entries
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <20200302235709.27467-2-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <599c3a95-a0a6-b31d-56a6-c50971d4ab59@redhat.com>
Date:   Tue, 3 Mar 2020 15:16:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302235709.27467-2-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 00:56, Sean Christopherson wrote:
> (KVM hard caps CPUID 0xD at a single sub-leaf).

Hmm... no it doesn't?

                for (idx = 1, i = 1; idx < 64; ++idx) {
                        u64 mask = ((u64)1 << idx);
                        if (*nent >= maxnent)
                                goto out;

                        do_host_cpuid(&entry[i], function, idx);
                        if (idx == 1) {
                                entry[i].eax &= kvm_cpuid_D_1_eax_x86_features;
                                cpuid_mask(&entry[i].eax, CPUID_D_1_EAX);
                                entry[i].ebx = 0;
                                if (entry[i].eax & (F(XSAVES)|F(XSAVEC)))
                                        entry[i].ebx =
                                                xstate_required_size(supported,
                                                                     true);
                        } else {
                                if (entry[i].eax == 0 || !(supported & mask))
                                        continue;
                                if (WARN_ON_ONCE(entry[i].ecx & 1))
                                        continue;
                        }
                        entry[i].ecx = 0;
                        entry[i].edx = 0;
                        ++*nent;
                        ++i;
                }

I still think the patch is correct, what matters is that no KVM in
existence supports enough processor features to reach 100 or so subleaves.

Paolo

