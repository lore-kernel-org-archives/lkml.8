Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F0C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D09206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbC0SGU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgIHRwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbgIHQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B97C061388
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:30:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so18912977wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y/EkIKvR6iBw+zS5qhGZEpN1iwHB9TWxtJTSD07C3J4=;
        b=GbC0SGU+jdHDgkoKWG2x4two8n4K73jUfxTdN6DtKPjGlsAaxh51FOkVE6YUzsr5dv
         Cl/uPdJHLO81KjXKkjm2YvYdaTjNfEdMS/wT0FkZHVgd+Pl9rk9gtifJLHjIO7kvCaMA
         eAQRJ0CKTL6XgI16ktwVj+sdsxZ4/ZT3SPRDRGEvgvV6Hem09VJQLjoYw52OOMtzAMRU
         WuCUZ1D2FRKthW77L5ZYlhOGTOLDjUUdyuMHMJP1hLgQNmFOgLRHNQYsOxcYmxQXpWM3
         Bpbvek41ZTKkov39peOcMfxY1Lf+7U5vKv199vZzovSFk/oQHLmzj0qS0PbV1iitF6qv
         c+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y/EkIKvR6iBw+zS5qhGZEpN1iwHB9TWxtJTSD07C3J4=;
        b=KZ7jD41VewP7h0GqzDnE4T11ljwNjCnhQutxnF4T9kssNpjn/sk/7BbiJYDUngBMML
         wNUFycdTYTW8ns4DLDcNOlGZEQkXq/jOjbckIZMERFlt+Ce89hh1yJigc8eV5hHIcy1/
         CBf9xyvbva4ejB39x/EZHiRtoqXB6cPzgeKjYGRzwzsjriT8asdOeezUVMUmy1W6XbAC
         H9O04oPyB9DZtyaVqtXnXyF50brGVE1QyceDKKkSCyi4360j6LFvWPTWKf4GSw2MAp6q
         RfigGq48Dk2v6O9I4Tloh0X680nq5ov+60R0SuIOXidjpPq0Q73syUyh7ZLYUXywzj7k
         FQhg==
X-Gm-Message-State: AOAM532uDg7b8YZQJxFlc4D7i2VyrZoXutC9QlDU8X8rW2Btt/mbFjJW
        WtI1aKq1sfTs9pvDxBgc3OQgWVlWKoLf8w40kfI3EA==
X-Google-Smtp-Source: ABdhPJzcPzSvH+P8hTbAa6PCtKuOhme3NG7uL/ej8gWFNWQLmk0e0zNZlg/a/MBGYQeeUXoyAAxylIEsLLY0lkgdWbI=
X-Received: by 2002:adf:ded0:: with SMTP id i16mr28452918wrn.372.1599568210306;
 Tue, 08 Sep 2020 05:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-8-elver@google.com>
 <20200908115316.GD25591@gaia>
In-Reply-To: <20200908115316.GD25591@gaia>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 8 Sep 2020 14:29:59 +0200
Message-ID: <CAG_fn=U8tv2tXdWPTakcpDKG253kHj0YdsSU46GA5WgMo46BWg@mail.gmail.com>
Subject: Re: [PATCH RFC 07/10] kfence, kmemleak: make KFENCE compatible with KMEMLEAK
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, paulmck@kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you instead do:
>
> #if defined(CONFIG_KFENCE) && defined(CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL=
)
>         delete_object_part((unsigned long)__kfence_pool, KFENCE_POOL_SIZE=
);
> #endif

Thanks, we'll apply this to v2!

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
