Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99456C47256
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FE7206F1
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MX/rAT1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgECHx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727821AbgECHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 03:53:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3871FC061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 00:53:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so3973398pfn.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=lqjnPYXn32XDo0uwwbeceHVvngW84dUENikJcKKBwN8=;
        b=MX/rAT1krwugoSlkOJy58eX7DRDLePH+rS7wFPUOwLlifDlqi8IS+F0L8nX9/Otiv3
         QBlTaKbtTMTJdYlK+uwvG2oJqGNZTl0bHJm54XLZnZN6ZbMneyBdnrWLAvoaLjK2uXrT
         8PrwH7of8SHNemxoNxWHf4PXv6ZffOFZCd0NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=lqjnPYXn32XDo0uwwbeceHVvngW84dUENikJcKKBwN8=;
        b=iDwQ+Mn/3UZKqkoNRalldPq5ucCa5+FhQwPBXebBEaVQjKdyCsHBe/2QDXsAMmYDCN
         opo6fwvbuw2eCegKquKyn05+UG3usQVhe7I3pQjpuoWsqz3lBIZmBDFOX0UBJ5oTHiAA
         MbuPLZX9GULINpCLR6Ex6XlIVvQKMZEmXhOs3AG8565prlSCj9UtUx8XfxfhBrkcVDWH
         fdSazEk8vyQK1OkJ/Rz/Swh3TR1oISYMN+foR5tqkmKLNgRvRmN9W3Z5bmo6m9HOLL3h
         +5J8d3BYOpcMQpWA1WTNZKn31Wp/aPmUXAanhCvqQVowt3bUycYCbbYM7zoFxwGeSsC9
         tw1g==
X-Gm-Message-State: AGi0PubwYOVN+zlg81O0eoWy3t0P0sWbKkqxS269fmUVVYcmWsr6UhBh
        5EdB/B0hFXyiNkMwlocJ4PckeQ==
X-Google-Smtp-Source: APiQypKuQsStdUvfPGRsK8okPUJ9KuVy7WCe8oITb3Qnf5Usr7WIzv1W2pNeujbXzvH3hQ8jASco9g==
X-Received: by 2002:a63:1608:: with SMTP id w8mr4704729pgl.232.1588492438795;
        Sun, 03 May 2020 00:53:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k6sm3677501pju.44.2020.05.03.00.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 00:53:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200424085121.1.I9d1e84d30f488cdb5a957f582abaecd2c0b24d70@changeid>
References: <20200424085121.1.I9d1e84d30f488cdb5a957f582abaecd2c0b24d70@changeid>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add "no-map" to cmd_db reserved area
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Sun, 03 May 2020 00:53:57 -0700
Message-ID: <158849243728.11125.2420286390909147729@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-24 08:51:29)
> The example in the bindings and all the current users (except sc7180)
> have "no-map".  I'm pretty sure we need it on sc7180 too.  Add it.
>=20
> Fixes: e0abc5eb526e ("arm64: dts: qcom: sc7180: Add cmd_db reserved area")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
