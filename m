Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8384C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12C120772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQBKvhc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgCaUdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:33:16 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33505 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:33:16 -0400
Received: by mail-lj1-f179.google.com with SMTP id f20so23478008ljm.0;
        Tue, 31 Mar 2020 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lShPZxhYmYKIxn9HZ21opBqSt/h6p0BHD/YYoVt0O6Y=;
        b=RQBKvhc3u0Nhb2lLvppi4N79yYa944hBQPGlB+L4hj0AEKhvZNVA42PVGAhWv564+d
         mbM+VCg1x+Wg314JZ0Og11zqSX9EjL1C4ZI/EF/hfm5idRjBecq1sw8eztp1/PGItaeG
         /mRJwLHzXjtsIITo/Yuh/K4BWeORJddez2OSwuw8912AN2Fw0xJ8yf13CZaSQ76WbPpf
         +vIvX4Vgho++utEkWjcQkmOeP4ZoxyivL8Qyy98hw0HeDJdpEGa9kZJeWf/gz8lfPFI2
         OpAY/EOuJkq+8SUhhaXUBVWzjd+phDD1LTX9H8E297XvE+l5vncJnPE5OYdAUnk/yhiT
         hkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lShPZxhYmYKIxn9HZ21opBqSt/h6p0BHD/YYoVt0O6Y=;
        b=D8PhFge/PNVaH6muvzDd7fx1UOzkjydQ9LDMK5o3EgqthbvQG/i7iv+ginKoS26Z5U
         8HxzGuFmbjyzVVY1JfDJh+AsJCnsmyR+tIK15HQr4agRpLtu7AduANSARmjV4hcJIYwj
         jbHYhQEMNonoJGV2+7DrErkzPQ+6HwJEdp5Ux1XuUaFvCni0CTMQlzjlRzL01Uo+UrFr
         2hZdyB2d09343sNuQJw84cEcYeyDb3T9oyCx1d9s/cKYBjgYJhXE0S0YZz9C82hBJaFQ
         b+eM8eopcgToUZmytgzPEDP0rGL3c3iYrrjX1SBT/8AcbS0R/MLd5QajBtufXfcyTHtz
         HRvA==
X-Gm-Message-State: AGi0PuYRNN/b2kdgClA/YkFAnZ8KzK5DXeCy5y9ZgJnDDmK/KI4+BMia
        /jq0PdwClvmRqF5q/cBzhkq+SfPQqpruZbCqebs=
X-Google-Smtp-Source: APiQypL9Ipre8TYKspmzX1YW+qdEGC4l1xDR2LSmRhJqreBFH4Gh/aHgcWcKDbJlMwBaSFTyNRo9JoQb/vDfy2wjpWc=
X-Received: by 2002:a2e:b1c2:: with SMTP id e2mr11666246lja.288.1585686793666;
 Tue, 31 Mar 2020 13:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJSKH-gXA5ncFS3h6_2R28rn70O3HfT=ActS1XVgCFSeg@mail.gmail.com>
 <DB3PR0402MB39160D3F0D03B968B7CBE25AF5CD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAHCN7xJ2m3LRB3oGBb5QKbacYyTBQK1CdzGcTh3w=hj18H=4Pw@mail.gmail.com> <DB3PR0402MB3916B68A1B0F37EA34825F69F5CA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B68A1B0F37EA34825F69F5CA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 31 Mar 2020 17:33:03 -0300
Message-ID: <CAOMZO5ABmK9LLOafmChFeDnTzrDTKgqfwLNe08bR1Yo8iA1G0g@mail.gmail.com>
Subject: Re: i.MX8MN Errors on 5.6-RC7
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Adam Ford <aford173@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Sun, Mar 29, 2020 at 12:29 AM Anson Huang <anson.huang@nxp.com> wrote:

> I am using our latest u-boot and ATF in NXP internal tree, maybe you can get the
> latest release to have a try.

Here is a complete log that shows U-Boot/ATF version being used.

It successfully boots imx8mn-evk running linux-next:
https://storage.kernelci.org/next/master/next-20200331/arm64/defconfig/gcc-8/lab-baylibre/boot-imx8mn-ddr4-evk.html
