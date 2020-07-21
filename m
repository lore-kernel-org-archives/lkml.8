Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92600C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6F220714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Pn8KR7gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgGUIYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:24:49 -0400
Received: from mout.web.de ([212.227.15.14]:58307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgGUIYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595319879;
        bh=pinAkDcd5KnixyadEDhBjfDDNVjx6NYYWhC74EmQTiM=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Pn8KR7gZ3pSiotWXGG7mVxKbHWTe0a7NUAuCoi4QsEisVEFrFwLVbig1EQWxSve5b
         mjoTxh/U/w6vAdBeaaSu/L0kkUIedM3mPdu7pkecFTKuEOLy88BG16Dt6T9BSSDt0W
         xzxeF1KIop43x19HqVplKeIZvDybsQmR1OVDYgH0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.170.58]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB3y-1k77FY47kE-00CjkY; Tue, 21
 Jul 2020 10:24:39 +0200
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 1/3] coccinelle: api: extend memdup_user transformation
 with GFP_USER
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b271c2f0-3852-e557-b671-a6b44ad10c19@web.de>
Date:   Tue, 21 Jul 2020 10:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HOk2z/0OBDg8PY/TDUng/SfV48LwxeSc8H9/Fhb7JiMy9RL5OQA
 vxNvdlp+omOza6b5rmLWSrvwDAqLZp5B/mlsUilNtUwVuYFbDU1iRvrjIN0mIcH33XXIV/v
 TZmtGb6AMPCpLklTuTegM7Nu+o9aCEvEYASVUODj8SCUjfOSpbEDeAVebZ/Vq1pPYIZJw3R
 +hx+wSYswvKYMKa9ezmjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DFnP9mSwsQE=:KRm2TdebtKyJCYJaiph3be
 AqMBXVfH5/rKiL70DN7MBIBmxVPe0JRW45Kx+Hp0oJy84ihMmqcdDDnNuMi0zeDXxPY0N0Nb6
 iXai9a2XQA19mghhrQmDURuV2OvpDEW8/qt4bhOkScdc/WCL+kOEI8gsDb16nPzYzZLRx+6OQ
 xx0urVfzakDKDrbgEmceQ7qfl/8Mie/MAL0AoJLCNPEos7Lqbiu93kJW8mjsKmp77xhS06Lbo
 w8PTVJRrAnmgRJeK8tzlMIzyls8ti6zP+Qs1EfbX1gExMPYSxdx452tjpnE45nRrvEB+R0RT2
 tdKaiSFEvgtebohcqjmi6kYY7p6G3d5HA2/8vNf1Rg+4R4cHgW3B7D1rZfTfkFBWHMmSql+cd
 trGS0SDsRTT9uAddtCNAg3F5doIB0TaZfMJt54+61Fl9FSldOOK3rNzgl08UpFQDqmsywVN19
 V8GQh5lqNBBQWg97Raus3zPWd94lQZQFzBuP9tEI68Dl6+sWrcitpWszeM4zY88uE9L38cN3l
 pTPxQcGFutUdC6FW/7HzmUjnE9WcLJ8YvW+FT9mkKK4RX8yxVl+GliiYtkdqjNdi6VCLcB6/M
 10Wl3bPuFJsuEhPIBgWl4OHpI52QlOe8zdk6Zd9Iq/HYe8xT0f5ogZxJrgcWlaoaO6aVPwFFT
 c/5LcGHQ/4FCcK1Uj2vuQdZuPZlGHP84+JacuHek/H00RiIKs5uBewBsxV81oNBTGB57+o8id
 yXkWaswzltr90jXNCVAor6AmsacZNpW3qBsUlCxsH2qaUTWmtkooSrInS1ESzgmC3+y7tdlnv
 MQZHqXm5WeXDQN6DHNs2QbA9WeGQqkJWJQ36zeVUy3s6sNcyOdWsG6Y/eGRtl5FyEhbNSLcS4
 4X06IuJULQQYewP6JU///fFGgOOmOFBGz25wOjnrfswbxEOJlZuCmOTehr2IDWZZK/Wo+oDrt
 zJ3pi4mr/e77MMkC3MKcjz57iBupxb7cFibp5ZDI4PqVQcS3xfiUB18qfNKxKE1DSgQhzhPrY
 /hAZi03xFJc18+ZrCCrfjXauOUptKQIbxUj/LbNXFNvwSwqJMaMPNQFf1YwK4WjvHiMSpQG46
 +w5uBN3DvMNrzwR5wI9trBZszDedqNZEErD+VUlnRnbpW/lB5AhFgvX9K20gjqRT3iux+PwwA
 90UEow2ofPEGG3WNCTHER4DZof2+qO2ky/3Ii7uAA5OqzUYyaCuMmG3n5Ap0MjkjQOZDd4SCf
 OEOC1EKkTbXZvdjnBSZFEhnV99nlDWc5vNcS/KA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Match GFP_USER and optional __GFP_NOWARN allocations with
> memdup_user.cocci rule.

I suggest to clarify software design consequences according to such inform=
ation
a bit more.


I find it helpful if you would have included also my email address directl=
y
in the message field =E2=80=9CTo=E2=80=9D or =E2=80=9CCc=E2=80=9D.
Are there further reasons to consider for the extension of the recipient l=
ists?


> +-  to =3D \(kmalloc\|kzalloc\)
> +-		(size,\(GFP_KERNEL\|GFP_USER\|
> +-		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));

* Would you ever dare to specify such a source code search pattern
  on a single line?

* I find the specification of SmPL disjunctions questionable
  for the determination of relevant flags.
  Could previous patch review trigger concerns and further considerations
  for the proper handling of optional source code parts?


> +*  to =3D \(kmalloc@p\|kzalloc@p\)
> +		(size,\(GFP_KERNEL\|GFP_USER\|
> +		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));

Would you like to use the SmPL asterisk really only for a single line?


How will the chances evolve to continue the clarification also for
the open issue =E2=80=9CSafer source code analysis by "memdup_user.cocci"=
=E2=80=9D?
https://github.com/coccinelle/coccinelle/issues/78

Regards,
Markus
