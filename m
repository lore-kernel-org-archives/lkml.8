Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01828C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA0121D82
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hh7rete3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632883AbgDPLTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:19:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54847 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506160AbgDPLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587035661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMhEZOoHAJnjG/UJiypTrpHYCbpZgvJbU4bT3L0FKI4=;
        b=Hh7rete3ARXQJJ6CQij9vn+QxSdXsHjWC8oi8jSs6rzA1Bo6BZ2ApYJOMUvKM+MbCg6zAJ
        QM8pYpo2Yg35TtcxOUkWUsF7G9xOwLfcpSMCTOZfjxUP3Is/OwTYYk3fcJRQd6GHaApqkn
        0+F3K8P2RGAKHX3TT/n9s8s9UEPpSAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-IhQnZEqzOiyLqd_xHe7YTA-1; Thu, 16 Apr 2020 07:14:19 -0400
X-MC-Unique: IhQnZEqzOiyLqd_xHe7YTA-1
Received: by mail-wm1-f72.google.com with SMTP id h6so1252682wmi.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uMhEZOoHAJnjG/UJiypTrpHYCbpZgvJbU4bT3L0FKI4=;
        b=C1FPKOW6qETBQ/IcJ15Z5XCueXIQd0yG8/tFm6icMPM1ijhj6t7qv2C2QQSJpwIDt1
         DzvpXhWeClDJ3TlL6qy3Y1553NOBg3j3QZwjAxurK4cgIxAIN4h0ZiYRcZXgEinECW9X
         OBIzvqP3SDkezWjn/8grqfzoWMll7mnPgHiYBw3J7tOdfgMMTfqyQ2O5u/MFwHTJt4h6
         44rOO5yIt2c35fkkZ2Y0WRvEsedRG9uxLk85fw9sdImN0b+ntzZwmgMbJ80hHa0oqyrG
         L+OA7uFfcavsAJaYiHAcZHqkG7AtdoIhD58iMzU+ntTjksKI1LsgRjys63OTSImO1jIE
         q1Uw==
X-Gm-Message-State: AGi0PubcGOZUuzTwLgpFZuCXwwX/rstHfBWbqF3jLv+5lHrJ5FuHnemO
        QGrHKfTmCWDnppZHLp3DIFsIpaH/27sEpnrWZQunN+2oVJynJMH/6mOltWEIi0896UfjT0eFZNe
        m30r7fwQlge5XS4zK1F2Zfxso
X-Received: by 2002:a5d:408a:: with SMTP id o10mr14651246wrp.163.1587035658170;
        Thu, 16 Apr 2020 04:14:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypIhCbY4Z2dk2GyzeI5Yi3sRn1ddz4I0YHF5eNgOdzfpIeQMINfj7YSC5j77R84e3b7mkneo+w==
X-Received: by 2002:a5d:408a:: with SMTP id o10mr14651234wrp.163.1587035657963;
        Thu, 16 Apr 2020 04:14:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id h5sm8397012wrp.97.2020.04.16.04.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 04:14:17 -0700 (PDT)
Subject: Re: [PATCH] x86/kvm: make steal_time static
To:     Jason Yan <yanaijie@huawei.com>, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200415084939.6367-1-yanaijie@huawei.com>
 <d1700173-29c1-2e7c-46bd-471876d96762@redhat.com>
 <35c3890e-0c45-0dac-e9f0-f2a9446a387d@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd77af4b-1e08-af7a-3167-eeb03dfbd1d6@redhat.com>
Date:   Thu, 16 Apr 2020 13:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <35c3890e-0c45-0dac-e9f0-f2a9446a387d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/20 04:15, Jason Yan wrote:
>>
> 
> Sorry that I found 14e581c381b9 ("x86/kvm: Make steal_time visible")
> said that it is used by assembler code but I didn't find where.
> Please drop this patch if it's true.
> 
> Sorry to make this trouble again.

Here:

arch/x86/kernel/kvm.c:"cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"

The __visible argument shouldn't be needed, __used should be enough.  I'll take a look.

Paolo

