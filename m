Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B06CC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189DB2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgCWHiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:38:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50743 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgCWHiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:38:07 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFbiK-1j2WHe2D0Q-00H8ym for <linux-kernel@vger.kernel.org>; Mon, 23 Mar
 2020 08:38:00 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 514C56503EB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 07:38:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z2kghf3aGAbn for <linux-kernel@vger.kernel.org>;
        Mon, 23 Mar 2020 08:38:00 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 026E364FD76
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:38:00 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.4) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Mar 2020 08:37:59 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id A763D804FB; Mon, 23 Mar 2020 08:35:57 +0100 (CET)
Date:   Mon, 23 Mar 2020 08:35:57 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] arm64: dts: renesas: salvator: add a connection
 from adv748x codec (HDMI input) to the R-Car SoC
Message-ID: <20200323073557.GA4298@pflmari>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devel@driverdev.osuosl.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1584639664.git.alexander.riesen@cetitec.com>
 <ebda055ae4c898b4ca29e518f89d8f3f4be4d27c.1584639664.git.alexander.riesen@cetitec.com>
 <87fte0lyjz.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87fte0lyjz.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.8.5.4]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7066
X-Provags-ID: V03:K1:1m39TC+xvYay9EOt5SXaUcUUiMq+opHESLAKllgh6X95/CkPYwA
 btyUONHbiRL1e+BGcA+wg3QKq42nqjMcqmT4z6I4D1hZSvugC9P+nC6kvwLN/ziO760yM0L
 w/B60MEhPff9+OOtcPofX7d+ezCWj7DLQ6ODwSWKHqyqoRUUAEIg+9FxuGdUEZEgeX5HIm6
 eDULk5R9WhDgJuZA/CEsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xX6rdB/4Zic=:H0JnF3jy3yd8szn/4Q3hAE
 vxueHIP/VeFkrfyz98SYkx+M7AOaAJSGq1YVdOmEoiJLFL4YIaaju4968iTFabvI7uOKlYNBf
 z7G4GAAfWXFeRGrdpydipMPI+x16tKrm01Wgwvg/Sjw4UwiBvac40xTZS2UtIdK2Yrc7G82fo
 ucfeotw4c3uHHey10Ayjbb9UUFN06Vfh2z7kZGzO5h8P+iqfQj9hu1JhGRJ5+EBscIwIKOAXw
 eb/DECQfEMdZ/ej4rVDJAxlDnTgM+5QvyhqjtcDDWkHNfbL61lMPyypJrm9Q4QsXrfW3TWqL6
 AbqcmG1/TvEEEKpYyyWEq43/usQZ4RetjywFjreafUkzkqXPOGV0h99JRPq665bIzJN/vB83s
 mnsthAVxuE7gmK5Bk7qsTPjesHdvWwryraWHcXJubIeOd9vnMdCOpL5OKpIR59t44u6Q3nv/H
 Wz94OglBl6+KGZAtDs+SUooZZreWbImDVvUdMSgZB92p/OBfJNUm+bp6gedoG9UGhOnLKF3+i
 UtVhvwuId14xQsEc7try0/EYpWt42Im7jBTkmqzCIOV5ucGwxx3UQAYNhZbzW3udwRNPEN4l7
 oDUwC5fhFiQIv1CXLzxf1r03hvCtkr3DMt73V7Awvlp8M+SGR8K8Mm07FN4l+lmEVGuehkdDX
 CbbQ77Gya52U23EW1QBnwtaRJyFDd4ntZJ6PNFPNZ+YjEZuj4LVFg7ySVrQ3OShDiJ4WPhaPF
 yca8EEyQ9Zb14hZnxb1oyOeNjByET7rf+Utb8s2plw2R6UNEfxtR9wcGN4u+vqbYbIciXEFkC
 v+ozeqaF5CC4OgYorQ6CXM9ZA2QFltQU6Kw2+NJ6jNdQQmz23FWBlUVy9bOAa0zZ351YZk/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

Kuninori Morimoto, Mon, Mar 23, 2020 01:12:00 +0100:
> > As all known variants of the Salvator board have the HDMI decoder
> > chip (the ADV7482) connected to the SSI4 on R-Car SoC, the ADV7482
> > endpoint and the connection definitions are placed in the common board
> > file.
> > For the same reason, the CLK_C clock line and I2C configuration (similar
> > to the ak4613, on the same interface) are added into the common file.
> > 
> > Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> (snip)
> > @@ -758,8 +769,19 @@ &rcar_sound {
> >  		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
> >  		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
> >  		 <&audio_clk_a>, <&cs2000>,
> > -		 <&audio_clk_c>,
> > +		 <&adv7482_hdmi_in>,
> >  		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
> > +	clock-names = "ssi-all",
> > +		      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
> > +		      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
> > +		      "ssi.1", "ssi.0",
> > +		      "src.9", "src.8", "src.7", "src.6",
> > +		      "src.5", "src.4", "src.3", "src.2",
> > +		      "src.1", "src.0",
> > +		      "mix.1", "mix.0",
> > +		      "ctu.1", "ctu.0",
> > +		      "dvc.0", "dvc.1",
> > +		      "clk_a", "clk_b", "clk_c", "clk_i";
> 
> I think you don't need to overwrite clock-names here in this case ?

I vaguely remember something using the names and failing to enable clk_c
without the list spelled out...

I shall re-test though, perhaps it was my own code (since removed) using it.

Regards,
Alex

