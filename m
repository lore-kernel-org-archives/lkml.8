Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F1EC10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA7E2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRH0acWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgCIJa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:30:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34873 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgCIJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:30:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id u12so4945874ljo.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYcdgI6FvewhDZOpmZcO42Ni58JD8wtrbZBYBFXrvO0=;
        b=sRH0acWgVBB+9NR/UF5Prr3uv/MZcxnZ+8nOsAZrAiX2cGHuBUSZGp5KF76D51wW5+
         1vYXf1TBVeSiGoEsT2pmlwUhOuepbYKdlkjCPVCw4sBtFaOPwmOdSJI3sSaM7tq0uNG6
         siccDlzUYxpVRNs2MaD9/nYbm8BWPBDdVmWXomSKG9mCt46XKyPZpSuLt8OvyB83k2mi
         L2eZQBNi55o/zfEG7a/Zm0ke8ZxW9xPo8Hok6vXKrAiSYV7mXwPnnJRr6635mKt1SMGC
         Dsrukcb2WSwlW6OQ5Ee68+LNBCmgcXiVt3Fhz4fwpJGbbJpPcJHgCykIMfdN9OKiFTGh
         T/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYcdgI6FvewhDZOpmZcO42Ni58JD8wtrbZBYBFXrvO0=;
        b=THSBLNQ2Jo+4JO/hfBqPmdToyCWOBC/W+dOJAguWVAirYK0vdbOAhElrZBsn+0Cc2N
         Wat7u46DeXNh0OgApyqXbnswExhFc4KTrROcaijLtuB8UWhCsnlQiWCbVtmaB86M6ste
         M81YHerumaqYnki96QVHHdzPF/JIAwxq0wwxDadyBWAYpLL7RE79Swh8tuWgf+uw1xMz
         RITRcesXtcKEPTWgOtBmyF1b90Vv/Nm8ya4lRVSmT+fJf9y9i4+UK6EvpdTQezDsWPPy
         W5XKwixS/QHljlDyHtJyJpY/LCGx/sm2L2FtSPwsQOxZz727uxI/7vk4H9ocsTRJQzFb
         CyAA==
X-Gm-Message-State: ANhLgQ1toVuB+N2OiQzd58jhFIzLDDGBbTTp2/VPlBStmgJmoJV+2t58
        RnlVB3SXh/vbP22kMucvZGPpLAwp9UlJ+gqW+gED6Q==
X-Google-Smtp-Source: ADFU+vuye/I8arS2yl53n56BiFwgYP0noR11NDx+eCmf1Q8F7bLzVJ3uGQe5T1ymxPZxIR9TSkq+SUJBK9BAL8hqd5Y=
X-Received: by 2002:a05:651c:1026:: with SMTP id w6mr908328ljm.168.1583746255448;
 Mon, 09 Mar 2020 02:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200306005809.38530-1-alexandre.belloni@bootlin.com> <20200306005809.38530-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20200306005809.38530-3-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Mar 2020 10:30:44 +0100
Message-ID: <CACRpkdZxnkni+zjYn2vgPGVLDMDghzdu8U4Parp8MSQb6CycfA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: pl031: switch to rtc_time64_to_tm/rtc_tm_to_time64
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

> Call the 64bit versions of rtc_tm time conversion to allow extending
> support after 2106 and properly supporting the STv2 range.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
