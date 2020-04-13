Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D1C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB6A20692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hK+WqM+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbgDMXD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389888AbgDMXDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 19:03:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95BC0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:03:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so3955174plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=HERDNU5OH+PvjNlr9iQyGhHNhXKozsGVzeIq4WUGW3k=;
        b=hK+WqM+t96PiNuHXnWPqKHQPZc1JGNjJWJT5mEzKRTCelbFKPswB36sT0fKUvXoF6k
         O2ceUOlo8V6WR/TmUKoHcnZZXePSwNxeVe/xlEr/Fbbu6mge5v6VoQBxguXpNmvImQ2a
         uNEhY+bbLVSmRdItQ8b48Zd4wUUsA1+ogPBcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=HERDNU5OH+PvjNlr9iQyGhHNhXKozsGVzeIq4WUGW3k=;
        b=pbJIKtwP5WsNH/0KdGB2G85CoKngNWe/YFgSmJUxjFzHjG53Qx32sE5KvlDwyDJnjw
         si3p/LQSm57hcfF6ZQy9/YzgNRDhrlS+Tpzxy0DlhjAPXhc9fwqZmDRmBiO7sWE/KV4K
         QNGI40oH86shU/opIV0roCVBDAfBaSpyj1awwWE+DSGWgLdgTzRgURobQ7GYskkLlNUg
         Co78CJiikOH9OFUgUEPs+tocHblr8kv9sKX29yvkJdPBT5o+Es2BZiwfxcBika4h4IkA
         3C562kzSNSwyV8LPSr7/ZCjEHmJ2cdig/FhqTQrimv2C5qXzgOiSk2XkDQkkJhojEQ+E
         +arw==
X-Gm-Message-State: AGi0Pua6mHF5XgX1IzaK2fbTzFquHQxJq10qUI4MBIIcyHaiYIWCzAvD
        DJSg0rjJIY/0B4sSGCU0w/ROHQ==
X-Google-Smtp-Source: APiQypKf1Cahutocem0pTsNwiMfVJ7pWZwqfgLYmUySDTv+Vq+QdlltB30vGfcmlfX5PJ1948DUtXg==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr750180pjk.58.1586818999764;
        Mon, 13 Apr 2020 16:03:19 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s62sm9126455pfb.53.2020.04.13.16.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 16:03:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200413100321.v4.10.I2adf93809c692d0b673e1a86ea97c45644aa8d97@changeid>
References: <20200413170415.32463-1-dianders@chromium.org> <20200413100321.v4.10.I2adf93809c692d0b673e1a86ea97c45644aa8d97@changeid>
Subject: Re: [PATCH v4 10/10] drivers: qcom: rpmh-rsc: read_tcs_reg()/write_tcs_reg() are not for IRQ
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Date:   Mon, 13 Apr 2020 16:03:18 -0700
Message-ID: <158681899842.84447.11598381397445180535@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-13 10:04:15)
> The RSC_DRV_IRQ_ENABLE, RSC_DRV_IRQ_STATUS, and RSC_DRV_IRQ_CLEAR
> registers are not part of TCS 0.  Let's not pretend that they are by
> using read_tcs_reg() and write_tcs_reg() and passing a bogus tcs_id of
> 0.  We could introduce a new wrapper for these registers but it
> wouldn't buy us much.  Let's just read/write directly.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
> Tested-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
