Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B5C2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA420748
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KZgnzElg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDHC41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:56:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41951 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgDHC40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:56:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id a24so1736814pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=C19SyW6s9ABaVcA96MgZ/z86+FrD+QX9SGhdUhVzpt4=;
        b=KZgnzElg6MCmjBX4mGgfKinaj7t+v/aV02z80ncSG8PxUBjzX8osIGF/f2dvYj1g8q
         qJPltNSCAVYAm7+AZ+kGjBJ4p3+vGibNA+Cs+ci4ZcxqKdTCJP2ul6676KCl8SM862yq
         KUq5o4+M56r068nRKzqYPTKKbNz6lL2TPGK3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=C19SyW6s9ABaVcA96MgZ/z86+FrD+QX9SGhdUhVzpt4=;
        b=rYXHXrX/DznPwbBMLpcbzOUlhrX5Lo1TEubeH9/pmg3H7saw3YS9DsLeiDwkuYo/80
         atYz528oQ7IVFI9nhFVidfx715RGTQLtjP+It0WD3crGF18qpke8oXEMYTD0vawEB2Jp
         CNK2AesfnlPrSc2w3n2N0FLIK0VrFzclyc/B2mhCYhl9NOhjN8SGaR6JS4xOroIbjDCo
         tHRvzXEV7NdNZhVRcWQ3UNU2Wriz6JztA6SuiL2NWJfvSkuHOU7BrcgQTqOsMU91MHM+
         j5IkYtcW8iph9yiaSvg7egQ40RL3fez61fTqg2tL1Url4ztORxTSrz7+2OWK+4/keSks
         IyKw==
X-Gm-Message-State: AGi0PuayRgZY4YGSUdLFobG97kW6dVjpiQaomvzsEo1WaGK6DzT9dvkQ
        i/72yB6ROCpiYf/Dn9Gx3g9Vbw==
X-Google-Smtp-Source: APiQypIDODO01vVtGZfqvyLcC30QAn+V1wKdyLppdB6LkQtNbXFqACB4TCOhjyHrMWZHXdoaBN1JBw==
X-Received: by 2002:a65:62ce:: with SMTP id m14mr4936916pgv.174.1586314585701;
        Tue, 07 Apr 2020 19:56:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i187sm15200635pfg.33.2020.04.07.19.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 19:56:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200402234455.75061-1-john.stultz@linaro.org>
References: <20200402223723.7150-1-john.stultz@linaro.org> <20200402234455.75061-1-john.stultz@linaro.org>
Subject: Re: [PATCH v2] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 07 Apr 2020 19:56:23 -0700
Message-ID: <158631458374.216820.17829557619378130779@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Stultz (2020-04-02 16:44:55)
> In commit 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2
> PHY support"), the change was made to add "qcom,qusb2-v2-phy"
> as a generic compat string. However the change also removed
> the "qcom,sdm845-qusb2-phy" compat string, which is documented
> in the binding and already in use.
>=20
> This patch re-adds the "qcom,sdm845-qusb2-phy" compat string
> which allows the driver to continue to work with existing dts
> entries such as found on the db845c.
>=20
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Manu Gautam <mgautam@codeaurora.org>
> Cc: Sandeep Maheswaram <sanm@codeaurora.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Fixes: 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2 PHY support")
> Reported-by: YongQin Liu <yongqin.liu@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Might be worth it sending it outside of this thread in case it's missed.
