Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6EAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD172067D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMhzxPLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgG2XMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:12:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726876AbgG2XMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596064333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9pPtUWnI75PPVSEE75oF0U92QV8pFljuW9EYbvcOk4U=;
        b=IMhzxPLiQOYE6OTcGDVJMcQEFMWqJ44emOWCTzp6DXLznrJ207CFn+CTaf9yAA3REbBhw9
        zEibi+7B8+YFrUfpovAAsNANwdj1qzE5QDyzJqpltpBOrx+iOZWDCkd9duPlmQxOgPML0T
        hdzFQqdCTvm0yB3miRetraxkpBr8U5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-6NV6y6WSNfCVjnctU0841A-1; Wed, 29 Jul 2020 19:12:10 -0400
X-MC-Unique: 6NV6y6WSNfCVjnctU0841A-1
Received: by mail-wm1-f69.google.com with SMTP id s2so961358wmj.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9pPtUWnI75PPVSEE75oF0U92QV8pFljuW9EYbvcOk4U=;
        b=az8yjygZD3Iyg+4T4LGrc8uZC/PmDIgTfdwI+FRMhtiahiUjp3sgDPAhGJ1xyVXz3F
         zG6cA5SevPPXo2O0EVFl8IYR6V3aUqS2Z8jAP0k0IheQ+0GxdxO8eSNtWPwGpgZD3xwN
         cnQ+x6iAfcRz/6U4ASChwo2iaCm5FCxTvkoFKffpHfQB7TtHX03T/IBGV4zPnbgsrf6n
         LV5gA5JH5JlCa5HGXWOxYarlHBnDkvWNUZuBerD3q3lhakc4Tl4Z8i3l1d+FmUUe+3rL
         gB1AMEx135rvNTQq8SP7DwnKkFmhO2ChI6+g4QexPv/BFeT8LhsE5DX7ABfIC4UFzTNd
         1vLQ==
X-Gm-Message-State: AOAM531BXLSzm9zjfuVNzwvE5fVDn4l6VqdR3PPNsoC6ysjhim/AF8+d
        L6yLiKny+PHItWh210wcMSMbS8yLr2MiXgtKnETEeK1TbtBjhPQL2ZPzdGC+l4NaEZUTFkjHq3h
        jYLgrcZ0YCWZaFlJZbPzw2e2U
X-Received: by 2002:adf:bb14:: with SMTP id r20mr28458wrg.366.1596064329525;
        Wed, 29 Jul 2020 16:12:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfASuMmdkKxWdOoYTiFWwNM71pGY6l/xn3XDIGVfVKppRfSjaNZOg3ibDQsz3/sYBOz5MIVg==
X-Received: by 2002:adf:bb14:: with SMTP id r20mr28434wrg.366.1596064329223;
        Wed, 29 Jul 2020 16:12:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:101f:6e7:e073:454c? ([2001:b07:6468:f312:101f:6e7:e073:454c])
        by smtp.gmail.com with ESMTPSA id s20sm6330064wmh.21.2020.07.29.16.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:12:08 -0700 (PDT)
Subject: Re: [PATCH v3 03/11] KVM: SVM: Change intercept_dr to generic
 intercepts
To:     Jim Mattson <jmattson@google.com>, Babu Moger <babu.moger@amd.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu>
 <159597948692.12744.7037992839778140055.stgit@bmoger-ubuntu>
 <CALMp9eRF-ScqaWG7vn2mxKmR4jWo7LYZiiicHksiZR9hh+G=-A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3841a638-eb9e-fae6-a6b6-04fec0e64b50@redhat.com>
Date:   Thu, 30 Jul 2020 01:12:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eRF-ScqaWG7vn2mxKmR4jWo7LYZiiicHksiZR9hh+G=-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/20 01:59, Jim Mattson wrote:
>>         case SVM_EXIT_READ_DR0 ... SVM_EXIT_WRITE_DR7: {
>> -               u32 bit = 1U << (exit_code - SVM_EXIT_READ_DR0);
>> -               if (svm->nested.ctl.intercept_dr & bit)
>> +               if (__is_intercept(&svm->nested.ctl.intercepts, exit_code))
> Can I assume that all of these __<function> calls will become
> <function> calls when the grand unification is done? (Maybe I should
> just look ahead.)
> 

The <function> calls are reserved for the active VMCB while these take a
vector.  Probably it would be nicer to call them
vmcb_{set,clr,is}_intercept and make them take a struct
vmcb_control_area*, but apart from that the concept is fine

Once we do the vmcb01/vmcb02/vmcb12 work, there will not be anymore
&svm->nested.ctl (replaced by &svm->nested.vmcb12->ctl) and we will be
able to change them to take a struct vmcb*.  Then is_intercept would for
example be simply:

	return vmcb_is_intercept(svm->vmcb, nr);

as expected.

Paolo

