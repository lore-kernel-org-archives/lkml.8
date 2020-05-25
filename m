Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51165C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0480F2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jBlRRIPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgEYFPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEYFPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:15:22 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652DC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:15:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49VlfJ4hjmz9sSd;
        Mon, 25 May 2020 15:15:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590383721;
        bh=GmYuIgDXbqUpvqUl8asodR/2TYm/PICGB2dDioI3BVU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jBlRRIPwPYpu65hwSsT0ks0iJYSGvjLJeFHHFphHmRyvb9gyx8/G0xg0cKgZ3+3st
         mwehdxXxmOXBFmMbCkJr0x5OeA1RdjRRCgiozJpHulHDYzk8FpjlgdRPTHHt1AzPkb
         yVPEIHhko1jt97jUGbLRJxRPjU+HSxANa5MejU4teeVhiTzEzCFS/KboVR35/lZr05
         ZLD5fIiTS/bY2ZtIi1rbmuaSuUqzPN6xMUGoXkSZ024+uW2/xVV1xfwHEqpD2i3wUP
         /mv7ibSdkelyced11GDmS/1SGOQXP3UW7OdzqHuaOH0L6EHhw43cBZJvAXtXRjjcJw
         UoQ9cR3Mscv6Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 07/45] powerpc/ptdump: Limit size of flags text to 1/2 chars on PPC32
In-Reply-To: <83a7a0cfca6198e63caf7a16839bd18454961f52.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu> <83a7a0cfca6198e63caf7a16839bd18454961f52.1589866984.git.christophe.leroy@csgroup.eu>
Date:   Mon, 25 May 2020 15:15:41 +1000
Message-ID: <87h7w4fvcy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> In order to have all flags fit on a 80 chars wide screen,
> reduce the flags to 1 char (2 where ambiguous).

I don't love this, the output is less readable. Is fitting on an 80 char
screen a real issue for you? I just make my terminal window bigger.

cheers


> No cache is 'i'
> User is 'ur' (Supervisor would be sr)
> Shared (for 8xx) becomes 'sh' (it was 'user' when not shared but
> that was ambiguous because that's not entirely right)
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/ptdump/8xx.c    | 33 ++++++++++++++++---------------
>  arch/powerpc/mm/ptdump/shared.c | 35 +++++++++++++++++----------------
>  2 files changed, 35 insertions(+), 33 deletions(-)
