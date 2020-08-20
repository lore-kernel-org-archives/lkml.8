Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3464C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E365207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mntx/bm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgHTRlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:41:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55907 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726887AbgHTRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597945278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=saSZ72xGZQjg7N1ZoxyMXMkEKF7tyG6HepfcvbIUgEk=;
        b=Mntx/bm43+U9X1/ilmJnlc5ny8YQzQl3vegCSVApaS4eDyoLO4zf+hPlnzYXhCEw9P9jfg
        lcpjuW7rLh51QrE/k05JSrTmtfFCz7tLHJT3iP/3ZAdXd3oPz7i5omRAbJh9RLCtqQuvvv
        WV++ahCW2ejRhfZouJbhayzHne8B3Cs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-caDrItTlPsuFNVszP9Oo3Q-1; Thu, 20 Aug 2020 13:41:15 -0400
X-MC-Unique: caDrItTlPsuFNVszP9Oo3Q-1
Received: by mail-wm1-f72.google.com with SMTP id d22so1050444wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=saSZ72xGZQjg7N1ZoxyMXMkEKF7tyG6HepfcvbIUgEk=;
        b=Y8CdQcfMc+Rb4p5MMlP7zmxTpMpEHlszKEbGv3tGeGX+rIglBwaQZutePGEKhg9Auv
         R+SYExwumL9gn9vWPTovLaMeoHAiw/l+6sV7Y0FzQfZ5Q9TDCuA4engucpYnbQS5CI1c
         qSRqPLASXLwu4p8NhWc6axtZ1aBbsvXTbetW6/AxoizWlFmQT6C7Sml7T8nQbNk3VEZq
         Asp6LDRt5fj9Vwkc9zCnWhIpPABeAg7gUKWpWaVHVIQAQByyYVoQAdcnuM8LlZTytTjs
         TWMwZ4iCgBkZUDQzvEYHJxIaYYYgvCZQr0L4oKWdcYIerNwZBXgtlcWsdupGXvXuenyZ
         tg2w==
X-Gm-Message-State: AOAM530UJCrqZzMGmtTlCIpVhjA2A9y829ynqDxzXzbKhLPa1vJvgwE9
        ZWWhzCAo1dXwjShVEGuVDv6T+W6S4n5UM8Tr7j4DNqEUllcXmCecri6o+zb9IcYeFnH9VU4MjB0
        mXY6Axx+/W16pC4YcHNnArxZF
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr4489699wmh.74.1597945274640;
        Thu, 20 Aug 2020 10:41:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXRw1tgy3fAFN1oCdLTnKz42TTndVNN2Sy+b17hJaQYRdiYwXj7JZqocGj8Y8zK/yjlQ25sA==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr4489678wmh.74.1597945274412;
        Thu, 20 Aug 2020 10:41:14 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id l18sm5660930wrm.52.2020.08.20.10.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 10:41:13 -0700 (PDT)
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com>
 <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
 <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
 <20200820151049.GA26595@sjchrist-ice>
 <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
 <CALCETrW8SWgWxDdMXuMPD-A1avztvNcpwLAKKRQ4ojmcz07B6A@mail.gmail.com>
 <45e16c5c-ce99-33da-99c8-ea52ef0945db@amd.com>
 <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59fc4b2f-7b18-53a2-b30d-c8e0842e7cf9@redhat.com>
Date:   Thu, 20 Aug 2020 19:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/20 18:30, Tom Lendacky wrote:
>>> running the x86 sefltests on a bad kernel without running any guests?
>>
>> I'll give that a try.
> 
> All the selftests passed.

Do the KVM selftests also pass?  Especially the dirty_log_test might be
interesting since it can be run for a longer time.

Paolo

