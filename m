Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B46C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D70206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L9Gg824r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgHKIlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:41:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:46277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgHKIlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597135279;
        bh=M9M7qYL8VZFfg/dq2QG/8WazSOytN0i1RiT2ZH3VShU=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=L9Gg824rKifp4DZEmES80yQQS8zjkZ0656CU/rv/kf0AvMpd8mW39dovbcHUbuOOF
         4XjbVV3SkuE3wS+lGgBjiRjnJniin5A78y+LZ7aLW6w9/Rr82k1Au5YRiIjS6tNYCr
         faGOE5KkYDQDGoaYBlPq/c5q2IYvHtwRtWyyDO+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([185.53.41.139]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1k7sgQ1b21-002Xlb; Tue, 11
 Aug 2020 10:41:19 +0200
Date:   Tue, 11 Aug 2020 10:41:10 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAOTY__4Qs93EMjrpK_jW4NsxyZf7w3RHa7vDSRecea_JwAxKw@mail.gmail.com>
References: <20200807082754.6790-1-linux@fw-web.de> <20200807082754.6790-2-linux@fw-web.de> <trinity-f5a5deb1-c123-44d7-b7ca-1f7a8dbe1c1c-1596889651064@3c-app-gmx-bap69> <CAAOTY_9o_hBWxWBdDoeeJ6zuV4rb4R_yEoN5+L0uHBGMw4Kduw@mail.gmail.com> <cefc273c226c93c605f4dc76afa9eb5aacceaf26.camel@infradead.org> <CAAOTY__4Qs93EMjrpK_jW4NsxyZf7w3RHa7vDSRecea_JwAxKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] arm: dts: mt7623: move more display-related nodes to mt7623n.dtsi
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <363F05E9-8D03-4CFD-83C3-1E874DA34309@public-files.de>
X-Provags-ID: V03:K1:ZNP3U6E48qwNApq7w86xi3lRf1wvP7J2P3fv+9MmDvflbc90kRU
 UNDIqQJOtP4hVaiDFfbEwVPzgkHgtgrRs3f+xv1TBSpshhMuXxjpV1UJhr9z/twLft1AurV
 TP41dErgCY9+JWekywsyK+R/hnQAXc1bzVRwzAV9auDSEiemgH1RhIRxJNAsuUjg8TpbQ2K
 Z6onIfvwHsD4BxUOoaRkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+2n+Y8/MXsM=:bnJA+dMMm77ZPibQTsNOPh
 SIKHVzHS5GuhHng9LDWVYEEjf/X5Prbo+PP21597Rd14PoqrJ6UjPZIPfn1CUZzXUJ7gVIXsG
 hu4YDHInCN16n9QC3PnZPfzYm4JWTHwPePbF11V2D+cvcGZ5rfwAgttI5YBPDhD/5OkZ3TRD0
 eoSXXDprqSdeTF8QGwT4TKIc3axA9/KwBGdUd5O7tk9xMfS7LbUNcGK8Xpt0VIcf5jUUJdktm
 jo6L/qfDcwGGpdhj5I8mU6Kz1LBzy/RuaTLnu9bWN53pYvnmJaWsy81ZXyNqBmtIe+LC5N8ve
 BYyJ1VBHzu9pVhBYcnD8lsRkCcJTCgdEMyvN1qaj6zoS19424Z8M7EHcCtkoUDIxZxGaEtbX1
 og3wADu1C1EJJqAVoxXh/kDVANUTpyKP0u4Q/uZpHv2dxRnPp9h4HyyLXqkYe5P/t6rDFGT8u
 6kIHRoWlafywgKE4/3UYD3OYtzH/ZWCeA+1/p8MqAYwjKjdAXRzeYDZ9EYI2sC4VBWHuvClxG
 Yr2VGYqWF3h0vSVBNOAuWowsbFyymfCAVYhzXo8F0j39M3Ij0CSH7lDoBjybCJ+HplVprZTm2
 kw0dCto+tFE5TCG/ola1CV0zhP0x7qu49IZnfBoRgH/dXl6wdA7SY0XKDLh6S9URDDxH2Nu0R
 hXYTE2KzI/5rTacIC0slIw8wda6Y1wRvriuyI/LeQCXLJH3yGjFYvXlkay+2XfVVHR7A5W8rO
 1mLzsM1BPCGfc08rh/CzffmiRJy4pdXcmI3rMF0z/Poncpsy8xjSr6iF1TrVg3Oo9OvYDUHpd
 zfrJPnmhyHVv01mT2hs4LVVuHw4yjJBvMSPBqj0NQmRMLrrbEdZC5EEI22U6BGyWNfqSeyzla
 yeQFyQktRO4+LN6w7z92ZIL16YS9/7Jt6HNNBYLv/o5c7xwb6FIUZoX1hobm8Ymnm1WlkhNZc
 F702YyD8nv6VRYiuLDtHO5vtnCbOSKjF9XUsFeqxJNYK+rKgf6Lk1OyabHVLeGdJ14eqozS4o
 EFrt077igFUDImRaGmM3/RiV2vSZ4CZy/6hpubDgfhWwRVhqi5vmpcSOEWrGbU4KmuVqDt/pY
 Taz0RWvnJT9wU7waFhOJ/h8/kIwMkkO7wO73qOfn/t5KDpsGzA4s08dn8jUjzD+uNH+bbgpZt
 OZyd0bD366jDdWXDJEgAqSkylUzXSCfjOyCLlFrCxqeCx5t5UPuJicTNo0dXps06kKMcjR4gJ
 vtUsWtRr7L7HmLf/Kk7mUqStGI9aldpEP25PrIg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am 11=2E August 2020 01:28:25 MESZ schrieb Chun-Kuang Hu <chunkuang=2Ehu@k=
ernel=2Eorg>:
>Sorry I does not notice that mt7623a and mt7623n are different SoC=2E
>Because they are different SoC, I think the first step is to upstream
>mt7623a=2Edtsi and mt7623n=2Edtsi independently=2E That means in each dts=
i,
>it include all devices of its SoC=2E After both dtsi is upsteamed, we
>could find out what is the common part, then we create a common dtsi
>these two SoC, for example mt7623a_mt7623n_common=2Edtsi=2E (Maybe there
>is a SoC's name is exactly 'mt7623', so I prefer mt7623=2Edtsi is
>reserved for that SoC, and mt7623_common=2Edtsi is not preferred because
>I don't know there are how many mt7623 family SoC and
>mt7623_common=2Edtsi should be use for all mt7623 family)

Afair there is only mt7623a and mt7623n=2E Mt7623a uses mt7623=2Edtsi as c=
ommon part=2E These 2 soc are released 5 years ago=2E=2E=2Eand only these 2=
 from that family)=2E

https://www=2Emediatek=2Ecom/news-events/press-releases/mediatek-launches-=
the-mt7623-and-mt7683-multi-standard-iot-gateways-with-high-speed-wlan-to-l=
an-to-drive-the-secure-smart-home

So from my current pov the best way (to no more delay my hdmi series) is t=
o move display related stuff in new mt7623n=2Edtsi and keep mt7623=2Edtsi a=
s common=2E So we can avoid touching mt7623a=2Edtsi for now (can be done la=
ter if really needed)=2E
regards Frank
