Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BD820882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MnWLKAp9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="snbqwbHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHSQrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:47:18 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46643 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbgHSQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:47:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 49B04246;
        Wed, 19 Aug 2020 12:47:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 Aug 2020 12:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=p
        wYXF6UAfi/NEMDJzpGN/PpRVDdHjhNorcnozan73zc=; b=MnWLKAp9cULxS82Vu
        xp72GcvzC+EMKXvXfR3dKNDdevka/fSEK7j0ditjhWXmpfrNyEOHLxpBQfBnemBL
        58skJuZz3C+roifCbwFJc8HPUNZP1nEOusCVytdKFWQo+GUS/EbTQp9h+5Ehcvzo
        QxPdCwyicO4fZ1IZElfT2NGMAkiz5fBdsjjq03uRtWbtPgxv0V+lPTLTQO6GKOcn
        brgQaHK3OsQQ3pjJSOHlCMv+qdpNLyUB7quqd6oibuJzH87H4zebf9zcfHBL1jNY
        j2RX6vmZneco+AuK60C+sjiQ94bNUsazbKDEP0AGvXHneVICDS81w7snXnS6c0me
        DsNIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pwYXF6UAfi/NEMDJzpGN/PpRVDdHjhNorcnozan73
        zc=; b=snbqwbHiM1gFDTOdLrPGUTlB4/AZ6s7pfhu5md2Mx/sBGpKj8+L9dI9D6
        DhIdTWMKfF0AMsv55G8zcAHXP+24aiuzcPsKgbRSP5078SvlnZBc4X4M0f+YYD86
        s7Kz4J4TdYuPDJ0RUtWJYmDTVPq47ZofQYvvuRgJe1KuoZCKpGfgxiVZZ8Tdct1p
        Tjt0eAciSVynJgEQvghV8Hdx86PiwgC9euEkuxaoabvLXVH0NbCSa0h12/zMVxpm
        m60dtf+8ZSd2l35Is2nb1DVK8k2AxfRzJRQfsbI9NUdX4h9DC7mnuBjRjOufcjge
        xn0Ank1dwWKmhT5IaMpTSpPGKSdIg==
X-ME-Sender: <xms:kVc9X9YEPkI8jcY-YyyTnmwxbshYd8U7Nr0H4mLOOqroEqIunf0nFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepueehke
    ehlefffeeiudetfeekjeffvdeuheejjeffheeludfgteekvdelkeduuddvnecukfhppeek
    fedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:kVc9X0Zv_j2-MFkXnN8_Y0SbT1hUsyvuRwfkoiInhpuNFQOu7yyyMA>
    <xmx:kVc9X_-cNj1eOpol0y9UYda5Q2M25kaJCYHbLKzUqNucHlQGM-_XSA>
    <xmx:kVc9X7peRUN7Wq2rSCUODlmapUVJh0lnypEI2bMmKAFk_DGQ5CTiPg>
    <xmx:kVc9X_2pZDA8538S2PtAWsnxSp7z9rWPnOSJAJ91aQFeaJCTUJmAKQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C409130600B9;
        Wed, 19 Aug 2020 12:47:12 -0400 (EDT)
Date:   Wed, 19 Aug 2020 18:47:35 +0200
From:   Greg KH <greg@kroah.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Muni Sekhar <munisekharrms@gmail.com>,
        peter enderborg <peter.enderborg@sony.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Scheduler benchmarks
Message-ID: <20200819164735.GA3698439@kroah.com>
References: <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
 <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
 <20200819104254.GA41946@kroah.com>
 <135393.1597855432@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <135393.1597855432@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:43:52PM -0400, Valdis Klētnieks wrote:
> On Wed, 19 Aug 2020 12:42:54 +0200, Greg KH said:
> > Look up Spectre and Meltdown for many many examples of what happened and
> > what went wrong with chip designs and how we had to fix these things in
> > the kernel a few years ago.
> 
> And I'm sure that nobody sane thinks we're done with security holes
> caused by speculative execution... :)

Hah, not at all, the patches keep flowing in, as do the microcode
updates...
