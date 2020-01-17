Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19693C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45DE22464
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fC8+V8B4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgAQQ7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:59:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45854 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgAQQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:59:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so23270794qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=qmz6hTLuOQmdpf5d+5xaf/MlGzIX54pPDySUObs3zSo=;
        b=fC8+V8B4/Q49oLtUmXQzCaUE2HrPNrU5+qTKR20TwRpH0EpUTlorqh6rLGCRtqZDuZ
         oK1T0DCe90DLkLB7SUAj7COfaO+9o3dbvAx1IAl8OlxjFPR6nkG+SFRlPHrom9HLHRBa
         o+wctd7pLL+nWCP/D00p9y51mMwZwgElCFrthZR26sg4PhPIYfSEaUvfJUN715ImMA7B
         tRKsVbExDG6AlkS2uws2GAzYL+UxSappwaAQxNHttOEAbNwHeAdpvkKjciKuWQf9BnG5
         nZV928pBeNAEPaDDNz3KCoIHmvH14wh7GyID2+Ox7KwgoPC7y34/3peoy+iAVlzhuI+M
         1ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=qmz6hTLuOQmdpf5d+5xaf/MlGzIX54pPDySUObs3zSo=;
        b=Vur7QXfarqIRMtyjcUp8U5ymESgwhkRMvQaU8WMxxC/Q67uBSh9kd3uvr162TdHwrN
         v4cQCe25GFKtVHhSVJLVXUNGba2MyL3+q50Civ9IIrBaRYlm5VsSyUrHilTiNit0lpDD
         KwG148zOFj40SXu7bt6huAuMRNL18oG7QYN+hQQlmhkSNTJAmChr7xRS+ELlZ+Tz5F24
         Gldva7+zlr7woP0iofCtVXT3ywLbJm/63niQRvdx59mEfb+CxPxFn1Q2KtwAdVFoNzML
         0bvG5Kk7nSHJO+oENiB6lhHiJQxtDzNtTZRLVlwAuCK0Hqz4gTrk9bH1c5dhc1eJcXO5
         FOoQ==
X-Gm-Message-State: APjAAAWciXIT2YFG8i9MdhFHzm5UBFaZTHkSk1kKI4NT0Zu5DCxVBSM7
        YeeCUZIDTx+SacmR6UpMX8G9Lw==
X-Google-Smtp-Source: APXvYqxNPTN58yjZAS6uL1OQ/0Ckkq9J0Q+WqN33gcklYiWSvDj5FxYNHra3F3+/ogZzshVAm640Dg==
X-Received: by 2002:a05:620a:164e:: with SMTP id c14mr37395038qko.19.1579280380505;
        Fri, 17 Jan 2020 08:59:40 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 21sm12014926qky.41.2020.01.17.08.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:59:40 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -rcu] kcsan: Make KCSAN compatible with lockdep
Date:   Fri, 17 Jan 2020 11:59:39 -0500
Message-Id: <3760F60F-4133-4FE1-9A4C-F335A8230285@lca.pw>
References: <20200117164017.GA21582@paulmck-ThinkPad-P72>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
In-Reply-To: <20200117164017.GA21582@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 11:40 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> True enough, but even if we reach the nirvana state where there is general=

> agreement on what constitutes a data race in need of fixing and KCSAN
> faithfully checks based on that data-race definition, we need to handle
> the case where someone introduces a bug that results in a destructive
> off-CPU access to a per-CPU variable, which is exactly the sort of thing
> that KCSAN is supposed to detect.  But suppose that this variable is
> frequently referenced from functions that are inlined all over the place.
>=20
> Then that one bug might result in huge numbers of data-race reports in
> a very short period of time, especially on a large system.

It sounds like the case with debug_pagealloc where it prints a spam of those=
, and then the system is just dead.

[   28.992752][  T394] Reported by Kernel Concurrency Sanitizer on:=20
[   28.992752][  T394] CPU: 0 PID: 394 Comm: pgdatinit0 Not tainted 5.5.0-rc=
6-next-20200115+ #3=20
[   28.992752][  T394] Hardware name: HP ProLiant XL230a Gen9/ProLiant XL230=
a Gen9, BIOS U13 01/22/2018=20
[   28.992752][  T394] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
[   28.992752][  T394] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
[   28.992752][  T394] BUG: KCSAN: data-race in __change_page_attr / __chang=
e_page_attr=20
[   28.992752][  T394] =20
[   28.992752][  T394] read to 0xffffffffa01a6de0 of 8 bytes by task 395 on c=
pu 16:=20
[   28.992752][  T394]  __change_page_attr+0xe81/0x1620=20
[   28.992752][  T394]  __change_page_attr_set_clr+0xde/0x4c0=20
[   28.992752][  T394]  __set_pages_np+0xcc/0x100=20
[   28.992752][  T394]  __kernel_map_pages+0xd6/0xdb=20
[   28.992752][  T394]  __free_pages_ok+0x1a8/0x730=20
[   28.992752][  T394]  __free_pages+0x51/0x90=20
[   28.992752][  T394]  __free_pages_core+0x1c7/0x2c0=20
[   28.992752][  T394]  deferred_free_range+0x59/0x8f=20
[   28.992752][  T394]  deferred_init_max21d=20
[   28.992752][  T394]  deferred_init_memmap+0x14a/0x1c1=20
[   28.992752][  T394]  kthread+0x1e0/0x200=20
[   28.992752][  T394]  ret_from_fork+0x3a/0x50=20
[   28.992752][  T394] =20
[   28.992752][  T394] write to 0xffffffffa01a6de0 of 8 bytes by task 394 on=
 cpu 0:=20
[   28.992752][  T394]  __change_page_attr+0xe9c/0x1620=20
[   28.992752][  T394]  __change_page_attr_set_clr+0xde/0x4c0=20
[   28.992752][  T394]  __set_pages_np+0xcc/0x100=20
[   28.992752][  T394]  __kernel_map_pages+0xd6/0xdb=20
[   28.992752][  T394]  __free_pages_ok+0x1a8/0x730=20
[   28.992752][  T394]  __free_pages+0x51/0x90=20
[   28.992752][  T394]  __free_pages_core+0x1c7/0x2c0=20
[   28.992752][  T394]  deferred_free_range+0x59/0x8f=20
[   28.992752][  T394]  deferred_init_maxorder+0x1d6/0x21d=20
[   28.992752][  T394]  deferred_init_memmap+0x14a/0x1c1=20
[   28.992752][  T394]  kthread+0x1e0/0x200=20
[   28.992752][  T394]  ret_from_fork+0x3a/0x50=20

It point out to this,

		pgprot_val(new_prot) &=3D ~pgprot_val(cpa->mask_clr);
		pgprot_val(new_prot) |=3D pgprot_val(cpa->mask_set);

		cpa_inc_4k_install();
		/* Hand in lpsize =3D 0 to enforce the protection mechanism=
 */
		new_prot =3D static_protections(new_prot, address, pfn, 1, 0=
,
					      CPA_PROTECT);

In static_protections(),

	/*
	 * There is no point in checking RW/NX conflicts when the requested=

	 * mapping is setting the page !PRESENT.
	 */
	if (!(pgprot_val(prot) & _PAGE_PRESENT))
		return prot;

Is there a data race there?

