Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23678C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE33D20663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlWHBQV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgGANvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgGANvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:51:45 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BE1C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:51:45 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w17so19950524oie.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xj1Lk3VZEMaGF9wl7c7H3our1i602EVg5obbUq2ppYc=;
        b=KlWHBQV/y+Tis6Ilt/08e+X2Po+9I9X6lFsX+D0PfXHDvGzQLPWYp5J6q1ZYDAvF6i
         JOw1dCSMqErC9KMgcMPoRUUXw65wifJElvzosNZsPLh5kFawxR3oX2eF+LNP2cVfF85r
         zSn9dqb/NhZ6zgbalPwsFQW1+N0O3WzCUCKBrG9hG1QMBU3dhk5O7ABfqVWkJcVuiweW
         WH7kJUMTJkqwM1O+cY+leLTMkTdlITrWFoZImeebn0n3axiiTR0lx6CDMaGL0Ys3Jdla
         b7kAWY8PLXCTGuqzHsF8FGvY6/gHI3MINMb4sg9WcCdOD6y5iJFgZq+owImhz2ZLCOUQ
         qwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xj1Lk3VZEMaGF9wl7c7H3our1i602EVg5obbUq2ppYc=;
        b=LIS9bJ24WF5YYaFc8kMoVraVRsjgI297qBWGnRl+Ky8Adyyl6+hNEjFaqtA+vu+qVp
         gMXQXX1q5+bJ7Oc0abRJE7LFfu7F4XERzObJpI0iA+X63g5En8IWyotfqURAZpPTTihH
         S7k54raL0t9Ks7feev8GjgVi7LWEMH+NDacmQWT50oCUqJPPD3h2UIdFaWd2ps3VEfL0
         V6QrYlo0G+5H0nHWyp8xxlgqfqgiXNu3MzxLSQhswvNvBrtbNvEAB56lUWAVBCUlw3xd
         JJjK1hPdAkRU6uQeXDmZk87hkdaVUYXLN8D4pdJoTyYOFmJVdXPEzbZ3drjp85Ar3ZY/
         wX5Q==
X-Gm-Message-State: AOAM530le5sy4bUPyjRDTMVJhE4p/YmzlZ0Gojq8wWOtZ4wTUw+ExE7a
        XoddmVtrzyUcnVGBk+2rmS8SivdQImXqwrEqk1g=
X-Google-Smtp-Source: ABdhPJwy8RbrJAOG7TcJUrkCo2N6WVNcYq+jC9yPpRV+bRfwoLzselPY1fC1n2p1IUJ6cDSQ8oaMTabv6rG1Zrtwklg=
X-Received: by 2002:aca:b205:: with SMTP id b5mr21158482oif.103.1593611504654;
 Wed, 01 Jul 2020 06:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
 <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5B-XVaZ-t2T7UBdCqqde3bJREiQhR71ET8p=9EHJ-DQbA@mail.gmail.com>
 <AM6PR0402MB360717519B42A48A754691C8FF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5CZMBeSY=0sa39wJsZpaCqWeCb4-HG4jjXO5pGeW64azg@mail.gmail.com>
In-Reply-To: <CAOMZO5CZMBeSY=0sa39wJsZpaCqWeCb4-HG4jjXO5pGeW64azg@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 1 Jul 2020 09:51:33 -0400
Message-ID: <CAGngYiWV93yWY-mWM-1YcRU71iWnP=qsLSD6Z5dZkz=Zb+iqRA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andy Duan <fugang.duan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy, Fabio,

Does the following describe the mainline situation?
Please correct if not.

1. imx6 ethernet ref_clk can be generated internally (by imx6) or
   externally (by PHY or oscillator on PCB)
2. if internal, fec's "ptp" clock in devicetree should be
   <&clks IMX6QDL_CLK_ENET_REF>
3. if external, fec's "ptp" clock should be that external clock,
   see 810c0ca879098 ("ARM: imx6q: support ptp and rmii clock from pad")
4. sabresd devicetree describes "ptp" clock as IMX6QDL_CLK_ENET_REF,
   although it's externally supplied (by PHY). This is incorrect.
5. nevertheless sabresd will work, because FEC driver can still work
   when the PTP clock in devicetree is different from supplied PTP clock
6. sabresd plus believes FEC is clocked internally, so flips the bit
   which routes the ptp clock internally
7. this breaks sabresd plus, as default internal clock is unsuitable
8. sabresd is sample board, so all boards based on sabresd may have
   the same issue, and break

Solution 1:
- describe sabresd ptp clock correctly in devicetree
- "clean/correct" solution
- may break other imx6q plus boards in mainline
- may break out-of-tree (private) imx6q plus devicetrees based on
  sabresd

Solution 2:
- on plus, never route PTP clock internally by default
  use a devicetree property instead
- complex solution, hard to understand if newcomer
- prevents sabresd / clones breakage

Solution 3:
- set sabresd ptp clock freq to same as externally supplied clock
- may still break designs based on sabresd
- hard to understand what's actually happening

Other solutions??
