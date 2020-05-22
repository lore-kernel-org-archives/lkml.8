Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D823C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F053D20738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiKDItij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgEVKZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbgEVKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:25:13 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F497C061A0E;
        Fri, 22 May 2020 03:25:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so11985800ljo.5;
        Fri, 22 May 2020 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFKhlqVsnkCrxGWdbHIjo8dNnb/R1dHUqeBwV1cH3to=;
        b=TiKDItijeKH7AVGFffJI0WsNtOyRdNrgnSponqh9Hcj2fCrZRYs3B3Bdd2HlOg05Tx
         5qBXUFdajt8aoufhAXUacFaUH8FaSbAn26Hepd2hgOspoIzlvqskSQ5nCankhINkProQ
         2IGTwUr2VJjMHOLKq5GNkCJtC6bP9Tn+lHwi/ASvaboNZux3vduuFMqPInP3WsjtGrSs
         kHe+idR/q5hkP6P0eh5Fuk1GSDmF4RrrF57r9OoBGsKjO28YnX+WR8qcLCDzTjLEFfm8
         rxcgnte9/6zmd6WFQqpEOJBfqtC7qreSOtEvPez59qKolI25kHr0oET1mD+x4vS8f2Ht
         NxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFKhlqVsnkCrxGWdbHIjo8dNnb/R1dHUqeBwV1cH3to=;
        b=jmcsm0/mnUfRG1wXviBJ/DC2zMgFxBXKEODBLo2TRHbblwhoAqOW735pQLV4JMaiMJ
         QCzR8aQOnkqxY+XQ8MycU/+aMT5tnl1GAj1i8aGfqGPBXPh1UEPjlWOYLDPc69NUIV6D
         W5bzaaadU3mfT5T53/DFQeXhdt/AJyGrnolIwfkMzptfdlC+OcE7/47YJa3c+7MT0+aj
         Ey8aRRsLXlAe1B1hM+pP0BjFzvcZOvYOEe23X5D8bx057lkwe077N5uL3JofCoFHzeSc
         FWdccYQ4zEWWIKXo1xjkvGMsbv0Hy2fxzheL7cBViTZxun2cr3Uk9g9G9gDUvVICrxkL
         A6IQ==
X-Gm-Message-State: AOAM530mpTb2lg8m5sJfrS7fCcUyPhxgAWBQUaqdvtRBPbYUvy0Kkay1
        Gu/RnKKD5g92HjZFB3b7Gx1LHNEFyHfnskHkFaJbA3Ftz1k=
X-Google-Smtp-Source: ABdhPJzgtITNAmGF4FXDUvVXgptvmZlGGf0/KQTzAC02eg1W4hBckNpsHF3Pn/RNqPoMOseHlfs4TSbPN2lmM9PcjH4=
X-Received: by 2002:a2e:b4f3:: with SMTP id s19mr795267ljm.218.1590143111779;
 Fri, 22 May 2020 03:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <1590144291-18526-1-git-send-email-yibin.gong@nxp.com> <1590144291-18526-2-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1590144291-18526-2-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 22 May 2020 07:24:59 -0300
Message-ID: <CAOMZO5Aiw+3N_o5+1g4nWWgsDQ5Yhdenumn04OhG6BwBy99EZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
 voltage range
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yongcai Huang <anson.huang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:44 PM Robin Gong <yibin.gong@nxp.com> wrote:
>
> Correct ldo1 voltage range from wrong high group(3.0V~3.3V) to low group
> (1.6V~1.9V) because the ldo1 should be 1.8V. Actually, two voltage groups
> have been supported at bd718x7-regulator driver, hence, just corrrect the
> voltage range to 1.6V~3.3V. For ldo2@0.8V, correct voltage range too.
> Otherwise, ldo1 would be kept @3.0V and ldo2@0.9V which violate i.mx8mn
> datasheet as the below warning log in kernel:
>
> [    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
> [    0.999196] LDO2: Bringing 800000uV into 900000-900000uV
>
> Fixes: 3e44dd09736d ("arm64: dts: imx8mn-ddr4-evk: Add rohm,bd71847 PMIC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
