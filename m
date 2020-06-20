Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD193C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F50C2469C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJDRoyXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFTUnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:43:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45145 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgFTUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:43:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7so7470892lfi.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcFxZDJV0JE7EILOFQLnvdmPuPHbFA43GAORC1SuIgc=;
        b=UJDRoyXfza9eu6l9hI9fr7ez3X/6F/4uo85Ob3sf281CMgHH3m+Mtx913shdmjDCe0
         wzT1brbPxl7u1YLem58YAbAa4VpZFhvnGvMihW/TlnF6bZ1DoH/Wu+ayNVzRC6yB28kw
         7TlBjKeoqPAGw7KP7ahp3CrVxtxGP+gXNgau75MLjl6u/z5yMPZf5QKKEy7le2fxjfjk
         q92+piYiIAsi8zTdAD0tFoH7sTEIpefFXSn3742nZAZBLtDSIGpF65YMY/aPDU7SHUs+
         M/HOxh1ELVqvlSqscMPa0KBYOA8R8J5zdAbxcXIxdltWl0DL8oMAxbyMonfdoQHqtsRR
         oLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcFxZDJV0JE7EILOFQLnvdmPuPHbFA43GAORC1SuIgc=;
        b=hl0P6aGdOUsAwsD9qTaN4kRbEbmE4Gj17eCtLDjSd1AAjEAFoR+2rAyTiklvV0Qvrn
         cY0RHjPYdMddA45tKkvodLW+1vu2KaZwKyPxn1AOicesBV+Q5KmeKjw4UOebySVRYY0W
         AUDtGgaAc5qCWCwvSAMSv6tme4ky2GZ1dK+lyKxi1TsfKQT0M1+AX7OyHMi+3R4r9fV2
         7Gt+jay0APUOJChvPX2TEVPDEBXWIVUKpcN4tUQ862wGnkS1SNrSsj7F9kj44J6u98Le
         Ughdnd24MLhe8foVBO04uYKA7fXV4xp2C6besAp0/RuEvL5pWdchox64hi+C46XQ37IS
         wk9A==
X-Gm-Message-State: AOAM532CCjL6mtWr6HFq7JGv9cFEDqdUCIF5dJarvA6rNpMwBrfAWDTC
        /aA7sjoHEVDCL+3bhniqmqHVqLMorBnrM6jXZ/FaDA==
X-Google-Smtp-Source: ABdhPJxYtAEDvRBSpp8tdmOckarOes/SsxhEPpZ0qNeeF/xp2t4qLjK5NUS7m1mNGy9cL9z49GKsu9JGaSMlrHxtXso=
X-Received: by 2002:a05:6512:31ce:: with SMTP id j14mr1633403lfe.47.1592685732304;
 Sat, 20 Jun 2020 13:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200612112758.GA3407886@x1>
In-Reply-To: <20200612112758.GA3407886@x1>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 22:42:01 +0200
Message-ID: <CACRpkdY8u8DxtO9nv5_Y17H3cs+ExvUOGEhmwWqz34q-QTRNtg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: single: fix function name in documentation
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 1:28 PM Drew Fustini <drew@beagleboard.org> wrote:

> Use the correct the function name in the documentation for
> "pcs_parse_one_pinctrl_entry()".
>
> "smux_parse_one_pinctrl_entry()" appears to be an artifact from the
> development of a prior patch series ("simple pinmux driver") which
> transformed into pinctrl-single.
>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Patch applied for fixes.

Yours,
Linus Walleij
