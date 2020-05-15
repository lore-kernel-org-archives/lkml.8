Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A0BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D5A206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yp2Wmewf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEOP7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:59:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42656 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbgEOP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589558388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGZXFwumSbdNNYAeiggV8U4re8SO4/3betnreXnOP68=;
        b=Yp2WmewfAw9QVLo5XbPRAbeoiAw66yszHg5nywd18NHEUpk4cAW5opYG16VZPqOxTOSqTM
        bmuqt0v0y1GMna3N2hUmJKZlBchSEqjYYM/XXc7PST8ZKz1YTylVSVkUutbSromJdHzSF+
        WJty/5CbViq/YvhSFyNysdpbZZmF33s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-sCq5CGBcOjW0CbXAUOkg2Q-1; Fri, 15 May 2020 11:59:46 -0400
X-MC-Unique: sCq5CGBcOjW0CbXAUOkg2Q-1
Received: by mail-wr1-f72.google.com with SMTP id z10so1402159wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGZXFwumSbdNNYAeiggV8U4re8SO4/3betnreXnOP68=;
        b=Je0Cbffwr/4jet7B8K5Qa9Kalafkea8jREEK6hESj3mhg4kkqpE8SGbr0J4w1KbJdk
         3NgUl1wKuvFTT6/OPnLH3bsP8CRpu5mR9hW7v/SrSxQTDObw49Z95lvWjE6/pk+sYtNp
         wlFQP8Yd9l1dnfSqawqMcy98GBYh7ki9aRrxlC0amzl9ZKWWhOaIDbbqcuCT20PFXg/j
         b7AkyqE2rdiRm/gL54FfPzSQT6OIcOx5jJ0sBQHn4cWUAaYh+UOoah2f6Z5nNNACypoO
         GQ5kjcGk6wSVftYnWvTZysbelXupY5Ngg1aTsKGVaPylTSKkMeYk7iQE1ukg3IqguyR6
         SvQg==
X-Gm-Message-State: AOAM533Dgf6bTmRSGpY7LRecoYPstD5LYdbdH3DLjZ6lncGG4VAwbuLR
        YI7tZs93ii8XEYNdsz+MPsjtRj16zxdo9cRlE++qgiYUNj8j+yEOcjrJQUK2EeU/13cFMpucszO
        EupIPxvoauuCLL0c6ikb1C4Vz
X-Received: by 2002:adf:d841:: with SMTP id k1mr4873041wrl.129.1589558385458;
        Fri, 15 May 2020 08:59:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSnUkPKjiUFYzyVHnxEbwzqPOvyHVqk4g3owBqQZqHtbskp7Ls7B+c3JLBHhLBGtvBBxcDeQ==
X-Received: by 2002:adf:d841:: with SMTP id k1mr4873013wrl.129.1589558385172;
        Fri, 15 May 2020 08:59:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:60bb:f5bd:83ff:ec47? ([2001:b07:6468:f312:60bb:f5bd:83ff:ec47])
        by smtp.gmail.com with ESMTPSA id w12sm4196501wmk.12.2020.05.15.08.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:59:44 -0700 (PDT)
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with
 token info
To:     Vivek Goyal <vgoyal@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200511164752.2158645-1-vkuznets@redhat.com>
 <20200511164752.2158645-3-vkuznets@redhat.com>
 <20200512152709.GB138129@redhat.com> <87o8qtmaat.fsf@vitty.brq.redhat.com>
 <20200512155339.GD138129@redhat.com> <20200512175017.GC12100@linux.intel.com>
 <20200513125241.GA173965@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0733213c-9514-4b04-6356-cf1087edd9cf@redhat.com>
Date:   Fri, 15 May 2020 17:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200513125241.GA173965@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/20 14:52, Vivek Goyal wrote:
>>> Also, type of event should not necessarily be tied to delivery method.
>>> For example if we end up introducing say, "KVM_PV_REASON_PAGE_ERROR", then
>>> I would think that event can be injected both using exception (#PF or #VE)
>>> as well as interrupt (depending on state of system).
>> Why bother preserving backwards compatibility?
> New machanism does not have to support old guests but old mechanism
> should probably continue to work and deprecated slowly, IMHO. Otherwise
> guests which were receiving async page faults will suddenly stop getting
> it over hypervisor upgrade and possibly see drop in performance.

Unfortunately, the old mechanism was broken enough, and in enough
different ways, that it's better to just drop it.

The new one using #VE is not coming very soon (we need to emulate it for
<Broadwell and AMD processors, so it's not entirely trivial) so we are
going to keep "page not ready" delivery using #PF for some time or even
forever.  However, page ready notification as #PF is going away for good.

That said, type1/type2 is quite bad. :)  Let's change that to page not
present / page ready.

Thanks,

Paolo

