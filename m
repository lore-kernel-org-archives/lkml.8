Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F5C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF16F20724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="JaSJ2a1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SolwAbVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgCTRF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:05:56 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34833 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726953AbgCTRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:05:56 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 38314641;
        Fri, 20 Mar 2020 13:05:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 20 Mar 2020 13:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=
        from:to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        amfe8YKfDyEVVeIYxRxirnjNRunqadNgHmLYG0QZs8I=; b=JaSJ2a1Sj92pLJ+l
        y+GlM9GoggZQvguJgG89FEGKaKWkVYAdC1DaomM7iT1ypG2ANZ1opY6zKLYnpuGE
        wlHRGVBlMA25JsQIn9/1+T1xMWyq2QV/XQFSpCDFPBmiUhL0aCQknayuyrjfM3e7
        LlkCsaOAMvVVNqAQz8jPCvHNm1U+xS2Oxj853XN6imKH8QX43Yp5YpWDjbrWnHWj
        o2z4elZmU2fHz4h67QqXmpKVtbFdKL7pVq89KJQHoUm8/7BD1Q/5lF20NwnYpzwy
        2N/5+FtozHqGS9jk4yizF9sXzc+ntLyhu31lqGrWnthI+Y08N7S41lDGXtrQM5yx
        ggEORA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=amfe8YKfDyEVVeIYxRxirnjNRunqadNgHmLYG0QZs
        8I=; b=SolwAbVWKyo3/q+nYh8nk1f+klb3XqlF9mF9U1HNmxsFdM6S0NsrKK1/w
        wCYCaBI/nOJlX5o+xr13OzfAtzHrZZj04lFGfLmvCPTc/trrcNVe8nu3eoC9qivW
        bGVWM3Jj6q/2v6xv+9PzazmI5U2SiXimICNYaQaUtr6FaVmKAI6cUOahWeh4PgaH
        Qq8E3WaJ9K6ZOKrdpdrMzeAZ+6Mm8TW6NaKv0GeY/qbYaz5QXlCGjvbEafLdiSMG
        fEvWoUM7t049gWFk++EdHYz56iFc9rbKscxbcLhfRD9i+MU/uhm+pw4KxoeKBqKA
        qrQSCLsaKnr4xMRAHWU41UtaooMfQ==
X-ME-Sender: <xms:8vd0Xs1nRAqI2MuHLyPduPDHZATwbVmvg4bVUCqIxGtzDhw5TooyrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeguddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufhfffgjkfgfgggtgfesthekredttderjeenucfhrhhomhepgghinhgt
    vghnthcuuegvrhhnrghtuceovhhinhgtvghnthessggvrhhnrghtrdgthheqnecukfhppe
    ekvddruddvgedrvddvfedrkeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepvhhinhgtvghnthessggvrhhnrghtrdgthh
X-ME-Proxy: <xmx:8vd0Xkc4fKe0uEJT-KC4TbOoQiexQy9gLe8Ha7IaM4JuGpBTPidB0Q>
    <xmx:8vd0XsM36jZVBZHqdyPfwqJHQmJhagg0YXTZ0yR2_6TccEOapyfhlA>
    <xmx:8vd0XgVZV-Xnl4cvcmmiHK2skDMnX1WnK8DT6cYc-rxUoiI2mTNiLw>
    <xmx:8vd0XiNd_AxVYBjGx5kWBPevIdoJHiWhgTXiV918UyFbEeTYa3bQDA>
Received: from neo.luffy.cx (lfbn-idf1-1-140-83.w82-124.abo.wanadoo.fr [82.124.223.83])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0C8043280063;
        Fri, 20 Mar 2020 13:05:54 -0400 (EDT)
Received: by neo.luffy.cx (Postfix, from userid 500)
        id E59C4A91; Fri, 20 Mar 2020 18:05:52 +0100 (CET)
From:   Vincent Bernat <vincent@bernat.ch>
To:     Kieran Bingham <kbingham@kernel.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/gdb: replace "is 0" by "== 0"
References: <20200320163820.3634106-1-vincent@bernat.ch>
        <55dae299-a5a0-6e11-c966-1d8dcb46c452@kernel.org>
Date:   Fri, 20 Mar 2020 18:05:52 +0100
In-Reply-To: <55dae299-a5a0-6e11-c966-1d8dcb46c452@kernel.org> (Kieran
        Bingham's message of "Fri, 20 Mar 2020 16:47:19 +0000")
Message-ID: <m3wo7f553j.fsf@bernat.ch>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 ❦ 20 mars 2020 16:47 +00, Kieran Bingham:

> Oh, I thought python encouraged the 'is' style.

Usually, only for "None", "False" or "True" (but for the latest, this
doesn't usually make sense).

> Given the nature of the statement, would
>
> if not node:
>     return None
>
> be any more appropriate ?

It would be more consistent with the other uses (like the while below
and the ifs even further). However, I don't fully understand this code
(notably the "node = node.address.cast(...)" where node is not defined
yet and node is replaced by the value of "root['rb_node']" just after),
so can't say for sure node cannot be equal to something eveluating to
False in some conditions.
-- 
Writing is easy; all you do is sit staring at the blank sheet of paper until
drops of blood form on your forehead.
		-- Gene Fowler
