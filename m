Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D1C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 04:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA56720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 04:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CPdOs3rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJEo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 23:44:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36821 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJEo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 23:44:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so4241860qto.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 20:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=YyeG7ioMptg4bos9WvsiCAkWTH6MJSyQRYyd9Ee7o3E=;
        b=CPdOs3rbLRg9yoyCDZ5FfBtSmUGg5ALJ1rif3cwywsjGy6iXqxjHOs2/coCTOgCWM5
         skYy1c97oA7WOyENX5nrTq+i258mB5kN1lJ6844lZuBZ55mg3HCR3yJ2k3FqbD698WH9
         1ypDv2ONkoc6fKwj3eSu5D3ygeQmlfVUjzau9YjRVEkOQGPXAaizsj9SOgiQQBOFpL15
         GEiBmgJL5ZzsZP6WJoCEU8kAS/fwjWnPtNJjv3BBVhfnqza6eZKIcp/nCD2NX1Tnt2dp
         4FBNLfo7cGYWsbrfhI6Cbvxgs0IhF0Nt4PpEXKMRJcM6jnyLoPKKXvFbPUS1Glf1qWMw
         ZbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=YyeG7ioMptg4bos9WvsiCAkWTH6MJSyQRYyd9Ee7o3E=;
        b=siDt3EJVTQ6ENXuFZBx+FrRowGqt+r5igbcmsiQU5pb3Nl6CBiWMEwo1XfcZnW30sW
         j6Uv8hC+knX2mqYYzx01CTmw1+N9hoMe+qK5kc/IDdVega/FxOJI0HZ/svjDLj9IcHkq
         gndFlWWYs4cnschqKgpeeljAdzz4z/FogxuvNmg5JfcNqGt0pMcg2XiHffwdsDCMqlNy
         qCTqec1Qb075JuXxVVRDi40T/7sK5Rv9c62CWNJRrog6AASjPCjlpGhLRs7rqieXxVbp
         0zEDG2fYknhbvOqez/ooDKCgbWkRb75NchUGep+qwRAccZh9eyuHLFJ4LlNBIunVZXr2
         9WkA==
X-Gm-Message-State: APjAAAWSOZ1GgqPqi4WKik11wNqdCqOkOdNsFfeYISRfwZsteriN3REL
        5k13h/it+e6unu8U4whTvK7x9A==
X-Google-Smtp-Source: APXvYqx0rDsk1O0gfP1a8V9FMM1lRMzUgooVrb7l8yRAD8+5GiHjXvNFCGmEn2Gqkve9SPZ+AYF5lw==
X-Received: by 2002:ac8:4e3c:: with SMTP id d28mr8485950qtw.190.1581309867903;
        Sun, 09 Feb 2020 20:44:27 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h6sm5533428qtr.33.2020.02.09.20.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 20:44:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/memcontrol: fix a data race in scan count
Date:   Sun, 9 Feb 2020 23:44:26 -0500
Message-Id: <6E237CA6-8968-4207-A9BB-1D18CB30822B@lca.pw>
References: <20200209202840.2bf97ffcfa811550d733c461@linux-foundation.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200209202840.2bf97ffcfa811550d733c461@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 9, 2020, at 11:28 PM, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>=20
> I worry about the readability/maintainability of these things.  A naive
> reader who comes upon this code will wonder "why the heck is it using
> READ_ONCE?".  A possibly lengthy trawl through the git history will
> reveal the reason but that's rather unkind.  Wouldn't a simple
>=20
>    /* modified under lru_lock, so use READ_ONCE */
>=20
> improve the situation?

Sure. I just don=E2=80=99t remember there are many places in the existing co=
de which put comments for READ_ONCE() and WRITE_ONCE(). For example, kernel/=
locking/osq_lock.c and kernel/rcu/srcutree.c, but I suppose every subsystem c=
ould be different.=
