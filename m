Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E839C7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D72206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCKtFioU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBSWu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:50:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36891 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgBSWu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:50:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so839482pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Xh6W34n9HHMOfDliHp3g0le7ud4E+I3txQ2gklhzxOk=;
        b=bCKtFioU0ZNVBpVC7nZcSTqgaaNvHvJ2QpHQdlE/GfbNy3c8wRephuuBq75QqGh0/6
         q8ZQGdTPtH1u1buLb4yZl4C/QP5LjT6cKqdK4IXTqAIcq/fItfJfWEKIWJMwXwIb0d8s
         WDs77G8E3jiZbo17nQcU+jse967+Fp52qjunk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Xh6W34n9HHMOfDliHp3g0le7ud4E+I3txQ2gklhzxOk=;
        b=RFpLHhyVVLwQNOSnlXeM+6wDQPELGezUYieCriGWHAyKy85DwcyzlLeyillAsBMDus
         Fwwt7E/kBTjxFByn0ZRnJ5P2lobOWaOwlJCCdrBcZfHIbxnFsNDXIxCECirF1jmnozzZ
         gyBONEf/QyL6A7GLuA4G4mJJ5goMa/iarX3JgdNi7Zq6WNoY+Oi4UExh9oYf42g7Hbvw
         R9dJ3UCba3rk0ttqHQcd+7+2ZI+0mLz8zuCnKGJ3DApMfG3J9lHIwBQF8sdNWsWDh7VX
         VPLf6Bs2wS+opY6zsm/OqjxDElsGfxqlQ+avN6oXEmSrRgHlM9AElbBmaUkVrHKP5sAQ
         5raA==
X-Gm-Message-State: APjAAAU1oQhRJlv0D2GaKPsjSLGSk6XCTL8Oso2XVrSCQq9v/9tiqU8j
        2T5Or7ZDMXxmj1v+ZQYkOmvJaw==
X-Google-Smtp-Source: APXvYqzC8A31lbSt2qHC9NJ+UENq9WfFlFJtzZY4ubDomuJM3gpEnKkV0tUtyrvaFFnQZZ2ZEjwOMg==
X-Received: by 2002:a62:7b93:: with SMTP id w141mr29774758pfc.226.1582152656638;
        Wed, 19 Feb 2020 14:50:56 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q187sm642475pfq.185.2020.02.19.14.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:50:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d3e1c0f148d46e395a0886d9028df0faf8e9f9bb.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <d3e1c0f148d46e395a0886d9028df0faf8e9f9bb.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 8/8] drivers: thermal: tsens: Remove unnecessary irq flag
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:50:55 -0800
Message-ID: <158215265508.184098.6650576617736440661@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:12)
> IRQF_TRIGGER_HIGH is already specified through devicetree interrupts
> property. Remove it from code.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
