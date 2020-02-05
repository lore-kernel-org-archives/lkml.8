Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9130DC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F90A21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKOqYjUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgBEOxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:53:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbgBEOxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580914426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAbY+Yr9/eO31ocuCCsfW4JHEc/zKedrcNZ590XXkuc=;
        b=AKOqYjUvJjRgVnBsb94Ed9/esx6AS5aUXM4FhO6L9S/pD0D8bVw+gPLXm82IUqnkv4Rbzp
        9/BIMs4MopPD/OVlND8sQc1ff0XeIzpW3rcVDpimsv4DvpMWln5G1p3G8SwudzrIh127W5
        Wz9j6nrQiiNZnkg9DDZHdX707tXhXew=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-vwhXq1hjNZqnwg5idzKDdg-1; Wed, 05 Feb 2020 09:53:44 -0500
X-MC-Unique: vwhXq1hjNZqnwg5idzKDdg-1
Received: by mail-wm1-f72.google.com with SMTP id y125so2054978wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IAbY+Yr9/eO31ocuCCsfW4JHEc/zKedrcNZ590XXkuc=;
        b=E63OfI4CtXo25SZYeui4Dh1sbVNXicdToaaHDcjYLAT0NzyTm2EPiw6k1FXbIqM5LT
         bdtGEUuOy3xIpsyMMBsrXTgIExtWRo10gpzQRWojkn7J6QA58TV5Q4adPYt9SMnb9wob
         Fxpz8dqVKWe+X/Uj6sI0efG+ndkc0JxI6wIb3i1NBPsyuh9aDgxinyH7oYHcGQNnBDI6
         NVnONQwzy5JtgZXaN3X+TexWAmOv/LHuTv0LRLn3KQUJuIIOQMXxJmLeb47dmU9Wipi3
         uE17O5/3LjTN0+RaJZeFX0FLPkggfrMFz5NaVmfKosEsYd+NpDYDc/SGSe0XBnbBPlYk
         pkhg==
X-Gm-Message-State: APjAAAV/8yR154xY1xa/3hdfxOZa2ln7YsYbnKFQfwCaCTbnLTRtrdgC
        87Du1pSyKndVr88VeBBTjxLGRKAmIbb8flLuhxVj1izJzZ0eplmHhxy+CWOIZ9nMowcfgXGbKU9
        acl0FXo5nFh1ikuJvAPzpWg+x
X-Received: by 2002:adf:ed09:: with SMTP id a9mr12568526wro.350.1580914423779;
        Wed, 05 Feb 2020 06:53:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4uM/x/8RTwBkdiICJD8IV48N7CDDFK2+/pLfMxQ3+hcFqA1/YQpAgUC0SFoYYkKnZRG1C1g==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr12568501wro.350.1580914423593;
        Wed, 05 Feb 2020 06:53:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56? ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
        by smtp.gmail.com with ESMTPSA id q14sm60827wrj.81.2020.02.05.06.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:53:43 -0800 (PST)
Subject: Re: [PATCH 3/3] kvm: mmu: Separate pte generation from set_spte
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200203230911.39755-1-bgardon@google.com>
 <20200203230911.39755-3-bgardon@google.com>
 <87pnetkuov.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1adc4784-8567-d008-4d78-957fd33585ed@redhat.com>
Date:   Wed, 5 Feb 2020 15:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87pnetkuov.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/20 14:52, Vitaly Kuznetsov wrote:
>> +	spte = make_spte(vcpu, pte_access, level, gfn, pfn, *sptep, speculative,
>> +			 can_unsync, host_writable, sp_ad_disabled(sp), &ret);
> I'm probably missing something, but in make_spte() I see just one place
> which writes to '*ret' so at the end, this is either
> SET_SPTE_WRITE_PROTECTED_PT or 0 (which we got only because we
> initialize it to 0 in set_spte()). Unless this is preparation to some
> other change, I don't see much value in the complication.
> 
> Can we actually reverse the logic, pass 'spte' by reference and return
> 'ret'?
> 

It gives a similar calling convention between make_spte and
make_mmio_spte.  It's not the most beautiful thing but I think I prefer it.

But the overwhelming function parameters are quite ugly, especially
old_spte.  I don't think it's an improvement, let's consider it together
with the rest of your changes instead.

Paolo

