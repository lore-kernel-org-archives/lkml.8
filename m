Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF6CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E3020734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L31SJ0Wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgFJLeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:34:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45024 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbgFJLeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztFqhUudHoU3NNYqFL5POta8Qmquf650y/nl/9Uo0mc=;
        b=L31SJ0WmX/2p6ulGSebAb22Ofufm5BGModPLE4jXIbqaMxEEjKP0HNXckWpM1isege8QTe
        gqdMldM6Lp0AMLQKAYluWGSNltWpU+YfFFWeIsieNrj55YWYY3ZMfZ9Ph2nadWpQPxuJZ5
        c3nqnujtgdgqa+USYAGdy7RLQIkfLBM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-YVpuJXw5NdGL1XItkto8Sg-1; Wed, 10 Jun 2020 07:34:05 -0400
X-MC-Unique: YVpuJXw5NdGL1XItkto8Sg-1
Received: by mail-ej1-f70.google.com with SMTP id g9so950101ejs.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ztFqhUudHoU3NNYqFL5POta8Qmquf650y/nl/9Uo0mc=;
        b=gcfjjGRdtSJ5u4NGz8FBhtUYoatkK+5X5AtyHg7S3OJkmRTiQp2iwOwAsIfGbHCzn8
         yNLphk9ReCMA1my0KdAhn1Qegjby1gBKr7h2bLP1f32eaVCThXugUIXTdjT/9FcN7xhn
         fTP4vKnUxEAVgW1cYtbYrE5AA1ti0Nf8Ec3Bkvyp4wSCMAIa/ZMNhnRdtvufaUwF1aM8
         pfRB2bXBtAmiNoX/a2uB9F968wpLNv+bRobbYE8EOczV/eSKVQ1oZVB+MPCfIF+a87PI
         Q5c/LX4zUxCseXJ49/EnoopCfMsPUrt+oy9nUYYpp4t7tg3R0jQ2sqa1Qj9JiB2G3VLN
         GaoQ==
X-Gm-Message-State: AOAM533j8Nog0nA9Re6fnMpZX3GOhm1c14jejMDN/Zdcndt8PXR39zMf
        AIFc0Jq5amtnIdmPGAGDOH7dnxi95dmswtKYrdzJCLhgI04B8ve+fGurC77t1A3fAGlgGrFyM5E
        Ql1dSeXDNNWnhvbavGAUSZuEM
X-Received: by 2002:a17:907:441c:: with SMTP id om20mr2772957ejb.62.1591788844398;
        Wed, 10 Jun 2020 04:34:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYfnxO7q4EnVccZRzA4Vkj9BRco2fOIoVOAQFKJPWEKvKv7I1oFGHoz1Ks7Pdc073loFhqzQ==
X-Received: by 2002:a17:907:441c:: with SMTP id om20mr2772924ejb.62.1591788844144;
        Wed, 10 Jun 2020 04:34:04 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.134.4])
        by smtp.gmail.com with ESMTPSA id e4sm16864342edy.17.2020.06.10.04.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 04:34:03 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] KVM: x86: interrupt based APF 'page ready' event
 delivery
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200525144125.143875-1-vkuznets@redhat.com>
 <20200525144125.143875-6-vkuznets@redhat.com>
 <20200609191035.GA223235@redhat.com>
 <dcdda87c-cf2f-da6f-3166-e2d0bfefce06@redhat.com>
 <873673b8gc.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce34f17a-d444-fdf4-1a1c-e052234c1516@redhat.com>
Date:   Wed, 10 Jun 2020 13:34:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <873673b8gc.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/20 11:01, Vitaly Kuznetsov wrote:
> The issue isn't related to the interrupt based APF mechanism, right?
> 'Page ready' events are always injected (sooner or later). I'll take a
> look.

No, it isn't.

>>> While setting up async pf, should we keep track whether associated
>>> page_not_present was delivered to guest or not and deliver page_ready
>>> accordingly.
>>
>> Yes, I think so.
> 
> Something like this? (not even compile tested yet):

Pretty much, though I would avoid the reindentation if possible.

Paolo

