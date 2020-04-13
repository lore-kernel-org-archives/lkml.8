Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ACFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8C4206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/IJ9Qtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbgDMVRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbgDMVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:17:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC835C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:17:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so5082381pfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=DkFXK9v0exA4G4YcoWc+xbEiRjzLLK+eOt9DRlAzn/0=;
        b=W/IJ9QtzeOvKUPUFofeH1yOLCsu6opUycc0sSKNqLwR+8qN+dHPEgUb0NDdg0oFUYy
         wNXoH8vH5uwI5EbvAnjV48iAY3AGoM8NSqSPlUn9R6Zxh46gtVVwInbFrmMikazboleB
         ByR48x+7toeu9FRO+FZGFHBsnRHm65xR0715k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=DkFXK9v0exA4G4YcoWc+xbEiRjzLLK+eOt9DRlAzn/0=;
        b=mMoV/ioIkjajY2sCJ6SL8N4OahpOn4pOwyZOaJy8ouzagdCntbTitGGgcByFmr2aUk
         +MuOvrlQrJ175r0mfsyUXzDE/bW0mj5N9zWBTl/AZ9pR8hKNAit3+EqPpsp/EqbOofeB
         PePFNRoaBuTud1CCzunbli41/4t/8spauxxA/0k1oc+Jmv/CnIpi80tWay2KFJg3v6m/
         GR9rK5rFzQVYxVfjCi8mJwVEPCIGMSJ8JSO7aFBzptWvnuvzDvGVi7jgqC2HA3qlkYDZ
         CpysaH5YYdoit1zYwuceLR5Ypxi2yyu/pu24hQb9gkpligHC4qiAVYu/3vJ3VV8XVedx
         qW0A==
X-Gm-Message-State: AGi0PubaUORV1EwSn1YRNJYEKC+87b0yzVeTz7puuopoN4rksBZIiu1P
        VH6LFt/RvIFqCZGIlPBcs9eULzCy1IY=
X-Google-Smtp-Source: APiQypKMJYVEMRyl16Tv6WhTVZnxVKiOSOT3Awd2c9FyrCwjVEiri7UREk8AA4GygsU6Ta+uW0b4yA==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr20026578pfi.322.1586812658266;
        Mon, 13 Apr 2020 14:17:38 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x3sm9071634pfq.95.2020.04.13.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:17:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586703004-13674-4-git-send-email-mkshah@codeaurora.org>
References: <1586703004-13674-1-git-send-email-mkshah@codeaurora.org> <1586703004-13674-4-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v17 3/6] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes before flushing new data
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mka@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        dianders@chromium.org, evgreen@chromium.org
Date:   Mon, 13 Apr 2020 14:17:36 -0700
Message-ID: <158681265694.84447.13031031594080430034@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-12 07:50:01)
> TCSes have previously programmed data when rpmh_flush() is called.
> This can cause old data to trigger along with newly flushed.
>=20
> Fix this by cleaning SLEEP and WAKE TCSes before new data is flushed.
>=20
> With this there is no need to invoke rpmh_rsc_invalidate() call from
> rpmh_invalidate().
>=20
> Simplify rpmh_invalidate() by moving invalidate_batch() inside.
>=20
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state request=
s")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
