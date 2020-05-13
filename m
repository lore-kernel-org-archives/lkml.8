Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2258FCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2DB24957
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKyKLt7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbgEMM5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:57:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729345AbgEMM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589374659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ob2GqH7qD296iB6P/14HKQmOuD3tUq1NGI9wvJ7eHUw=;
        b=jKyKLt7hZAaHFtuHp89QWNMAlDoHb9+Kd//6qpgmMmotlBGyXO52IK2fB1gArKWXBsF0pe
        xcwQ7J9JC9G9753SAXH1Vb978zLCqZKWODYvb3XDIgwbLxMz4U8u6nZ80k92cVhD4FrIsf
        j+AjYhdgYQjK2IN2sg849KftK4jEkEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-AXkP3UecMxq15pCZf32bTQ-1; Wed, 13 May 2020 08:57:38 -0400
X-MC-Unique: AXkP3UecMxq15pCZf32bTQ-1
Received: by mail-wm1-f71.google.com with SMTP id a206so4701194wmh.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ob2GqH7qD296iB6P/14HKQmOuD3tUq1NGI9wvJ7eHUw=;
        b=HJt7gC/J9VbxwwCMw2GrJm5Uq+G0c2nsbj+q3xJYz14U8xChIi6qX2QQ1IdwzQN7kU
         /EU1fNOp7Nb72klIWcoFvpm1EmVdd+TdOS2u19/4cZ0CkN4Zk0EvVk91FKbx2jbEIqkK
         euzaoL+NpTKefVtRVwcWlN02YBfG4n2I7X6cDG0yYdC2hMv6HxhXxXiFRNJU/3biCxP5
         xrIxO7NoGCFmPx8qDTVqr33pMvMIXuv/G86yFOhpT4cbRS7hUlSVkL2Dj52EuobknphT
         8AwLjoAj2yv6J86rrgMfGdQ5ix5uwMx0JVQHjrMV9nu8GgP5+jOngyHUxzIq0I/JhMkJ
         7hFw==
X-Gm-Message-State: AGi0PuY38eSj1Jync8gcGbV1qlX8HwsQuDef8MgWzoYi8WarGGCycQ9s
        8txgN1kAkuw8JYZmIcnzbq7WExgbvAQWl4O77JZec4H3gRymSpVoKTaDaPwOQn3qNM68X/N1In+
        scvbPk047OKKXzrG9e8TF2eQU
X-Received: by 2002:adf:ea09:: with SMTP id q9mr31683730wrm.399.1589374656918;
        Wed, 13 May 2020 05:57:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypJENo1pNxT4cb92OnEACsibSpJCPfFYJKeXmxUB+ec9RrJ6uO1biLurikfbbxKtZB3cjIAnAg==
X-Received: by 2002:adf:ea09:: with SMTP id q9mr31683712wrm.399.1589374656760;
        Wed, 13 May 2020 05:57:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 7sm29948323wra.50.2020.05.13.05.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:57:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 0/3] x86/idt: Minor alloc_intr_gate() sanitization
In-Reply-To: <20200428093824.1451532-1-vkuznets@redhat.com>
References: <20200428093824.1451532-1-vkuznets@redhat.com>
Date:   Wed, 13 May 2020 14:57:34 +0200
Message-ID: <87imh0kn5t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> This series is a successor of "[PATCH] x86/idt: Keep spurious entries unset
> in system_vectors".
>
> The original issue I tried to address was that /proc/interrupts output
> was always containing all possible system vectors, including non allocated
> ones (e.g. 'Hypervisor callback interrupts' on bare metal). Thomas
> suggested to expand this cosmetic change to making alloc_intr_gate()
> __init.
>
> Vitaly Kuznetsov (3):
>   x86/xen: Split HVM vector callback setup and interrupt gate allocation
>   x86/idt: Annotate alloc_intr_gate() with __init
>   x86/idt: Keep spurious entries unset in system_vectors
>

Ping?

-- 
Vitaly

