Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E1DC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 04:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0F620748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586234554;
	bh=GxpQspwTAWCLkkNgg/VDtRi6wG258pn0cjX6BZfGeH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mj+Fh2ubRhDg6acow+RKIdXpKg4wzIZ4Y3qEOgxkA1wsDJ/xIaL3vCE0uUo7iecbu
	 iIypw1fL+EtINhwHjusKMH/uZU9rloEK+4tAYxRJLVrgXJo4jfx2LDylFqT6NcU6V+
	 pNbXf+QU8oU+ITNbpbQ8ISgAU2GLgWjekmjdYXc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgDGEmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 00:42:33 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40782 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGEmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 00:42:33 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0374gOCM012174;
        Tue, 7 Apr 2020 13:42:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0374gOCM012174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586234546;
        bh=CdHc/8sVSQ4d6Ie7iKvR0diSkrEOJeL+mmH/Yszwrqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OYrYl+i5TyWoIDy8ou+xLJVQz7jQ3RExm87aMzCiZSQkD52lfg980nHjlnySg+wkd
         8hZdwg5xevIEKuaEVYbUsuDgkeCYY1l6EMIJC+s6LPt1MaD4FnrUPlj0Szhqbwt6e0
         Vd5Bde2RppOuy31cFj/MHbGv73U1swsvcMWxSgxJSgbAh2etrhPF/xPhct5kjXn7fy
         Zt2e9myNKRwivnfmhRPfiwCej1o7U+8JfD1wSS4Vs71kcSTJs9W18FkflbKsTQdNwO
         j90796TmbNrBZkdBIIb2j04nAs91WWONQAJb9cTmWJtyZPK/gypzIU2eiyTp6TJ222
         Lco/IeNi9m/WA==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id e138so1365016vsc.11;
        Mon, 06 Apr 2020 21:42:25 -0700 (PDT)
X-Gm-Message-State: AGi0PuZDhgDT9fKWnKwWBEZed02J0qa4aFPubpLszlWRRW/NONaiKMYp
        RsEXO2M4YVcCTsDVsK5CRh5XoDChVrPxQbjlGPk=
X-Google-Smtp-Source: APiQypLJKZXPrcYP365otvzBGyKcE5PdVeCX/bi+e3i7zA78jwrbZGMKGAcIVoHe2gh5W7oSuj3CMX1NHHJtqLuoeQI=
X-Received: by 2002:a67:2d55:: with SMTP id t82mr423662vst.215.1586234544251;
 Mon, 06 Apr 2020 21:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200406123403.4f20fbb1@canb.auug.org.au>
In-Reply-To: <20200406123403.4f20fbb1@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Apr 2020 13:41:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjRY8RT4vAjhT=L0xJY2nnVHR2VdrkfZxTkFV2YC_iXQ@mail.gmail.com>
Message-ID: <CAK7LNATjRY8RT4vAjhT=L0xJY2nnVHR2VdrkfZxTkFV2YC_iXQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 11:34 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (powercp
> allyesconfig) failed like this:
>
> In file included from net/netfilter/nft_set_pipapo.c:342:
> net/netfilter/nft_set_pipapo_avx2.h:4:10: fatal error: asm/fpu/xstate.h: No such file or directory
>     4 | #include <asm/fpu/xstate.h>
>       |          ^~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   b851fc367202 ("x86: update AS_* macros to binutils >=2.23, supporting ADX and AVX2")
>
> I have reverted that commit for today.

I will fix as follows:


diff --git a/net/netfilter/nft_set_pipapo_avx2.h
b/net/netfilter/nft_set_pipapo_avx2.h
index 8467337c5f4c..a1cde35fdad6 100644
--- a/net/netfilter/nft_set_pipapo_avx2.h
+++ b/net/netfilter/nft_set_pipapo_avx2.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef _NFT_SET_PIPAPO_AVX2_H

+#ifdef CONFIG_X86_64
 #include <asm/fpu/xstate.h>
 #define NFT_PIPAPO_ALIGN       (XSAVE_YMM_SIZE / BITS_PER_BYTE)

@@ -8,4 +9,6 @@ bool nft_pipapo_avx2_lookup(const struct net *net,
const struct nft_set *set,
                            const u32 *key, const struct nft_set_ext **ext);
 bool nft_pipapo_avx2_estimate(const struct nft_set_desc *desc, u32 features,
                              struct nft_set_estimate *est);
+#endif /* CONFIG_X86_64 */
+
 #endif /* _NFT_SET_PIPAPO_AVX2_H */



-- 
Best Regards
Masahiro Yamada
