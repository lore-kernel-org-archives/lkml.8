Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB17C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0803621556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2PrwOAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMUeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:34:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33391 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgAMUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:34:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so11696596lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 12:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5btG8+rDtVkHFSsWTVsc0YN5eY7jgmCtlCqNwE1Iys=;
        b=N2PrwOAdsbaBW3XZzD4fjuiU0y1qsP6DSHHfbXBeiVSodYZAmT4Pj+fQBtVT0bgt+Z
         YeA1QyTXs0lKv5AcCOtdvCsLoI1bxHcPYIh+qNvvaohu4ga5ktE/YhmQq3umz+b+RPgd
         yFmcIw+Mc/fyLDB5qabO+mtE6exPsL3D2t4m513tZbEz6u8nvVj48gxyLWv/uVK92R1I
         lgnBlrkSLTKceAD3xy6fBfpSk7hoDseJA1OHaSHJMS0lR6TPNwq4Q0JCZf7NfKtexs5v
         tlBoXN+i5VEOeEQURjIjx8i2Zil8UTf2L/L0QKC2jTZahnS7FkTr6tJMDRRB1qSBN8UO
         92VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5btG8+rDtVkHFSsWTVsc0YN5eY7jgmCtlCqNwE1Iys=;
        b=M6NgCcNBvrZH/AsDj+LaTiZyBTanFBwbCWwFK+9WPExU/B2JJskGvQw3lpEjERAQbQ
         yzKS5oXNWVQQ3Wxzq5S/ooUvPBJaaBKa8viUSU7szcvNs6ufb+g/11A3mc55C/OWILO8
         mj8Mu61Y57n4EmgJQRbzisD4Y/K4sjCFL9G8dwYQdlo8pb73GaywouPgo/eeQwgHeSmT
         ZQMOQ5ntzZUMMvZNmFXR950s3R70aF5+yqA7JzOTB5mDRSFwV875eNX638ieMKh2n4Qw
         GdhZarbSjTpssE6I6w4wicr97IFtifjVn8qMRPomMYQGFwYpx4YhvPvd3c9sFMnvA0K5
         96sA==
X-Gm-Message-State: APjAAAVABvwA74BGFaj8a9fZxS+8zrZg8xxwkhTskkMhi2/kT6HYo7VH
        JFQaD/bL1MuCk6XlhVv/jAGzJsuPoI8YyEK9pq3vojCQx6bmjA==
X-Google-Smtp-Source: APXvYqy+h3uYVoEzWBBQzoSiJFi+QF3mEdOYnavTCKS59kG2E1X+rTKCRiOgNC7GE/c0qcOMwRXUKAR5syrQRB9414g=
X-Received: by 2002:a2e:3609:: with SMTP id d9mr11389552lja.188.1578947657486;
 Mon, 13 Jan 2020 12:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20200108104746.1765-1-m.felsch@pengutronix.de> <20200108104746.1765-2-m.felsch@pengutronix.de>
In-Reply-To: <20200108104746.1765-2-m.felsch@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Jan 2020 21:34:05 +0100
Message-ID: <CACRpkdZYzjcq3+NwSHL3pFVjo4ZugJjDKcjVGePUtmZ3OqCw9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: da9062: add gpio bindings
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 11:48 AM Marco Felsch <m.felsch@pengutronix.de> wrote:

> Add gpio device documentation to make the da9062 gpios available for
> users.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
