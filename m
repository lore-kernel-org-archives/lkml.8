Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36644C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C64A2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJgmdmXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbgEYJC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgEYJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:02:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CBAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:02:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l15so19571574lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hg/OH74DORU9tQYyoK6Bqm4fFp4PsuIpQ1XLjl+5O0=;
        b=nJgmdmXKEcK518FOp+NQL3H6U+rX+6T2vs7v/hbMr9J7mT+2oqY5KESoJrLLAjOUG9
         uZQP1RTQZ59BZRCli+A8sOYo+oCK7EjHGwWIJD7hMZeI49fs0lVC7oMvLSsrEaCdeYd7
         D9ftD2zAvSNkl8FFKRMqVMuY2uWNqV+eUM+Ubhy8lyZ4Oan76ifF3HzMV80DsH0eWWwe
         z/RYZU/PENhp4FyyFK+yA0dUh5joa/UuWAWxgcBchUTn1H5kvYWb/pD1B55BLWpj9Rb9
         Q12oVhjQlXXxI49ZU5keD+FfG/wX4BZr6dj+DxxLXS2e8op5jpfTGZw4yAuPM+OtzzYX
         mPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hg/OH74DORU9tQYyoK6Bqm4fFp4PsuIpQ1XLjl+5O0=;
        b=Sj/HZsNZKc/K5HZTywt9jKQlQMpwFAmPGPfH9R8GOLNaxgAjszResmz7S9I82Dyb++
         Z22ORpcdAZZcKm/Q1JZzzutlaV870uUm+gJRCw3OluN84E9SI1ybyiuwDol2pi9uVCz1
         GIv46DZEHWlCtJmitwwxhz1Rs6Wt6LHF75Zzh3xRyPDCYlaBjgoD84loXaCh1tJ+xg7X
         CcD7g3F5xjPQQ9QYMI2/I74DC3RyDwVby2lwxex6VhG+mXeGvTci2YL96ggLsYryFLG8
         8d6czk15ey/El/ULQUnhX9Mj9vHCyNQVZgyQNwE92AYm1ATt79qexVTe8n1B7EbQvG2Z
         Sv1Q==
X-Gm-Message-State: AOAM531a3ACRMymUxTaO5BtOniwn8lDnyYj/nxT/HBRuuXs6sD8H/HmM
        Un5oAN7IQGIQ9ZladYEN7IVcJpR1J1jWMycnOhuDhw==
X-Google-Smtp-Source: ABdhPJwWFwfymHIMrEwH+BYN7cjY1SJ5pJ5xBRDS9aLWhYF4MaLelR7tHM5Ct+bMfDm+2aOeyWd13ahqyngusi6HRaY=
X-Received: by 2002:a2e:9716:: with SMTP id r22mr13965648lji.293.1590397344884;
 Mon, 25 May 2020 02:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <1589817025-21886-1-git-send-email-groverm@codeaurora.org> <20200519013813.GU2165@builder.lan>
In-Reply-To: <20200519013813.GU2165@builder.lan>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 11:02:14 +0200
Message-ID: <CACRpkdbSsVcy=6Bo42SnPqgKoa+jNanmBEXix_yv6aNK8VcreQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: Add check for pinctrl group is valid
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mayank Grover <groverm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 3:39 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> @Linus, we started off with something similar for GPIOs and ended up
> with the logic in the core code. Should we somehow try to do the same
> for pinctrl?

msm_pingroup_is_valid() looks very reusable but I'm afraid I do not
understand the implicit assumptions around it, but I guess yes,
if it can be properly documented etc.

Yours,
Linus Walleij
