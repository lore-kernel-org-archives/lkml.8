Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846C1C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604FC206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NOJW6non"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgD0Npe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0Npe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:45:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF7CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:45:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g74so17920868qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8jUAWAujXvZ0VY7RF5kRVUXx1mj2yOpaAX7XC80WP4M=;
        b=NOJW6non4Ll0V3I6uEfCr/ESOj3DBDbQehKt3+mh1sV3XeW5EUGxXJumZ1eol/Ns/Z
         gfrf5WVMmAXzRnEaqPkAw8cm7gfc+5wLEz4ZmJcb9qmsb7zqbF0YBWXF28/87cgoT2Z3
         +H2BnulDi6WsOdp+mz21Llkt91piGsh+4wsDGgRD0cHLk8yIB4M92xY52Y6nRhsbbMA9
         /dJQh2qn/0RPlUqGgFJiz5arZrHBIIS9oVrMKWTO0VTSU9m2lpjUTAYLOFs5YdxmnaTO
         R12rZCtEWZan5U95xQg20IPthhyT4x5QK3EoL3imHRINK00vhoMMjauKfz/Hrp4wHgdl
         n53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8jUAWAujXvZ0VY7RF5kRVUXx1mj2yOpaAX7XC80WP4M=;
        b=X9mJPniaJgDvd/MOFOY+Zip7OBL2DT0U/jkOcaBsLiLP9TN4EWZ3wjmUTv8FPU5LhQ
         PQBrn48Px0+ayLd8vu4O30G5b0Pa/mw0PYvgc7R4B8RABNPuk5KhYKsotncdob08L4o1
         IJNf4D12tB2Q2nDTeByHngFpyqlGEjRWzjbfOpxb07dgPKLZx0GiyjDArB4kb3CZYRr3
         0LETgg01aVA7btczXNwAq1EKmdJAaZqzU4v3Zpf1wKCgZgdpn9fReCETSalgMMjUbxGf
         XGyV475uZxDmDvjAHIVIbvn1z8TZWaEmzs24JnLS/VGvwZhH6IgJ1lr05ZXCUVCYwhCq
         G00w==
X-Gm-Message-State: AGi0PuZRmvCLyx3TXwjm7OECs1WrB98E41I17Iz05eDzXX7qHf7vAOQ5
        8GzsQ4ohHvCVVJmop9pjaJQzZg==
X-Google-Smtp-Source: APiQypKxEkniHZZ1hqYEzVaYqRaskWLrDeNl5dhVFeDWiRfKZko2WRAfrrV51dgII31vu/A3s5vilg==
X-Received: by 2002:a05:620a:2006:: with SMTP id c6mr1248072qka.343.1587995132853;
        Mon, 27 Apr 2020 06:45:32 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m33sm7851275qte.17.2020.04.27.06.45.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 06:45:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: compaction: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200426144139.GA340887@linux.ibm.com>
Date:   Mon, 27 Apr 2020 09:45:31 -0400
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFCC92A8-8D2F-4A52-9656-7627904D0AFE@lca.pw>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20200426144139.GA340887@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 26, 2020, at 10:41 AM, Mike Rapoport <rppt@linux.ibm.com> =
wrote:
>=20
> Hi,
>=20
> On Thu, Apr 23, 2020 at 05:25:56PM -0400, Qian Cai wrote:
>> Compaction starts to crash below on linux-next today. The faulty page =
belongs to Node 0 DMA32 zone.
>> I=E2=80=99ll continue to narrow it down, but just want to give a =
headup in case someone could beat me to it.
>>=20
>> Debug output from free_area_init_core()
>> [    0.000000] KK start page =3D ffffea0000000040, end page =3D =
ffffea0000040000, nid =3D 0 DMA
>> [    0.000000] KK start page =3D ffffea0000040000, end page =3D =
ffffea0004000000, nid =3D 0 DMA32
>> [    0.000000] KK start page =3D ffffea0004000000, end page =3D =
ffffea0012000000, nid =3D 0 NORMAL
>> [    0.000000] KK start page =3D ffffea0012000000, end page =3D =
ffffea0021fc0000, nid =3D 4 NORMAL
>>=20
>> I don=E2=80=99t understand how it could end up in such a situation. =
There are several recent patches look
>> more related than some others.
>=20
> Can you please add "mminit_loglevel=3D4 memblock=3Ddebug" to the =
kernel
> command line?

https://cailca.github.io/files/dmesg.txt=
