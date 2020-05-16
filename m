Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24409C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 02:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC8520671
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 02:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt7OFWfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgEPCf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 22:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbgEPCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 22:35:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E1C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 19:35:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r10so1880037pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 19:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=n6/B7X0c/MJGcAtgpNhnYCDkJASTFIqMvt0ANlimUis=;
        b=Mt7OFWfTf/gPlx8Zs6Kq8r47RUGofk6FH4o7Be8RH2BpGbAh0z2BY4q8TGJzrtsXpd
         Nzw1/WWxWQNWSeqgzjVwx+ZHAteqemUPtlrTSEMzeAXT37RKMn4Dv0LX6V8+FJ0xwjBZ
         ZHX7ZnmQ1nGvb4t5ECZXVMGp7+OeQjldaRzujMNAo/n7gddY417c+guEgegy7esZV6LW
         n392yRJVq0/u8/7HNucaWwB9N3S3YrV2Qy66l9KPBNN5w0MP2kOU60AXZ1/34Jx2Lxk2
         GAHupHWVw9Oq578QtAMXyQfK5nUjTBYXtW8RxeGol8DAI4JGaiGGFB+2Ge3ZgsYbcsfQ
         DrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=n6/B7X0c/MJGcAtgpNhnYCDkJASTFIqMvt0ANlimUis=;
        b=iSVp+KhpM2NaWM4R4zx5dyXKz/rLr2h8qz873RMgibs3oxpJcrzfkom4yqcMUVLp3F
         2maTJdYz8jv8X2KtyGZ81jwbXZS8UFyOMaficOPeUh7j0UvQvhvstRcLcNdZPWaQPVim
         2QRpD8uL95Fbwo5r5j6s/lp7gucdVJihVrEiENaqceJzWAuPpbmzYjvck3a7BpL+uOfb
         +jNu8GE2S/25I9EKt5miN0yRGsDhUOg92YMXdE9gGwotmuF5PCOsekQ9iPskgC+Dabob
         ExBadQZUYDkvp+jrngoIQ/ijBVxbFavbvigdCt2Ez16MfEslipKTG6ldKMOxYwpokvVA
         e9NQ==
X-Gm-Message-State: AOAM532i5gklE1W9xbLd6V39ZJJH7s7UP73Md2/Y3SweoAMgsVZmhGBB
        WUE1gp84o50EU9fhtDEmBgyh994t
X-Google-Smtp-Source: ABdhPJzZdgWUfkP6XjtPQ1NVm6vtUk93j4syI/EhRB3x3K0kTxgRfYk3V3gkKF1GZNtuEz/Rc5Xteg==
X-Received: by 2002:aa7:9148:: with SMTP id 8mr7124000pfi.154.1589596525486;
        Fri, 15 May 2020 19:35:25 -0700 (PDT)
Received: from localhost ([61.68.67.54])
        by smtp.gmail.com with ESMTPSA id w69sm3090910pff.168.2020.05.15.19.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 19:35:24 -0700 (PDT)
Date:   Sat, 16 May 2020 12:35:18 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Possibility of conflicting memory types in lazier TLB mode?
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
References: <1589523957.s4pf3vd48l.astroid@bobo.none>
        <3b217554a8a337de544482d20ddf8f2152559cd3.camel@surriel.com>
In-Reply-To: <3b217554a8a337de544482d20ddf8f2152559cd3.camel@surriel.com>
MIME-Version: 1.0
Message-Id: <1589595735.4zyv4epfsj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Rik van Riel's message of May 16, 2020 5:24 am:
> On Fri, 2020-05-15 at 16:50 +1000, Nicholas Piggin wrote:
>>=20
>> But what about if there are (real, not speculative) stores in the
>> store=20
>> queue still on the lazy thread from when it was switched, that have
>> not=20
>> yet become coherent? The page is freed by another CPU and reallocated
>> for something that maps it as nocache. Do you have a coherency
>> problem=20
>> there?
>>=20
>> Ensuring the store queue is drained when switching to lazy seems like
>> it=20
>> would fix it, maybe context switch code does that already or you
>> have=20
>> some other trick or reason it's not a problem. Am I way off base
>> here?
>=20
> On x86, all stores become visible in-order globally.
>=20
> I suspect that
> means any pending stores in the queue
> would become visible to the rest of the system before
> the store to the "current" cpu-local variable, as
> well as other writes from the context switch code
> become visible to the rest of the system.
>=20
> Is that too naive a way of preventing the scenario you
> describe?
>=20
> What am I overlooking?

I'm concerned if the physical address gets mapped with different=20
cacheability attributes where that ordering is not enforced by cache=20
coherency

 "The PAT allows any memory type to be specified in the page tables, and=20
 therefore it is possible to have a single physical page mapped to two=20
 or more different linear addresses, each with different memory types.=20
 Intel does not support this practice because it may lead to undefined=20
 operations that can result in a system failure. In particular, a WC=20
 page must never be aliased to a cacheable page because WC writes may=20
 not check the processor caches." -- Vol. 3A 11-35

Maybe I'm over thinking it, and this would never happen anyway because=20
if anyone were to map a RAM page WC, they might always have to ensure=20
all processor caches are flushed first anyway so perhaps this is just a=20
non-issue?

Thanks,
Nick
