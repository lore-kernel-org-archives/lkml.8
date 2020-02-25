Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A4C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A272721744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThrqcSwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgBYPKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:10:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730172AbgBYPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582643422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRFD3PMjjqRPLYE/BqYxDm6sJvPkBl4qX28FKWyGGt0=;
        b=ThrqcSwNl7zJ66bvrLSKf0MCEfX88FnYDczxaCZMtdeym8mWp+eB1Dxo373xv355MzkfGT
        Burj2qOiBzCl7edjLDZQgR+Tr0qpwBVTRJLe6WCTCRFDrB6PCCif1l7tyeF8yEub0vktyH
        S6aL0bn0L4tB8fQ4OJop82o9B/LucFQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-F4tyTekVM4KKHhS2ul-aZg-1; Tue, 25 Feb 2020 10:10:20 -0500
X-MC-Unique: F4tyTekVM4KKHhS2ul-aZg-1
Received: by mail-wm1-f70.google.com with SMTP id g138so981195wmg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QRFD3PMjjqRPLYE/BqYxDm6sJvPkBl4qX28FKWyGGt0=;
        b=hqzxdBSvp80ZAQHuJSE4ggEzhBW5oEIxPJAxHjYjlpeGavyqKYtswFXhsWHV4g93E2
         yeuRvtS7c8w4g2ZPOdsoDi+Vhtaa5m2Ks3KVGbS517CYIOA2GsICYXGCqW9oy26q+ma7
         iCJLl4C8JlovZuctN9OHeA9EK7+eD2eCgvhxjtHk0o4rYRSoHHLlhQ3/575xUMdugoMK
         yQqRk1MtrhapDwxigu9/hdHvhr6B1QRfIBSq/WoVdodEJST4EuQ0BJzZQ3q5/0KY2HN4
         8+bpdvudOTov5+YzpyW5WEfOo7w26B9ABMHXqbLQRqLHZgnBaS/s1JBTfyMUusIdjxLT
         Whag==
X-Gm-Message-State: APjAAAUEoGaKEY9HRcoj25646qJa9017YSp+LPAe2SdieMl9pUoU7fIF
        oJnqnkG1FtaYGhnmBflGqzzvoF88LJc9ql0Dtm5n/FWzbZAz0dfL0xP1SwlA+PNaxAhsXiN1jrZ
        5SS75GA2s8KbTfmbsKpxV98Sj
X-Received: by 2002:a7b:c019:: with SMTP id c25mr29146wmb.126.1582643419597;
        Tue, 25 Feb 2020 07:10:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSlTbehjzt6fQaWvLGS5yyGzUn9gYwXqID+MDIjftANEs2/W8YYDcK4izZDikzk+F4PoUasw==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr29114wmb.126.1582643419296;
        Tue, 25 Feb 2020 07:10:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id b7sm16100391wrs.97.2020.02.25.07.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:10:18 -0800 (PST)
Subject: Re: [PATCH 39/61] KVM: SVM: Convert feature updates from CPUID to KVM
 cpu caps
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-40-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f21b023-000d-9d78-b9b4-b9d377840385@redhat.com>
Date:   Tue, 25 Feb 2020 16:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200201185218.24473-40-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/20 19:51, Sean Christopherson wrote:
> +	/* CPUID 0x8000000A */
> +	/* Support next_rip if host supports it */
> +	if (boot_cpu_has(X86_FEATURE_NRIPS))
> +		kvm_cpu_cap_set(X86_FEATURE_NRIPS);

Should this also be conditional on "nested"?

Paolo

