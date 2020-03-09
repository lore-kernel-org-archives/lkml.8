Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB5C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7813D2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NT6VnCAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgCIJaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:30:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39828 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIJaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:30:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so7073081lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BPdUCBHlhfxC1rf07ErhiV9Y3RjZ/uMH/FRYyL0Tdo=;
        b=NT6VnCACPTlfQ6tWkirEMRPIFXPc5uK7jgSYi0wnLddxfiCCEj05iElpYaDaH3cZ75
         LqklW21zdCUaNQtn3QFqKyHl0yqr3btYYcm5H6Ka7nVRYJi04kLWL8ehoZFX1T24ci5g
         68/yypQ2HROcI28ReRXFtzEcA7Ukj6JPraEAdjarZILSamvIOefZJJWw3gLWYzIwGyGC
         3rpk0OwRTmQqrGN3iAIz8L9gh1kwpAMa+0uGcPJsfKdGw3qvXLH5MFsbn2Q6I5rsamHy
         i56/xRCkG/2LfWs+C5mD5MK4iVGp5H+Tq4JO1XVq4f0TI9JDDCKnLuIw71tA9Kuzi0/w
         GcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BPdUCBHlhfxC1rf07ErhiV9Y3RjZ/uMH/FRYyL0Tdo=;
        b=Ft/YAiUPwy7RSt3mtHaBDvmsBD+ndBGw+pB/t2Ns/gZSmG17cHVrtnxroG/rBTWIec
         0sxbTSg8SH+Y3SaYKy0RqMH6CnjGkaSMu6/FI6akoKuBJzAzJ5zZG5A/PU+T0ntLt6Gv
         gYEKqGLAIkDk5BblXNE46MPv6XEqR1ZPpUJgpVERE3BDzk4POzHCgSk6SsbccxZG/oqq
         7JbQ3ThSWlS4hBYJd/K3gSV1J07ghQt6QzAwqzSKlfCFhzoQ/1c4v6WhUaSWr5ut43/O
         8VWdJN+SaEpaGr44afwN92sNO3qLxGAp14CyBBVxHZsrqj4Zftq5ZDIi78thgZMoVOmw
         Z4OA==
X-Gm-Message-State: ANhLgQ1oifvdeLO3D1zJgLdePnZFwsyecUWlixy2tLPOyEzZzvtIhGRD
        nevbgWv1q1neJoyltcH84tn5lt3SF7vfWJx1RBQ4hQ==
X-Google-Smtp-Source: ADFU+vvOV5BngHUN/iOXkIp0aCZj3DO7RIX6/Jfe8ek7Mb4Q3qAwKJPpaPcDy0NqYQc1dT6I+NcBqHSrx9nC2FYST9M=
X-Received: by 2002:ac2:5e6d:: with SMTP id a13mr9224214lfr.89.1583746219481;
 Mon, 09 Mar 2020 02:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200306005809.38530-1-alexandre.belloni@bootlin.com> <20200306005809.38530-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20200306005809.38530-2-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Mar 2020 10:30:08 +0100
Message-ID: <CACRpkdbs_wtyU5wjqFcdpYanA9ZMRczysw4kwkA7y+qeB0pHEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: pl031: set range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 1:58 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The PL031 and ST v1 RTC are 32bit seconds counters. STv2 is a BCD RTC
> apparently going from 0000 to 9999, hopefully handling the leap days
> properly until then.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
