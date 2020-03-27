Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5783C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EFC206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rROi4bYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgC0Xd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:33:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41570 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgC0Xd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:33:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id n17so11985062lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=31OCCdsx5Mp+cw9g2eq/fgIixaxEpyfnaxTPFOvJXaY=;
        b=rROi4bYmrya2laI29eBwhRi8+o0B6pv0VQ0S87fTvDSOO1fI2+V4b0Vi3Qd9NE/cXJ
         mMu507vWPOzoHxkFh2PXEEBozO56iynS+gc+aU1gUJabRDrk2QYOHuA/j6obtc63r+sK
         lBRbPiCQBu8h/FWzdqlqAKITKpNDgAXfGSi07YfsXX/K2J4DNy6xR30fZIBi93GTKn1Y
         58Na3pTmM2nCqEvEDt3cI16oM911yve6Zu8EVsJZxVO9ub+FXvBuKgX9nwRB+iHbMBrZ
         gKGbaefg4CamnX8bzITzpgwiRzpSPf0giuE6Y5joLA+AG9CL5gVR3mH01HLuYA9oCTbG
         C88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=31OCCdsx5Mp+cw9g2eq/fgIixaxEpyfnaxTPFOvJXaY=;
        b=YwJ3PAg6iCDswwqL9cq0xPnwXh5bKLwNuL7JYZokLWCFaqE0aYicEYg9J1yZaMzCG8
         heLh8dYyAcQZmDrioXACgzLhJf7mttzyhc9SaLBWw4xdSoDjXc4cV+NJ6G82bdLKBk5I
         d25QSLzUYOVOVG9vNNSR6WL72Wx7sI8ERHMLRG55isS+BINwrnPjysFjuH/MeXKPes46
         ACsivyo3voC/Het3djNhZfMCDqt30Bj64SSCpJ6itQSOxYKEcinElByUUJED8NkApZxL
         ksMoS1rj8tYELmEUo5pywrzGCBCLZz/dFNoI2cyBqxk9OlqIQd4r1htENGGMOVX6gU/y
         y0Ww==
X-Gm-Message-State: AGi0PubRLi/M8eiRDy+GWNgTbz92VUdy5T8BJKsZjh5DyKV3ngLbdXJ3
        UxWw1hcCbbsWmNpgVTFtxJGj8p2yXunbZEX5ZOgynQ==
X-Google-Smtp-Source: APiQypI/NjrojqWxdb8e6IfCyjtcaINz+cXlEUyGidd5WOLU+ClWfg8pCJNKY7+Nnm9MsxpZbuwSJaUnMrtX8Xx3U+Q=
X-Received: by 2002:a05:651c:445:: with SMTP id g5mr723803ljg.125.1585352034393;
 Fri, 27 Mar 2020 16:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200327223209.20409-1-ansuelsmth@gmail.com>
In-Reply-To: <20200327223209.20409-1-ansuelsmth@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Mar 2020 00:33:42 +0100
Message-ID: <CACRpkdaemQ_udn=TawvcSrUgmnw4eG0ASpjTC-0hjJCP-hCQ_w@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: qcom: use scm_call to route GPIO irq to Apps
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Ajay Kishore <akisho@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:32 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:

> From: Ajay Kishore <akisho@codeaurora.org>
>
> For IPQ806x targets, TZ protects the registers that are used to
> configure the routing of interrupts to a target processor.
> To resolve this, this patch uses scm call to route GPIO interrupts
> to application processor. Also the scm call interface is changed.
>
> Signed-off-by: Ajay Kishore <akisho@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
> v3:
> * Rename route_to_apps to intr_target_use_scm
> * Follow standard design and rename base_reg to phys_base
> * Add additional comments in route interrupts condition

Patch applied with Bj=C3=B6rn's review tag.

Yours,
Linus Walleij
