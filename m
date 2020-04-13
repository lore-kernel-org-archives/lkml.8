Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C1CC2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F1320663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxYzFGln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbgDMVSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbgDMVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:18:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA6C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:18:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e16so4085716pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=LKoTx7KG6nMQkllRzw0i6KXlr2iV0yoiA8xfd0IZD8Y=;
        b=bxYzFGlnRvCemxxTVzeumw06vj6zrN+T5v/ulk6eifLDOyYFXN5u1ZsIo8Fmd6S+N2
         qP1e14FkwD6ajb9Vqy3pfdpp+ovGUI+axLrkfbAMo1hdVT37CtHACAYXL7rfdzo/9Can
         OJjz6IQccgrjto+PIwESV67aRX+9DTsul9bl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=LKoTx7KG6nMQkllRzw0i6KXlr2iV0yoiA8xfd0IZD8Y=;
        b=pbRopFPUuOT4s18OVdL5vosUb6Cjm0x+C1957PEBuhg6IEqGbB4cu7fIyac5bMjntC
         aBBxBxB/ShoP20QopKmjEyvyvwynIuZag7UsExQmhYC5NzXGMNzrdtSVk4FgFFGcJhNg
         gDVoxi6nu1Mgvwmtv6cb9vf9fn4SZ1RJSlstDhUg6YFC/1nWCjS/21gkfCVwv2Qmsh8M
         +VfP8xuSN0BpEGtn2abez1Ut5IFWZGycYHzlmFqEAtghZDBtTNTmn8kq7WftAxvUxNgj
         6VPROjVzsNsWRHEHHe6LJW+gDclGhXQtlJdOLVMkLLDbz0ySwTjeBrDtYCJ/1E4ARIJN
         SApw==
X-Gm-Message-State: AGi0PuajWU0Mkonz1El26MEo+uBfQs2ejPLlZ1pUEpwDiJ1k7tAxib73
        s9NMFh+/J6rjHpaNyi3ztsRhux7abtw=
X-Google-Smtp-Source: APiQypKjoL5f6I30TXYkN0iQQiyEkvHoaPfwBdhhfCcaM+MCpddzq0315YY4+E2sgHg/x//OB4MBEw==
X-Received: by 2002:a17:90a:fd90:: with SMTP id cx16mr24287639pjb.41.1586812723419;
        Mon, 13 Apr 2020 14:18:43 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k12sm9320099pfk.46.2020.04.13.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:18:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586703004-13674-5-git-send-email-mkshah@codeaurora.org>
References: <1586703004-13674-1-git-send-email-mkshah@codeaurora.org> <1586703004-13674-5-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v17 4/6] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mka@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        dianders@chromium.org, evgreen@chromium.org
Date:   Mon, 13 Apr 2020 14:18:42 -0700
Message-ID: <158681272208.84447.17507041349057590305@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-12 07:50:02)
> Add changes to invoke rpmh flush() from CPU PM notification.
> This is done when the last the cpu is entering deep CPU idle
> states and controller is not busy.
>=20
> Controllers that have 'HW solver' mode like display RSC do not need
> to register for CPU PM notification. They may be in autonomous mode
> executing low power mode and do not require rpmh_flush() to happen
> from CPU PM notification.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
