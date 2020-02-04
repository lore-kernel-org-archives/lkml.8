Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB9C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B89B2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OXbh3xD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBDAjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:39:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35472 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDAjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:39:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so8756717pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:subject:cc:user-agent:date;
        bh=aY+PkOZvhDkr1IoLpMvufUwCSEjSEtUTCkMrzIaPtMo=;
        b=OXbh3xD9TSmengwKoH7bMzEMxTwmrX2ayW/CIY39z2bvXE3XS/dbykz7iB9oegCRVM
         orhJjtWromvx4gHPOdCplJFFoIyAzNy9rs5it0phG8yPrfjvrn2nvfbfeRFwiw0guHLe
         KGmobwApJCvLuTqFUiACsJuFjlhixO36LVCvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:subject:cc
         :user-agent:date;
        bh=aY+PkOZvhDkr1IoLpMvufUwCSEjSEtUTCkMrzIaPtMo=;
        b=rzCEX/xYh8lUQQ1VRvsaUGDGnnN6g4GXdLfK68V2dG5etXMpfg/uF1xLl0eSiEyk1Q
         jtPqoWDlND1ZSMkSOj3oXJXGRUDlKh6IFX2NwIXSjvUuAbxkMMnwYgPOBucUtrihrksk
         quiN/9mJ7zI5e1QufJSspw1JvJ1PIk1pb+ZIyMH4i9qapIhln2Q7XTyYz2hRoIP+WG8s
         8nNprDbZU5LqEENzsCgGOZOjLz8Pf4QQ9KTgrrhQYxc6SBwGeZyCa2ksI9S7IK8idXBT
         eM5NQ0auT/ASk/A3NB14kLCymF5AgcJwU/gAvtDc80XEsQIAJ1kpIc6pDvPUUfpa06fh
         kyVg==
X-Gm-Message-State: APjAAAUDUIScXsuWhzSUxMB7i9Ip6oBrcdwDcayi+jM9FmdA3EKZukXw
        kS2KGezZ/biaFwKkWPXu4xbUIQ==
X-Google-Smtp-Source: APXvYqwpBeAZ7tUjUr6bFDrm4kqCYRIGAoKoisn6oW50rp2ZtSptT7JfRmJEgX6dr6AeyrNNSTuHaw==
X-Received: by 2002:aa7:8ec1:: with SMTP id b1mr27399143pfr.95.1580776782670;
        Mon, 03 Feb 2020 16:39:42 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y127sm16375426pfg.22.2020.02.03.16.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 16:39:42 -0800 (PST)
Message-ID: <5e38bd4e.1c69fb81.4702f.d53b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580305919-30946-3-git-send-email-sanm@codeaurora.org>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org> <1580305919-30946-3-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: Re: [PATCH v4 2/8] dt-bindings: phy: qcom,qusb2: Add compatibles for QUSB2 V2 phy and SC7180
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 16:39:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-01-29 05:51:53)
> Add compatibles for generic QUSB2 V2 phy which can be used for
> sdm845 and sc7180.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

