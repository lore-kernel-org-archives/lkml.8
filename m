Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71EDC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDF021569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpU8piGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMUdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:33:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37065 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:33:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so11646994ljg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 12:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuTGLwwi85unK1r2EuOVeR1TE8PIkAuBbjrUABOzDgw=;
        b=zpU8piGPL9mpHkrJtOvWOmAmPCUN6/daRz0ojUt9E6UCmugQuBrK0cZ3BJlV+fRdsa
         SNBPWQlE4286crRo0WryamW09tOCSpLdrkTBOEVU0x+HhGeAIOIbqSxzogTawgl/YxZJ
         qb1WS1KFweRqYBo/grYoBBXGbxLaPDTc634U25aUFyJ6NqbH0YIpt81h0IZnUdhHN42+
         L6prwrZyvZNu131oOSNpsMe9phKAoHzWW2Cxqv38p91FaZeYzeVNfho1XhQXp7NKtURq
         YljLikhpZ41BvBqLmw9RwGzZJTgySKbDfm2AKWeETyC2vXRzUxagRWS/v3vS/ipvaWFw
         RXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuTGLwwi85unK1r2EuOVeR1TE8PIkAuBbjrUABOzDgw=;
        b=RvWTsuJ7SHQAkqDyZnMZ61jNYP1OM6wHP38m8Nd6CH/arkAaWDDa7XhJV56d9L1JRX
         j2nlo+zTICL+oNWoHWZEXQJCEBqYOW9hd410/j5BctR659luf2QAhO8tGf306F3dM9Td
         FENYvV3IgAk2hqEpFRb/ICKXC2TnUttfDpiGSyovhzd2NeXftRdlI2BNHaZQTJfwkP63
         aavUnk17I2C12gNSCzIEWyTU4JooWaMoxbfq/LfVUT3VeXnAwogT1ngpd+AuQlU1HLfe
         +2dPrKlzS1WARtYyYQxoLnZu0J0dPDTgK3wtrfo6hBuZAE75oUq+VtKwAsT7XyH/iVCb
         v8sQ==
X-Gm-Message-State: APjAAAXzS0rslLFO3rZ7HoJ2IjL7sOOZyp/l6yxL4XLGOOfELxoALOuH
        H5FLSDz+71aQdLwFQGQlGVrA5R+JW27gHV0JMnhVfg==
X-Google-Smtp-Source: APXvYqxQgFN4EyvNsq/0cxCAmW7rkasdy2yT7fyEAdqz9b7VC2A3LZlCQUy4eUJQrf+iApcFUDBNEQ5YZAPoK1mi1Ds=
X-Received: by 2002:a05:651c:111c:: with SMTP id d28mr12487289ljo.32.1578947582550;
 Mon, 13 Jan 2020 12:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20200107130844.20763-1-srinivas.kandagatla@linaro.org> <20200107130844.20763-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200107130844.20763-2-srinivas.kandagatla@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Jan 2020 21:32:50 +0100
Message-ID: <CACRpkdY-4zfVa0xmeN1tZ_quDM9kSWgXw4RzEyU0WUZor1oR=A@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: gpio: wcd934x: Add bindings for gpio
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org, bgoswami@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 2:09 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
> gpio controller to control 5 gpios on the chip. This patch adds
> required device tree bindings for it.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to the GPIO tree. This should unbreak dt_bindings_check
according to Rob, so pushing out ASAP.

Yours,
Linus Walleij
