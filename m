Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34958C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D092068D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQSLq1W1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgIHS60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgIHS5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:57:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3BFC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:57:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o68so56302pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=bZ0hdB3aDnQdw+HPiv6w6/rS4ctBv4+DDy7Q7mzZQJA=;
        b=kQSLq1W11bCof3VZGivNs9jhTs6eQXMNg151pVMeum5ivTvrGyNKTmBC8o3aAVTMCD
         fWHq03en9zOkEUNKYb6mITKGyBNqVTB2ceHUt93ApjVkk5vDvZP7SZyD5G3hpSk3mpff
         TpEU3uBAzAcI94SB+dVKpTJKqYy/8/3vpSWho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=bZ0hdB3aDnQdw+HPiv6w6/rS4ctBv4+DDy7Q7mzZQJA=;
        b=SwFfZcnQLt4XKeJz7nsT37Q1ter+l3gS9o/06VXiF7eJnchMgHHM2pGZD+c/Kc4NTu
         B/7ORp22ds48/Qv420N+j4Mj330L8xOp3J7QmlRULSOntpe8++UXttnv7Q3C/KjrY1NU
         gcqnBhF1diZWDCNtjWiUncciHpNFYvbLl81XhsauKFljuSKwmffkiFVSD3+3qJCZOzaO
         0OZ0UyOlu8hykLwgn0ejsWHYnzKutKyEH1Ct4FyDD9UiVtmQsr0KhxNcfkGDkrZbTtMc
         OmmrYg4m7pCckw5mUJuDYHoIFibntRZwR/aCge/FHllR7tnkXo7f25PjEXGfHrf72Shk
         2G2g==
X-Gm-Message-State: AOAM531vU9Y82WTgqXNGR6sKz4JpOi+RTamqqtQc6yzR+kozUFjZ6NcZ
        HOSjx/rrI4wlqIJx/KiMmMEHAQ==
X-Google-Smtp-Source: ABdhPJwf6IhPcHFN4xXP49f62bCdnIGRRPklRPb2u3kzC8iwzMNMbimK4omnPZ6atruNND3LgaRG1g==
X-Received: by 2002:a63:b202:: with SMTP id x2mr126839pge.432.1599591441474;
        Tue, 08 Sep 2020 11:57:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id o6sm44291pju.25.2020.09.08.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:57:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <010101745aaf685e-49eb2897-ee17-40bf-89e8-2adebe8d022f-000000@us-west-2.amazonses.com>
References: <010101745aaf685e-49eb2897-ee17-40bf-89e8-2adebe8d022f-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH v5] drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Tue, 08 Sep 2020 11:57:19 -0700
Message-ID: <159959143931.454335.4137726843867018185@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2020-09-04 12:54:39)
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
> Changes in v4:
> - add ST_SUSPEND_PENDING to handles suspend/modeset test operations
> - clear dp phy aux interrupt status when ERR_DPPHY_AUX error
> - send segment addr during edid read
> - clear bpp depth before MISC register write
>=20
> Changes in v5:
> - add ST_SUSPENDED to fix crash at resume
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
>=20
> This patch depends-on following series:
> https://lore.kernel.org/dri-devel/20200818051137.21478-1-tanmay@codeauror=
a.org/

Can this be based on v12 of the patch series? v4 of this patch was based
on v12, but this has regressed and gone back to v11.

v12 is https://lkml.kernel.org/lkml/20200827211658.27479-1-tanmay@codeauror=
a.org/
