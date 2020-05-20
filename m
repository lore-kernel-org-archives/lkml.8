Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6424EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401F820849
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXWaUVl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgETDFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgETDFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:05:18 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7DC061A0E;
        Tue, 19 May 2020 20:05:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l15so1553729lje.9;
        Tue, 19 May 2020 20:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HoeSq/8pPr91BzAJhNOgffpepxPbgET+ZXok/fBudck=;
        b=gXWaUVl9AECOIaCl0Fcc+xIuo4vo2rEIF5DT5q2sv+aXAEEHz28fli9wQX7i4ZL0vd
         OTMHmhNz8TAFAW+eEa4bcvhbiIu5W4TKrw/tR8wq4t6xZR6Ed2hk+0PNmkujpnyDWgvc
         s7tPAX538te6tQJPButCPQupE1SOrMPA/IVar+zT+v5TIELfDPahdw4HGt8fdOeVrY0J
         i2LbrOe9t80DtGsd00VNOZshUUf2oNbffcVgAzIrNwv2ZnsFdYSy5fOnGSuVECXxNRbs
         10VLvYUYyRv5pXPhGbClPwhJc8VvC7G2u30dXXZh2SByvRn1fWehU7xco2tsGt7/dpXo
         sAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoeSq/8pPr91BzAJhNOgffpepxPbgET+ZXok/fBudck=;
        b=tqiDpz9UkzHmRIq7vmRyW7yWgfL0uJZYIZHsrj/wZAHWu3w9ofw4+KzCrGk24YycZG
         RKFvyQPKdZaSwCtFoQwqPKs6DXuiK9r4EF+dUUWkaDDkeFX5q/qq0ZNW8GIW9aULKHAa
         XDbRps0sWud55hF4HMUzZEO5yUPEMDkTf0sEeIYxugub6gUdBEpiXhuMbeKTqlCuSekJ
         C3aXUUPWFImiXwNxHi82vD6b7Ida3f6FXXl53sZSaFJmdhJNsgdBqw58dViut3ogjyfr
         YzRT18/HbXlDYAJIGMrI48nrRRw0HeRW+4XfsRViQolzq0SJ6JaGPBV/Bk4vKMNC+adh
         wvyg==
X-Gm-Message-State: AOAM533Mh8Q//t+MEYma4JRhzcL0Qnk5kDPmNUYydI61QNRo0S3js6Jf
        YRoq9hfNwX2J4HRZChwpGr+GUCowPXfbx1HgbkM=
X-Google-Smtp-Source: ABdhPJxUgi5dbYAyeOHZlGuF5KVl0KkfJn5CPaaSvjLesR7QA9yJpSBV50lArSyjN0Eg4earSj4hHAa4IsUApfKwREg=
X-Received: by 2002:a2e:920e:: with SMTP id k14mr1474641ljg.288.1589943916318;
 Tue, 19 May 2020 20:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <1589940278-3680-1-git-send-email-peng.fan@nxp.com>
 <1589940278-3680-4-git-send-email-peng.fan@nxp.com> <CAOMZO5BPPRy_XGHHyZfE3eOrmCwW_VytueY-An8qqke6HU06TQ@mail.gmail.com>
 <DB6PR0402MB27602682E90E4CED55244BCC88B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27602682E90E4CED55244BCC88B60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 May 2020 00:06:36 -0300
Message-ID: <CAOMZO5DmiQbfJjTLKPiv6uUNaQ8ae-0h7uOpPf2J9ZMwDoE+Eg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8mp: add mu node
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, May 20, 2020 at 12:01 AM Peng Fan <peng.fan@nxp.com> wrote:

> Nothing specific in i.MX8MP for the mu part, so do we really need
> add "fsl,imx8mp-mu"?

It is good practice to add a more specific option.

Let's say in future a bug is found that affects imx8mp MU, then you
could fix the MU driver and keep the dtb compatibility.
