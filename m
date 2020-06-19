Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F753C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0328520B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="M+gek/yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405279AbgFSPqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:46:22 -0400
Received: from mout.web.de ([212.227.15.14]:35373 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393496AbgFSP0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592580394;
        bh=1/GDrKnoAzkupFdrRTGpCfampXo+6ifil2ModgwaGvU=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=M+gek/ynz2XgO+mUMRP05L2lhNYSaH/iv51fox0siLxd6oU5DxVN6gQCvlOdVB+34
         JsWElPrNoST4vuCHtNdw5mUn3HpGAWnU5ig1z4PDnh6iX5cXqXjP+EzSG6R8bCUFzS
         yV5GEq2XqTlgx+E7UF543BcrDQk3CNKAaAOETsrE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.139.231]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1jmIuY0fQG-0007Vj; Fri, 19
 Jun 2020 17:26:34 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api/kstrdup: fix coccinelle position
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <0f221342-cd9c-04d2-da01-f86574d3de34@web.de>
Date:   Fri, 19 Jun 2020 17:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4A8O+v/braYvujFpniGy20a6x6QdcckHyF/IRe/dy9FTzDcLsos
 xK4P7tjvYRQDo5+iplWnDzGbFQ+u5ET5jVLr/4oM9gL6cGFo+f66vwm1o8P5Ww0w1EBe/Rp
 LaaPsPIuYzIfEuGETVwDSlfBDPyClrkb235VBoBFFovFxzA9hdw0KG8DsO4sfkMxR+qHkt+
 E7bYJW5PO8QgwDAvyb1KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wXnT8ygw07M=:nn614KRPWLpTtI2xc+bXAJ
 bHAH9M3rofijLo+WKAwkKHDpL3jjEh333dUPuEYjsS6vAC2GrHwM41ozX3BIwmQ6CgfSHGRTS
 TTDW6w8itXCSxdHq/lXoW3JhPqV9Gx08kMoXcU4w6MspOUhas3W1uxZtm1EMLh9NvyHF1qKOW
 Dl39jKXfk55cErkHO8KNqVkJJT/Uc3LINkLqvdLDkPJlt7+u75TPnKsZMaiIDIh6Tk/Lwsmkv
 s0cRWbY3OO4IAnBQ9ngbhpqU+/UOEccz+zYuwgYCmTvDX3KNZ9/aZTOY545+Y1Vwwn2J8Uj2d
 V6MB+ajtyydG9M4vY0srz3nKEsz3w0J5vosvYEa9/5j0XkECGNFLr7onJvSXjlT+iifaWT/U6
 eKfpHUBpg36YxHJ0/TgBHpPoHT0YDruLbD4llXfqYA+ZufmE+JO3uWydZPmubsgM4SRIs7gfL
 yH8mfkPF8W1QOJErMvynaOjtKQaFbVh9VUGZjQeaX6aZMmA4zbKCcw5X3D/+4xQemjsiNGKwe
 QG1XS0hENA4jIXpjY17hH0IAWoPh+fVRUu0UURXrU0G6n7M1BR/TieoL8VyfuI/8HXZ98xNdu
 9qQIJKlV/bvoxWxTFDGLdgiijrG1VQJegjWqUdeZ0mwgt+9cQnfjdp6W2U+UT0Anh6/5ADhPt
 oNAKJAlok0szGy6i+FODulYqwfioi9Y4EsIiCW6VyUtZSNKI+UoL19OFzstCKIsHzPcpxD2tA
 KPzIphrlK766z28UAyMhcr73pGhorau8w6vYdbQa8u6SG6n9zDg04bbc6036Q4I/Oa2iJJ4DJ
 HRbpKJP5j19jY9/FgAR9S2/LHYpiASeF2l7wwfeQaIhy7nsLGHEN86LZTE7jXFrtEth62svlK
 8FlNPgXhUIJR3pJ1HqQ2jBaJkUiQh7UCvpYrVf2zzsaTgP7e2kVyf4NHUjrA0Sw+NclzsTFzO
 gY7xqVWIIYJZ+1qyolkdBS0w8EENoOpR3mFX3o21KV5d665WqHJ+bJiPDOnpY27+n52e/CD4e
 f5oTBKbmGqy21G39VHMGM3LZnnKKHoOW60LKf//ZKp+9knHJWPqqrar20I2XDR8lzLyaUcUgJ
 5XPNOIswvpMZFNCjb3omZo+UhDyFnW++ApIa35eEGNdlrrlEs4te/4BpcVSwXFLuGOYKR0JeF
 4jlD/nF9/g4CCRSSiVYS3vSBsJhEtZI1sF7CvA0Hf10uFHST8ACMq9n9czsTVGs2ZYyNmsph+
 byKHf5SSDD0uR1JFM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a typo in rule r2. Position p1 should be attached to kzalloc() =
call.

I find such a suggestion reasonable for an implementation detail.

I would find an other patch subject clearer.


How do you think about to move the specification =E2=80=9C@p1=E2=80=9D out=
 of SmPL disjunctions?

Regards,
Markus
