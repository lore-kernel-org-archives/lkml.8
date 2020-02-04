Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACF4C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3943821582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQmp6/Yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgBDAkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:40:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36629 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDAkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:40:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so6523959plm.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:subject:cc:user-agent:date;
        bh=nDX2pOrFO8+HqSdSgLX9aJulWTBY/K4HRKE5kgWbO3o=;
        b=RQmp6/YfNqfWMLRf7Vpv1rU6ihIhTpfXh2fJauyZWP+ac/wMTKsf+qz10keMfpFaek
         Lr7xSjSsaaAWO2S8eiZsCfg6C4m7VapEm26sWbZ9V2fccFKfS56oJyNJTztMeLIU72qZ
         o/5RBWBySGZg1YT16fcw8EE5cMZYObM5qlydY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:subject:cc
         :user-agent:date;
        bh=nDX2pOrFO8+HqSdSgLX9aJulWTBY/K4HRKE5kgWbO3o=;
        b=PB5DUrhE3kV29pL8BmBdlpnoVaeNq/dcPPGHouKnTxNLJLBl9NTIfGBtFLjzgLxf7n
         uXeIfw5Hwx7UXDFazZD7KOxtRWt3HalinXcSsvFQfhZhi/HF6NHcR1SDoAy5+ZssRJuQ
         nSLYfkoulKXqJMcnNWVzfu/L+SfiZFdu1+93sY1nvkyht81z+8xig6dsju6cZyJIDa/n
         gmGonlHYspBqAu+aDsCMJTrA+a6FAHp6QQRBIaZ0NEftczc/goVLTnicpXwjMcFXw9sl
         qNMrFKEplLDelcSUD2jc2lpkpte44Bn5B6s703o3XnUKZyUdAymXE2uwObYHMbKO3KLI
         bd6A==
X-Gm-Message-State: APjAAAXla12YpKmdH5ifaUmK9yKMekRn3D0/NZASPvh+4DjdoGua0RkK
        k8lgYPPolxG5Da6Jkto1XkskCw==
X-Google-Smtp-Source: APXvYqyNUNXKUOiH6nIoLqHpUNf4PMruM+fuDE/kmUzYKdah7fcsP3wiQTOlxMeXa9QVo0Pmc44D6Q==
X-Received: by 2002:a17:90a:2ec5:: with SMTP id h5mr2347158pjs.79.1580776800370;
        Mon, 03 Feb 2020 16:40:00 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r7sm22171384pfg.34.2020.02.03.16.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 16:39:59 -0800 (PST)
Message-ID: <5e38bd5f.1c69fb81.78a32.df02@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580305919-30946-4-git-send-email-sanm@codeaurora.org>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org> <1580305919-30946-4-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: Re: [PATCH v4 3/8] phy: qcom-qusb2: Add generic QUSB2 V2 PHY support
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 16:39:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-01-29 05:51:54)
> Add generic QUSB2 V2 PHY table so the respective phys
> can use the same table.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

