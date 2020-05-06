Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B58BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A999206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bHT6W/fW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEFFxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725771AbgEFFxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:53:35 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 22:53:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q7so823924qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 22:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=22ofnai8Kmb8nUlZsIXdX+pSRFQQCaWUWDTVletlIn8=;
        b=bHT6W/fWOA40fzVohmqwgewBY83jYMapJYxNmoWYZVRhjvCcN/uCGzLtu9ZZpjegPt
         Q5UbabCAQpEu6VOQ2/0bfia7psVZhQGM9SB5PDcKKTxpXQn9IS3XpkRWbxDGHYQAG7N1
         ovzcSLqAS+e8Fw4CCoKn+w1qIPMvetUcoab0V7CJoEZh64Q5tvUMem8gw2iKrTYXkngI
         YqVYPnFDEVpL7n0s2gMY4wNqTWgAriIEJAvPIW46iz2mFzAkM75yNUg8U+l18gc8m3i9
         irKLWLsMowcpjqZtMkd8CoZmJ6mEW1aJe6aQcZk2+U4qiUPJRXSGghS4vawiCrNLWoCM
         CvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=22ofnai8Kmb8nUlZsIXdX+pSRFQQCaWUWDTVletlIn8=;
        b=GpoQzArAqt3fX7hQUyidbZO7qjLn8OsevtSvbonx0KxjgL0Ka7vtMglZiJ0GuEdHpB
         lGqsq3eB91cbSxhNXAzl04alAT+Omx6bgvTxWrAnd0UTaHYtHinEb28wvIjCu6DEfcet
         L53ozNzHFy2Qf8WQSg8yKTKIjZ4e9kANCzyG08RtyAdELhYw2eCGuDHVGsrjNKXywrPg
         gAcqqTPdvxvU5RDD+5wLc6eNiUjS7ozqiphf4cys3Lyy1j3C3I+AbgGuQFhbtro9TmNU
         LxmpZGLH3uZKe2LGTILK4L80sUcVfINQFKllrGFRIE576wpe0q89N4Kj2WXvtigZtSJ8
         Jb9Q==
X-Gm-Message-State: AGi0PuaEkLJcyOCXTl7J4UE+xkDdyGZjU2SK33HbCEZWJZhytgeltzJm
        PGHdkx1okSbpkVWKVc9JvPBpkh8HX8JhGw==
X-Google-Smtp-Source: APiQypLikjqrC0WTXdzYihbO3/y7LWLnb+LLpLiSTCvKKz620VCQubf/5jDWJa4A3ZgrSWfdszM/kA==
X-Received: by 2002:a05:620a:a12:: with SMTP id i18mr6804658qka.316.1588744413624;
        Tue, 05 May 2020 22:53:33 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p31sm706132qtf.11.2020.05.05.22.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 22:53:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] kasan: memorize and print call_rcu stack
Date:   Wed, 6 May 2020 01:53:31 -0400
Message-Id: <2BF68E83-4611-48B2-A57F-196236399219@lca.pw>
References: <20200506051853.14380-1-walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20200506051853.14380-1-walter-zh.wu@mediatek.com>
To:     Walter Wu <walter-zh.wu@mediatek.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 6, 2020, at 1:19 AM, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>=20
> This patchset improves KASAN reports by making them to have
> call_rcu() call stack information. It is helpful for programmers
> to solve use-after-free or double-free memory issue.
>=20
> The KASAN report was as follows(cleaned up slightly):
>=20
> BUG: KASAN: use-after-free in kasan_rcu_reclaim+0x58/0x60
>=20
> Freed by task 0:
> save_stack+0x24/0x50
> __kasan_slab_free+0x110/0x178
> kasan_slab_free+0x10/0x18
> kfree+0x98/0x270
> kasan_rcu_reclaim+0x1c/0x60
> rcu_core+0x8b4/0x10f8
> rcu_core_si+0xc/0x18
> efi_header_end+0x238/0xa6c
>=20
> First call_rcu() call stack:
> save_stack+0x24/0x50
> kasan_record_callrcu+0xc8/0xd8
> call_rcu+0x190/0x580
> kasan_rcu_uaf+0x1d8/0x278
>=20
> Last call_rcu() call stack:
> (stack is not available)
>=20
>=20
> Add new CONFIG option to record first and last call_rcu() call stack
> and KASAN report prints two call_rcu() call stack.
>=20
> This option doesn't increase the cost of memory consumption. It is
> only suitable for generic KASAN.

I don=E2=80=99t understand why this needs to be a Kconfig option at all. If c=
all_rcu() stacks are useful in general, then just always gather those inform=
ation. How do developers judge if they need to select this option or not?=
