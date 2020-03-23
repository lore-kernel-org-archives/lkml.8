Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFFC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9432720736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgCWIru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:47:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgCWIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:47:50 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MSLhm-1inboK22cy-00Sc1j for <linux-kernel@vger.kernel.org>; Mon, 23 Mar
 2020 09:47:48 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 4C96E6503FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oh7xj93cHGVg for <linux-kernel@vger.kernel.org>;
        Mon, 23 Mar 2020 09:47:47 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id EF12265023F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:47:47 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.4) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Mar 2020 09:47:47 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id D7DA3804FB; Mon, 23 Mar 2020 09:45:43 +0100 (CET)
Date:   Mon, 23 Mar 2020 09:45:43 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] arm64: dts: renesas: salvator: add a connection
 from adv748x codec (HDMI input) to the R-Car SoC
Message-ID: <20200323084543.GD4298@pflmari>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <cover.1584720678.git.alexander.riesen@cetitec.com>
 <077a97942890b79fef2b271e889055fc07c74939.1584720678.git.alexander.riesen@cetitec.com>
 <CAMuHMdXiG1upHQrCcuZgNLFOEoeDVcb0zWxh1BZZST5TOURDBQ@mail.gmail.com>
 <20200323084011.GC4298@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200323084011.GC4298@pflmari>
X-Originating-IP: [10.8.5.4]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7066
X-Provags-ID: V03:K1:mG8qDdG46eZt0YIdCzBfuKDxpiKUwyPumOi/GoU3CKPhfPllCBx
 UFtngEXsxFcybqe1Un5RC3BpGRz1r33AOMbnLW6ICC6gh3LHHduOf27Lf8N/jeED5a3uBBl
 m/iljxfkOIrH0rGrn26ktHU8NDQsd0KXi/ZttN9NM2RynmeOJArGkiTdhoRiGMrq7npMBcd
 /WbhTQH0lU7j6aVwdNv9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7i9DDpY8QzM=:yRRGzB1u6HtwLMutppyMiP
 5CbtJU42YJxkjNlX0ZPd9TocmKW5PN/rHoXBCdd+f/gLjhxp8r/PxY0LuzmdGUYfkhpcSqHv2
 RF5g1JCEGleNaSc6mzJ89eapxsnPvJJjqkihWbaYG2d6XbahN3mqqaFJmF8c4zOUbR7csDaxg
 Qyy58Pm0R9uPznQdI7vePwZwhwu8ZsMBsJScgDta2XkGXhqVqXs1/kLShYoF2/Byn0Oq/89pD
 vXrbXS1KrgRTLodYeYj38p73B0EQMC2iEYv3XnxXBaLFFFNJRW/i8ZB1s2NXfsbMvS2DB4zov
 Eu64efXhgdGBW1F6TNlATkbU7lpANW2Q+Oa+AeLX/o8fXo/5Vgsc7qdvxm9pinyaKjYiAYmGu
 OUET6TAg1CyKmtAZBCWmyni4Lv0JswvELecfEJpdi43QXKVdgmOlP6pov0jLyvnRe0jT4PfgZ
 nnNrqyIES/hyJCJGVzO116QJTRgiXltkCdw8LSla1JDhPzPGobrRoO1gElrIaVL4zr1jini64
 Wi9zmTf/gt+DZj2diUvVsYeaLbU+kaf7rsS6WHA3CBiGejpKJXv4Oc0RWsbHhBA6UcHs96mTw
 /ilh9v3yXD3I6BSwxMnAXl6TSQ3FUxpiqNbJGK31ILN4WewalBBj54+JiE3jTJwo9i6F5gWZJ
 mfz0D4fUPMKvX3xllOZ/pJxnNYxRFddQd4KFdGsL5lKm3zFif5n4CTWN4RZUsQp8A8ap5e0Ku
 7a+dAtJSOuqP/dX7/Lo+cTLVPy3Z2nNaRqebBE718enM8/0AIwNQeub936j2+nGklyiOHhqfT
 0s3k2lThk1fgN7Aheo9t+OypE99g9Xo0JAa+kR2Gwy+6SYjJHKaIdlglFgemo1aa6ukCmGg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen, Mon, Mar 23, 2020 09:40:11 +0100:
> Geert Uytterhoeven, Mon, Mar 23, 2020 09:34:45 +0100:
> > On Fri, Mar 20, 2020 at 5:43 PM Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > > As all known variants of the Salvator board have the HDMI decoder
> > > chip (the ADV7482) connected to the SSI4 on R-Car SoC, the ADV7482
> > > endpoint and the connection definitions are placed in the common board
> > > file.
> > > For the same reason, the CLK_C clock line and I2C configuration (similar
> > > to the ak4613, on the same interface) are added into the common file.
> > >
> > > Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
> > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > 
> > Did I provide a Reviewed-by?
> > 
> > > The driver provides only MCLK clock, not the SCLK and LRCLK,
> > > which are part of the I2S protocol.
> > >
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Perhaps you mixed it up with Laurent's?
> 
> Sorry. I actually did: he did provded Reviewed-by in his email, and you
> did not. I was ... a little overwhelmed.

It's even worse: even Laurent didn't provide his Reviewed-by for this
particular patch (it was bindings). Corrected.

Regards,
Alex

