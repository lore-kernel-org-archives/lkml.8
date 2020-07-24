Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5326FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF320767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lWSNfLJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGXHJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:09:47 -0400
Received: from mout.web.de ([212.227.15.3]:55149 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgGXHJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595574576;
        bh=f+IFexYtJPwWHzHuhj2w155Xw1h4mmqMLdDNsyAy+Zg=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=lWSNfLJkAa7Xc3LTDy14FsliU6zFhc1vz40510rO0zMuQsEAb6DgrAPLd105pVYUb
         hmLi7VOOLMwWghEHt7lO3yWjQKVujzJYER2T+HTQlTgzhbkdag3iNktjC3krDN8IuS
         2kGZJySeZSsGV8g1PC5w1dsf5ANym6gQASAXV4bE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.46.40]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRYd-1kGGGJ0Sih-00IULU; Fri, 24
 Jul 2020 09:09:36 +0200
To:     Vladimir Zapolskiy <vz@mleia.com>, kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wen Yang <wenyang@linux.alibaba.com>
Subject: Re: [PATCH] regulator: fix memory leak on error path of
 regulator_register()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1e281322-c589-9c36-0565-98fccf5f0e17@web.de>
Date:   Fri, 24 Jul 2020 09:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bbgcSdS5PDU8YLgr0H8Rnt7x3HymkQeQJ+myGNAcEVhaiuAHNva
 cs1K1G96V/6jl2/SRDOmgJJk33BE+O2BG4rwBqYToj8tmfN06dJojTnQGGk5mWx4EpEN8he
 hhxvtX2hmo4lNL3+uWvhPrx9wfuLzqChECsMCXxjRGCmq0aMnaNz4f+ExRFKvD6rGS+eqvc
 J6LgYPSRGRLzywb/InQHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O4yPpxT6jfY=:iHWnIX5MNU/0UxTIzzzjCw
 yvHA4YpP1zESJR9nUDO2eERs31RrE1G8lNxqS43bMdB9BOk6fOuHtY6WKMsyf40bdAq/IjB7+
 G9Sa0ovkdZ19BHxRA7vQzWL3ekXR37x84MKsS3JFYGJ3pK/Ua6jKiblVs7UWl5xyxnB0KDThF
 /r2V5I7j5YbLQchAYWvvMI7o7qFkTDVv4HzU0fvaS1oLVO5TsbhL5pnHFe8bTh+EBzjBd0Izo
 sVcXUkPkibrO6grS03UDxJwwNZm5huVVo4sD25B/ha/O465UxPwopxPCQ9oEfOutNcMvEQvfd
 TTgE/PEC9yoaZsML2X6tuTiN6INbH4eTDIAQmZWF4zJgk8V3GN4BGPNZN3uQTov9XVqF/rMi/
 eubRdM4PMur/CHvk9JFsrmhwh6bS/UILyUSv6qqolAO7YpAcpFYGzbms7RZkNY5tq/RokcMI7
 EAgrCZOBBhImkfgG2DJBxSl55iQOTzASdGz6hFhOwrilWb7T9vOO7/jJiJCAOGG2e3TmXX5nZ
 rfRBHFIfch8uEw2++dHutiYHgrd3mqeZERht+tIV7z6uzkUm0DKgfwISNZh4XAEmajtHWSash
 /w46AVqk0fw40qq6WcAhraALEPDXnFs0LruKWXUclxcGxvHfl5t457lCQCDS0UHcz72Zf5CI1
 ZTv9GRY3erbQh18/PGezAEOniefhIc0OlmNqFVjSpYAu8hs5rXVK5c35oMf04ru2mBbURQb5P
 mD8xvhopmy1KVYSUkW8wBqToWyz4QvnRf+Q5+MUXU0xo/0QH5Tw5oh8liZQtgBWxNkHmWawol
 KsSJ+xtytkaGfkMnEkfhql3vVtWxAc4h3f06gvdM7M8ZKDf6FYGDN2qk4m2O6D14OW8uqOI8u
 bfdxhaicn1SzPsdexnwQkRCb7NyMSdcV06KzuI3YilVB8t3k3m3JUWuHUyn6HdgeZl9SjO6hx
 iHfPBiTOE6GdlPE9Cc8OAjriOZc+9S+fKhJRRNyt2WBLmRprb0+tqMKa8yQb/MvnjP7n3oyLM
 4zVK/+sBMYkdGeVl1uBrF2NGpZ9UjOnKRzFz3Xs8JurU8Ei4Naef5h0B9B1V4wVOcKCBq6Ljm
 zlPJg8zIAdBVxhNi9fAYP6WdLqs9iZW5EwlT9+4RjivHfpC14B2CAeM9fpxVe2ZNnNMXEXG+q
 ybdurhxdob6ccUmxNDkZ3CZN8pl3CF8rMixvBS/v8p+hit7nEZUDNBoiwk5ZOEiekTOHI668s
 UWnk9TaQmVPMbHA79kIc673drx4n6Zval1OjK4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6 introduced as a side ef another =E2=80=A6

Would the following wording variant be more appropriate?

  =E2=80=A6 introduced as a side effect of another =E2=80=A6


How do you think about to replace the wording =E2=80=9C=E2=80=A6, I believ=
e =E2=80=A6=E2=80=9D
by an imperative description?

Regards,
Markus
