Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF05C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD362070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gyu9c7mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgCSQkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:40:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45765 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgCSQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:40:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9so1275853pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=H3Qh9MRFkrW7eubE7g/PTYkKSwQYsQfKFn0ldHiI/ek=;
        b=gyu9c7mhkMJwzKMXvge9gD7MV1dSFaFcFzb2ZrPARvKculD8xwliJTUIG0jz2mzDvj
         ypfN9/7QKnlAN//K6livKuNk+6ySjO8cuOakLFVVFVByS7WyaiNEnOh3hgNbIREJ6TEY
         L/YFr6suGa8wTINd1rVecbLo8+hrZV8BG02NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=H3Qh9MRFkrW7eubE7g/PTYkKSwQYsQfKFn0ldHiI/ek=;
        b=MFSDgM84Jm9JIWKr5G8ttDeTB24XUmMLFC/+ADMEZTQNdIARvJfTGZz6NwqgqNyPI2
         fOd9pW6PQT6ier04kIUowub3ZwI4rmvE7hRyLM6g/yN6bdsWNZx+tTnfFKFTyOkFF5Yt
         hX7J6vikwBVaiptHZpqJfjZT0/6rjMO2Gxn8OOFZCIIfuHzj9fcbYpFrEALr3KejqpOK
         IFIgcX1cGfdvFqdTTW+OOOVmySXHZnwNDqMnCC/Md/unt0gtx0uubZpx/OM/uAlO3Y02
         HYcs49ggLiLvGVoAqyWPpmuz7ydtdlZuImINZAP0SJ1AnFtrwJgQEr8W/el3b0TooRnf
         LrRA==
X-Gm-Message-State: ANhLgQ3aTImR4dFVd0q5Hw3679zvfGWRMrR/Qnn+GD5CKCabr4AOOiwU
        +mZtFr32l1fIJl11tAvmtQA30w==
X-Google-Smtp-Source: ADFU+vt8w3kcLzL1YLsszOfH8enVFIKV6/Gk0PHjqHG+oxg3AKEfxOns8NIo8vKyf0a9X96F1vw7ZA==
X-Received: by 2002:a17:90a:bc06:: with SMTP id w6mr4645048pjr.67.1584636047303;
        Thu, 19 Mar 2020 09:40:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u18sm3063339pfl.40.2020.03.19.09.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 09:40:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aa6aa234-e2d1-bdcd-0f0e-64b2a7e497d3@linaro.org>
References: <20200311191501.8165-1-bryan.odonoghue@linaro.org> <20200311191501.8165-3-bryan.odonoghue@linaro.org> <158458013177.152100.17920784952083533825@swboyd.mtv.corp.google.com> <aa6aa234-e2d1-bdcd-0f0e-64b2a7e497d3@linaro.org>
Subject: Re: [PATCH 2/7] dt-bindings: usb: dwc3: Add a gpio-usb-connector example
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, jackp@codeaurora.org, robh@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Date:   Thu, 19 Mar 2020 09:40:45 -0700
Message-ID: <158463604559.152100.9219030962819234620@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bryan O'Donoghue (2020-03-19 08:22:14)
> On 19/03/2020 01:08, Stephen Boyd wrote:
> >=20
> > Maybe it should be a virtual node at the root of the DT if it's GPIO
> > controlled? And then the phy can be connected to the usb connector
> > through the graph binding.
>=20
> Graph binding can probably work.
>=20
> Re: the PHY.
>=20
> For myself the hardware model is
>=20
> Connector -> PHY -> Host controller -> Host controller wrapper
>=20
> Only
>=20
> Connector -> Host controller -> Host controller wrapper
>=20
> care about the USB role though.
>=20
> If your PHY did care about the role, you'd really need to write a=20
> connector/phy type-c type driver, to detect the state and toggle your=20
> PHY bits before doing usb_role_switch_set_role() back to DWC3.
>=20

Yes some PHYs do care about the role. Sometimes they have to toggle some
bit to switch between host and gadget mode for example. I haven't fully
read this patch series but maybe the PHY can be the one that controls
the gpio for the connector?

We (ChromeOS) need to integrate the type-c connector class, etc. on
sc7180 with the dwc3 driver and the current thinking has the type-c
connectors underneath the cros_ec node because the EC is the type-c
manager. The EC will have a type-c driver associated with it.
