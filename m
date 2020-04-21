Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3975C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21D42098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587457805;
	bh=wuc3jx6PfRbtja5FaljDspMeSZne9nEnpk9fXRv7ORc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OEIuC24B8j59MLMsHzTeRYG8EXvfjBkEXSeQ92HhCdzxDBL4lbAiGD627h36qot2K
	 fIKbyqSiLOusp+iej5q3APzdaJ1qY7JZ2yed5VqHVXnkSGmGKkQ6p5yhDFlSQRPSLw
	 2WKbvHZKWpkWjjcXuIzr+imgorEhQFPC3HOXDOaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgDUIaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgDUIaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:30:04 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAC12084D;
        Tue, 21 Apr 2020 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587457803;
        bh=wuc3jx6PfRbtja5FaljDspMeSZne9nEnpk9fXRv7ORc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cBeTasdd+HGRg0i1aoz0FlXhSMkbkVJHNm1tkH7EIUqH88VFxxEhHaT/HyGtNhADR
         ql+7BURcZ7j0xbG2ePO7UGVzBFkZP7U1XA81ccNdcmlE+qQNQdg8xn0dBlnmIEtW+R
         WZpO1nF1wsmSWJIohvDpWcDtVHNIkB/n4RkaPW6M=
Received: by mail-lf1-f47.google.com with SMTP id x23so10415992lfq.1;
        Tue, 21 Apr 2020 01:30:03 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ3KuF+M6eEnP1d7iEmmkouAXxWDEAgG58CbqThHeAiBJkfnjoJ
        Zg070cAbwidlOni4lYde65ld4oSj93n/o0Fu0iw=
X-Google-Smtp-Source: APiQypKroxytzJbwhdWevuEF+uOt/g+//e8nKL3ioSPIf4DsbVu1D4JJAdVWzgBa88oLLtktr4riRTPrKW6asxMnkh8=
X-Received: by 2002:a19:f206:: with SMTP id q6mr13560133lfh.85.1587457801468;
 Tue, 21 Apr 2020 01:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200416181944.5879-1-jbx6244@gmail.com> <CAGb2v67N6t+C8dVKdjuOv1NzD9=3-n0GZQkshy1Pm6PFPJ87dQ@mail.gmail.com>
 <2710874.PL6qFFFsBp@diego>
In-Reply-To: <2710874.PL6qFFFsBp@diego>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 21 Apr 2020 16:29:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v67vV2Bxff5Gj1R8Qx3Cj+nzA5ine12hoXbhGP5Z+S7=UA@mail.gmail.com>
Message-ID: <CAGb2v67vV2Bxff5Gj1R8Qx3Cj+nzA5ine12hoXbhGP5Z+S7=UA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add bus-width properties to mmc
 nodes for rk3328.dtsi
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 4:23 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi ChenYu,
>
> Am Dienstag, 21. April 2020, 05:48:52 CEST schrieb Chen-Yu Tsai:
> > On Fri, Apr 17, 2020 at 2:19 AM Johan Jonker <jbx6244@gmail.com> wrote:
> > >
> > > 'bus-width' and pinctrl containing the bus-pins
> > > should be in the same file, so add them to
> > > all mmc nodes in 'rk3328.dtsi'.
> >
> > Nope. First of all, pinctrl usage is with pinctrl-N properties, not the
> > pinctrl device, and there are no defaults set for any of the mmc nodes.
> > Second, these are board design specific. For example, boards are free t=
o
> > use just 4 bits for the eMMC if they so desire. So this should be in ea=
ch
> > board dts file. If a board is missing this property, fix the board.
>
> you are correct that the pinctrl entries are missing from the patches,
> bus-width and pinctrl should be defined in the same file each time,
> but for the whole idea I tend to disagree.
>
> So far every board with a Rockchip socs follows Rockchip's reference desi=
gn
> for a lot of parts - for example I only see sdmmc nodes with bus-width=3D=
4
> etc.
>
> So the basic idea is to have default pinctrl settings for the settings
> everybody uses predefined ... if a board comes along that needs different
> settings it is free to redefine that.

I think having a default is a great idea. :)

ChenYu
