Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969B4C5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ADD206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BCbh2aaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBSWxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:53:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37385 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:53:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so862193pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=AcediiSivT+LWqDEtOSOEIb/ql/h3th0iLtIJJddY0A=;
        b=BCbh2aaODXUOMbJ47FYF0Z3q9D7rmjUO9/HBZ51aFQnoqI+xQZNeZTl4dktydUcZO5
         mfuB+gNhVU3QidqaXo1cEkR9P6QUPcTUycelJSZTKfXGbYQhspJ+EvcjDHoXBiGZuk9q
         e9xQE32LTHEKzSITdQuKrTMmihiSSub4Q4KM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=AcediiSivT+LWqDEtOSOEIb/ql/h3th0iLtIJJddY0A=;
        b=hddDCO3PZxfKa3Lerah77KlS7c8beD1BfCa1OpqjOX7iy9sH0882mhOjUME5CFgbVW
         nCwvyPiDh7S2UHZjxz7OMshAB75cy2j+gfkA6WlQfCjxuqAep319TgI7XvBXCnw1S3Wv
         8byQopX3Dy/A5HHInSZGD+0cLT7ZQ6YhfairD+O/QyaOloFjzEDdzB5kJvAhz1iDgUo7
         TArBvJqGNDxTd8UL/gADA0RDdJ8zaKjtiIESzmjOCwry2gMDKcTCGfdzUumy/UKrXC+1
         nQTytdQ64cOzS2va4FLu8bllV2fj4VdvJpAt6OpI/pdq+S2+3hfa2y6kITUBnLNc3yxf
         q8yw==
X-Gm-Message-State: APjAAAWxxAPPX039Ouhy1No6kfDbWSJ5lv5IZQPptQRpb2dPpy3NWkjP
        fvI/bvKNaOhBJQvHX13LtO305Q==
X-Google-Smtp-Source: APXvYqzgVogCk4wmUAOqQEW4bVutbe6o2CYTMqBsdOfoHwfv/G7oBszdNXPvfuE9X4po34XTi3SYTg==
X-Received: by 2002:a63:c30e:: with SMTP id c14mr31594137pgd.168.1582152807989;
        Wed, 19 Feb 2020 14:53:27 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h3sm845289pjs.0.2020.02.19.14.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:53:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6f95b3f0d39433c7e6b01094bdb200a7ac8e9f0d.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <6f95b3f0d39433c7e6b01094bdb200a7ac8e9f0d.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 3/8] drivers: thermal: tsens: use simpler variables
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:53:26 -0800
Message-ID: <158215280660.184098.15487361696633323314@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:07)
> We already dereference the sensor and save it into a variable. Use the
> variable directly to make the code easier to read.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
