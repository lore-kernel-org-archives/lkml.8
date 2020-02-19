Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9BC5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004222464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ELKjPCAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgBSWwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:52:30 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40784 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgBSWw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:52:29 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so2672pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ZFoLB6pXpWwVB/0/nffKZvl9x/yuFK41bQrQqAdnUDU=;
        b=ELKjPCAsP9wn4m64lhqgq4GsDkSec4foH+Z4EnFjf6Law40CGWBtMXKTU1TahNqTao
         JrMKYq+VwFQ8yCdkMa9xx+hxKabDXCc4EQx8z0/GoIH9f7xcv7EhMqIuc0kvh+gkzv2t
         ytn6ROGRkgTmIzG2qPqCQb/R3Jf5eN5n+q+s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ZFoLB6pXpWwVB/0/nffKZvl9x/yuFK41bQrQqAdnUDU=;
        b=RC5e59DhmF7r5SpjNOjFVKp1+HFwI3U+ZrI68E/1bK9+k3HU2L8eyORwetLLM8xCHd
         RGJaLBVlJ1M7R+bySTCkl83TyFy1EAE4ms/eBpW7Oj3ofADAEAMgzG/cjvWu5BVt2GQW
         SB1FmlzcHtqvYpw/f1d2FJI8Gt96D1QQdxf3EVYJr1iF38mGIZVzbn2oC6eKrbTzq3Ng
         H+qrwWJlcoBDfuZ5GKqe3FMVj9HRPtMT3blZrXbRmS2ntKuN+OmtCkjoo0nomyNVsz7w
         aQ/Z+YMw8728rGDdBO5rpNS6STYl3B85uZvg6y6G5upapaumaEtr/rcgjxEoZeVxNMPN
         HJdg==
X-Gm-Message-State: APjAAAVOmnE910v4Pzqf98VhD8m3IK7tvyrRDHuQr3HD6vbk8shjY8TY
        mt+/683iqol5nemP9nJxojAAHw==
X-Google-Smtp-Source: APXvYqzyMU1+wblbZiSb70HWL3nCcboMCE3sFJ00Oxk4gmWezLb8kmCwTc1+/jgiWjZuoIZb3VlUkA==
X-Received: by 2002:a17:902:265:: with SMTP id 92mr26471493plc.292.1582152748063;
        Wed, 19 Feb 2020 14:52:28 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x10sm662447pfi.180.2020.02.19.14.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:52:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eb967cd5a374fa32d93e486b1c9fd7e56796629a.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <eb967cd5a374fa32d93e486b1c9fd7e56796629a.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 6/8] drivers: thermal: tsens: Add watchdog support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:52:26 -0800
Message-ID: <158215274684.184098.4618542372318170687@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:10)
> TSENS IP v2.3 onwards adds support for a watchdog to detect if the TSENS
> HW FSM is stuck. Add support to detect and restart the FSM in the
> driver. The watchdog is configured by the bootloader, we just enable the
> watchdog bark as a debug feature in the kernel.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
