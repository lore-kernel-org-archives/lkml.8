Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD388C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9768A20760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfwJae+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389707AbgF3PoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:44:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29820 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389617AbgF3PoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593531851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+7JZMmEMWPm9TcnXCXFzCXeXPgv7LEiZobSQGLUt4c=;
        b=IfwJae+M2aGa3GlnEIb2oQas55fDDGCS0TQiF685YKehOUQrTyFUXUCbsRLUifaPC8YC3s
        YoeXQGn28QSNmSFnuHFOjoC9GA6C9FsqUOM3e5bnxxiFdRzcla4gKuVira131VQw0ft7ot
        uDMqfUhNE6GAGHpxTB17Sem0Sceep+U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-SRPiOL1MPj2l3OTDwGLi4Q-1; Tue, 30 Jun 2020 11:43:58 -0400
X-MC-Unique: SRPiOL1MPj2l3OTDwGLi4Q-1
Received: by mail-ej1-f72.google.com with SMTP id f11so2844062ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=g+7JZMmEMWPm9TcnXCXFzCXeXPgv7LEiZobSQGLUt4c=;
        b=Nh6nLhkTGbqKwbZqEgKnZb0cf7A/qAfn9HwkSqShDNXtw+RZMU8H7H9VrhxBpxFskw
         CquLOobZtukFcdxvnVhAlgT4AEEkgxLDk4JHR0hCRmuy0foUnTou46HOUm7AxZajoBfq
         a0sRqf76dMGPlGcNNYEQaF/ujGenizMF58A7MuenjmzViTgAcN9a4vdzJknLG0MnmStn
         k5q6kg0zHtP1eykAS+1WL73Obn6MM/sRktqYkJ3rnE2XEoQnPN7NCNs73Wz2xS2lRVtA
         SoWEZwly2S3TASbF6AluvwTbifazbkLUE9b8kOv7allLaqy/KohV83gqOpMpyamxzJYj
         qbmQ==
X-Gm-Message-State: AOAM532TQFl9Ae6XGLOwAqicuxr7+Tlgnzruo8b6LAXFlqfE02bzGYhD
        Ya4ucPjNN9Z8CefjPcK0YODR302+TRGYdiEjYRphkDnysB/VX291FtuFkqytXyS0P/MZcQvj5HD
        hFtmdOi4pdiM12sr4lfeo9v/h
X-Received: by 2002:a17:906:6a14:: with SMTP id o20mr19371694ejr.128.1593531836505;
        Tue, 30 Jun 2020 08:43:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN5020D0g4+WwC4BExYGDMsxQNa0UsSFFuaNfKIVU9PWBDqP5EAnwkz46NPYCIlmVoziF18w==
X-Received: by 2002:a17:906:6a14:: with SMTP id o20mr19371673ejr.128.1593531836311;
        Tue, 30 Jun 2020 08:43:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w18sm2247913ejc.62.2020.06.30.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:43:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, virtio-fs@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kvm,x86: Exit to user space in case of page fault error
In-Reply-To: <20200630152529.GC322149@redhat.com>
References: <20200625214701.GA180786@redhat.com> <87lfkach6o.fsf@vitty.brq.redhat.com> <20200626150303.GC195150@redhat.com> <874kqtd212.fsf@vitty.brq.redhat.com> <20200629220353.GC269627@redhat.com> <87sgecbs9w.fsf@vitty.brq.redhat.com> <20200630145303.GB322149@redhat.com> <87mu4kbn7x.fsf@vitty.brq.redhat.com> <20200630152529.GC322149@redhat.com>
Date:   Tue, 30 Jun 2020 17:43:54 +0200
Message-ID: <87k0zobltx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Jun 30, 2020 at 05:13:54PM +0200, Vitaly Kuznetsov wrote:
>> 
>> > - If you retry in kernel, we will change the context completely that
>> >   who was trying to access the gfn in question. We want to retain
>> >   the real context and retain information who was trying to access
>> >   gfn in question.
>> 
>> (Just so I understand the idea better) does the guest context matter to
>> the host? Or, more specifically, are we going to do anything besides
>> get_user_pages() which will actually analyze who triggered the access
>> *in the guest*?
>
> When we exit to user space, qemu prints bunch of register state. I am
> wondering what does that state represent. Does some of that traces
> back to the process which was trying to access that hva? I don't
> know.

We can get the full CPU state when the fault happens if we need to but
generally we are not analyzing it. I can imagine looking at CPL, for
example, but trying to distinguish guest's 'process A' from 'process B'
may not be simple.

>
> I think keeping a cache of error gfns might not be too bad from
> implemetation point of view. I will give it a try and see how
> bad does it look.

Right; I'm only worried about the fact that every cache (or hash) has a
limited size and under certain curcumstances we may overflow it. When an
overflow happens, we will follow the APF path again and this can go over
and over. Maybe we can punch a hole in EPT/NPT making the PFN reserved/
not-present so when the guest tries to access it again we trap the
access in KVM and, if the error persists, don't follow the APF path?

-- 
Vitaly

