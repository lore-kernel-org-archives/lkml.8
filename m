Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D43C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F9F20866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icVbOLMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgCCR3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:29:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727440AbgCCR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583256576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrfJnMYXSp8JuLlI51btEW+NHNdpcFTSzHFKKNkjZ3g=;
        b=icVbOLMYPVorVQptZ1XFRS6OGN5Ml2EL0Y5Lj+V2KkCZ33vDsJnl3Q8R75T2tJJgDzBdN1
        wDF1doPoNeut2NUOehgLxoiQH5Mkp+4S5srTGVxa2U5KXXXQpCJd05eb0WkCgcE8T4MRii
        G7GOHEcKXSDw04tlYzxJTOYQOznZwvs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-k4EmAwWJOxaF8xFyyIDScA-1; Tue, 03 Mar 2020 12:29:33 -0500
X-MC-Unique: k4EmAwWJOxaF8xFyyIDScA-1
Received: by mail-wr1-f69.google.com with SMTP id j32so1535931wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OrfJnMYXSp8JuLlI51btEW+NHNdpcFTSzHFKKNkjZ3g=;
        b=BMwm4sZKf65hR4iW1crLf35CVFzZIA7cL+wE3C8sRw2XN2wi9PGI9RiQRGzmusfGoy
         Xjpb2ptgi3lYUtixMLcCKPRvgAOxQdzPBQwAErCAxVKOoTZEtwHccM2qT6Sxz/5p1waY
         VodTVkvLKoDac+r76ACxU6BY3PRSznSxeMrYYup0xzWbeh8xj5GFbtXoV9NEtjDvILkK
         5q6rwiSq3UfkmGpQrAxhV9oxp3SbkXGhXAdHm5yegP+JtOG1TVYaQ5LXzu2VWVhTlA88
         gkxseniRqon9oOGJ+K4Gtqe29oMYAU2CAUqWlik2bvOMM0KjhmuIJrImJIdfneIuNIa8
         WiPg==
X-Gm-Message-State: ANhLgQ0n1vKjT0mwjIDHqT430Ky6yCV8AjV0Y1S9po3exaQe413EOFNI
        vWguehP22N4I2gcwzyofeHPT/1Sf/j8h8gsHB1NEnjeBG/P4jJbLxD5sXSgS2SG4HQIlI0ceuIb
        6CHhXOr6vsh29IBiZCN2k3HvB
X-Received: by 2002:adf:ab4e:: with SMTP id r14mr6584101wrc.350.1583256572436;
        Tue, 03 Mar 2020 09:29:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vupGdoUnfoghBjUL1FIu3d71GoeGRPzgmv5uLVuiDEfNO0XORZcpwr/9jEOAVGm1kpiW/5Fyw==
X-Received: by 2002:adf:ab4e:: with SMTP id r14mr6584088wrc.350.1583256572246;
        Tue, 03 Mar 2020 09:29:32 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id n8sm33290957wrm.46.2020.03.03.09.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 09:29:31 -0800 (PST)
Subject: Re: [PATCH v2 06/13] KVM: x86: Refactor emulate tracepoint to
 explicitly take context
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200218232953.5724-1-sean.j.christopherson@intel.com>
 <20200218232953.5724-7-sean.j.christopherson@intel.com>
 <8736axjmte.fsf@vitty.brq.redhat.com> <20200303164813.GL1439@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f3f7aff-2bd0-fa62-4b66-9f90f125e44e@redhat.com>
Date:   Tue, 3 Mar 2020 18:29:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303164813.GL1439@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 17:48, Sean Christopherson wrote:
>>>  	TP_fast_assign(
>>>  		__entry->csbase = kvm_x86_ops->get_segment_base(vcpu, VCPU_SREG_CS);
>> This seems the only usage of 'vcpu' parameter now; I checked and even
>> after switching to dynamic emulation context allocation we still set
>> ctxt->vcpu in alloc_emulate_ctxt(), can we get rid of 'vcpu' parameter
>> here then (and use ctxt->vcpu instead)?
> Hmm, ya, not sure what I was thinking here.
> 

As long as we have one use of vcpu, I'd rather skip this patch and
adjust patch 8 to use "->".  Even the other "explicitly take context"
parts are kinda debatable since you still have to do emul_to_vcpu.
Throwing a handful of

- 	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
+ 	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;

into patch 8 is not bad at all and limits the churn.

Paolo

