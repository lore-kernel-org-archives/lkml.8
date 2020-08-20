Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85EC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4F32076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+IMfnfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgHTED2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgHTEDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 00:03:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521BCC061757;
        Wed, 19 Aug 2020 21:03:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so660298ljj.5;
        Wed, 19 Aug 2020 21:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6OYjRa2YFAp9GJDPztH9gcNTvoIcykOgM6tlkjols9M=;
        b=W+IMfnfO0neSwKeVFbvWDeuWIRAvdaVfvcDLXJJ41lTXU7iPndyA9PLt28yD9GMKe4
         C4HBzhGytXnftGN6bZUSUvWof472d4B6Dz1pquvg+xhwsp7SDdnVU634hM4h9LSiuAH9
         hmYTr4EItQSteN4PSjXLv4iJZ5WBNrll3N34ayRio9FL+fQV3Z7wtCHpcFoRyiiHc5GP
         RJgjqRE14sD/Yvn8YW856kH0e0A6p7Rq2lZQTTiyAnyZ6dHN4H6DV9YibWOcRpyfFdsR
         /jeOEvyOo8NLtQGxywbWEiQLpDjdlChuCufX2VNDLcK1dzVZyxE/CK6Om5vn3HkvqL7F
         1pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6OYjRa2YFAp9GJDPztH9gcNTvoIcykOgM6tlkjols9M=;
        b=JjitZN5izmwCG2Nm6EW0cQuhA9PZBUYSvZaaqGHj7f8NwqhPC/FuJmXW9J+CutJ8mN
         mghy9Ev/4RlnPpX1rZNvdm+sXuM4ZFajdkHFY9zc+gg2qp2SETqA1eLP5AwS6KJGnedF
         0nIBbekBV7123xt7jKH9D9cpmETX9mx62b1BkVEBlrRKlGjptRIMs7xZyuLQ7xlO2GYu
         W9tR8dbkNaTARMlINQ3c/ejk5gi2ZZssyRp/SXm4h+YxN+uAyfnoapS2oZjtfn4WFV9o
         N0eJqpCjA8W6IU+a8L3UwhiiIZl0h1FetteyyxVnW/6HTtf4lvWdZQKFAJ/OJCdoTEiR
         eBOw==
X-Gm-Message-State: AOAM530TbEP55yODI4n6CQ9U0uCzxeJGQoL9hSN+mEw7yM7inZ/5RR66
        Ci/fkY3lE3GAKcusI2LFaZjgUwTGv4xfRYlvG3k=
X-Google-Smtp-Source: ABdhPJx1X9zOEzqgLSjQ4E93SffXxZgVfkOs9yIT7X25hcIxRXMs+MjFFkiDnYKpp5gtJYO1b/QtmjlOzyx0/o2H6gw=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr641018ljb.452.1597896202260;
 Wed, 19 Aug 2020 21:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596025057.git.agx@sigxcpu.org> <41adfe49c75d8bb261dc8d481e9bb537f6699cb4.1596025057.git.agx@sigxcpu.org>
In-Reply-To: <41adfe49c75d8bb261dc8d481e9bb537f6699cb4.1596025057.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 20 Aug 2020 01:03:10 -0300
Message-ID: <CAOMZO5DUA5eS8apZPbte0EcSQ4Vwpg6YLK7D0YdjSUy+kdBu8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] arm64: dts: imx8mq: Add NWL MIPI DSI controller
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Wed, Jul 29, 2020 at 9:19 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Add a node for the Northwest Logic MIPI DSI IP core, "disabled" by
> default. This also adds the necessary port to LCDIF.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
