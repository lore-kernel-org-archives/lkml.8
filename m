Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BCAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A95220722
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4nlWGsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgICTfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:35:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21107 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728304AbgICTfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599161743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCyBRNagum+nnv7ajU0MzZ+M38TwovtYpjuUsvYy9UI=;
        b=P4nlWGsbPFBoCBP14+cwlDLex/Non/0gk6878vb0fvG/U9HO+W+ecm4Q7kIUFcINxPTYMz
        hup5ez/VoC3g2Y438VLNEOKLiX4qIARbMvIJ6IrS3o3qHAzzyDLq1L8Ws0Qv5SXm2Po734
        xPmyDmi8P6SelKJYhrt1j9tEzNooVR4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-omXMNlVLN_62Bsbb_o91OQ-1; Thu, 03 Sep 2020 15:35:39 -0400
X-MC-Unique: omXMNlVLN_62Bsbb_o91OQ-1
Received: by mail-ej1-f72.google.com with SMTP id dr9so1618136ejc.19
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 12:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HCyBRNagum+nnv7ajU0MzZ+M38TwovtYpjuUsvYy9UI=;
        b=OubqZZeWPtqen7tGccnjNdnYCTff44e5ugyaG1b1mPJzuoejDkTJndM0jNBcqzhBb6
         gjhijaXt5FYOU+gYIueN5k8KkEh/YmE/LElyCiK4VCsKhSKxj6Y6dt6aX+em5FXx1VHG
         FMggrxHT5m2OvPC6FOhbPCYwAN9fHoyCFKlLq7RadGqRk0bKNbmPT7wmuutoncSutCWc
         Xf5sf7/W/DB/TpWoLFz+CE61s2/KbwFps4sTbrrRV7IZpw/mCgErYTtpLjWyRbSAFxPL
         G3S3io5HziDsayzJcuOZCns9VWfARGRJcv/B4GYxCpZy7bzMBuQnYG8rs3fBIgFgRz7S
         RYZw==
X-Gm-Message-State: AOAM531LuaeQhYdISZumnG5Vc9XjDkeE1ZeWPZ3Z8Fk+cBvOGeOUGJuf
        OY3AFgE+tGa//gReG2S9/Xq2Bg9A7cQFEJDc9eUv2EuNW7XZBInQ1/qeqrpSa2YlKm6BtKh9/6J
        xczPPjEKu8/z2o32DSeKoYsih
X-Received: by 2002:a17:907:72c5:: with SMTP id du5mr3943333ejc.469.1599161738347;
        Thu, 03 Sep 2020 12:35:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVJXCj6u9zMSZeQq1jRBH6YJG3dd5tBUSi08e2VQGu1JA8wnnzfa+aGyb9qQTLE9nTibaNNg==
X-Received: by 2002:a17:907:72c5:: with SMTP id du5mr3943319ejc.469.1599161738112;
        Thu, 03 Sep 2020 12:35:38 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23bcb.dip0.t-ipconnect.de. [79.242.59.203])
        by smtp.gmail.com with ESMTPSA id d13sm3024664edl.68.2020.09.03.12.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 12:35:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/memory_hotplug: drain per-cpu pages again during memory offline
Date:   Thu, 3 Sep 2020 21:35:35 +0200
Message-Id: <C6941572-4380-4E07-A622-1BB63AE30622@redhat.com>
References: <20200903123136.1fa50e773eb58c6200801e65@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, mhocko@suse.com, linux-mm@kvack.org,
        osalvador@suse.de, richard.weiyang@gmail.com, vbabka@suse.cz,
        rientjes@google.com
In-Reply-To: <20200903123136.1fa50e773eb58c6200801e65@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 03.09.2020 um 21:31 schrieb Andrew Morton <akpm@linux-foundation.org>:
>=20
> =EF=BB=BFOn Thu, 3 Sep 2020 19:36:26 +0200 David Hildenbrand <david@redhat=
.com> wrote:
>=20
>> (still on vacation, back next week on Tuesday)
>>=20
>> I didn't look into discussions in v1, but to me this looks like we are
>> trying to hide an actual bug by implementing hacks in the caller
>> (repeated calls to drain_all_pages()). What about alloc_contig_range()
>> users - you get more allocation errors just because PCP code doesn't
>> play along.
>>=20
>> There *is* strong synchronization with the page allocator - however,
>> there seems to be one corner case race where we allow to allocate pages
>> from isolated pageblocks.
>>=20
>> I want that fixed instead if possible, otherwise this is just an ugly
>> hack to make the obvious symptoms (offlining looping forever) disappear.
>>=20
>> If that is not possible easily, I'd much rather want to see all
>> drain_all_pages() calls being moved to the caller and have the expected
>> behavior documented instead of specifying "there is no strong
>> synchronization with the page allocator" - which is wrong in all but PCP
>> cases (and there only in one possible race?).
>>=20
>=20
> It's a two-line hack which fixes a bug in -stable kernels, so I'm
> inclined to proceed with it anyway.  We can undo it later on as part of
> a better fix, OK?

Agreed as a stable fix, but I really want to see a proper fix (e.g., disabli=
ng PCP while having isolated pageblocks) on top.

>=20
> Unless you think there's some new misbehaviour which we might see as a
> result of this approach?
>=20

We basically disable PCP by keeping to flush it. But performance shouldn=E2=80=
=98t matter.=

