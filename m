Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5400EC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4020866
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXkFRFdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCIJjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:39:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42051 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:39:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so9156710ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWafhgkHqGjhRe8y+m1pE0quFmlowBtOnAE/oPWGyN0=;
        b=vXkFRFdzlpOZtT+31ydgd9FX6Z1Zvo7ZtEaYUUUUW+uBV0RVnItMZc3YcFbcE7StgI
         vFAu7B5k5ORVKbJJlmV5EaSIhBSm06bToQPWxW2sw0hcVM+qy6K+yhMcZaQzIacJvJnk
         me07kNBcAGV55Bm1xfEIxflpbzWiBrTxe/u04FpXKoHPfK+iddC/bwDnFI2tr0SQIOyd
         iElasMAdPOJOJjbiD8Df9etU+Xl/hIVTSSAN4OFehXJBCj5AukvJdc+mEHgduzN6ckSU
         pA9oabtckEopSKnlebbTUOLNLAse71uhJXUJks5a8jE7XQC1qt36yei5GNrrB10bz5C7
         UIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWafhgkHqGjhRe8y+m1pE0quFmlowBtOnAE/oPWGyN0=;
        b=dmO66drECLc5H4Yw6bfHqQhO5xCgK/dfqcLaLoCQ13H1p6+A7nm9r882HwNf1m604D
         Rd4UqTQN8rPvWehGAb7GPgaqNNb4NNhrGkzv22HwFvbcsJlrmQTpciLZUo9Aq4ekvV+W
         xUAN+dFyepuwo9ObO/a8L7Yzpd5KU7PAKW1ybzc0N8ct8iKJrCmczzvQNfqm9RZ0iYrZ
         Xr9ooyZWTsTCMOxcDTu47v5w/LmtS14tY2tKDkNZ+9Fkc9F6L69x11AB9hj4P0T2mbp0
         gRoDR4w08E7LwQmwGejVbjRBlaFtRBBnbkxKmmIFBBhEhGIqxfO0WFD9BBXTSoA5WqV9
         9xjQ==
X-Gm-Message-State: ANhLgQ3GvTzCPHCl3DznahliNPN6Mmr2EVwnSJJEQbRXP6L2SXhrV3IL
        mph19EMZ4AcA1G2nD7hTRjqMA/V/AUZ3X5807gCpWg==
X-Google-Smtp-Source: ADFU+vu6HqaH4j3SJuv247SDzYUyvCKTi4MauowZ3Ck69fFNO8x9HHykET10xqulLd8bodNOiiPts9wgXPa49Wa6eH0=
X-Received: by 2002:a2e:894d:: with SMTP id b13mr8156479ljk.99.1583746761788;
 Mon, 09 Mar 2020 02:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200306010101.39517-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20200306010101.39517-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Mar 2020 10:39:10 +0100
Message-ID: <CACRpkdZ_GdA=37mng6OBA=9JAVGxesAJF2_DeYBOzJy3Y1UvDg@mail.gmail.com>
Subject: Re: [PATCH] rtc: ab8500: switch to rtc_time64_to_tm/rtc_tm_to_time64
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

On Fri, Mar 6, 2020 at 2:01 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Call the 64bit versions of rtc_tm time conversion.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
