Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C07C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2773F208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL1q1AuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgHTNri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729762AbgHTNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597931005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUj6yx5X7ltWZxH/b96euv3aQubH9i85achpimDWoYg=;
        b=cL1q1AuLDPLpG2AGCod7/hSccPe6qmDMrn+dYt1OFsDCec4jzy9RIfohEYScJcf3at3hH9
        wmcPRl7y+zlCFCHlFM19ebW2bJNj1eindiqlCj+acicYnKT6euUiFsfvTS8HWvyHGRpq4A
        uSggMoJRzReN4UEhpJbdr26dwtvdnY0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-Dzfst2oTM1a4u5Y44wfmlw-1; Thu, 20 Aug 2020 09:43:21 -0400
X-MC-Unique: Dzfst2oTM1a4u5Y44wfmlw-1
Received: by mail-wr1-f70.google.com with SMTP id k11so676344wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUj6yx5X7ltWZxH/b96euv3aQubH9i85achpimDWoYg=;
        b=EOy+RdSUHK5yhb7s43CNktaJIdBJ4AgH7CSd8jc9CQuNrazi5oJfuXRU4jBcVp70uo
         xmKQzTS1lR3Bvcum46VAX3sk/Dg8hq+FFRUb0AuKQlRr/c/xVCYH+4K0dC+n3NCnRhau
         YtIyRmJGzwEwYjTNIqTvCBhdKf18MNwRbEk6r8Jyfl3FSEWc9lG3Q0oRqPiXjjE1sAJg
         WdNBY8ZYtutL/O6SLXtbLdyZl+wOWr2IKS0tn0G3vUqDH0S1kzN3bg3pWLwbtPhaqiZH
         uzXUekU996RBP7B3rjIyQbz5ZvzBk1UhkN8GnEn/sfHGCWpxpvVFOU950T3pHn0dtACD
         jipw==
X-Gm-Message-State: AOAM530PT7wr+pUHw8t642SnpKrrJsCAiDotZk+xOcGMXEN64Z8e+YQU
        qAlczZ64j720AftrA+7YA6tzb6js9aYjNh6GduWoRf9M30I8/13lTHxnv/cHSFs4kUOEI2N1D2t
        dMaOmPDHOadzenJ9txE6YnsP0
X-Received: by 2002:adf:9501:: with SMTP id 1mr3285837wrs.413.1597930999853;
        Thu, 20 Aug 2020 06:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk4AYhMdLAx9L3X17nzshI8k7fQJaU0SM+fw+yWM5KCtAXxh9slvySYS9RNfo3aInUv8N2Cw==
X-Received: by 2002:adf:9501:: with SMTP id 1mr3285752wrs.413.1597930998734;
        Thu, 20 Aug 2020 06:43:18 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id d14sm4210136wre.44.2020.08.20.06.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 06:43:18 -0700 (PDT)
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Andy Lutomirski <luto@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aab48f12-5c2a-8e01-8dcb-16669fda7526@redhat.com>
Date:   Thu, 20 Aug 2020 15:43:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/20 23:25, Andy Lutomirski wrote:
>         wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
>         load_gs_index(svm->host.gs);
> 
> Surely that should do load_gs_index() *before* wrmsrl().  But that's
> not the problem at hand.

The wrmsrl is writing the inactive GS base so the ordering between
load_gs_index and wrmsrl(MSR_KERNEL_GS_BASE) should be irrelevant?

Paolo

