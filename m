Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1899CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D583A206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="K257McYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgEDQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:33:53 -0400
Received: from mout.web.de ([212.227.17.12]:56343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729697AbgEDQdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588610021;
        bh=iKajeEThUjwNdKgviLkmcHAYeTjhUS1wUVRcmyQKF6Y=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=K257McYQeURBaqfoACrBFDGgBSXXGK/wQwEcNSOAL7hOdZGzJMw/igJwkWXB23waI
         QE5hc5dSGBjiFxVS44eAldPlQl8sPa0beenJ/A54YS8BhPM36tNdB9vmDkWDW6Ynym
         HHGIyBNv/pFzrg5wvpSWp/K+doxW+G46nUF5iJCw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.152.69]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxODe-1j3ir10BNy-016u7u; Mon, 04
 May 2020 18:33:41 +0200
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>
Subject: Re: [PATCH] fs: jfs: fix a possible data race in metapage_writepage()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bcfeb785-b787-4ebe-c1e1-159b6efc7e51@web.de>
Date:   Mon, 4 May 2020 18:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7YzZOCIxWKK/06F9z/ZoK6WsDS8atsDgIU4fFcNjE6d6Q+wNyQX
 TbHjc+gy8VxPl6nXw2MEX992I2z5RX7o3FEyn1hhQRCKfQviHJjoPn4YQ9Zn1UI4TT/7LnQ
 5bTsgigi4YzCdVxOShXOLhDjtc4tFK8v5Vf/ZazivbflC/VT09VwzktchzAsYooQzhcZLIp
 WXyV3/ul3uZpfuPLJYI4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:55LdT5xZYwQ=:CDw870Ji6yeC5L4Zf5gTqQ
 Pyrx1kQLYV9Te7BL8CgSFme9+0o5zNvlEFb6HH3kiOK7wt/H5U4jlwTTEDrrzrGUxa4HkUt6h
 BpCuVtiu2rZYsny2rWfdkdahOk9FWDuw/80EAQSckcVE1qBiz9Wgmv1LtOpwZiPs3dMOmP2qT
 hxvazXprI1eew5nIxph0V+YakkiKQ6lw1ZJumfvIr8I+Bj798TaWr3hZAKxdTfjDDVNf0EODH
 7lGfDk/LPWUO7y+Ohe8NyXKtVOQ+AFGRQL0+0T00z/IMPglvM7ZiViijxGzeQAtWtRQ9m8YnV
 i1sviaI3nm94jm8xedRArAIuA/Y9eRTcg1KJhGVmXooB1A5QiJ10KyS1vEhyAjGoENh767Agp
 IQewBQtBwnICDiP+MqdOLRsoU7B5q0KVLN37l05MdwQctQGwKFKpLCR4poNaXQFv8q0V0kCSu
 580M/v35nFkc3X4slRVS3+qIfFnlijH2wzaGySQYxiUukzmiYvvyGpfzqaSoGqJRIdUtcC3gR
 DFSceH2FRdPtubLmgjKycweYrSQepHVTP78ZL0Hv7LpXLgAb9aOfITuZnxHfZ9o0cbkThlDw1
 C1+v4sYnNRCSYz3gBnKXar0zANdhBV8iovrQ651gk65f+9yTygvFNfzjpIs5maIrzy1zkhRNm
 tgWvX3UTvcmE9o525a6ukK5T99TqzI67z7lEJpvAeFts1TkysOh34RKTFQGfAN+IoiMURPxlC
 2CvRQeuueisg4aWchdosIBiSLX/dGcaMotjAZwQy6iFJo0XipEmYNROGR6uXSArIQywt3lMRZ
 rDRO1rGosq9P6adtQyQroB0k5CFLBD6FsTgmXgTEfSAChetd6LluvNd7qMAf11olMom5snTQd
 lw7BoEIa+JWSEVkXpEPN/oOr4b+9uLyswxTGWYN54NsYK6QY+DmDcFV7U2ZaoMUIOWbul4Yjo
 1BXegqTkUYCdUvcACjTYUZoNct4dkFNpb/irhPNZaLpnc5Kfz1yjmKAX2JAGJtqnVnWNnpTs7
 iKEKXPKBXUuFgEnz2fUtByuHrbrEHCMxzMXVkowPvwE1ZVBLBv5FCd9WVXQA6q0vuaWnvLQp4
 lTVdQXoookE0bPsZLc/QxQeBNFjy11oSz83LlZlidA/aMMQosRNs/t3KFlpiGcYfSPku/+qr4
 K/RcRRijjMy7Edmls9frfz39CiSLM5r4S8/xG1JCeueoF06B5M8xWUWoSb8D9wGjy+MnJWMVL
 +/BDhs8ybSbfsF9E3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> To fix this data race, the spinlock mp->log->gclock is used in
> metapage_writepage().
>
> This data race is found by our concurrency fuzzer.

How do you think about a wording variant like the following?

   Change description:
   =E2=80=A6
   This data race was found by our concurrency fuzzer.

   Thus use the spin lock =E2=80=9Cmp->log->gclock=E2=80=9D for the assign=
ment of
   the data structure member =E2=80=9Clog->cflag=E2=80=9D to a local varia=
ble
   in this function implementation.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
