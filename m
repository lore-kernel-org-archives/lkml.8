Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522BDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E95E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+ArHYoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgGPSBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgGPSBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:01:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A33C061755;
        Thu, 16 Jul 2020 11:01:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t9so4320064lfl.5;
        Thu, 16 Jul 2020 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RO0Ev4XWmJoAtIvt5ezwXcEjz8a/igJfRlR8CqYlcwk=;
        b=f+ArHYozj9iXY05L2a9mOZncLmIZrkrlfF7f0ox3qDStqRjfkcCoFld6RZ/ia6HTpb
         cIV5mTlOmVrT2hjAneei3Je1SaJfNb3yJIwSwwU9HsjWOBm8+6U4e7LgxQoI7mr16P0A
         DgnV8Z4HlfwgS2+n69C5VzbJOQlqN1MIHEt4HdYUP1Ft+s0W1MrsCHpNyCE54wr2zBgN
         D0Q1+bJul3OgyR6iDe1P+gQE1P0fXPf/yVaz3k35LplZb/agJQcEJgcI9Ko/5w+Cpnvm
         V4h7GT+PWGjBv2q79K+tqii9a6lhV4v3YUxcsonHparWShvyBB4QFnzyn+jNaSV/vP2t
         8WpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RO0Ev4XWmJoAtIvt5ezwXcEjz8a/igJfRlR8CqYlcwk=;
        b=ufT6brl52tjobI2hmpYXN1FnC/9LYmn7TTnCQZ7+cl2Yj4oQffwoTXdbn/Fg3zaxGR
         9U+iStsRuwr4oToOXKwL0O0YfdGeziVt4XqDR/LwTAwKrVON5LB9isbWANqHMwqsajJu
         qI5689Isp9oAUL5GN+IxjCoxrcqrosvkhwkru4eXYMZVpSowBan3TMZ30HifKIBjyvLy
         PRFfwDokB9zoOa+UGGDpDERBBcBUt9jb9TXqltuAf686fiYMEaiHFOQbNkWSO3lvEbTO
         lzrR5KGreSNIRoGAtI7+YlghkvBtMHc4TH5VEvYkz22IX0mDW5tRzSmtIr57r5yJ5BlA
         LICQ==
X-Gm-Message-State: AOAM531Jw8H8DFw/WotOFTLE/h5TDnDTwWMqZFsrT76E/yqRSVw4xQv/
        EhlgybbyH1QkbIwfL5fBqyynpfrMfCVmI17eqccanr2WrWg=
X-Google-Smtp-Source: ABdhPJx/Zdv8xhyeZFB7H/DVbJijxmGRfl3Fpd8wrS1ku4bzw1EgItsFCIj6+osuQpx/XobNVdvngNL2tfdWEJC+814=
X-Received: by 2002:a19:428c:: with SMTP id p134mr2325052lfa.70.1594922495164;
 Thu, 16 Jul 2020 11:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200716172611.5349-1-bruno.thomsen@gmail.com> <20200716172611.5349-2-bruno.thomsen@gmail.com>
In-Reply-To: <20200716172611.5349-2-bruno.thomsen@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 Jul 2020 15:01:23 -0300
Message-ID: <CAOMZO5B7cJmF4e78xbErzBHfMw4MuF09eXti4xAUFcKOGKXqNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx7: add support for kamstrup flex concentrator
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruno,

On Thu, Jul 16, 2020 at 2:26 PM Bruno Thomsen <bruno.thomsen@gmail.com> wrote:

> Limitations: Ethernet PHY type auto detection does not
> work when using reset-{assert-us,deassert-us,gpios}
> properties so it's using a fixed PHY type ID for now. Auto
> detection worked when using the deprecated FEC properties
> phy-reset-{gpios,duration,post-delay}.

I think we need to understand this better. Why does it fail?

I gave a test on an imx6q-sabresd and the Ethernet PHY (AR8031) could
be properly detected using reset-{assert-us,deassert-us,gpios}
properties inside the mdio node.

Is this a Micrel KSZ8081 specific issue?

Please report this issue to the Ethernet PHY folks.
