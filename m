Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359ADC55183
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BDA2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUpaVAZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgDTVEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:04:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727862AbgDTVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587416683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=el4OTjYf5mEySshudgJWDWTRuJmOvD4sG0r7YGx0AyM=;
        b=eUpaVAZpOY9hz01deiiRcM7gpch1F1Qzomvll6b1LBEmn2x5f0wDz31i0aHdh6T0RFkvL3
        RdZm1xQDBJ8s/L2dUraD3wjMjMYT6LdNLIJ1LbVQE+9G/E2aPcGIbf11XrWa8g3yXlFNlP
        /PTZbticjtWq8YGVv5bJ7nltInksK1c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-jxJBfc7xPXumMghEcvHwBw-1; Mon, 20 Apr 2020 17:04:42 -0400
X-MC-Unique: jxJBfc7xPXumMghEcvHwBw-1
Received: by mail-wr1-f72.google.com with SMTP id j22so6418363wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=el4OTjYf5mEySshudgJWDWTRuJmOvD4sG0r7YGx0AyM=;
        b=Un3T4EbjB2oZhUIP2nGJkcC20T5ejvHm3yZy9hM08lg22UQVTSc1p+aCXtsWOL6IJx
         80a0hv6SmmfMOcdLwV44OvPzwFZQ7MvySMm2J59bjsKioIBMBkYY23b3oU9BOtUiHStP
         dVvc3YtP8uSa+AiF41Uc9CM9xtNHsZ2SZMXz8OidovStyhRf8R2igzkphKyvgmA9LpuO
         8IRkb5XDRGSnM2p1JYGhjQtDhx5XkH235vn2yoS8ELxMRHYmyoTcJQKAqc1m1eou+Tsl
         R4Z9IGWyn3RWbshfgmVwV3zneFbphMqs86T6tUP+DbbM/3Kn0KdVidw4FZoVG/tFrHpU
         Er+Q==
X-Gm-Message-State: AGi0PuYfiVKAbmTxNDKrSv2gmnwpIpV1UVqzjdJIMOgda1HwppkbFlkE
        o36mAEQSpgEFyNJdfknN1eRrlKEJUw0NJWrlU/ZMBEztY05kgikL0EFKUYs/SfVYUUvQuikFONu
        jXIRT+RQxgSd5Zi55RUvhF8y4
X-Received: by 2002:a05:600c:2c0f:: with SMTP id q15mr1372491wmg.185.1587416679644;
        Mon, 20 Apr 2020 14:04:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypLCHmby4MneKzzDfoFddn0WzGOWW+JhFqcNNGOFAialDolkEgs5MBOpolhNVZ8zYuGZUO7k8A==
X-Received: by 2002:a05:600c:2c0f:: with SMTP id q15mr1372470wmg.185.1587416679373;
        Mon, 20 Apr 2020 14:04:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5c18:5523:c13e:fa9f? ([2001:b07:6468:f312:5c18:5523:c13e:fa9f])
        by smtp.gmail.com with ESMTPSA id a20sm944701wra.26.2020.04.20.14.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:04:38 -0700 (PDT)
Subject: Re: [PATCH v2] kvm: Replace vcpu->swait with rcuwait
To:     Davidlohr Bueso <dave@stgolabs.net>, Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, kvm@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>, peterz@infradead.org,
        torvalds@linux-foundation.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        joel@joelfernandes.org, will@kernel.org,
        kvmarm@lists.cs.columbia.edu
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
 <20200420164132.tjzk5ebx35m66yce@linux-p48b>
 <418acdb5001a9ae836095b7187338085@misterjones.org>
 <20200420205641.6sgsllj6pmsnwrvp@linux-p48b>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7cc83fe-3e91-0057-9af2-26c201456689@redhat.com>
Date:   Mon, 20 Apr 2020 23:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420205641.6sgsllj6pmsnwrvp@linux-p48b>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/20 22:56, Davidlohr Bueso wrote:
> On Mon, 20 Apr 2020, Marc Zyngier wrote:
> 
>> This looks like a change in the semantics of the tracepoint. Before this
>> change, 'waited' would have been true if the vcpu waited at all. Here,
>> you'd
>> have false if it has been interrupted by a signal, even if the vcpu
>> has waited
>> for a period of time.
> 
> Hmm but sleeps are now uninterruptible as we're using TASK_IDLE.

Hold on, does that mean that you can't anymore send a signal in order to
kick a thread out of KVM_RUN?  Or am I just misunderstanding?

Paolo

