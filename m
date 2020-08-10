Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4170C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F4C206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597102121;
	bh=z0r+lCZYPiccixe3QpsKbupOQvldS1z/zwKsOkfGnbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fg6GT5DJ9JsAes+I82H3IV7jXgvNbkiu5T7UljKRo7W89g51olMb4wEyj96+ZWCF7
	 Qc2vFLqb2vmUlJsSgVDqx3YzvDgwPXP1g6lQarLtZBVefrvZoW8rB6F8jvG5n/J2r4
	 k6bckdf9mQEBibgyqovw/XvNhO2uRPfIoQYF0bPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgHJX2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgHJX2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:28:40 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4117220748;
        Mon, 10 Aug 2020 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597102119;
        bh=z0r+lCZYPiccixe3QpsKbupOQvldS1z/zwKsOkfGnbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tMtC168Bnm85aHCmeS+xFlUQehFiZbUw8MhBWzmR+rX9oXkBTJ9+6sjcAGUs/ol6B
         VuYqe1fumGkUlr+mxa3T/EuBk1y2t1nTxpQvBKSzP90oJ3cNI5r3pdhOO61Z0m5ri8
         b1WJ4rR5P8XSyYq0Q+bD2m2pLDXcvF8KQ7/6ZfEM=
Received: by mail-ed1-f50.google.com with SMTP id bs17so7681185edb.1;
        Mon, 10 Aug 2020 16:28:39 -0700 (PDT)
X-Gm-Message-State: AOAM530/Es6M6rZ2sGTxSIK+AELd0zZIKYLiMzuJOHuHbSAxEJKUbWQi
        siz6uxEYpAKaSwfb0r9gJomCSuMNRDyK8saF2A==
X-Google-Smtp-Source: ABdhPJxj39TNRd8PZmBPNLHQXvrBc9ZMP5IPGhmxFpa1bdCoTDN9dM+s7gqXWNb3Zrxm/Il68M8rnUnavB35d/xb8W8=
X-Received: by 2002:a50:d80b:: with SMTP id o11mr1986679edj.148.1597102117741;
 Mon, 10 Aug 2020 16:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200807082754.6790-1-linux@fw-web.de> <20200807082754.6790-2-linux@fw-web.de>
 <trinity-f5a5deb1-c123-44d7-b7ca-1f7a8dbe1c1c-1596889651064@3c-app-gmx-bap69>
 <CAAOTY_9o_hBWxWBdDoeeJ6zuV4rb4R_yEoN5+L0uHBGMw4Kduw@mail.gmail.com> <cefc273c226c93c605f4dc76afa9eb5aacceaf26.camel@infradead.org>
In-Reply-To: <cefc273c226c93c605f4dc76afa9eb5aacceaf26.camel@infradead.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 11 Aug 2020 07:28:25 +0800
X-Gmail-Original-Message-ID: <CAAOTY__4Qs93EMjrpK_jW4NsxyZf7w3RHa7vDSRecea_JwAxKw@mail.gmail.com>
Message-ID: <CAAOTY__4Qs93EMjrpK_jW4NsxyZf7w3RHa7vDSRecea_JwAxKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: mt7623: move more display-related nodes to mt7623n.dtsi
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David:

David Woodhouse <dwmw2@infradead.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:48=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Sun, 2020-08-09 at 08:16 +0800, Chun-Kuang Hu wrote:
> > I would like to put all device in mt7623.dtsi with some device's
> > status is "disabled" and change its status in platform dtsi.
> > I would like to see all device in mt7623.dtsi because of its name. If
> > you move some device to platform dtsi, we would trace all platform
> > dtsi to find out how many device in mt7623. One day a new platform
> > enable different devices, you would reorganize all these platform
> > dtsi?
>
> No, this isn't "platform dtsi", surely? This is mt7623a and mt7623n
> dtsi for the two different SoCs, and platforms then just include
> mt7623a.dtsi or mt7623n.dtsi as appropriate for the SoC they are using.
>
> If you really want *all* the nodes for both MT7623A and MT7623N chips
> in a single mt7623.dtsi but disabled, could we still have mt7623a.dtsi
> and mt7623n.dtsi for the chips, enabling the nodes that are only-for-A
> or only-for-N, so that each platform doesn't have to do that for
> itself?
>
> Although putting those nodes that exist only in one chip or the other
> directly into the mt7623[an].dtsi still seems to make more sense to
> me.

Sorry I does not notice that mt7623a and mt7623n are different SoC.
Because they are different SoC, I think the first step is to upstream
mt7623a.dtsi and mt7623n.dtsi independently. That means in each dtsi,
it include all devices of its SoC. After both dtsi is upsteamed, we
could find out what is the common part, then we create a common dtsi
these two SoC, for example mt7623a_mt7623n_common.dtsi. (Maybe there
is a SoC's name is exactly 'mt7623', so I prefer mt7623.dtsi is
reserved for that SoC, and mt7623_common.dtsi is not preferred because
I don't know there are how many mt7623 family SoC and
mt7623_common.dtsi should be use for all mt7623 family)

Regards,
Chun-Kuang.
