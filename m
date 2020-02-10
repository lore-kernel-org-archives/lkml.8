Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56669C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9C22051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="a+Nlc5bM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBJMQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:16:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44272 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:16:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id w8so4887013qts.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jOS4lF/HfGt+hqkWTYE7/ikX0I8M0rt4XoEg2BiMX2I=;
        b=a+Nlc5bMsGl55jCxMRqbTGgnyr9X0K+VNpY85sE997TDTXoZb1kP/m9K/Zylpq7CEG
         BQ9Z9lbuTvBp0AYjDvTU+Y93ujo1SdGB1BLxxIJF2Isb1Kwf44iyRLvlwgVUXLH2G8Pt
         xnImYyZd5VrRvZxn3E+86q9FzbWriBT+t4/edFZlZcCWbtIsS8xgX9zTFmgSAs10UH9X
         xqCQR7/2rxRUGRnvRCyTsw1qWoU1CqrpqAWc02XImxSFEarOAAifh4tJ6hMdGHU69yDp
         /FP6se8zh+Skzt4Uy/jCLmhS4kQ7eBcdFNzyNKyIsHWLyhzUFvfqK38raf5Y7gBp5Yru
         46Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jOS4lF/HfGt+hqkWTYE7/ikX0I8M0rt4XoEg2BiMX2I=;
        b=BEaEk6MArW8YIK4edTWY2MxigytOAuUQO5+7hC0QdnvSh7OcDFXc/iytCFCclao6B9
         4rHqRs5oW6FwnsfPKZDLLcVtRFFzrrv8G6xewK9mjIfTH7IpH59gBAE6qIYNrTyQTVCC
         cmhb72yqaxLlgsa3CeWWBojg8FG/uckMPD3T/+6KHj9OsjfNvw6YmmBqg8seB5NZsUY/
         hZTKK9Vszme5Ht9gTzDuRs7PNs2fLeAw54133KeKOehb0FUQePfjF1n99ivsC3eohycC
         mx9PILzdrokviTLKMNjPAL3GULUchs6ovDP+hCgJDJaoDXabmTKrGlC4OIgfYQVZQGrU
         qmeQ==
X-Gm-Message-State: APjAAAUM7MFmlCoPp5i7X02ruc+BSvr4MPEYm6ZdS+Ie8tKVedEzO0FK
        HtUyaft1zyJI/tevi+MqbKDNJA==
X-Google-Smtp-Source: APXvYqyl/cjx3W37/YdnY8dDHkhzfpIYJo29jFFJpcy6EqwGmlKtlD9YY2t1EXEDbTZDgDqiUuQPjA==
X-Received: by 2002:ac8:198c:: with SMTP id u12mr9826102qtj.225.1581336997787;
        Mon, 10 Feb 2020 04:16:37 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i13sm40735qki.70.2020.02.10.04.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 04:16:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: fix a data race in put_page()
Date:   Mon, 10 Feb 2020 07:16:36 -0500
Message-Id: <26B88005-28E6-4A09-B3A7-DC982DABE679@lca.pw>
References: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 10, 2020, at 2:48 AM, Marco Elver <elver@google.com> wrote:
>=20
> Here is an alternative:
>=20
> Let's say KCSAN gives you this:
>   /* ... Assert that the bits set in mask are not written
> concurrently; they may still be read concurrently.
>     The access that immediately follows is assumed to access those
> bits and safe w.r.t. data races.
>=20
>     For example, this may be used when certain bits of @flags may
> only be modified when holding the appropriate lock,
>     but other bits may still be modified locklessly.
>   ...
>  */
>   #define ASSERT_EXCLUSIVE_BITS(flags, mask)   ....
>=20
> Then we can write page_zonenum as follows:
>=20
> static inline enum zone_type page_zonenum(const struct page *page)
> {
> +       ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
>        return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> }
>=20
> This will accomplish the following:
> 1. The current code is not touched, and we do not have to verify that
> the change is correct without KCSAN.
> 2. We're not introducing a bunch of special macros to read bits in various=
 ways.
> 3. KCSAN will assume that the access is safe, and no data race report
> is generated.
> 4. If somebody modifies ZONES bits concurrently, KCSAN will tell you
> about the race.
> 5. We're documenting the code.
>=20
> Anything I missed?

I don=E2=80=99t know. Having to write the same line twice does not feel me a=
ny better than data_race() with commenting occasionally.=
