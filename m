Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A07DC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7B820675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JsRbV06q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBLMaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:30:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37613 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLMaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:30:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id c188so1835729qkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2YAAi82KRVa7ktUoT85C9ZCSdgpeOgvdOFNrlRCdrz8=;
        b=JsRbV06qHVZ6Qn1F5A9M7UlSU3cMwrfgLbddxXDwgDf3VoUPVMkd1m81kUBpsElspj
         v1qTjgctpyYP+3WIvzQlhA6VRGmg6t5d/TBPiyi8LD6zJCLq2p1r6CUSIB2UfYekSDQG
         MCVpSQIQNryDJNULr2EI4o6/of6g66yoCz4NgRhrblwsSkgYhwf2/+GbWVIHaCneQ4WT
         4Tj69IZwAR8o1XkTNpyKTx7vHmKgy7u/BfRlvu2IRaxaGUwF7LJ3MmIMqLRZwPSSIWnu
         7mMxK4N6AyeBdiTHNj/8EOeJMl+s7lOURLZmfNAcH1R1C3eXAN5g5XLAijvpw+/WAhUO
         fsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2YAAi82KRVa7ktUoT85C9ZCSdgpeOgvdOFNrlRCdrz8=;
        b=L0WR/ZHHJaaRJWbHZZ2OI7KaoG0VeEKaaBQcj80QyeEBgcMpyyp9+64KQrJwLk9155
         fPIX6qJF71rmf8wrz/C8ljyLKtjSprTGNiEU84INOe+TqFgNTHYcBIsy103l4SIjcAX1
         mYJQYzy+wU4ZGVUzRYKWPz3kD7tzoSyFfgTM/Kw0lasXuqOdcWLxfNX01+5krApnooDo
         M4txQ7MW3zGUpnbKg5c8TrDX/ApTlsn8YVI+Q5he2xiNjJBqXjmOEuZwNgc+EZvb+l/M
         05qbwAoR1m2Yx6zEDGz0ImN1kR2SPX5bbVFZYAiN1cQBC/I7b9Sn68eEw2bGgQgvCt6L
         e99g==
X-Gm-Message-State: APjAAAU5HYUDSKhlLnhGOXzhpmbbBEckDbAfyG2uDNzoWDeCkkwZ9P3S
        /oQ5uyr6YkgwA7yMymf70dOTqQ==
X-Google-Smtp-Source: APXvYqxS/gQQHOq0dxkxvnTrRkEJ/mYkj/ZHJsPvgbmrK3JOtXMegtyrLV1boEHF7JvNv72J4td8oA==
X-Received: by 2002:a05:620a:122a:: with SMTP id v10mr6440245qkj.79.1581510617666;
        Wed, 12 Feb 2020 04:30:17 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 65sm41786qtf.95.2020.02.12.04.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 04:30:17 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 5/5] kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
Date:   Wed, 12 Feb 2020 07:30:16 -0500
Message-Id: <ED2B665D-CF42-45BD-B476-523E3549F127@lca.pw>
References: <CANpmjNOWzWB2GgJiZx7c96qoy-e+BDFUx9zYr+1hZS1SUS7LBQ@mail.gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
In-Reply-To: <CANpmjNOWzWB2GgJiZx7c96qoy-e+BDFUx9zYr+1hZS1SUS7LBQ@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 12, 2020, at 5:57 AM, Marco Elver <elver@google.com> wrote:
>=20
> KCSAN is currently in -rcu (kcsan branch has the latest version),
> -tip, and -next.

It would like be nice to at least have this patchset can be applied against t=
he linux-next, so I can try it a spin.

Maybe a better question to Paul if he could push all the latest kcsan code b=
ase to linux-next soon since we are now past the merging window. I also noti=
ced some data races in rcu but only found out some of them had already been f=
ixed in rcu tree but not in linux-next.=
