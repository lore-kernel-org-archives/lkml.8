Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17948C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E917A2065F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SjdFktkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGYAOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgGYAOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:14:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF967C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:14:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n22so11612533ejy.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+Vu9pSlrXeJ0YA5vWHf53k6LVNR1H6tyHZmx21hYRQ=;
        b=SjdFktkRZL5d9npLMGNf69oDrZeerMTNoyzDanecRnbmMLkkCIovy5VZzvZI9H6ZrE
         wf7ggS1ZDWHplJE+/Rr6YYYW2Z/GmcKEAOxxbY8kHCtfA1cZZuMsSF4unXlrp05YmoKp
         BzaKkLMhAS/juljjaUHYbMbZIBZuyPfCEsagQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+Vu9pSlrXeJ0YA5vWHf53k6LVNR1H6tyHZmx21hYRQ=;
        b=l6q71a9hTAO7Rawpx4LfdKpRNg88V1vURcUCdZGoXDwp6z3HoU77oc2XdePB21+ch4
         VJULb+STHeDzKJPDYU8HklAzHRws3duHcQapkjumMrmc4YTvUnDU/Ukv3/zZthW8oiTd
         eA7j3S9t7g295oTs3VVYC+R3IENZIjvK9sX6yRqcIufv8MqFmDJieSKYa3v9yzRzWXeR
         9nzERbSV042F4BMextZKkyYJH19lyqKWIpuMqTFQ0Yn+2DhzjQu5XV+Qu9PfMxXgHrH4
         niTn85lGuXMmpDFjEaHv+7EWbz+9cOxSPUAbTXGmRhBTmjRD9S4yevWRU6voSUxzaEdq
         SBRw==
X-Gm-Message-State: AOAM531Un/I5b7DLXFjRL2MvMRveF3vPED6J9mczQ6Fwy5/rGQFEHe71
        9T+DZNFXT6dzP7dq0qFPUTxeTB/f15k=
X-Google-Smtp-Source: ABdhPJy/SPdQuy9cb0v0GIEBBosy4QeRBSV4FrVR6r8IBAJ+q737dR4RMmiXE/kCZiMD1XCpPzHaWA==
X-Received: by 2002:a17:906:960a:: with SMTP id s10mr1741142ejx.60.1595636085053;
        Fri, 24 Jul 2020 17:14:45 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id y7sm1613432ejd.73.2020.07.24.17.14.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 17:14:44 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id 88so9712559wrh.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:14:44 -0700 (PDT)
X-Received: by 2002:a5d:6744:: with SMTP id l4mr8918727wrw.105.1595636083918;
 Fri, 24 Jul 2020 17:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-4-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-4-swboyd@chromium.org>
From:   Daniel Campello <campello@chromium.org>
Date:   Fri, 24 Jul 2020 18:14:07 -0600
X-Gmail-Original-Message-ID: <CAHcu+Va3wWW_5eONbdD_VL2H3p-u3-jv_MxBR7G5hFwCr6w+tA@mail.gmail.com>
Message-ID: <CAHcu+Va3wWW_5eONbdD_VL2H3p-u3-jv_MxBR7G5hFwCr6w+tA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: sx9310: whoami is unsigned
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 3:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This is an unsigned value, actually it's a u8 but regmap doesn't handle
> that easily. Let's make it unsigned throughout so that we don't need to
> worry about signed vs. unsigned comparison behavior.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Daniel Campello <campello@chromium.org>
