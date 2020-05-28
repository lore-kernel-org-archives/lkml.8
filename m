Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B99C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkWZE+6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgE1LoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:44:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388427AbgE1LoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590666259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgkJrhOZc0Gmql6BW59mVLIzHXzeHqmyTqYLJYXcY78=;
        b=TkWZE+6alROes+ok8BaQ4Ef4Y7ycwbrE6MHI1DVQYTc7Vwn4XsJg1g/N2weL/DMpw0BUNZ
        C/RoB5mM385wbcYkLE8AeQ4Ye5CE8RL5ihoji5ExC09+T23kSyzCuM79BTIR7+s5VCiaQW
        KbUkzdho/nn1R+Z1NVXIg54jL3WsoDU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-LnK6fXcNOTGJpOnjpjI2lw-1; Thu, 28 May 2020 07:44:18 -0400
X-MC-Unique: LnK6fXcNOTGJpOnjpjI2lw-1
Received: by mail-wm1-f70.google.com with SMTP id z5so872528wml.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lgkJrhOZc0Gmql6BW59mVLIzHXzeHqmyTqYLJYXcY78=;
        b=gNArg5S1a6XQtqFUZMdYoDggJbgnxuoXesdQMWo8sqO2Mm9x8qEQGQy5kA/sI8v7nX
         pPcveBpOLO4IGeSPPr3wgpG12dpX2ibiQ+DAuVH/GCaQ4bHCDZSbEPsw+yRTmbe8tF1q
         0O4JYw8qI0ZIX8urbmQiJMpsitcSqH3+1HYZSA+9UA7nlFcNmI72EEuO04rBJMaVZDuN
         iuAJfQ9phGnNA83z6J6tcJ00losqgIUqhYIcWTQcRgF5ue1aY2Zt8gRWEm4wF5wvCgTk
         BdWC42Fi68U4PD2sVtru825cwrcstgyFLJVJSkKARwI4zywOx7oB/BE6EGNJNBQXYkSg
         Vayw==
X-Gm-Message-State: AOAM530Wgt/FDfHUfRRSeOsLCJBK0jqhDN+6Iz4vXBeoIVEPsGalUJs+
        ykoa8qJ90n/HeHGv0gZH7uetiOTTL5iqMr5BUx8DLVq0KwHrnWncGpIW2RW47qyrlEHVvjNM/Vc
        Qpoxwudy/D6iqWwBOP29kJmhH
X-Received: by 2002:a7b:cc71:: with SMTP id n17mr3058761wmj.148.1590666255878;
        Thu, 28 May 2020 04:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzHaTkWilSw87BW7WiyiNlzanym0eR9Ue95hcqTXW/NOC53yreRPh1IoGr76Fufw/nyptOQg==
X-Received: by 2002:a7b:cc71:: with SMTP id n17mr3058733wmj.148.1590666255503;
        Thu, 28 May 2020 04:44:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id a124sm6527861wmh.4.2020.05.28.04.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 04:44:14 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] KVM: x86: acknowledgment mechanism for async pf
 page ready notifications
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200525144125.143875-1-vkuznets@redhat.com>
 <20200525144125.143875-7-vkuznets@redhat.com>
 <f9d32c25-9167-f1a7-cda7-182a785b92aa@redhat.com>
 <87wo4w2sra.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <690f1a02-6077-e971-f2e9-aedd89f0901a@redhat.com>
Date:   Thu, 28 May 2020 13:44:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87wo4w2sra.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 13:39, Vitaly Kuznetsov wrote:
>> How is the pageready_pending flag migrated?  Should we revert the
>> direction of the MSR (i.e. read the flag, and write 0 to clear it)?
> The flag is not migrated so it will be 'false'. This can just cause an
> extra kick in kvm_arch_async_page_present_queued() but this shouldn't be
> a big deal. Also, after migration we will just send 'wakeup all' event,
> async pf queue will be empty.

Ah, that's kvm_pv_enable_async_pf, where the destination writes to
MSR_KVM_ASYNC_PF.  Cool.

> MSR_KVM_ASYNC_PF_ACK by itself is not
> migrated, we don't even store it, not sure how invering it would change
> things.

Yes, it would only be useful to invert it if it needs to be stored and
migrated.

Thanks,

Paolo

