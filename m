Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8BCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EED922B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8k+eYcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgHTLCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgHTLCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:02:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2BC061385;
        Thu, 20 Aug 2020 04:02:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so1578343ljk.9;
        Thu, 20 Aug 2020 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vm6UdNU57gL1rdZIYLxxXIMcqfcOyBt2uS2h2r+o3AA=;
        b=c8k+eYcm2xdYhX3dBI5WE4ENzx9S5r/hl4iAVSAGG1s0PTZm3HRH3hXLldFD/cpA3J
         /YCW1qQrwrEazIg4SJctbIZ+oji0znqSQ6ZDr92UPv2jsuTaFXOX5vtHR51gZyosCrq5
         Y1dTk2eJOtiKIp7EbG/xaTNAI8z6pdhyKYcMgxzn0yW5hEgUn48x6qQlldqCYjzYNyyC
         NrCDCzmVU1bl8qkrsN16umktMbsS/LEMZYgo/jdJIWovHmO5vYTfO0X+CQ62+pphkorr
         rVuammeF28ca8ZSRLQxEsEj1U19MShSPBxfuiS/sIJ9MaogSssSsXrFDvq1h0C5Pd1A2
         ithA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vm6UdNU57gL1rdZIYLxxXIMcqfcOyBt2uS2h2r+o3AA=;
        b=iK4tBJGuu0G35e5wceFPIPWFN3+9F4rFAsrlKxoYLcpnIjTOf+YdK8StdeJrkvUtdk
         wdMpEdS09ISeqTKoTskC9CpBI5OqgjRRjdYlbL03YoE6o7rw4/En+Xi1jOVGGvu+1SnV
         Z/uqGSDzr6kBm0TlliQ0InLSp0XrPu9uMJs3rGy1/BkgCR0fOn6rMLJAfJpV/yEXVyTF
         fQWCgFEkq1qoYvamRY/6vqGJy04OLDHK7nBBHFGEDtLZODKnQCQq0GRcBsAar9y+KMwV
         P97YC1KmtHQ4f+cmxMqmlYo+gAW1uzOqRpUell6TflcF+0i1HSf7Goo6txB+oQrETBiw
         cvZw==
X-Gm-Message-State: AOAM532+XrE5grU9JoxbXLoIr3ycjg0drptSj4trqIBAA9v7mLKOPmPb
        zNrcuRttK7mrvJ6V1Nc6vSiCIDwEzrcyvOQ7M4E=
X-Google-Smtp-Source: ABdhPJz/o/A6bxp2clzyeUoXRZAdQW/bQW8WJs+Uhw6QF52TM+vJBw0WX4aNw96WJw6RBt6gP8IKs6T2VYcg7l4a/1k=
X-Received: by 2002:a2e:1417:: with SMTP id u23mr1438908ljd.44.1597921319247;
 Thu, 20 Aug 2020 04:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200820041055.75848-1-cphealy@gmail.com>
In-Reply-To: <20200820041055.75848-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 20 Aug 2020 08:01:47 -0300
Message-ID: <CAOMZO5BeuG7hvTcwrYoDqu_9fsS3uPhaWVqyWYPDHA_0bvH_vA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: vfxxx: Add syscon compatible with ocotp
To:     Chris Healy <cphealy@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Thu, Aug 20, 2020 at 1:11 AM Chris Healy <cphealy@gmail.com> wrote:
>
> From: Chris Healy <cphealy@gmail.com>
>
> Add syscon compatibility with Vybrid ocotp node. This is required to
> access the UID.
>
> Fixes: fa8d20c8dbb77 ("ARM: dts: vfxxx: Add node corresponding to OCOTP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
