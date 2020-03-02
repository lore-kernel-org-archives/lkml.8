Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D210FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73E724699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/pUlbcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgCBIme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:42:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41234 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:42:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id u26so10604241ljd.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g29XyuwOKIs/sEqqYbL4oYNrFf9RHLiVPNCz/UCehWQ=;
        b=e/pUlbcQmcm0oyU3Y02zwylI4JrIeXc779uRry4j8hsXzctEL1xDwKZ72PpcJERVpR
         JMdOrU3ejtO0UqlSL4L7q72XGFWKL6mCkYBaz191Astmalsh4dpNWXmfq82ObYeNs4xE
         LaSyWROJ/uo9K3VFd//AHUI+H7f8SJJaxM4uCpmgB0Nn9Isw5WsIKHNUQvYaiHli7v0H
         12bebEYKkd04dwjWcG2JCGtlj3x3g2qpMBT/3cWbQSHNBZCgZ+1tx1MAF7BJc8u05UJR
         Xa9qrJfOfzPWu8FlGhcWZrNSYhC3knLoUA6Uuo0Q0LXre0ggFjj1RFTyNtJoj+PJZPp9
         9Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g29XyuwOKIs/sEqqYbL4oYNrFf9RHLiVPNCz/UCehWQ=;
        b=egtbX/D5MIthCBrLgHS7w/r/wdgpLVn8jFxQKJuBBxwdO0nDTAtuKy9loupAh+r+sy
         CwVmB8NEUQqFsgoz+oDWidvJ8q3SGzAwXAn5/rwfRPR2PCzm870bRxCogVADQ2UjR2Sn
         QT2ZTFHglJNZYHbBpDusdiZQzoNolDI+1h4Jn45Y3yRmdqnrI1ilOrP8WQUaiAvk5nZx
         VywERu3tl6xrzh66jKfcT3/6Zr3gAKMI58hhD+RFgV5KKg6vP/TFRaMaI0kuvlQhF1Uk
         1Lmf+R1EYdShvLAGfliT8JlHOi1aaoAvRKfZ3SjQQRqYYpZcUgxjBERlMVtfeS1SUFXw
         VRXA==
X-Gm-Message-State: ANhLgQ0BFfiX+F97jfWyoxmzxNfiLqOHZxkkCOU5uzmzVLM7ZHUiUwnM
        q37wlwze8Vq5S0uqaFsMou+HgNlHlRAhvPE4xlA8/A==
X-Google-Smtp-Source: ADFU+vt1Kci8gmkDhxlBgMDvyCvVWOL0VcOHJ/mrOCVqKw9mApHmYjif5ezTZ7tN8fRIiZstU7VWpvTxnPc4wH/TCqM=
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr10777873ljo.39.1583138550738;
 Mon, 02 Mar 2020 00:42:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582913973.git.hns@goldelico.com> <010d6ad3473fb4b1f1041888a071796180cdd838.1582913973.git.hns@goldelico.com>
In-Reply-To: <010d6ad3473fb4b1f1041888a071796180cdd838.1582913973.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Mar 2020 09:42:19 +0100
Message-ID: <CACRpkdaP59S1uzGVKTHkJAyv_jSs6GQY1KBxgfrvmPq2c74iGg@mail.gmail.com>
Subject: Re: [RFC v2 5/8] pinctrl: ingenic: add hdmi-ddc pin control group
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Paul Boddie <paul@boddie.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 7:19 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> From: Paul Boddie <paul@boddie.org.uk>
>
> Signed-off-by: Paul Boddie <paul@boddie.org.uk>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Patch applied to the pinctrl tree, it should be fine to merge the rest
of the patches in another tree since there are no compile-time
dependencies.

Yours,
Linus Walleij
