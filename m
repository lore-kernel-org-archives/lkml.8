Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE34C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2342B20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NxsdW1M+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDFGyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 02:54:51 -0400
Received: from mout.web.de ([217.72.192.78]:40973 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgDFGyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 02:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586156078;
        bh=rCy76P9PUqATeEVtGZt2SPKa1RtA9OAXSPP5+zNddb8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NxsdW1M+MYd7wkBg+6nUPUrTg5I7Yy4JpnO2IU29y1XHg0W9KHHKdwFtEFcs+TpNO
         MQ8T0UrJxn37DELV4+78Wa01pr6UouUBWxglm5ACEEIkze4dO+3OK1NlTxlqulxVOp
         UcQuP5fHiTbgiJl0FhMtmSciRPOOID6QqXic/FGE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.176.200]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNcV4-1jMzHY0UqA-007C08; Mon, 06
 Apr 2020 08:54:38 +0200
Subject: Re: hwrng: omap - Delete an error message in
 of_get_omap_rng_device_details()
To:     =?UTF-8?B?5ZSQ5b2s?= <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <eae7170c-4371-4865-7b85-589c0ed2b5b6@web.de>
 <2020040423261552036811@cmss.chinamobile.com>
 <e71d56f1-6fce-5e2d-9719-1385ef3b0811@web.de>
 <2020040505380926003012@cmss.chinamobile.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e719f5df-a79d-fa91-e88f-ba32f1a64a69@web.de>
Date:   Mon, 6 Apr 2020 08:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2020040505380926003012@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lVxYgaIvrXBAqfcg/7w2v0qLQUnGPZHrdQj8ypdOpm+K77vWW6i
 KhjEyYt20kJlFybRaUi+0+qItdNmjz3HSdUVNPyhXchljcx6AQ23UV4bh6qSHBE520UIWX+
 zJ83C5r3dmDhS0VbxvAuOR+TAdQ75dBWiSiEYMTqNtAZ/cM47kpRN2zHhB4MI/z6Ze2E+aE
 F/9TYVjPf6N4Srwivl7SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4VPpKDDXisI=:O1D+Dcq6kpxJgAnkTvtV+T
 Zab1TEYxPLPHW9gZ8+/9187ML45ZzyQe9wQRb+yRL8REHmie+rxLROCXlbXx6rnKxHAU1D0pG
 NKXJIaej+wlOjM8frRZqj6CKXEN3Yg0oH/t6m21Yt55kH7JBq7VzqPXzB5IO3S0pvOAfpjVVJ
 iMfjzUso5IrQh2uz4Oz+TZs1rxD6vryfArS7TDXiLqtZ6cWyFTAPhGUMQMrRF+sRWf0+jRHCh
 RafgpiJ0ruN5ZF9GY1kNom5y40VFF7K9BZz6Mi3556nBgKeLCbuaTGJqumoaSCB4ODMcoEBms
 gac9fSWTvM/rHZZjJ/XgKUeAakI1LP+7FB/Nftz2hx91O0SLuuUn8F0uaZWiNFeGN96HIqe0K
 xz7uBuaqs8gvdtqOHT9Z3BT5OYubWbbUvzNsRyO6SnAx7RSIoVxlEzl6jPDRNrbapqqtQZzkq
 ymbEQzXJ8pLXm3E5EBAdXTymoGr9h6ty9uboi+Sb4/7Re0jZiMvbDBxMGJM4SfRwe2GwSWNpz
 cg6ZRMllgOhIMX9D+i+0lmYVtrhGWwmQjliN695EMjQkRXtTAIfpZ9Tgqk/hbFlyjwkKlN2oy
 RWp1yy6iSpnAxtt5Vgx+6FFmMdnZq1HKZxVARm7HkkQ36ayrqC7erONgt9N3fuvGDBzB74A5S
 r1MynE5eQzrQRBzB1py07+kkumziIH3ZCx67KIdkBUh5W3+5LAS/2OSazbqu9ixGhUfyOWw0a
 eva+pcMBF36xrlOe9+whBtOdzYRv8ERYZenMYzYNP8DIbThQS0SGIzRowcPfdclxzIcCCXH+C
 VOAlmN9Fsfxd0STCRbFobn6YCTyGrT9CJN0FnqrbSnhTlIpyRbVEstkIaC2MLHmr24HyutZsJ
 TyUoO3/mjXXLktJrD2lgKxqSbR0dfnan+B10qkzYAvRFa/+j/1/OFETrfIHetipf+7RlTTVzf
 120Auw+tiooNKFsPuaM26r3NfwGDQkeBlH3LgahmPVudilDXJirLVANoc8ztBjDe637Ng2ZDA
 L0aITGuvHNjSMcfbxUAf/37gxxMJs0+hszv2aFbCD0SsalptaL2VF+oAAUc3xDG+VTWxCr10b
 TW7bzurr7y4xjYiTw2YyQU1nSlX+ajGZEjx4l+OzxTDdxN/Pm+WDcTC+yew8DFHQ+iKAXGARA
 tT9eGsn2gOZTcJzWGnhU1RCqHIDS3m2GZBwJNVVxoovmJuCTR7IkkD4KebWuDe63/C5jkbBor
 Qi/zR++Fbsz2Y97mu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know what is=C2=A0Coccinelle software, I will check it out.

I suggest to take another look at corresponding software development possi=
bilities.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/sc=
ripts/coccinelle/api/platform_get_irq.cocci

Do you find any information from previous clarification attempts interesti=
ng?
Commit 7723f4c5ecdb8d832f049f8483beb0d1081cedf6
("driver core: platform: Add an error message to platform_get_irq*()"
by Stephen Boyd on 2019-07-29)

Are you looking for further collateral evolution?

Regards,
Markus
