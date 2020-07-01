Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97236C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778632082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VUotbRSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGAUKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:10:48 -0400
Received: from mout.web.de ([212.227.15.4]:48963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGAUKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593634219;
        bh=2/d5gzwWmiWVdOHstHVZeON0XZWU4ALfPZ0g3/Y4zqY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VUotbRSZX+QdAMN9lhgRYY2uA62gWqliRUgvJgK0VoeMp4wxjU+m9KgczeIZHSquk
         QDuntUunxFDfCrARWHskFmqlcNP+yoXxRyh4fzl63ctgzPTgIAte2ZzDPmw+m8k2vs
         zgwhWZ1bqK2gtYcIJXo/58SMxGHJGaJJF8kdVYW8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDg8k-1jakU9259C-00H7I2; Wed, 01
 Jul 2020 22:10:19 +0200
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
 <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
 <bd4033cd-f564-0414-4dbf-4ff58f841648@web.de>
 <05f8cb2b-c76e-e2ba-24a8-5676c1792255@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5e83b473-8764-fbfc-394c-1acffa74943c@web.de>
Date:   Wed, 1 Jul 2020 22:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <05f8cb2b-c76e-e2ba-24a8-5676c1792255@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jD4EB52PawaqfgsahwsJGbuF64bQsQduoXCr0IJiHVg3UFzIiwo
 FVDB3b6JEGsVa1N0SecQAhE2hT1CCWlRdbVjW/u/z/qbgRqZutmyEhM8fxvfDJB6HlZUql1
 DHOlk6ZcZdUFZ1UczQWtddIsvX083o65GE7VjRvqBB+keus3d/iZRinol1FhgUcMJG537Bg
 G5/N5v3m1rPaDpq6Y1kjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rHFS/U+2lfQ=:6EKSOFKocFcrfq5useRqwK
 YSM3ONfLrRGLZdt86zHtulfV8Ow2rZ7m1H/c1FQH2ZSxJOAIk3xlxcSwk6abl1SP2jyxe23GO
 uzX4lh6ZLxmFwzq/UDACIikR+Yt5Sg6lB71RFr3ClwbBg9I2wmNUa0YbldjLwBHCpAFoyH3gu
 ZT4Bc3imclVkz4SNMsjg3qqPgxWNR+dWmxT0BTsJftYWChHQck4egNpXNc3Hue2jvbBQ1nvod
 2+TtZoj3EmAsEp2MsH2/kTPhanyjOHj+bstd9/4CjZfMoqveaBc0ZRgmi8ptE5Fi+70oUy4/+
 TiQzDrRKqdFLYeZWgKjuJ/c1rgtpfZIl1aSvEvjt7n5+31H/xnSL1isEInBcvJEJcLxl8ladU
 7kDZu0eoiuBSYMTtLii/X7Lo2XBJZNXgFSsVjKsSRxDuDqKZKEG040EE4/sp2kLNNb1QJeWHS
 vju2rAkIZcCWTSGvGCr2P0qZBqgSO8sQtov4/wa33LwcnR2YZPze4wG1B0BI7herkUBFQumkz
 3/JqknFiiP6SeN+f+5XaFWM1HoI/CFAQL3dOVodIgQHFzK6OM2i3SZi5jkxzLIC4KvlwTLkxG
 BsWU3KtWzypBS1rf8mWaNTy2XOURxanTgpBbEu3cdmocYUh1hAXhp0Ohyi0gkyIEEi9CiEYxZ
 brZUClMkCNqoYL/foCjx36vQM6A1gMY/YQJIQ3dCa4viC9nRUmZdIOfEHWy62/dGAGzUXvi4e
 ZQqgUDgYwi8SyhzpPB7qeNXGJA1Uv9DX8jnEleuHeEdMSks2TBck7Wz3gqM3RWlmCq0dfM0al
 PqSUNoOWhy1W1W0nUgOBlmDZ5zfvFDbb7fBIsFa0V65rfLExw6is4Wx6Or9I7MVldhI9jsfWR
 PnpM0X74nrpkH08xhH6LQClB5/BUyMPqMLnAoNnzM6Tky2jgAXrAKsi0wvmi7oWTuSD0JmED7
 q5C/ba1ZllOdLr6LCB2+KimQWMw9PgkYF2YywEQE2QqRP+nvEXULwwkjtIX2cstiT9Aa3SJxq
 CjiEageY38lC8JE9G+iRsYq5SfpM6zntpU/K9SHe/Km69QdoX5oJUuCVLSxvokEGVaNNfDKBX
 hL7YEhdfTQqLGAPDTQU+PBe+7Te+WJ2zoAVE2v2WYYphxVeMIlHFPtUaBz+/ApA90g2NSzuDv
 u9qOepB1Ow250dHKCHvs80aPipPrQfrOBWseF36f7bouxGoSr6MXkYoJwtu8xCCRt300HUlqM
 EIZEcbfTuWej6PnbX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Did you test the specified make command for the display
>> of expected data processing results?
>
> Markus, if something doesn't work, just say so, OK?

Did a previous information fit to this expectation already?
https://lore.kernel.org/linux-doc/c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web=
.de/
https://lkml.org/lkml/2020/6/30/492

=E2=80=9C=E2=80=A6
make: Nothing to be done for 'path/to/file.c'.
=E2=80=A6=E2=80=9D


> Don't go all obtuse on us.

I am curious if involved communication difficulties can be resolved
better by other means.


>> How much do you distinguish desired effects according to
>> the specification of file extensions for such build commands?
>
> I don't grok that.

I assume that you got used to the handling of specific file suffixes
also for their application together with make scripts.

One part of the discussed software documentation deals with
the combination of compilation and further source code analysis,
doesn't it?


> Julia, Markus- can you tell me how to run coccicheck on one source file?

You can choose between two methods.

* Use the documented build target with appropriate parameters.
  (How many Linux software modules do consist of only a single source file=
?)

* Do you get further ideas from another concrete command example?
  https://lore.kernel.org/linux-arm-kernel/5b693ee0-0cb1-7ff3-b562-bac6bcb=
6aae8@web.de/
  https://lkml.org/lkml/2020/6/29/357

  elfring@Sonne:~/Projekte/Linux/next-patched> make J=3D1 C=3D1 CHECK=3D's=
cripts/coccicheck' MODE=3Dcontext COCCI=3D~/Projekte/Linux/next-patched/sc=
ripts/coccinelle/null/show_pointer_usage_before_null_check-20200701.cocci =
drivers/usb/mtu3/mtu3_gadget.o

Regards,
Markus
