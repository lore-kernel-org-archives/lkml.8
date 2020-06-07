Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EBBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 06:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805EB206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 06:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pkSHQEsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgFGGnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 02:43:09 -0400
Received: from mout.web.de ([217.72.192.78]:33801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgFGGnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 02:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591512172;
        bh=C14jTFdBniLyU//fambBzHFvEplMYic9zRGDYcczO5w=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=pkSHQEsxph8fvccKHxm7PO8otQ4Y0p1TVlXe+HeADE45zPRyj7HHK11dD0zod73Do
         TYajCT4O1fLZfux+O7f7YdVeTM1tdZkNkbSbHhTxXWR36FIJz+j3wHie36L4cFuq8n
         4T3QWIqQFnUDKaE+UFoFzbKA7WollYdz/ALRRyp8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.149.75]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKJ7S-1jhGmr3mxK-001h9E; Sun, 07
 Jun 2020 08:42:52 +0200
Subject: Re: Coccinelle: Improving software components around usage of SmPL
 disjunctions
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <99ed463c-b7ba-0400-7cf7-5bcc1992baef@web.de>
 <alpine.DEB.2.21.2006060944320.2578@hadrien>
 <51a176d4-8c59-5da1-b4d2-c97b17b691a7@web.de>
 <alpine.DEB.2.21.2006061307020.2578@hadrien>
 <bf698c44-4384-e471-3ff0-e38587140b98@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e06c858b-80fe-9d7c-be48-882162a414fe@web.de>
Date:   Sun, 7 Jun 2020 08:42:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <bf698c44-4384-e471-3ff0-e38587140b98@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i7Jb9vdrzAd2LmX4YKf9o5wC3r/vzdumhKlgqu5Qnwrfs/qj09c
 cPEwEkqdJ7HfvnKsSePbNKGQbpCf0wlJUe4mEerL8WZEtQsyHi8Hq8gbTD1hrfCAcr/8E7a
 NAR6m6Tu3ZjORyB1HYgjLmVvirqAkkrXbwry34/RicMT4r7plTuNHpVzCdgiAnV6lp4s6pW
 IRLdc//Gt5SaRbJKwvjGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Y3KBZ3kMgU=:8KBAgmNI8Mr2D/CAQ6U6xG
 NI/xOnci3DLqn6+XLw2+IYbtAqZSArCTm0Nj80L/xXh+Xl+tPn5xkrYP5eqr9IhtrA98KQrdB
 Sv+jF7vhhDKOpyNm6vBYntfzvDmOrjX3MPJkO18Yh8l2zp4rBRT1byo9aGSbjTU0F78KjC4zn
 bcRWs8gWu7VTB79yAcDSYsh2o/LU7ziwsjvQ3bAPH9htzHpZruU+8jhE41dXccNb5r0wH1psW
 fD6co3T+Ti6uIi1Nv9+dJMhiw7xBAoR28PcXI/E8p4d3x5o9f4ebUi60IEXs1sZal/G7yrzrV
 IUsP9WOtPsvBgbU5czgRjDbjbMw85dxAiQ3awk/c5CU4Z7E3imHbOkqHEGUW+KwgFPQR5iyRB
 rjLyEUsKD+Vc5mexy2gx5MYkkHpr7qwsp2xln26Z4ShY75meYL6eupGJd63GjOpuHSEsiZDug
 a6Gd0+pxBwxN8AA+YqRQC3NGE9cn0XpWTAkq2VmvsiSJ63UoIX5QX43fLl2J5ousa8WZCqruz
 2ocYsDjEDePTqktMsTEeTt97+d3TUK+YCUTebcVwQ9krN8WAOmYyhXgBbTvT5ZbqUFwAkahbJ
 +afDMjdfso9AIQ1YuNv5i2Es5fx7P3soaVktoPbwTy4UbrHmdMDuaECywTQJlbLK5ni/fu5sq
 rHZhPexHM72ALHqVINzuWUXE1cUeg+n6G3ibyhQAaGeSaZzPlv/0yRe7zS54EqYrX5bdEX9P4
 Kn7TnIWGXcyhlCcRO0Wr7H+5Oc0eYAZWPKL3TrJDUC/mrM692dJT+8+VyN1K7dqmXaSTh74ee
 dS6bvfSPLDd42ytBiYjRGn6Cs2WAWbMuR275WyztqWvtAkZ8qe+qkvlXSTV3aeY0IKzlftUnJ
 q8V8ncf6sTf5iWfdbbnoyeN8ffCkVi+R66rsWVihNbdsLaZLtG5qWXphbm5SpI3REu7dBle4n
 ciVhhr6G9EGAbM6beXSFkWosifFPFWEPJT8AvMbAq+HpVwew4WIzzkCMhU7gQ62/zwaRindyw
 HabtyQjGoELCC35QkSWj/RczC7wGVhqEaY4htl6XLSZlQRoIpdaYaSifZBE4PXZ9XxhoRy7Jr
 WvDhdNhP7uzC759FXInF0srynabIZAFwrPtulC4bdIj6tCYkvehVCpEWCjk4LUEXeDQWZka+p
 Bkv4X+gJab7WyDyv+I4nYpfjrs/BoVe9enhKImFdLNg5WtH9VGMtGxys8xgxJl4wlJJSD+kaB
 Lnjka2P4fcVhsDNoL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> But hiding information that could be apparent to the SmPL compiler
>> and could be used to improve the performance of the matching
>> process is not one of them.
>
> Will any software extensions become possible also in this area?

You pointed out that SmPL disjunctions can trigger specific consequences
according to functionality which is different from SmPL constraints.
Both application areas support data processing for function name lists
to some degree.
Each element of a SmPL disjunction refers to a fragment of a detailed
source code search pattern. We are discussing use cases where a search
pattern is occasionally restricted in the way that only identifiers
should be found at a specific place.

* Does this detail provide the opportunity to improve the corresponding
  software any more?

* Can a feature request like =E2=80=9CWorking with variables for case matc=
h
  identification by SmPL disjunctions=E2=80=9D become more interesting?
  https://github.com/coccinelle/coccinelle/issues/159

Regards,
Markus
