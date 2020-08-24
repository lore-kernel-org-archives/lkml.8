Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 01:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893CC206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 01:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFudpDFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHXBFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 21:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgHXBFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 21:05:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A7BC061573;
        Sun, 23 Aug 2020 18:05:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so7692323ljo.12;
        Sun, 23 Aug 2020 18:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWX7H96L0UTSs7SYWnb0yF+ExzD4uVWoQtXpHGhYPt4=;
        b=GFudpDFpSrYMwmzlITIl19n5T/kkMisz1fhJcgcOgqnpNg9y0ujEezi16yBjUtEn7h
         v3ghDXydog9dH867lgOA8hVSqAb4PvC5JLkZ79W0tklnTUgK4/04aTCM4x0K0jF9yctK
         8O2i7um8E2y7Preo/FeoutVMvbERGWpyD/Hao5PHgECHqihw37avi/jrE/RS2dRqmqlK
         kBOvnOfnRpdxu4yET4LkBS040mT7tMOdrjSaMhiH8So8MQ8xgMKr5SuoI+CuLMpk+cLk
         Wrvwsw1OIx1+OAuUafFuW4Mjdcc5d5o9BMyRsnR6w3KqteXLNqEuPSI7Y9eKwYyqEHI2
         Drng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWX7H96L0UTSs7SYWnb0yF+ExzD4uVWoQtXpHGhYPt4=;
        b=o7ylhAxGnqwO+Bj6Bq+HyjQ25TzlvL6SBtngxf4YPxX8qO3NvWibIRxsTUZrLcJOa3
         enKuPfdWa/OdI4iq/adSUEvZ9ORs2UD0fWSUY6OjUkllnbTPxxGfdBU8HTpIdV6vhqrO
         RbEgBXCgUSkDjEpZsmRm7rfcsNvRSFW3pEMXbTRYFLu89x2cnLfrVD5p5VcCcRvcmayz
         tGLGKAPP8t10E0NgE/fzjsAIoTbF31wzcMLjG4fA1nIMnpr2jmQd1HdCWT3bM7hsBZ6p
         kW3T8cOmLkmSLs8ea5F5wcNSIX1hnVxotR03s4HYSs2QW3h/WmQ8g6w62oznE/vehgGd
         qDdQ==
X-Gm-Message-State: AOAM530hx0bvjMhvKYnVlE4k03tlMfP90MTs/6WaUaTm1ejQysME22//
        yWShL5IVe+DTyPScHgD7m2RQosuVmFBd2wB65co=
X-Google-Smtp-Source: ABdhPJyG2Vg2PXqp7FOp39Jr1qK75EubaBHR6KMuQHTqCBcIyTzbOFJir/nGZH+p88lYL12I5LDwRyDaPl2sD28gY+Q=
X-Received: by 2002:a2e:9c8b:: with SMTP id x11mr1397465lji.218.1598231128750;
 Sun, 23 Aug 2020 18:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200823022505.196825-1-cphealy@gmail.com>
In-Reply-To: <20200823022505.196825-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 23 Aug 2020 22:05:18 -0300
Message-ID: <CAOMZO5CgEa2ZkNL5wNwwhon=ssSC7ot40G-GO6Z7R+tpeh_ttw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx7d-zii-rmu2: fix rgmii phy-mode for
 ksz9031 phy
To:     Chris Healy <cphealy@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davidjoshuasim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Sat, Aug 22, 2020 at 11:25 PM Chris Healy <cphealy@gmail.com> wrote:
>
> From: Chris Healy <cphealy@gmail.com>
>
> Since commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the
> KSZ9031 PHY") the networking is broken on the imx7d-zii-rmu2 board.
>
> The end result is that network receive behaviour is marginal with lots of
> RX CRC errors experienced and NFS frequently failing.
>
> Quoting the explanation from Andrew Lunn in commit 0672d22a19244
> ("ARM: dts: imx: Fix the AR803X phy-mode"):
>
> "The problem here is, all the DTs were broken since day 0. However,
> because the PHY driver was also broken, nobody noticed and it
> worked. Now that the PHY driver has been fixed, all the bugs in the
> DTs now become an issue"
>
> Fix it by switching to phy-mode = "rgmii-id".
>
> Fixes: bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
