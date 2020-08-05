Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C284AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9276C22D07
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AzpDX/pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgHERac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgHER2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:28:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C738C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:28:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s15so13288447pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=+NwscihkyAu/FXhdjfSfqJQ0G8XORbep4M6yL43omkw=;
        b=AzpDX/pdttML8hpGnV7CYgVj7jzy9iJBwHCagRD5VIJLhBOLYpn/NezzEuxNPYyCx8
         73ZKBGCorW3UK7rCTphBUubMD6bglVj+kOrX7Q3cYB1YBrNrj05mgMUC/AF9qvcTXjk7
         xREJjWX1463a4osBUjJ8sX8BsGAEdx0lMxzFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=+NwscihkyAu/FXhdjfSfqJQ0G8XORbep4M6yL43omkw=;
        b=BptCIatyo/YdVTEWBEmC1+FEOWfE7cqOQJ9zW5wvq9xXKI+vyfBHTX3ZuAmjRwVXP0
         sNvgCv2FTFHZ9j1d9HAypIV363FZ4XnyKJlYiV12GqQJevDZ5GuaHROaIXdXBkF6k/GU
         J6SvY5cVrA7q4OBUmKTuQZp8/scnmCw05gY1gIvsEtj50hkqeUdLZwPcfsdJdXwrga66
         XI2CA4UrsoZ2PyGCXepiays6+2z+k9QHtb48GN9MGHNCb0qTs5FcjUcw5Zxe8JwU+pnK
         AW206CEZLPstAWdFePLIpGgfEdyREzu0k99FOlgl+uKTy2UrWh0TD0/CnRRlN1TdoR4U
         GZMQ==
X-Gm-Message-State: AOAM532KV6sTH7J71zIFWbcMWKLM9Z0ZOOfHy3gda6+JKGFjzSL6LMZa
        JOzmzEbTaAYyYvFCQhbdz2lguA==
X-Google-Smtp-Source: ABdhPJx4G2QAgYi+0Fmqhi3sFod+CAkH5QH51SVLdpljhnVuosdpblgA0K7YEkZI9Nc/bAtLjfuHTQ==
X-Received: by 2002:aa7:8d95:: with SMTP id i21mr4118213pfr.240.1596648491136;
        Wed, 05 Aug 2020 10:28:11 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y10sm4270672pfp.130.2020.08.05.10.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:28:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200805091141.2.If847565ed7568448c67804f3735d5f8a61eda560@changeid>
References: <20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid> <20200805091141.2.If847565ed7568448c67804f3735d5f8a61eda560@changeid>
Subject: Re: [PATCH 2/2] soc: qcom: aoss: qmp_send() can't handle interruptions so stop pretending
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alex Elder <elder@linaro.org>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 05 Aug 2020 10:28:09 -0700
Message-ID: <159664848938.1360974.193633020977562116@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-08-05 09:16:11)
> The function qmp_send() called wait_event_interruptible_timeout() to
> wait for its interrupt.  However, this function did not check for
> -ERESTARTSYS and assumed that any non-zero return value meant that the
> event happened.
>=20
> While we could try to figure out how to handle interruptions by
> figuring out how to cancel and/or undo our transfer in a race-free way
> and then communicating this status back to all of our callers, that
> seems like a whole lot of complexity.  As I understand it the transfer
> should happen rather quickly and if we're really hitting the 1 second
> timeout we're in deep doggy doodoo anyway.  Let's just use the
> non-interruptible version of the function and call it good enough.
>=20
> Found by code inspection.  No known test cases expose the problem
> described here.
>=20
> Fixes: 2209481409b7 ("soc: qcom: Add AOSS QMP driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

I would put this first in the series as it's an obvious bug fix.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
