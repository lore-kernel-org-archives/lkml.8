Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5BC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABDD20657
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YGcbcvjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbgGWAu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGWAu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:50:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F514C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:50:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so2177623pgc.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=79nT7TCbavlKTvAjlFmsWU03rk/qHwKF6zh8YUZSTdQ=;
        b=YGcbcvjoJjGEJsEwK341b8LPPW7cY21tCnUUKGLZdYMzOpv1ClesbiLphb7xZEIZS6
         vw5zovR/9Q/GbHbAg8bdOPaF+YsjC4p4UCxlugGH/DR6WIBtE9r5Ek9ZuqnL5pMkhuyC
         OGvlX+dW1ci8SrYuWRKyzsfVBEwt7BMr/51Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=79nT7TCbavlKTvAjlFmsWU03rk/qHwKF6zh8YUZSTdQ=;
        b=Onrpua8rCzy67y0GtZqpQLWV23bmqMBl3vwEEnZWyc/Vqmt19unWTU6azeVrydUp1z
         Lc9/5zWm6qoFvR29FEFw48KMGO/HqVkSBKDmgw32b1CMYH/UhhWKLsolDpuwyg/gUHRm
         dXxkAgBFxun7aAa+BgGYCk4wAVne5H6yds1ed9tURle8KfP3hr2OCAck7lgiyjcMA90Q
         231w3tjXssfnnxtzfJcD/ke3KgLyX80L8afLluV4gmxVZ1aMjgw1jVY+2dAKPqTC6anV
         D1QoDJla6cc0hxpd9JBXO+3YVTg4dkgYBApriXcaBPfmLLmzivKeKvggR5mMd2LKjGg4
         7wAA==
X-Gm-Message-State: AOAM532MgUxxM5yUSvcoyNhL0ZBtbua6UAYxqoU6pdu7wNj4LGiP1oej
        eu261rURPw46Tp/a8f4vxT1ewQ==
X-Google-Smtp-Source: ABdhPJxw9gftHTfZNdHBmj/aQ6rhgFvRetcUhJQU0A9vN+tOj4m1E+bJ8Ea3rQPb2K6hftFAYQmGLg==
X-Received: by 2002:a65:448c:: with SMTP id l12mr2045251pgq.234.1595465426001;
        Wed, 22 Jul 2020 17:50:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id m9sm815681pjs.18.2020.07.22.17.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 17:50:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200722150113.1.Ia50ab5cb8a6d3a73d302e6bdc25542d48ffd27f4@changeid>
References: <20200722150113.1.Ia50ab5cb8a6d3a73d302e6bdc25542d48ffd27f4@changeid>
Subject: Re: [PATCH] soc: qcom-geni-se: Don't use relaxed writes when writing commands
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Wolfram Sang <wsa@the-dreams.de>, msavaliy@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 22 Jul 2020 17:50:24 -0700
Message-ID: <159546542444.3847286.3076597427214316886@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-07-22 15:01:20)
> Writing the command is the final step in kicking off a transfer.
> Let's use writel() to ensure that any other memory accesses are done
> before the command kicks off.  It's expected that this is mostly
> relevant if we're in DMA mode but since it doesn't appear to regress
> performance in a measurable way [1] even in PIO mode and it's easier
> to reason about then let's just always use it.
>=20
> NOTE: this patch came about due to code inspection.  No actual
> problems were observed that this patch fixes.
>=20
> [1] Tested by timing "flashrom -p ec" on a Chromebook which stresses
> GENI SPI a lot.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
