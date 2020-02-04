Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C65C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C082086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XyE/ibDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBDAjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:39:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44198 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDAjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:39:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id d9so6512457plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:subject:cc:user-agent:date;
        bh=s99twd8T9lfxqqfXkkpW+eEO8uM/iiYe3oAKa4dMeeE=;
        b=XyE/ibDJ+79HIbydPGG183qHACW1D6X8nehb+4R6bNf46GIb2DLhg2lp8s/CuRH4Sx
         VKBswrBeGLDTxMWl0gc+wwS8q4MIGIZl0JBTBJYN863oyxxFUBgsAA4b+w/sfHbo66Nj
         /Y2TO6j0rtDGCC8j9B5mUa/IFw820PxNOcHP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:subject:cc
         :user-agent:date;
        bh=s99twd8T9lfxqqfXkkpW+eEO8uM/iiYe3oAKa4dMeeE=;
        b=oGqVYsmhoK3OoQ34bmHs6F3ocCHSw6Hlu/rySytPa6yXZ9lHG9mre5ya/W++iO59qE
         RpXrMUcRV9Fr5dPimDZpcpVntScnVn7/Kzunvezp6Ay0fHhTB6kgJV4fF4adRC6nDAr7
         0N+HwZNJLJfLZi6F1eQdX7E+ajbj6x76hooXccBEV/bZUY+igCFJk9Cln90WcsyIC9ch
         xwPVAYCuH3oyPa84qc18T/zoWB9i4jEq4KLNb82xZrXZy/EA1TMLik189KrQPdsTa95u
         3pIvqL4SwR8Y3JjmNpBjkXSZ0ujYjBobjiNp1a5I7DpgWfhOTCi/4EF4L+IH8zBiKJmT
         2cPA==
X-Gm-Message-State: APjAAAWutI6ivrByX38gTng2kDloTZFFZ3NScorx24AVb5m89T72EruB
        n/kpNucIuoRqtrSbaO9mNAbqdg==
X-Google-Smtp-Source: APXvYqwd5LQ2/VSMcwQin0jFZzTzrheBaz3AQBZ4/bVQlPqoBD9MSuZyuVOOi7osiMJYE6viDVpuHQ==
X-Received: by 2002:a17:902:aa01:: with SMTP id be1mr16714483plb.293.1580776751190;
        Mon, 03 Feb 2020 16:39:11 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m128sm22014128pfm.183.2020.02.03.16.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 16:39:10 -0800 (PST)
Message-ID: <5e38bd2e.1c69fb81.82ebf.ddaa@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580305919-30946-2-git-send-email-sanm@codeaurora.org>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org> <1580305919-30946-2-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: phy: qcom,qusb2: Convert QUSB2 phy bindings to yaml
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 16:39:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-01-29 05:51:52)
> Convert QUSB2 phy  bindings to DT schema format using json-schema.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

