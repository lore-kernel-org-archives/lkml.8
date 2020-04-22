Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC50C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648F520781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NdOunxgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDVVcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDVVcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:32:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB5C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:32:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so4195539qkg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+WYIg4RAMlWM7Kf2aYaI6IHSuB8btJKPWzUnEhkHm4Y=;
        b=NdOunxgYBVAoc59q9VgeWd76PGFtMQcwOs4ul9C8PcoLGV8am3yrxBpSEBL4XGYCVE
         WOX11uH1cmX2e5VPgB3U/cmwikvHNpSpboh6qd82m2xlaQus59tccoLJ6ESovohjwYPV
         /t4m9MhXdZ3O8DmNgTzg7CaZFD8VWBpDdP2x8aLHiu8A6O3FztvSL8WJqBtBB2YRmUf1
         nXmrFWKg9bLs4KaDPCVIU9KABkVfzmA5M3+zj10yazmoN4RpuhR7gq7bmRrYyh3RYPPU
         WHmjtxcpl7A0kXvI63CFQqjGMlqqparMLZ0rycI9OBafn/P83tIenmV8NfdoxKkpPPbF
         V/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+WYIg4RAMlWM7Kf2aYaI6IHSuB8btJKPWzUnEhkHm4Y=;
        b=OWjvMvaCnfFBaQpbGgllSiiDdNYDa5UXmosyl+bi4t8Trj+SGSmwSImOZbaIyn7nfN
         Hmmg0grYDUwomnJuaRWeDHtI6EO1i4B8zTFRlFt5wIoTdztz2SaiPZbaw5tsDfA6ORCk
         gNiFwCqFSx6CSzvyBAFt8YyD6ZpmkuUUw2561kNxvAj9RKnzqW1/rwNBnJfTRj2hKBBd
         w50TxRKwbCyVnqPK7uEpjb8URPaSks3Jrv7KpnJi5zqz0fm7KSvZMM5YC28EKQCvc4qh
         4Q4StSSDt1qF/6fkycX93gBTPuYvO4kf4MZnfYAoRUs5PlgLqqHccFpCKlxv/Kj4c9Gr
         2txQ==
X-Gm-Message-State: AGi0PubU6VBQqrlOuwR9bbStWzd8c4WuzJdh13fi6z6AuwQKgM/Wccmt
        e/vrVuopkbvgBJgF3Ky+1HW5tw==
X-Google-Smtp-Source: APiQypILa2U97Y/gU88kX5KS8gFWKZMZ2UPxxDl29LseCwfEixTbGseUfJRdvuxdHsQJmv+i9tryTQ==
X-Received: by 2002:a37:6754:: with SMTP id b81mr343164qkc.129.1587591122484;
        Wed, 22 Apr 2020 14:32:02 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l13sm362769qtj.17.2020.04.22.14.32.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 14:32:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200422170116.GA28345@lst.de>
Date:   Wed, 22 Apr 2020 17:32:00 -0400
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2568586B-B1F7-47F9-8B6F-6A4C0E5280A8@lca.pw>
References: <1ED37D02-125F-4919-861A-371981581D9E@lca.pw>
 <20200422170116.GA28345@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 22, 2020, at 1:01 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Wed, Apr 22, 2020 at 11:55:54AM -0400, Qian Cai wrote:
>> Reverted the linux-next commit and its dependency,
>>=20
>> a85573f7e741 ("x86/mm: Unexport __cachemode2pte_tbl=E2=80=9D)
>> 9e294786c89a (=E2=80=9Cx86/mm: Cleanup pgprot_4k_2_large() and =
pgprot_large_2_4k()=E2=80=9D)
>>=20
>> fixed crashes or hard reset on AMD machines during boot that have =
been flagged by
>> KASAN in different forms indicating some sort of memory corruption =
with this config,
>=20
> Interesting.  Your config seems to boot fine in my VM until the point
> where the lack of virtio-blk support stops it from mounting the root
> file system.
>=20
> Looking at the patch I found one bug, although that should not affect
> your config (it should use the pgprotval_t type), and one difference
> that could affect code generation, although I prefer the new version
> (use of __pgprot vs a local variable + pgprot_val()).
>=20
> Two patches attached, can you try them?
> =
<0001-x86-Use-pgprotval_t-in-protval_4k_2_large-and-pgprot.patch><0002-foo=
.patch>

This fixed the sucker,

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index edf9cea4871f..c54d1d0a8e3b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -708,7 +708,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, =
pgprot_t prot)
=20
        set_pte((pte_t *)pud, pfn_pte(
                (u64)addr >> PAGE_SHIFT,
-               __pgprot(protval_4k_2_large(pgprot_val(prot) | =
_PAGE_PSE))));
+               __pgprot(protval_4k_2_large(pgprot_val(prot)) | =
_PAGE_PSE)));
=20
        return 1;
 }=
