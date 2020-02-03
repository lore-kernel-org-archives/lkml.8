Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F857C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072422080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QjnvLUY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgBCRAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:00:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41228 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbgBCRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:00:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id l3so4035071pgi.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:subject:to:cc:user-agent:date;
        bh=+bbS1LurHkbiJrVa8DwGY53PnP/qS0ULTiVuSYs5A3E=;
        b=QjnvLUY4Q4hhfq3l2iwv+1X78eBmhau5DSyA/OBUYOQTo7bb7ep2XKYKghIh3ErkDd
         IZFNWonhBADCHxXVXrF5wA4/tjMGNQMg+h06spG6a6CTAKE8J4qvXYpFAP4mY6hPQbnm
         wMnNfqk/rz0xpnssK+2Td5w2GVQGzRoArLMDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:subject:to:cc
         :user-agent:date;
        bh=+bbS1LurHkbiJrVa8DwGY53PnP/qS0ULTiVuSYs5A3E=;
        b=HYRXQ1PLM69HxTgjgOM1outadbtbtyOMrMOf5F/rCwo1fKmaPJjh4xUGdISbgPK/HX
         Q9VAV+grv6cR8jvOiHrVizUoebCEAQ6N2WWZdooONP+KWw3E6rIPssqvR0mXXySkq1O+
         fE2i5b/RXpDEctgQ+HVNo3usQLlrZZE2UEpHLTPC8C4BG0oGo9kZ4j3BHwoFN3GZ4x6Q
         vCiuKPZLqS8CGIt1uoeydn7HNsn11RJPwpbg5zhwirmG8LLObBziHUW2gOXcI63fpz1L
         4fzfmsL5bCbCYFqGYqsvTv7gwmkJ8CqtCZdpgjhnHl0qcPTaTtMW7+1t2R/J9FajxZco
         4IVQ==
X-Gm-Message-State: APjAAAUFKGrAxtFT3CHuXF/pDMhb2uPUA7zYqXO26LevC3GqoxgA3B/W
        bhuuOFjnDd9n+K5QgZP4AMHWjA==
X-Google-Smtp-Source: APXvYqxfeVAORXMLObE3gAN7OxJt/+U7e9kSIe1Jr0RUJ3rinUWbypd7Od3IggLAS+/64DWu/MihZg==
X-Received: by 2002:a63:7907:: with SMTP id u7mr21605031pgc.138.1580749213150;
        Mon, 03 Feb 2020 09:00:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v9sm21759786pja.26.2020.02.03.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 09:00:12 -0800 (PST)
Message-ID: <5e38519c.1c69fb81.d469f.9b0c@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3726ea2e21cffd2f9667aaa0430003b2407ed74f.1580632081.git.saiprakash.ranjan@codeaurora.org>
References: <3726ea2e21cffd2f9667aaa0430003b2407ed74f.1580632081.git.saiprakash.ranjan@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] dt-bindings: watchdog: Add optional interrupts property
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        devicetree@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 09:00:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-02-02 21:31:15)
> Add optional interrupts property for specifying pre-timeout (bark)
> interrupt on QCOM SoCs.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Maybe there could be a description that says it's the "pre-timeout
(bark)" but I'm not too worried about it.

