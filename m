Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6CC35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265DC206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="dmEZRWbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBXCPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:15:05 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56135 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbgBXCPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:15:04 -0500
Received: from neuling.org (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 48QlyG0dVfz9sNg;
        Mon, 24 Feb 2020 13:15:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
        s=201811; t=1582510502;
        bh=T10jB91g27CIda1DuAyao920kpjeZyWKNketNp+UJeI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dmEZRWbeumV2C1GARdwbs2sht9CYu40Ktuuh3vhIbZyTTCvxo0lOOZmlzHljCwKeM
         87EK1xzoF8Y/Be60JflnKkvZk+KlbTEiQsx18N9/FWiibbbqUeO6L3PfXqNkHiBlEK
         XK+Hn8hFqEbbX0WOSL7v+tMPRG9NySbT0AUCdek2Bpiof/dx1ShSnUa0T7nXgJ4Fn7
         yRlfNhMXtJRiSuFVz8OmG0tbliSktD6TtSxH4MiFN8YdRKv1SUgChZVlqhwBpkPVQp
         jbCAGolpm4PhDI6rlKeFhd+3+Sfv3KVIohaig28oEVnBs6yxGYxJx3eM8RPoXwlNXQ
         3iEqX4BR21ySA==
Received: by neuling.org (Postfix, from userid 1000)
        id 0C9B12C026F; Mon, 24 Feb 2020 13:15:02 +1100 (AEDT)
Message-ID: <7b86733f81c7e15d81ab14b98c8998011ed54880.camel@neuling.org>
Subject: Re: [RFC PATCH v2 00/12] Reduce ifdef mess in ptrace
From:   Michael Neuling <mikey@neuling.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Feb 2020 13:15:01 +1100
In-Reply-To: <f62b0f67-c418-3734-0b07-65aea7537a78@c-s.fr>
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
         <f62b0f67-c418-3734-0b07-65aea7537a78@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe,

> Le 28/06/2019 =C3=A0 17:47, Christophe Leroy a =C3=A9crit :
> > The purpose of this series is to reduce the amount of #ifdefs
> > in ptrace.c
> >=20
>=20
> Any feedback on this series which aims at fixing the issue you opened at=
=20
> https://github.com/linuxppc/issues/issues/128 ?

Yeah, sorry my bad. You did all the hard work and I ignored it.

I like the approach and is a long the lines I was thinking. Putting it in a
ptrace subdir, splitting out adv_debug_regs, TM, SPE, Alitivec, VSX.
ppc_gethwdinfo() looks a lot nicer now too (that was some of the worst of i=
t).

I've not gone through it with a fine tooth comb though. There is (rightly) =
a lot
of code moved around which could have introduced some issues.

It applies on v5.2 but are you planning on updating it to a newer base?

Mikey
