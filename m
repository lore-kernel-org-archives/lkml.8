Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D434C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AE420675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCINAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:00:20 -0400
Received: from web2.default.djames.uk0.bigv.io ([213.138.101.246]:35650 "EHLO
        web2.default.djames.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgCINAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:00:20 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171])
        by web2.default.djames.uk0.bigv.io with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <chris@64studio.com>)
        id 1jBHTy-0001A8-De; Mon, 09 Mar 2020 12:26:06 +0000
Received: by mail-il1-f171.google.com with SMTP id a6so8453772ilc.4;
        Mon, 09 Mar 2020 05:26:06 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0vDjedDN3M86CIrGmIlQ4QoSFdaDnBCW2pCS1JdSLhS/zOKo+r
        KN45Z2VLtmxrSGe3lC02//H8a2u7dOxZfdJzZNw=
X-Google-Smtp-Source: ADFU+vu0JkvWQv5EfOULvX4ETtAzCphE8kDE54vgYQ6FBm1lZBWOUKLYrzMJm9pKlXxjBqR8DVxB8IQ0iajNwWwNeuQ=
X-Received: by 2002:a05:6e02:e88:: with SMTP id t8mr15468197ilj.291.1583756765113;
 Mon, 09 Mar 2020 05:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200308164840.110747-1-jernej.skrabec@siol.net> <20200308164840.110747-3-jernej.skrabec@siol.net>
In-Reply-To: <20200308164840.110747-3-jernej.skrabec@siol.net>
From:   Christopher Obbard <chris@64studio.com>
Date:   Mon, 9 Mar 2020 12:25:53 +0000
X-Gmail-Original-Message-ID: <CAP03XeoKo3+iQTPAeuUQ5WHCrS12VoPHymaFPok=-E5Tgzym6Q@mail.gmail.com>
Message-ID: <CAP03XeoKo3+iQTPAeuUQ5WHCrS12VoPHymaFPok=-E5Tgzym6Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/2] arm64: dts: allwinner: h6: orangepi:
 Enable HDMI
To:     jernej.skrabec@siol.net
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mailing list linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

> From: Marcus Cooper <codekipper@gmail.com>
>
> Both, OrangePi One Plus and OrangePi Lite 2 have HDMI output. Enable it
> in common DTSI.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> [patch split and commit message]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Christopher Obbard <chris@64studio.com>
Tested-by: Christopher Obbard <chris@64studio.com>
