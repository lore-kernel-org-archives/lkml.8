Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3794C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD35420738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLPAj5Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEVKYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgEVKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:24:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7EC061A0E;
        Fri, 22 May 2020 03:24:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so6230479lfb.3;
        Fri, 22 May 2020 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKfCBTr3t9MLCQ0J7OL7a+qWvpib5l9QLHxm5yO1R5w=;
        b=DLPAj5CqPOJrt06enKB1ajI2NDFv9SufvT/yTgLAfjpMrZr6oFlggLT8lcqC29rl9t
         GZUftu34UAAOMb7Rg8sQqIRMQW86faW04AVGbmaN+KNh+aHKolxikQ3th4gwg6fAX5cp
         4JSk2b201knvWxlgX9KV57jVas0yhJVfYR/1H1HrbrSScxOCbvx+WBZ2XWJAzrSiQxHC
         qG6ALBdMJSMtjAP59+7gOVZSwtKNFqbI3aEXEOT9urqfWaAOcOuTs9NUVhgUp0awvr2n
         LtS3rbyGNcMspVITcsFZLgoRx41zfo6QMAZSgygb3FZ8xDvdfCbbTEx0LrZJmn8DUYjU
         t0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKfCBTr3t9MLCQ0J7OL7a+qWvpib5l9QLHxm5yO1R5w=;
        b=KzQERF02HdGBhNyUZ82jEGyZq6xP2k3sb3ikz5yo7W2Nnf3uVCeyXT6QfOzXCib1z5
         2kmE7qoyZ+kdt7yS6fpQW+JTD83cIZg9DibIdmD83fpeY4pbXTHJgoZw2ht8/7yyvl9K
         JyXzyiE7Imx/CHEFS7EKp2tvvpKuJcbyMeKLMu+B7rprDRoZlr0n3c+LZ1LA/cIyy6ol
         0u8uA+qum/ImGNllLU1GV44VKdsEBulMZTNif3GwCpDdpVA1mJ1Xqz96PP2cuK0kd+qM
         eXfpUUtOaDmkgV9KecVdu3SCmV8Qse1attoVzWC0ulqN1Hc5GTbNpmqtnKgmUv0K8euK
         tbwg==
X-Gm-Message-State: AOAM5301dkjS7yJSR7z183Y8XWMuGxHS+s9JNUTTu8g2hEBzzxD41i+X
        NoXVutfJt3Tg/e+PZWAORQr7PFVCq/X2Jt8nfB36K6mn
X-Google-Smtp-Source: ABdhPJzAE9qHyplI74KdB5AD6oGUghscmd0IOe8zTZzcr+h2CPvEAwzkjjnL5jblpWGxXa2/Me9+fgzuIQyHXzThdww=
X-Received: by 2002:a19:6141:: with SMTP id m1mr7281542lfk.7.1590143085555;
 Fri, 22 May 2020 03:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <1590144291-18526-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1590144291-18526-1-git-send-email-yibin.gong@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 22 May 2020 07:24:33 -0300
Message-ID: <CAOMZO5AgAYgxb9djwGXdpMme4aREYiGPXVa=x0Hb5vo-KJGrug@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage range
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
> Otherwise, ldo1 would be kept @3.0V and ldo2@0.9V which violate i.mx8mm
> datasheet as the below warning log in kernel:
>
> [    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
> [    0.999196] LDO2: Bringing 800000uV into 900000-900000uV
>
> Fixes: 78cc25fa265d ("arm64: dts: imx8mm-evk: Add BD71847 PMIC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
