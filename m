Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E82C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF6320774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QECDpTuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgGHNcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbgGHNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:32:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8FC061A0B;
        Wed,  8 Jul 2020 06:32:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e8so19997254ljb.0;
        Wed, 08 Jul 2020 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyWAeR1uTs/9fAF9wUmZ0OImawjeuUkpapCXR9PrAmA=;
        b=QECDpTuJTwRzCzuhG2763IHEXgvtUskyyhE85TzGDu8hEBvLOFq/H5kFjfjK+xMnXJ
         SC5szPi/O3K31QxF0W1dT8dGKt7pGPU6XrcaQ2KnKtm+eza62+fqot+fl6tVLwu87CN/
         GsnPii3wl8QN8XHoBkxSfDgAO7E1FQENtrX6KRxty0Msh4HDbDHIitGVvuwN8KtwqzYO
         a12Ad6Gacs6E6W2fGAsxOZSTZYTR8lITfbMtm2TJXhseUA6MXXZuVkLYuCn4JfK2uOtw
         5x1WPQPKywsALH2J3aELblkKO1g3hpMliGZsqRhNPOySN04+QAwVy41LJPjx0PQgLL3b
         I/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyWAeR1uTs/9fAF9wUmZ0OImawjeuUkpapCXR9PrAmA=;
        b=EO29uml7YecIVGds0E4B3CuJByBTADREjEBswfmXaMfneApkC98Vqyoq4f9ex5QpJj
         XJD0P2/o/2+CzVaecQeXZr62dQNL88spDpB+lFV7TyarIYVlBnykvdNrp+3ymom/WRsM
         HfP+jIlEa/YvBs6o6EOQ/DrJeDEqYw1q6pbaX2AlyiCzYnrcmdyA4IPUgNY7CjcwnCdS
         OFbyTImidX6WnZjMBolatSnwwXbfetxIGRnNc5BMKguiscqGW89Ij2EAGKBUhgaliSK8
         OcRJIgDdWOlhT6xUhJoPhX8H+09lLgGkN6MGC6zHidGqAMQ2e5gSoY+qbW6hrszdF9Ee
         Yv3w==
X-Gm-Message-State: AOAM531P6FbYJKLSee297UZjZTqxl09JaBClL97FCPB9pLRK2HyOChqW
        ETRm9ix+yw1m9obLajtgn2DeJpvWABwXfez6VVA=
X-Google-Smtp-Source: ABdhPJzFxYy8aKcybTu5lfAkoS0cN1dpUz/UH/XTyV+W+0pwpmYOnE7soZElzFfKoJQjn4vgvw4TUtuhQrGYfUC6/kk=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr23010681ljh.218.1594215129024;
 Wed, 08 Jul 2020 06:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
 <1573586526-15007-3-git-send-email-oliver.graute@gmail.com>
 <CAOMZO5DX_-zSHJjDigK2c=dVLEMxvfd_dFCu=0fbyjht1gsr=A@mail.gmail.com> <20200708103836.GA20983@portage>
In-Reply-To: <20200708103836.GA20983@portage>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 Jul 2020 10:31:57 -0300
Message-ID: <CAOMZO5AddAHXs=dmvJtK4qi=khnNJDo0GZcWTXeWT4RVogz98g@mail.gmail.com>
Subject: Re: [PATCHv7 2/3] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Wed, Jul 8, 2020 at 10:12 AM Oliver Graute <oliver.graute@gmail.com> wrote:

> ok thx for you comments, coming back to this. I now added this to
> panel-simple.c. Is this the way to go?

Yes, please submit it as a formal patch to the drm folks.
