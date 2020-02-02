Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B96AC3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 04:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0149820838
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 04:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F+wcw4jJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBEls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 23:41:48 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:42243 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgBBElr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 23:41:47 -0500
Received: by mail-pg1-f182.google.com with SMTP id w21so130446pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 20:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:subject:to:cc:user-agent:date;
        bh=jX0fufKYZvyZ8epx+GgARD/j3hIwfF8CK7/JT+nLQUg=;
        b=F+wcw4jJSFXFdzlfMyI59VpB8DLk10MQ4kH6+dKKDRP0qzO0vGHwxvsD/1ag0wWA3s
         XQi4UvScdhWg04rKZEp3M/puGRnXV2e4K15vJdtGwNF6WCQspP6iVdw45fgkdZ8aP4QJ
         OxPcEXVMkPU1BjSCBDmOO6gvymb2SrhzQilJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:subject:to:cc
         :user-agent:date;
        bh=jX0fufKYZvyZ8epx+GgARD/j3hIwfF8CK7/JT+nLQUg=;
        b=Yuxz3pei6BkbLQg2tEfrzr8dXGtNYGmVPA2Rme60v9XIIgdff/yXrB36ptqaSQH7ws
         otB2OZHgLoD/JPuMyw1YK40xnoEu9i/SpSs/2nDfXltTo4ZvwRnq452FRWaIh94wGEQC
         P472ykCgis/W/tpTB5JpEMalk4TFivrvC7PJATW3nz4G+oihh7RF72VLi+Epi3FHoF53
         xPwRcoxODLAsGl66X+GWCtfLZDdgCEwzVVFqT3AL2GP4dia0wT1G0ReC/kCoFEBBvCWq
         BzT4usIMaFIDK81PfIr3IwAJiU1pE9gzIxwVq5NH8aEe+gNrRVgRmEcaHlQaOZ9SCmct
         +2hA==
X-Gm-Message-State: APjAAAWC/xgcppa8gL7biZASUd0D5LuJuRDd8a4Ba0FdHjhhoQhVx2qs
        4jxYiu0D0xz3x9sf3ZkeCArqNw==
X-Google-Smtp-Source: APXvYqztpJZGE14XPIWxWqPTuQSH8BXdLKg6SY8K4m68pmf4NKVNkv30SL8rm4M4AMOz/D4RUnCJWQ==
X-Received: by 2002:a63:f312:: with SMTP id l18mr10829165pgh.178.1580618507301;
        Sat, 01 Feb 2020 20:41:47 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b18sm4977615pfd.63.2020.02.01.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 20:41:46 -0800 (PST)
Message-ID: <5e36530a.1c69fb81.680db.f620@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ff71077aa09c489b2b072c6f5605dccb96f60051.1580570160.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1580570160.git.saiprakash.ranjan@codeaurora.org> <ff71077aa09c489b2b072c6f5605dccb96f60051.1580570160.git.saiprakash.ranjan@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv2 2/2] dt-bindings: watchdog: Add compatible for QCS404, SC7180, SDM845, SM8150
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        devicetree@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Sat, 01 Feb 2020 20:41:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-02-01 07:29:49)
> Add missing compatible for watchdog timer on QCS404,
> SC7180, SDM845 and SM8150 SoCs.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

