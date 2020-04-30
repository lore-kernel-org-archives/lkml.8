Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1618C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5A5214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0kElSQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgD3Gts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:49:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25289 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726491AbgD3Gtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588229386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jDhUGC0q9fpb0E7nmomakw81mS0R94uGtBxC+k3irk=;
        b=b0kElSQb60ylUG8YrqZUtsaPUvlxLfbwt17AW9TlbAP4az8FVT3Ah9wuHitck7JIxSJt/R
        F6Cj3bqO8Yx1ZGfDVrxRm7LoDE8Yxky5Hq0GHc6rP38CjfcnR980FzslJJqMuTS5iQhiqk
        FZDRqeFQehE7M4dOlgK2DiC6Knodn/c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-GK0GwWwBPr2AUrjybWXTQw-1; Thu, 30 Apr 2020 02:49:44 -0400
X-MC-Unique: GK0GwWwBPr2AUrjybWXTQw-1
Received: by mail-wr1-f69.google.com with SMTP id s11so3382042wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 23:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jDhUGC0q9fpb0E7nmomakw81mS0R94uGtBxC+k3irk=;
        b=U1uW2Ed+dKIxHU7to+ZFaHAabMyTu8ryHCZC8guYI4ZceksvAh4+bF521TbOMqL5qE
         YCEswu6xTwIdnmAjUzI3/Zdgn91AG9C6TagK+sKyP6ChjZeZ1L9iWHy0m37UDsu35j0e
         iRXNW3H2HMQ+R1IxvYNt5ajEyxZgQBmPzMAfrfQb0wDWEFnTsEbQTbrjId7QL2CSxbMB
         cYpkDbAye4vyyKkhxxb1sR0Y53T1yiu+R0oGV9ByzqbauMMfhzizM4NLeIS0l8mN0aHN
         cXvVcTH33N5ujDUh1hS/36RlPKsHhQcssNAeBSwkgABeMJipCYyzQQmFD5y29edtxD3M
         2xCQ==
X-Gm-Message-State: AGi0PubolWIVTvLYHgh30X7Dv/jn53fG3tvOyBT1XrlmBWnBVX2dkgOc
        08ICZgQEqflz5poA9bY2W2z2DR9trbkA8VZBZAWwQjNp0HeNAUT8sqE9ok1M1MvJ5l9y8XG3xq4
        GG1nJ4O6Ic+RlpvvO7kI7SNTd
X-Received: by 2002:adf:d0ce:: with SMTP id z14mr1006543wrh.179.1588229382511;
        Wed, 29 Apr 2020 23:49:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypJsr6rw4wP2fqMQl3zalW7R42B7drXGchkN9CzcjY2NDZHyXF3Wa5dNOSiiq9a1MPMvoUroSQ==
X-Received: by 2002:adf:d0ce:: with SMTP id z14mr1006517wrh.179.1588229382284;
        Wed, 29 Apr 2020 23:49:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id g74sm11257055wme.44.2020.04.29.23.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 23:49:41 -0700 (PDT)
Subject: Re: [PATCH RFC 4/6] KVM: x86: acknowledgment mechanism for async pf
 page ready notifications
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-5-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1297936-cf69-227b-d758-c3f3ca09ae5d@redhat.com>
Date:   Thu, 30 Apr 2020 08:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200429093634.1514902-5-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 11:36, Vitaly Kuznetsov wrote:
> +	case MSR_KVM_ASYNC_PF_ACK:
> +		if (data & 0x1)
> +			kvm_check_async_pf_completion(vcpu);
> +		break;

Does this work if interrupts are turned off?  I think in that case
kvm_check_async_pf_completion will refuse to make progress.  You need to
make this bit stateful (e.g. 1 = async PF in progress, 0 = not in
progress), and check that for page ready notifications instead of
EFLAGS.IF.  This probably means that;

- it might be simpler to move it to the vector MSR

- it's definitely much simpler to remove the #PF-based mechanism for
injecting page ready notifications.

Thanks,

Paolo

