Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 00:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1092070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 00:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597018002;
	bh=R4aysq8cb7E0lt1g+L7QoE7drym+sqAlY7Kl5ewT9W4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QOZQ/X5EDhbM7Q9rXFyoMOYKgBfCzIkYJz2L8KEgaHbzedTyqUL9FBP6kwKW5pcRp
	 no6zc4blax4wAAfib5OwsnxedCE6W16RD3rohlOzuFqzU0BVgZlAcjN+bfr62mbABA
	 04qsuOLkFgSK65CT+fAc7R3Kz4sHTiJVkmGS12jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgHJAGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 20:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgHJAGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 20:06:41 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC032070B;
        Mon, 10 Aug 2020 00:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597018000;
        bh=R4aysq8cb7E0lt1g+L7QoE7drym+sqAlY7Kl5ewT9W4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PFJUK4RboaUyQadDQQxPBwd2mWFx5eqi8vYU/1ln23GMqVDmgxMjmS8OiCE5deT3T
         3jL6lR41OYOSmVjW7gbdLQs4YANUBtRuawMrQz6qjssK0V/MZ1bA1wI7barj0aKoPP
         oOqZccr58IG6qLu1rgsAHBxZYdck4+UEHXlk0n0U=
Received: by mail-ed1-f43.google.com with SMTP id a14so5143136edx.7;
        Sun, 09 Aug 2020 17:06:40 -0700 (PDT)
X-Gm-Message-State: AOAM531aZqzbWlvlU+JyNk3zsiWHXygUB9R8hDg4+zU9UkIS/4L+fi05
        WNjBRDhbyVUoNJxyZQis64lJfEqumwL+mUzPlA==
X-Google-Smtp-Source: ABdhPJzs3hNq441TdiNg5sGMfiRejhS75UfI9CWnqxJ5HqFTUExR+ocEV58lXwZry63RX+M/RRZzyTn/TlCXxBAyudU=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr19470902edv.271.1597017998978;
 Sun, 09 Aug 2020 17:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200807082754.6790-1-linux@fw-web.de> <20200807082754.6790-2-linux@fw-web.de>
 <trinity-f5a5deb1-c123-44d7-b7ca-1f7a8dbe1c1c-1596889651064@3c-app-gmx-bap69>
 <CAAOTY_9o_hBWxWBdDoeeJ6zuV4rb4R_yEoN5+L0uHBGMw4Kduw@mail.gmail.com> <81DFA743-B455-498F-B2F2-161DD9D51F57@public-files.de>
In-Reply-To: <81DFA743-B455-498F-B2F2-161DD9D51F57@public-files.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 10 Aug 2020 08:06:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-DYsbAWkdKfiGeJOwmPUOO1T+6WmOmhDQEUbzoRh+KPw@mail.gmail.com>
Message-ID: <CAAOTY_-DYsbAWkdKfiGeJOwmPUOO1T+6WmOmhDQEUbzoRh+KPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: mt7623: move more display-related nodes to mt7623n.dtsi
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=889=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=883:22=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
>
>
> Am 9. August 2020 02:16:59 MESZ schrieb Chun-Kuang Hu <chunkuang.hu@kerne=
l.org>:
> >
> >I would like to put all device in mt7623.dtsi with some device's
> >status is "disabled" and change its status in platform dtsi.
> >I would like to see all device in mt7623.dtsi because of its name. If
> >you move some device to platform dtsi, we would trace all platform
> >dtsi to find out how many device in mt7623. One day a new platform
> >enable different devices, you would reorganize all these platform
> >dtsi?
>
> Ok,then i change the dts-patch from hdmi-series to disable all nodes and =
enabling them in bpi-r2 dts. Do they need to be in alphabetical order (or a=
ny other)?

Alphabetical order is better.

>
> Is the tmds Patch ok? (because review missing) https://patchwork.kernel.o=
rg/patch/11700679/

That patch looks really like a hack patch. I would wait for a long
time to see whether any one has comment for this. Or you could have a
better explain for it.
I could apply other patches first.

Regards,
Chun-Kuang.

>
> Just to know before reposting series as v5 :)
> regards Frank
