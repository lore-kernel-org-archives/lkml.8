Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F225C47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD1420757
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CRjtQYTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgECOyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 10:54:54 -0400
Received: from mout.web.de ([212.227.15.4]:37493 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgECOyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 10:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588517686;
        bh=Mvq7drscwWZHpHChF/heRq0J0YJsoApkaamEhxE0ThE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=CRjtQYTNpzLA9RwEdp/hDo9FLGlfhOqF1L2dcPm3oBLZtJUUP+ICHNc0emZUeAXDb
         kFWUnMZ2o/ETA27kc1lVZ4KiTzPHXFpSpeMRUzpHY/XUXYR9DihaO3WYm+x+CQOUNM
         OcXBWu+W2q069hXLnPFrFSmaHw1H+HXZDLYVDQ7g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.26.31]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYZ8c-1jhqwG1dr8-00VTf2; Sun, 03
 May 2020 16:54:46 +0200
Subject: Re: [PATCH v5] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200503122938.GC10332@udknight>
 <2d13b5c1-6745-23da-e22d-d56f0644edb2@web.de>
 <20200503143700.GA12276@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <1abe0267-7c2a-53a1-bda2-469ef681d469@web.de>
Date:   Sun, 3 May 2020 16:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503143700.GA12276@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:PrqiPfxqrfclCLS0boIecg9L1Na+wuOf2PdvQeSXifhFtq0TUu1
 FRplUzjwFhFChp3kiQVhyhtUyfHXrQudJGP0CueV4G/Byw230jl3hRjR7D/6gmo5I9MCelJ
 e7BcuR3H5X5MiEIEd+gqv+csZTxDBHzk3d1Jpa7/JLWF8uELBDWRRZajp+0nAzy/DgRExJw
 ct81dInzs19BTaGE4l/3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LtxRitodLRc=:pSoMHQgoL5ZKxeDQp9P366
 Fq9LhsIKlacIJgzCy3e4GwjEtfLOJAyvCzEAhEvafCtg94/z7wBjiDUN29YZuWajwdF0kKqYz
 ICmwJEbMxS3cvc6F9aH3GGlHod7h0h85WDWfGSQ2lfqVlX8RZXTVRqXrgcmVWDOeZf3IUigeT
 rb9OPDpo4CXoTHvLI9Gw10qBEnnon+ZIy7OoMy7DYJwuYVpPXEvdeOlo8bFTsyB0EGFk0mqSN
 3VDtMvIZrlArIMt3ac9SqzPUD7OMsYlEGb7R7qMJdjVISGj7RMhsFEnWiapzU+6jKNllZjJRj
 1//+F9BOFlaL7o94eqzLNgRjUeDWlWgLjKUwEsJvmG4SpKcN4rvCcD/tk3svZTD+Xm6MHrxYZ
 IE3Lp3eVc+Cnz5gsE7rZLZfDA0fGm6Yf608sDveniR/fqmkb5paoSJ4o8ETncWfUsyio56LGo
 pgD7rHe3G7rR9cZ/ok2PKFSXLjsVg7HozI1ToqBVjkontbLnFzN0DGUQtiO73i17udJ/MO6Rq
 Ie52b8VE0HElx7sANmydAW9IAAAz4+cwrodbbtFcSFHnqBg+AcEs+sVhV6ijPJ+0YsUKrsrsv
 iKKekRTx9g9bFQpVt6mkj+/B5DAr3eSfPIqWmxEvQhIy3eA7cIlaHm5CgKYtPU0n89jPOU6Ih
 Ct/Q7CNW1E8/wHg6y/GOEjJ5aQpC8Ow67CNBeSX0Nrno3EWWkenZJmNaxchOa6JMXt7sqEj7V
 kbzQ36v5IFoY0CEHo2jgtrYDIxDI717IjmnJXD58EwX7TizJjSvAVW/50Fu6TSy96dG52HmGU
 p3tEq9VvCaenzvNwBfKlPsKmNDJB3uqV6bIEeGqp08ityhJ1WdVzk27UUjkfigzx0n1no9njb
 ImGWVEnfJrdCdqOaM/r6ioFGhXW7NkOVzyihqiT5aXsaPhIWWe23lhBCgS+li/cQa8VwmJNeP
 iKq1foo+j8rR3aDBMyJt92sb+JZvC6fYOlqNYewz0K+Tbqhrv7scrq8YEv6OyntADOL00ivjg
 Ac9zrppZBXJ+I1Vzjm9pC02MeEFSBgyQW/jx9N/vX0dGoLnUH3ysYgpuNv0v571Sj5lafRVZQ
 NvThNWgSjzd6OmNOVTNsqIjQmw+agSMKij5mZ94kLz7AuB3iDIKs6AZXfRrjhM4m1rGhd5Vzq
 kaNt1rMT96Y3mniaG5s1OJeGMVtdnAJEC4HrLGAEvYMlz2ZsFGVrINMSI83sQZXm8Nwcvegsa
 Ip03TUi0A3GftGWmz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +				      "Please use git commit description style '$prefix <$sha1_length_min+ chars of sha1> (\"<$title>\")' - ie: '${init_char}" . substr($prefix, 1) .
>>> +				      " $id (\"$description\")'\n" . $diagnostics . $herecurr);
>>
>> Can error diagnostics become multi-line?
> The length of "$description" is unknown, it is difficult to
> cook the error message into pretty format with any length of
> "$description", so let's keep it in current way.

How do you think about a message variant like the following?

+				      "Please use git commit description style:\n$prefix <$sha1_length_min+ chars of sha1> (\"<$title>\")\n" . substr($prefix, 1)
+				      . "i. e.: '${init_char} $id (\"$description\")\n"
+				      . $diagnostics . $herecurr);


Regards,
Markus
