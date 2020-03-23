Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C255C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E942072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCWImS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:42:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCWImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:42:17 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mlvmv-1jhcr52Vwh-00j0KX for <linux-kernel@vger.kernel.org>; Mon, 23 Mar
 2020 09:42:16 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 633BC6503F9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0GpatPY_6o_p for <linux-kernel@vger.kernel.org>;
        Mon, 23 Mar 2020 09:42:16 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 0D9A064DC5C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:42:16 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.4) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Mar 2020 09:42:15 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id C14E8804FB; Mon, 23 Mar 2020 09:40:11 +0100 (CET)
Date:   Mon, 23 Mar 2020 09:40:11 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
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
Message-ID: <20200323084011.GC4298@pflmari>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXiG1upHQrCcuZgNLFOEoeDVcb0zWxh1BZZST5TOURDBQ@mail.gmail.com>
X-Originating-IP: [10.8.5.4]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7066
X-Provags-ID: V03:K1:FXAA+aqJw8KBduUOzfDxvUDAkxF0D3QXU8R7mOo9/ob2aSWdg+l
 uGc6+CGe7YWKso8Qqv/kP7WEp4020FR0Wbq+DkWLrnsSqdMUCkWGOn3QJ6BpBylhVmoXg6O
 SHHybdVEGNl2Twc0jxITWc0b3UVNHjK1ma8c7j8+oTDwLWMWXHAYi5gWuxmp0PigmoaDIXh
 YwauBc9pNY1QNFvSEZTkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4HbRlU92+u0=:LzSMmUFlaeFcHo24Kl8NZ3
 RqaQ/kQhS3rQgQ0LbB9kIllMaVEXZMJIELLSue4Yw2c0NYj8XLWHqfp79Ab/WW07ncdAlmvKM
 /lKja0Tp4M1V0ybmiw13FaKNNNZZc+ZfKCUFn69tt1LrT2GyYCULK/chfgVUMTUxb3PNmrRC0
 4kkBCsHHFv9F4HdoXbuz7YIgPXP5vg0Z9dGdjx7e305bE0DkyQ4Eis3cQimxzsn/4s2mmEOQC
 ESAZ2BxrNn046++aC4Qq0d6dEiHLu77nNwfTzMEnL31ivxDDhlmXcBTKdvlJmL4LjVrNZyhMV
 uJ+yUNk+ugbCyj5vOo6O/71tRQwHuOAZMswMg7Ycyp8NhImQZ85J3FhSXDfDQB8MxaLJleFGe
 oZXKSMHf02UrNl2dFU3QhBkGErk0rD5nWQ4hosD6oB3cZFfZIqOV7JQ/Ws4Kxt2409mDHzhNY
 OkuZuzu/kj93TYMFePPy7563GBSdAMoE7FCdaPCu3BlX6rkaT2YGAlWDKwds3ypK7WS68BzQt
 07YH6pDkWRaKYDgTORnZjRm3Sa+HIkhGanjWxRybSzUMnkiJ8n7eXm5y4gOGwUcc3OLNlLzHD
 riayD0I+zGcd/BdlCtUFISmE9CmikLY9HV+Q21BJHt6Am/WYdSU/S78Gxjff8FWZELiAQYuK4
 H4QvmnVPf4Ztyq+Zo2qj+ifPKu3HXLJ3AYZkb24Q114WIyI7e404sWwsCMmw8vA9cOW9OhXsm
 EuvVFOEzbmEfp5+oqHVBrtAnbWr05EW+isHTtJ0nMS9SfD0T6vtPBmi+qr6lwSdQ3CmGqbYRI
 Z+29O3dlOuSaqk3wvkNbV7l5kNtzQYPOOenC+03uZ2kVyjwUU+pK6moHrNWx3hAR0GbvQHj
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven, Mon, Mar 23, 2020 09:34:45 +0100:
> On Fri, Mar 20, 2020 at 5:43 PM Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > As all known variants of the Salvator board have the HDMI decoder
> > chip (the ADV7482) connected to the SSI4 on R-Car SoC, the ADV7482
> > endpoint and the connection definitions are placed in the common board
> > file.
> > For the same reason, the CLK_C clock line and I2C configuration (similar
> > to the ak4613, on the same interface) are added into the common file.
> >
> > Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Did I provide a Reviewed-by?
> 
> > The driver provides only MCLK clock, not the SCLK and LRCLK,
> > which are part of the I2S protocol.
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Perhaps you mixed it up with Laurent's?

Sorry. I actually did: he did provded Reviewed-by in his email, and you
did not. I was ... a little overwhelmed.

But you really did provide a lot of very useful information and it did help
to improve the code. Shall I remove the tag still?

Regards,
Alex


