Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B4CC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2459217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZBAZtrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBDVVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:21:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42306 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBDVVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:21:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so10128361pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AtWtJixQXJEvwVUUWZ050sx2Cs96YdK2MYE0iBVoPE=;
        b=UZBAZtrO/decnADrW/v2Xq/F75VWYYRrSDbVnjsCcf9AJS2FNt0kg7UnEyl/QfeFR6
         SI077bR4Uq478O7uAWW5txLfu5k8GVz5TleXHXsrFC3tww/xt6hN2LnMR1SpRwCXT9Gl
         QB3p0Iz8uBk5yDlUouTsdUk4ehTbirgelCTJIgoH39zdUWTp4IwsnrYZ1y81/LGgPwh8
         XYi6jZdHnYEsXAN8cfAtsC4HSXkNPnl+gKPqebDcZueNCD9fBAwOP7hPHJSI3l9DyHYu
         wZ8VP79ux89OGQpXvErnQ3VxSC//losE9Wa4O90v30Twzl7G+SDjWTZTUGhk2Ypjbynr
         uBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AtWtJixQXJEvwVUUWZ050sx2Cs96YdK2MYE0iBVoPE=;
        b=fjCts44SpELcbB6AwjbUxIMdXkLNypGLEI9mV/1L18yiifzweaTUOFqm3QlmCWQjds
         TTkLMIPxdWXTDUlEJYObrLo/PfLgrvfD00+2W5parZ/Fvwt9amOemI6ai7mV0GxGyrvp
         9K5/CZSQOXuPan0iF+1XyiwioEgcXrO8CNRrZVV79Su1gA26kDjKPq11TQcvFXieR0oT
         qJFPGETF4GlKUMrxFmoI7KgyYQYXoAzjCzcGL1B8MZMBVkfFsqwgjHHS+qSHLQ5Lbkb6
         VRFhiIrqYoLOzy5lgbWqBC5hZau3ZkefV3u+wl6Mhe26OURQhQOUKFCc0v8bwYlBx28P
         Mh4g==
X-Gm-Message-State: APjAAAVkyCtLmYrHIsQUiAO7DCzLfbNZH5sS7F8RjKjFICrZsQKahE63
        5xbpk9mQeUGiNe4KqjTUEByH94q009iyWaJe6er8Hg==
X-Google-Smtp-Source: APXvYqzjxjq2pg8zE+N4VlSkSAMXunGecpY+Ekkhv7Ev2K6ODumABErzxwV4JnVRPPf/71iLHE5bwPaoBjpsLoqkzis=
X-Received: by 2002:a63:1d5f:: with SMTP id d31mr33893164pgm.159.1580851263251;
 Tue, 04 Feb 2020 13:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-4-swboyd@chromium.org>
In-Reply-To: <20200204193152.124980-4-swboyd@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Feb 2020 13:20:51 -0800
Message-ID: <CAFd5g45KEKd0NcorYyxpw84FX=H8yeBz8i+GJWEvrMN3Z9aGkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c: qcom-geni: Drop of_platform.h include
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 11:32 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This driver doesn't call any DT platform functions like of_platform_*().
> Remove the include as it isn't used.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
