Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E3C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A9B20732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlBR1oph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCWGSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:18:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43319 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgCWGSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:18:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id o10so8399077qki.10;
        Sun, 22 Mar 2020 23:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SQnmimIw8EB7Br4Qk4hYzrDr3nWlxz2sB0QneEwM5AE=;
        b=FlBR1ophAFyc7D0X9934B/YO2qQAw5o2aXJ5f0M3P7sdejjQ4I+CHkfeiHh2Y95fg2
         OlYI5rUV/NbNQq8sr1Y3qoyYXmtzi5G3yZOf0EhZg3pVHjxLO+aRpPE7wKwOnz6LO5cc
         6UMjkyxF9F2Dv6fi32bY31rVg82EmwtKEt3myNanml4XN5V+5hF9WeqpqU/vsDTByIcg
         bUx7wMnrlptw7AB6b1ine6/IF3zlbpQqAl+ZecbMHEMZla3ekNe9PM9vn7wDgR5EU3z0
         /5sfXGc7PPs+e9X066GQRC18+7a5nvT83yXNhyKIa9+wZbAMYzPC+KFb62WGsXQZOCAZ
         Mj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQnmimIw8EB7Br4Qk4hYzrDr3nWlxz2sB0QneEwM5AE=;
        b=fgWlVFsHtDYZhlCJzEwlGjcKZbEcrePBevF37Jy12V0B8D/ENbZz7wkbDaVke4lDUJ
         QNUup+ivUN7uz1KzB6UaYRLwHd9PC2V26CJb2qNkcWARNT1p6cpib+hKqO/8a+meeV2Q
         YBnyiCkNNfVBBLjRtUoMQ0F1SNiYSOBgK5wduaCtU5xyq35cT98vcIRK6UyUZGhOHM2s
         wfgPUadD8kWtTFBkfxLPn44J+RCSpqtwjXLik/f5lT/uCvVEGBzx58gWVJasSZ+VtYEF
         +6MngCOX5IMQa2D79Hquu9KMivntrrNCb3O9aAyOCBMm7a2m2Xv4bYqMZW4wEb+54k3G
         V9zA==
X-Gm-Message-State: ANhLgQ2rvNkHpLnq1DedZkHp4IvWovJdpxAKrgc8eZNIrg+drUeJDcPA
        H02bCgSvI1TQKXw2b7vZxqA=
X-Google-Smtp-Source: ADFU+vuEw9f5lMuZyZCve7wlV7Q0jqbpXmuL00NDmVWduaBBX9pfR9oWSETcAeDG4Bymacowx3r9RQ==
X-Received: by 2002:a37:52d5:: with SMTP id g204mr19960812qkb.401.1584944313982;
        Sun, 22 Mar 2020 23:18:33 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c12sm9640234qkg.30.2020.03.22.23.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 23:18:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 08EED27C0054;
        Mon, 23 Mar 2020 02:18:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 23 Mar 2020 02:18:32 -0400
X-ME-Sender: <xms:t1R4XoQPYNp2yqk8nqnEUyp134Ak1C4wP8kv4BICGq3Mm6BZPXJWXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:t1R4Xv4EWHGy74y9SIQCdqTPbSyvdgtQlOMigZJA8PCb4j4vwC-Ifg>
    <xmx:t1R4Xq3dcEcbFQAe-i48RKNPZWLY6NCs8Ky_PNZvQVl8JWcMW0faBg>
    <xmx:t1R4XgLc-DpF2Jkh2_UqOSiLZw9u8bJCtjnmAK6KkR9uW4LoKZLjGg>
    <xmx:uFR4XtSii8IIXWKz2By7a2Qk6Y9A9uymjQC1kzPn7JCVNYA6rLTORSI9hJ8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC723328005A;
        Mon, 23 Mar 2020 02:18:30 -0400 (EDT)
Date:   Mon, 23 Mar 2020 14:18:29 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Update maintainers for new
 Documentaion/litmus-tests/
Message-ID: <20200323061829.GG105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <20200323015735.236279-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323015735.236279-4-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 09:57:35PM -0400, Joel Fernandes (Google) wrote:
> Also add me as Reviewer for LKMM. Previously a patch to do this was
> Acked but somewhere along the line got lost. Add myself in this patch.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc1d18cb5d186..fc38b181fdff9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9699,6 +9699,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  R:	Akira Yokosawa <akiyks@gmail.com>
>  R:	Daniel Lustig <dlustig@nvidia.com>
> +R:	Joel Fernandes <joel@joelfernandes.org>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-arch@vger.kernel.org
>  S:	Supported
> @@ -9709,6 +9710,7 @@ F:	Documentation/atomic_t.txt
>  F:	Documentation/core-api/atomic_ops.rst
>  F:	Documentation/core-api/refcount-vs-atomic.rst
>  F:	Documentation/memory-barriers.txt
> +F:	Documentation/litmus-tests/
>  
>  LIS3LV02D ACCELEROMETER DRIVER
>  M:	Eric Piel <eric.piel@tremplin-utc.net>
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
