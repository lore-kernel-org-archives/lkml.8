Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E641C206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="S3iC1Yb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgFDSsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:48:43 -0400
Received: from mout.web.de ([217.72.192.78]:38895 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgFDSsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591296500;
        bh=Q1AXMZK8PtFx7kYNgVwlx0o4/ubYO/O0mVp0OLQDl9Q=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=S3iC1Yb5AvOFgTcY8hHOMnJ52Rl/iYkr75/ROueE+VmejA7AOQhwETDcSumLSMSKj
         lFyCEdpF/1081M32j//T12xwGyKwCH4O8U5NlZ7wCpfpzXyfq68M1Wex8JVid+pTgz
         QFMcyTCdh6+/9HccLOwEpDgefTyg5Dyia2nh4Yu0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav2X-1j5wP11Ep1-00cG3B; Thu, 04
 Jun 2020 20:48:20 +0200
Cc:     Alan Tull <atull@opensource.altera.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Kevin Hilman <khilman@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: socfpga: add missing put_device() call in
 socfpga_setup_ocram_self_refresh()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Yu Kuai <yukuai3@huawei.com>, linux-arm-kernel@lists.infradead.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <22cf7c59-f689-f475-2170-48df94f671ee@web.de>
Date:   Thu, 4 Jun 2020 20:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Z3+YlAGRAbKA9DiohrfMek6xv9YDSe/m+V9NaGngCOHJbZru0iS
 2heCToRLmhg+cW4z0EanzWOfyMMIfSn1ZteQWvPrS8bPvA+VCZ0rKgvcTPqf6/EC5m4Y2/d
 EIt+c1mmkN6BETQDtjEWXZQLB6iLCQYeo2meCMFeEqiX2eFU6GKbO7CRyuxQSUeJdQ14mNo
 g+sim7/RVFTaIm1dvJbFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oo8LLglHASI=:hG3IceVOBbdxy9ktZWLt6B
 eUTmksTiayhlf0LPlHvM2L5cUDXdqJxAg1xkkj+50LFUe7XZVoAkwKJTUqUZBbsLD8/fnMjo/
 3bDNIVM4WzoNWS4F5FMMebKvjEPsAlfa7X0f5MWU3jJmMo/0Rlpp1NUB1KO2wweUCyzJ58HNY
 FGkCQZ6I4iEYvB4IngbmFNXHdKEMUDHFp7rdTiiFtM86lqji0VcNYRnO2SzEbCbz/FN5jVuwE
 ogDkFeQbHfUxMUTQri3iyCymv7ukRpeqMVd4MpR9PycCmz8agfCoSlBjSemFJMEqtSrv0BIm0
 vz26J5lNNIo7TI/yD3U6kBxX1VHycWmHdMPKXXPYj9JHlO6A6cwTGDAkwsG8qSEM+9IIWRVsq
 grf8vZDQ9lubny2V5V94JnPej3Me0QV0r/FSWFbi8Gc+XEb+GnwbrrujFTEzPb+hxtnJV4fZF
 z+KVlpEzLUPoZ5PErhUpy2X1/WOqUuuOCoQpTRWCjRRC8sv2LiDm+0/1QPJ8UzzWY3npUCRqr
 rGMGC5CN4RSPiDnUvyxX6mrEvXfnKNXSd0CkkKLaRMnYeWxEKuN00RessdplyTUx+ZXSJ5Qx5
 Wlwvx5r/awl/DOxPOdGwQbQORm6l4Hpw3zX8yQhtoJjGYARv2OOlxcuLmHS2KTkOWqttNzR9a
 qlmPVFF0zSDg9ae5ktdwlR9cYe/wfwPK2t2Y9igkIJCzVB2BhHkQV1bQUNeRZmehq/rDiyPs0
 C1dGhBS8tIN0hX11kj04hxj/l4n950+56mscjsHYEzhUNF87DBq6FfIg7tdteNPYYLnHfHUXw
 E+/Az04mcPDThIDNdVDEPV6772jmpmA6qkzmlDPb5bbJjEtw/PIMZWEWJ1jp6f29craUduVJW
 5WuhsXCchVayREVkKDJMAIos2lDm5cupJb9E563eiKOqH83Q1nZ9nmmjuk5dEBLcU2st+Twx5
 hzbaSzRv2otf729zgnFP2A5vNHBm9VpVeqIWJ/ws1Z8t8V58owGrLS0rA0fUm8R/TYPvokDD/
 G7QbgSjXnK9s9tLx0fIOiI2FOEIVLU4r1N+oGlBfUwriuFIh6OKOeKvyVqekP4dxO4STIngtO
 VXYzWOLz6qIesvcEfrI7EZOHNBjCKzFGOw++y1JwOV/qcu6gTJ6spNiqQ/pqNzXfW5i3FANeL
 HIIzjfn9HFThNtYJLvdTQMBPpunwtNXKBVYbaxQTFf7qcLZuQVWLifmL5mMoE5o8asZhmjOD+
 /0c7ATVDYJtxYQ1bq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> if of_find_device_by_node() succeed, socfpga_setup_ocram_self_refresh()
> doesn't have a corresponding put_device(). Thus add a jump target to fix
> the exception handling for this function implementation.

Do you find a previous update suggestion interesting?

ARM: socfpga: PM: Add missing put_device() call in socfpga_setup_ocram_self_refresh()
https://lore.kernel.org/linux-arm-kernel/c45a8e00-3fc9-adba-1a46-5f2c4149953e@web.de/
https://lore.kernel.org/patchwork/patch/1151166/
https://lkml.org/lkml/2019/11/9/156

Do you propose to adjust the source code a bit more?

Regards,
Markus
