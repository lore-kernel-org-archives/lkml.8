Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F921206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPMTnqW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgGHLKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:10:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34429 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728764AbgGHLKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594206608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14f1mTpd7HVDpOyXYxD6GElv4scdvE+XkzizMQMoy8M=;
        b=aPMTnqW4vi7hq5klY6J2VUbGsVQnrotJZlcnMe8cPHSSCQdUyKf3qPpba8e7uJ3m07i31x
        WEXkUFh125t61i6fffK+YSFOyx+bGHtMv+Zh9YR2Z0HlgBCIitfthnb+/4hMewT87ksT7a
        VphcxakFTpnfY7JYX0zPbtO2S1NDblU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-RwB05G-MOPK6OfZ0w1nCpw-1; Wed, 08 Jul 2020 07:10:05 -0400
X-MC-Unique: RwB05G-MOPK6OfZ0w1nCpw-1
Received: by mail-wr1-f69.google.com with SMTP id 89so28140735wrr.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 04:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14f1mTpd7HVDpOyXYxD6GElv4scdvE+XkzizMQMoy8M=;
        b=ZXWFwiICjspZqC6FSgINQEhV/CE6sOGnUoKquYONm1ydNMLXEIi4SX/DYxHBkTWMfy
         s2vnOzGQV2kk9p1a/4fEfWMOk6PdZb4VUwZ9xp21hDPYf5POUSWyUX6ZAIbvX8dNeyGv
         Qkn5Peu8+Gqbh9tFFPhwxB5RHGmmpig0opwISLvLNziJfKiB2wiU5FQzYCDyVdiifm16
         tOsMLpbWsMy3BB/VkotZMrD/e1MA3cRneuJO2jJkqtqm5UOXDbO4nbI/SMPM6onk6g6O
         dPbZZ3eg1OtOaN86YATdzCcoK7h14z37QU5gvjnMQAO/Y4uJqG9Epn/nHToUAoK82duT
         1Wig==
X-Gm-Message-State: AOAM531neZdpg11uD21Z9QxrAFwBvzo+sfToIaZw9fnEkozH7NttyWDk
        qvIuMy3nSkMrHfTOdC/49C6o0Y4LvJuXamz0IZ33bqQOODZA9hgabbEjAP0JbhQ90RuhA0guH+h
        zzAkAL2YHwr8Cv0crqQILaLSh
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr54529520wrx.50.1594206604360;
        Wed, 08 Jul 2020 04:10:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS9IXWXY8AsLX9C3rrryHKZ4q/47XveQNN7O/2+yEMRnuw24+Agts1i9nEHB/Ycwubh37ATw==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr54529504wrx.50.1594206604189;
        Wed, 08 Jul 2020 04:10:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id j6sm5766924wma.25.2020.07.08.04.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:10:03 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: SVM: avoid infinite loop on NPF from bad address
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "# v3 . 10+" <stable@vger.kernel.org>
References: <20200417163843.71624-1-pbonzini@redhat.com>
 <20200417163843.71624-2-pbonzini@redhat.com>
 <CANRm+CyWKbSU9FZkGoPx2nff-Se3Qcfn1TXXw8exy-6nuZrirg@mail.gmail.com>
 <57a405b3-6836-83f0-ed97-79f637f7b456@redhat.com>
 <CANRm+CzpFt5SwnQzJjRGp3T_Q=Ws3OWBx4FPmMK79qOx1v3NBQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7507de6a-799e-4f71-012d-ddaa39178284@redhat.com>
Date:   Wed, 8 Jul 2020 13:10:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CzpFt5SwnQzJjRGp3T_Q=Ws3OWBx4FPmMK79qOx1v3NBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 11:08, Wanpeng Li wrote:
>>>> +EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_memslot);
>>> This commit incurs the linux guest fails to boot once add --overcommit
>>> cpu-pm=on or not intercept hlt instruction, any thoughts?
>> Can you write a selftest?
> Actually I don't know what's happening here(why not intercept hlt
> instruction has associated with this commit), otherwise, it has
> already been fixed. :)

I don't understand, what has been fixed and where?

Paolo

