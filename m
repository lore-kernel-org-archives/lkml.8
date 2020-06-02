Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95294C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730A7206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GZCHiMkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgFBQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:05:26 -0400
Received: from mout.web.de ([212.227.17.11]:36423 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgFBQFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591113912;
        bh=RVIJhnmYHVzwEIV6eBW7bKgScuuqxOdFPaqgSLjJePY=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=GZCHiMkgngHgty2QAIBuZ3lo8UoYeCO7M4JDFQuMLtkJfulXIYaEzRflK7Bcw4X7L
         B6eu0ZGZb9iA+EAaR+jhcom9BedOONX7l2AFO2JgRAdGes462XHdzK4wrY+kSbTQV9
         c6bE32ODhwU3ekdZkHL2H5HiTd69AHYRfqvfOIsI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6lR-1ilpUl1bot-00zRtJ; Tue, 02
 Jun 2020 18:05:12 +0200
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        kernel-janitors@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] workqueue: ensure all flush_work() completed when
 being destroyed
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <52adbed0-57ae-7af6-a673-2111e4d42252@web.de>
Date:   Tue, 2 Jun 2020 18:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xu/PwYxXryyG1PnNCbc1YWRuI5ag9zFwCP9TOJXxxEBHNaeKsQJ
 X6OBPJ1aGcLlqcA1Rmhcw2RBFjEqDse77tdcXQXlWlVBU98OxR9NXdgI1R6MdOSprxYbCHP
 CNqdS5T5+jiLRxVhGOZWNNJ3wdJbBxCa9+Ku8vqqRTnE5f+hkbiUokAtVER3Hb5mqN3yBz8
 ytHdDFTn2tOwDSykeYeHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+HNJP0C/Dtk=:mLymU//VRWxPlMGWK7eGqO
 X9s7tasDipi4XTDG+h2WPh+kZcpGWDSgVp/1MAQMijHhO9KHXxFR4oOVydDeswiDyuo2ZVk6P
 eTGx7V1LRg0RjmtXcvKN/3nLxk3o92kWRrthFiC0xbDtsoj4xDiazPBjRu45OVXraVFxrxkZg
 PORvj1UidCb8/8CNpoJ40i48YiNV4nahO4973dRPb9/enJAZ3Dcf3kYzNWvUID7Ig4js2eIPU
 HOGlDkB7RgwgO8Rqgo+fhil8nfLQY+Vwp21v1akXHSkNSycP+tCjQHSkabBf01f+a3bAkPPEx
 /Mnh8UcBLZbe5FOjNwTLs7qJIaUE8AoPtj097nyaxToMxk/7KETKfW7HLW3iD9FyHq5m6qFu/
 Y0t72EpzyHefnvJGpmb42+3yF/yoiON5CyDNg1v6BA9CFRbd2WFbO/VsjayuXPu0NHzmqf0a8
 /YwaODj92SEcl0VkcNb6HIC8A3hT4z9y6iYgL47xinXKP/sb32gXjR7zA0B0fYq89VfQr00vN
 m0IQEwD1+3E8rrAqfcDdn6DecrUT/pYNTHwry6te3jCbzVkkPAbW1E0AR+3ZNJ2UdrIdS3jIM
 nKbAWTQu5SiVI9J5+L0a2ExqyUBXT5P9IWA7TwJ8286yQRHUCOue2TsRrSiZL8UZMIXHZeiv9
 bQAahktrN/ZvOGs3zqFO3BjkJELiZify1CxXD2HcezYCZnA/PrkNH5/O2GyskI59Xkrq6MEdc
 SnS2Ffi4c8y2gJyBgyvGnbd4ploecg+hMv2tA7By3FGPC0llmeCzUpEmL33XMqqGGoSQuXVS5
 KYMcD7fSTrezs1oqKOge2M+ecCID/eWIeVcT3EdTCeU2ppTj++ix75DBjjomQZyMg8zjbLu+m
 dep/qm9ySMtqtmWnVpb3qjeGLncMpCl7U9g5EFZbUuqGyXE4pNYFq9sJjZLPdjBzMC4lvI/x7
 viQRhnHINBg9r/97/NBLV3EnYXGW2+xY5UL/eKibq2X/TIl9KLQX4Hz+xe7ib7B56GdKwKtdl
 pliO9boAGOIuJL+Ub/PqhPpZlKHQQpTFERwbXnoAAmQWUJyvSEPyPEGnqnR4DMv6aHefsBScS
 NEgA3+HJl8GK4rmkYF508A0Ik4fp8geosvEOz7eyhUNAM0v+aPyw/QiCN24K4pjvOz9ammcYC
 GsNmhha37k3w7k5zrdzlvTziOvn383WcCF6ZpiXFMKyQZ6jmIWAc6FunxcixKS71550x6fkVl
 uyvpX6/z0teX0lKzp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please avoid a typo for the patch subject.


> But
e22bee782b3b("=E2=80=A6")

Perhaps small adjustments?:
But commit e22bee782b3b ("=E2=80=A6")


> and the wokenup wq-user code

=E2=80=A6 woken-up =E2=80=A6


> can be scheduled eariler than =E2=80=A6

=E2=80=A6 earlier =E2=80=A6


> Changed from V1:
> 	Change from flush_no_color based mechanism to atomic+completion

Is there a need to reflect the versioning also in the patch subject?


> 	based as TJ suggested.

May the real name be specified?


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
