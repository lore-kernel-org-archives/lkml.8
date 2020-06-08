Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005C12063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HyOkmT0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgFHSkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:40:25 -0400
Received: from mout.web.de ([212.227.17.11]:37317 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFHSkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591641616;
        bh=HsC+w8dunnbHNKQH7ymo+2rXPeBinbvbCV8bV6qXMOI=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=HyOkmT0yTgEyjAPJKvoAbezDVbSTXV3MBKh/b/bX3uAjZscf1u5a7u4ls0I26Qljf
         5qSW1494pVw4CUTqSMYMjS1miJe6NG2c9/6CMujDL7/o0ZRCWkmfXxBz3Dg9waAkHo
         lXueo5DF4kMT40vohl1otsgGN4CXUS3mj1SLxWxo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfGh-1itU6N2GaJ-017Fq8; Mon, 08
 Jun 2020 20:40:16 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] coccinelle: api: filter out memdup_user
 definitions
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <623c6271-4cce-55c1-a15b-4a1ce4365fe8@web.de>
Date:   Mon, 8 Jun 2020 20:40:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:bz34Uiz7xaBIUF3SMjCHf3vyWYKMHYDd/st1vIF9u1xt2kO3JAs
 uFCKCaR+ZnpOzhLZtkCgkDJcIjR4q6Vpn6pT/ZADIe5J3grBwfVrOtJOrpDeb7LWoteFFhp
 p8208XNnIq91Ow5dWOBjx8CUbsxoy7QrrU4Djq9Pn+yEaWAkWY/eoE5QsMzvgdyGO2G8Sm5
 y4ct4sUoDndok08phzLpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MMICAGTd+wA=:dkGjTMf2Xcs4B0XbrarNBe
 nLtsRQQxkDGB2osghFSBI96QzkSiaF4i4WuV/xam2XqGTS16VquUDJGqsHSiPSPaRgsqt5yvs
 MHtazI8qyaIeBbEVHhONGbxhw0QWwGzzxpmnqx0Ts1L3xte4o5O2Zo9Y+fK4CyTcUHsYMRm7M
 sIy5l0HDF61IMOM5BAA9D9CccMYCQXstV/c5cjZSL0/DtgG2r8BKJcsm6JmmJ91PYau3zHUGD
 YTFDfs4crTQK408nH5N5AZ0OHJTvD2dFfSyELCbJuH6VpLXqBxdh+3kX9AMb16ZBCIkGrCHDj
 CSR9u0yyFFggJf7IJhV/49wHKmEg3wL8IuTG4xrXQyE6I0W17a6fwqsIsxl58J2xzzhlu1sMo
 vOIbPaJWKA5OCxNqk/0pKtgAcZ1pQcmhxyXM1B62v/l4QhQ5ngjM+JZDLX45ntLvpGhWhhHJ7
 86Amngk0Z8wBfgi5P12cpVpWNWxUfF+QORMlQr2BLFocSgocYQa+RvrAhmnqYS2XM2hlvF5X5
 rJb0HfgcsHFCLv8C8mxwppPYYg6yVzPPVYkOFgACjy6tEvuPHUStEikS1IvEjMn9MJNE8kIU2
 kCqWJZ5hUzvjT8BnBkHFS3VKIFDI5YTUbtTvYK9kf8v6R73IbZ3ufUHeTe2zE9XTlVqnEFZm6
 sxXBXJBsfNxAGXobiqw1pT5gGIAo8Tp3A5WYIIyDuDsIYFG3Ov/fJ0yzeuL1q6sxueB+RCYnl
 MklglqcDAnlab5Mo8PBPa2E00EcMVFYnNRbEbhPvT3frKOzTnQyNuEHle6JPj77ZpiLABcLEp
 TiL0Bk0Puyc7qX1s7BgmFUn6MtFHmXMC2+qADAVYlgR6o1gUlNc2kVSDxyiTR8qNT7dOMUz1a
 Wad2y4Y3zWorNEzUif1BA5E4BtjtRVyIAfyuk7Xw2Vp0sJNsOkQ6bUmW+lcvu5eVfyyrH/iTe
 nhsV1aVG+ucM1hJC1knYgCTrmC2Lz/9YfzeqOYEdZMS4bMtbQtgNhAm7Pd3vmho9DUKX98WKh
 ncZPT91KBRf5NzoFwduW9kMd5t51M9lv9XNVg2BAeVhJtebNYh2QXQiRfr1fqHiopyLakKY4b
 fIerCWvbMxIoXSdI770EzBvDmFXu/Bk4OrrWK33QJPoGZq4LxfmSKz5PQFhd2jedwCqf5AH29
 7BFMgLudrgjltNogo0cvpmOb3Sts3zy58egOPdtRi7B49Yj61kc2Ll0ElbB4eka4lBObu5j5x
 ND0cP0APuh9BPi3xU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Don't match original implementations.

I find such a change description insufficient.

Regards,
Markus
