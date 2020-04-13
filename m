Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D59F2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="msSaILPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgDMQSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731429AbgDMQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:18:13 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2BCC0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:18:12 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id 74so3292574uau.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxavWCT24jIuFXqrtLF2I2Zgrd6r4LKh480arMC2+lQ=;
        b=msSaILPI9zCObtNnipbVnToRXsRM3FDo1JT47d/JoGzgTaXbk68YCd2H6SUljk50+7
         D3PSOkFLlcDUf/wGiSzQRVp1NU/KdaOYBIwd5LPCkUOBI4c8L7MgThKgwg5CnvAUq+5g
         mhDZbMLfCJuP1MAe3AXbA25tc1ztHL0MaO1Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxavWCT24jIuFXqrtLF2I2Zgrd6r4LKh480arMC2+lQ=;
        b=oADTC3He3HgXlKecXbxOkKY7UsLv8bbU1X8kbGhBtODV+1sXY61qixMy1DZlv4Kme0
         TD4He0GHL03Q5B+EaJ/QEiahHY5D3Xsk5nanIJPHhrfWyvmO/t3qjfdIWWG5AoytAeWO
         ILq7E9XQNvDSl/c64Wt5EcLUsfSauH9M5Sria0jagOQSrnA8sFY72jYEU5WYgs8R1Ff8
         vJ/oQBO9SmBUy4MbQVVm2C5QqreD09cRwqFNMOEDTgScWF2Xl7nIbqikTTlQ8V23gDF1
         iyU3F1WD599wV9nzMiBy6VcavPDV3S6VhwxJPkHLhULgwbvwsGplsBF6dtj3YSYAHepE
         g97g==
X-Gm-Message-State: AGi0PubdRAy/j8hI/GqZyVf1ljx53E3n98pj+oboliQxB+1f3W9gTwQB
        q9hnO/ts/9SN2rMcgGKOMgJaCNUUm5M=
X-Google-Smtp-Source: APiQypLi2t2Y38c3AV3ltP/tVO9a6hYrJbFofgIAtj4ngP0kJZOawOvbsH/TXZxzhu9vKRNyTlJN/w==
X-Received: by 2002:ab0:6c4f:: with SMTP id q15mr11129950uas.78.1586794691650;
        Mon, 13 Apr 2020 09:18:11 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 60sm2853607uaa.5.2020.04.13.09.18.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:18:10 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id z1so1717248vsn.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:18:09 -0700 (PDT)
X-Received: by 2002:a67:8dc8:: with SMTP id p191mr12836211vsd.198.1586794688896;
 Mon, 13 Apr 2020 09:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <1586703004-13674-1-git-send-email-mkshah@codeaurora.org> <1586703004-13674-5-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1586703004-13674-5-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Apr 2020 09:17:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WknGB=MRzf3J_FtN5p7V3Y1PVpEhBVDXOH+kEvatkn1w@mail.gmail.com>
Message-ID: <CAD=FV=WknGB=MRzf3J_FtN5p7V3Y1PVpEhBVDXOH+kEvatkn1w@mail.gmail.com>
Subject: Re: [PATCH v17 4/6] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 12, 2020 at 7:50 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/atomic.h>
>  #include <linux/bug.h>
> +#include <linux/lockdep.h>
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>

A, B, L, C, D, E, F, G, H, I, J, K

...which letter doesn't belong?  ;-)

IMO could be fixed in a follow-up patch or by a maintainer when applying.

-Doug
