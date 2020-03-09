Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8681FC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CFE20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCIM6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:58:02 -0400
Received: from web2.default.djames.uk0.bigv.io ([213.138.101.246]:35602 "EHLO
        web2.default.djames.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbgCIM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:58:01 -0400
X-Greylist: delayed 1937 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 08:58:00 EDT
Received: from mail-il1-f172.google.com ([209.85.166.172])
        by web2.default.djames.uk0.bigv.io with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <chris@64studio.com>)
        id 1jBHTZ-00019T-Lp; Mon, 09 Mar 2020 12:25:41 +0000
Received: by mail-il1-f172.google.com with SMTP id o18so8408530ilg.10;
        Mon, 09 Mar 2020 05:25:41 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1SxhF1uqV4XljuLOdfF96Q4ow3Q5t+d3pGlFrNWCZp2RiPqpbf
        DU+HZ0AKTxiBe2l8VIjb0cTkexntvnFJ7Fyd63E=
X-Google-Smtp-Source: ADFU+vvrP6s95F70KAX+G0iZkhUaLDICZcpMKzCTLzJhjvlacWG0XFUUaMBOD/Ff4COtuy5/V3gYe+1JcR0FTgevcTI=
X-Received: by 2002:a92:40c2:: with SMTP id d63mr15438368ill.23.1583756740126;
 Mon, 09 Mar 2020 05:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200308164840.110747-1-jernej.skrabec@siol.net> <20200308164840.110747-2-jernej.skrabec@siol.net>
In-Reply-To: <20200308164840.110747-2-jernej.skrabec@siol.net>
From:   Christopher Obbard <chris@64studio.com>
Date:   Mon, 9 Mar 2020 12:25:29 +0000
X-Gmail-Original-Message-ID: <CAP03XerBUbpC-4XL_BFjAwCnR1JT14d=4VwoJUJqzLFDzkFcaQ@mail.gmail.com>
Message-ID: <CAP03XerBUbpC-4XL_BFjAwCnR1JT14d=4VwoJUJqzLFDzkFcaQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/2] arm64: dts: allwinner: h6:
 orangepi-one-plus: Enable ethernet
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
> OrangePi One Plus has gigabit ethernet. Add nodes for it.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> [patch split and commit message]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../allwinner/sun50i-h6-orangepi-one-plus.dts | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Christopher Obbard <chris@64studio.com>
Tested-by: Christopher Obbard <chris@64studio.com>
