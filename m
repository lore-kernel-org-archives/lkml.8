Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A61C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9279220709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOK2BsUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgHRV7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgHRV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:59:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FC6C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:59:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so10628677pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=LBK59hoC/QeRiJTHTK+5CDgO+Kpr6UH6snOINOdNcEc=;
        b=dOK2BsUAC+X5cn4UBcaTivDHVHteQhdCDednUL3JgbPE0LOySnHHNp+kxYp4Lv5hFv
         OZtGYvKkoFMin6uNX1fpS5sMdOvPh43Y+szX4VYbJ3utQ2drqua2Q3lYg1+/t+WC0OSP
         Vr0/W/jEqyXLCcSw9VpAABGrGf+ZxjFwXWtYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=LBK59hoC/QeRiJTHTK+5CDgO+Kpr6UH6snOINOdNcEc=;
        b=tf94vAeVaBwc/PBq0hdtPh2QQMejvKKfS91oa5pjUcUaHwehsDIXnFhSAuWiCogtMQ
         u3dzFRMXdsjifpZEL2SabtECpf9HDZpj8feuv1XIfIPTPdyWrgh54AVsl93VHFpS9Gbz
         Ivh51LIccNZNYLPgMV/YW5BP6c1joUw2xSgRKRnqyIsgiORm9hZ6KsY4wuSMpRm2Z6JI
         Fqlnq8F6fA5cnfd03PxG29xTO7jQpiZouFql7UAaxhg8yGd8EcYJG80zpKhyO6JsBADu
         /04xWQ9x1rYJiiaui8WrJkOwoA8/yf1jL5E9Jb+eMOJmlUCMaKAc7uSVOCP00M5033Gz
         IYRw==
X-Gm-Message-State: AOAM531qi8krArYPILUuFllHsrD0BYeJnS/qpXTdcAQSO932ziqgV0bg
        S6LICH+Ugv3ax2qo0yI7zAwqS7uEUS6aVQ==
X-Google-Smtp-Source: ABdhPJyS57EcdCietirtZsste3Gi4BbiPyYRBoBbKZ4T/VQNq4avYwEZDBCDdLGtQZOv+9ZD6nUmKQ==
X-Received: by 2002:a63:ab43:: with SMTP id k3mr13655112pgp.426.1597787976692;
        Tue, 18 Aug 2020 14:59:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x28sm26049746pfj.73.2020.08.18.14.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:59:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200818211546.559-1-khsieh@codeaurora.org>
References: <20200818211546.559-1-khsieh@codeaurora.org>
Subject: Re: [PATCH v3] drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Tue, 18 Aug 2020 14:59:34 -0700
Message-ID: <159778797494.334488.5009772006048435758@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2020-08-18 14:15:46)
> add event thread to execute events serially from event queue. Also
> timeout mode is supported  which allow an event be deferred to be
> executed at later time. Both link and phy compliant tests had been
> done successfully.
>=20
> Changes in v2:
> - Fix potential deadlock by removing redundant connect_mutex
> - Check and enable link clock during modeset
> - Drop unused code and fix function prototypes.
> - set sink power to normal operation state (D0) before DPCD read
>=20
> Changes in v3:
> - push idle pattern at main link before timing generator off
> - add timeout handles for both connect and disconnect
>=20
> This patch depends-on following series:
> https://lkml.kernel.org/lkml/20200812044223.19279-1-tanmay@codeaurora.org=
/t.atom

There's a v11 of this series. Can you rebase again?

>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>

And fix this SoB chain to be proper with Co-developed-by tags and your
tag coming last as you're the sender of the patch.
