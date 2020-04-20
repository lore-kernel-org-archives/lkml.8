Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103DC55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D227A2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGCbe8fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgDTVHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:07:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbgDTVHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587416850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/IYN1616yr1SA6PkPQ11e2tZILCIQKcMMBO70ZP5s8=;
        b=CGCbe8fzQqnaIQZtyklrdw7vBPMKqA5O95HUs38Zxpc9e7o4BDksmv4kPamME92LXrr2V8
        pd83oknFwFEt5EQxe4wTtmHfW9Lyoz9KJHyIC9PiiBH7Q6sh3fU7TLcJ2fv2Hv5K7NCrHm
        mjZjV2awCYkAtw9NdHT9HEiy6l0lOjU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-5eEsuILKMbeb7ItiefifNg-1; Mon, 20 Apr 2020 17:07:28 -0400
X-MC-Unique: 5eEsuILKMbeb7ItiefifNg-1
Received: by mail-wm1-f71.google.com with SMTP id o26so456910wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T/IYN1616yr1SA6PkPQ11e2tZILCIQKcMMBO70ZP5s8=;
        b=WHxGw+YNh0TicW0nJ+hFEcfLNlCHhkj2v6OOgz2dY89L3KrLr9I0p2pt/uPqWOgGAL
         bjkWTYdoIBdazqc76lP5PAJrtMLe4Y3YomsD4Bs23Z5TwyXqewLQCF5A2vzEnmhjKO0y
         WdcSoskdZ0hmEwf54o6DsRwwl7UU9gGfxXIW/dbroN7Ids2AgDZmplD6zmWO++vG9Ou9
         eJ4z3fmZU7Ey/imJdWrckIFRXWFAGIYsJyJDRnA55tcyXcMOIdG9o9zoVlodydTvF2mS
         RxrTJuL8bKt5JcJFn0BlE7P5fWWjbZNiz11N4onMJpBccX0dFodQ30fhELFj76a2LrWA
         aAgg==
X-Gm-Message-State: AGi0PuanePso8Kzbr6YDec950uATw66d2j6I85xxY3kKuJfxXuyIRkjM
        YWGuChj/mDuejojvJgdszcz8CCvvCP1+VQ6BeVpStSnr+RDF7vzr7BvkwBBB2T5xr+MgEDs8PEK
        1CVFDQAXfjzI5XaJOsrMd7Vd9
X-Received: by 2002:adf:dec9:: with SMTP id i9mr17364162wrn.197.1587416846887;
        Mon, 20 Apr 2020 14:07:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOqoIAgfv+Cg9KTxLRZbcaffpkxlufOwb7c1SleGl00WZf2mNcXeq7YYmz7qNJxCGApScq8g==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr17364149wrn.197.1587416846652;
        Mon, 20 Apr 2020 14:07:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5c18:5523:c13e:fa9f? ([2001:b07:6468:f312:5c18:5523:c13e:fa9f])
        by smtp.gmail.com with ESMTPSA id b191sm809910wmd.39.2020.04.20.14.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:07:26 -0700 (PDT)
Subject: Re: [PATCH] kvm: add capability for halt polling
To:     Jon Cargille <jcargill@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200417221446.108733-1-jcargill@google.com>
 <87d083td9f.fsf@vitty.brq.redhat.com>
 <CANxmayg3ML5_w=pY3=x7_TLOqawojxYGbqMLrXJn+r0b_gvWgA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02848f20-ecf9-550b-9b55-0260b05f6ecd@redhat.com>
Date:   Mon, 20 Apr 2020 23:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANxmayg3ML5_w=pY3=x7_TLOqawojxYGbqMLrXJn+r0b_gvWgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/20 20:47, Jon Cargille wrote:
> Great question, Vitaly.  We actually implemented this as a per-VCPU property
> initially; however, our user-space implementation was only using it to apply
> the same value to all VCPUs, so we later simplified it on the advice of
> Jim Mattson. If there is a consensus for this to go in as per-VCPU rather
> than per-VM, I'm happy to submit that way instead. The per-VM version did
> end up looking simpler, IMO.

Yeah, I am not sure what the usecase would be for per-vCPU halt polling.

You could perhaps disable halt polling for vCPUs that are not placed on
isolated physical CPUs (devoting those vCPUs to housekeeping), but it
seems to me that this would be quite hard to get right.  But in that
case you would probably prefer to disable HLT vmexits completely, rather
than use halt polling.

Paolo

