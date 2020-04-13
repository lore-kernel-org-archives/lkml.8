Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C3C352BE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD5820663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOe16klE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbgDMVR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388862AbgDMVRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:17:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72AEC0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:17:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h11so3851800plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=eC2MEHdLAsuZgsM6/ln+QWOcxR9o897nfctxg2dELsk=;
        b=FOe16klEN59gHf8DsemBbvY3xk8S/CsK6R046piFKeROmNPkOeYqJdgM7fstOlZhb9
         iDyn/hdH7byLxSVS85oAQkXRAjRV/u2jQdeCnKK4EYoxrHaYvVoG8RUKfXAu8oLYlDZu
         fBVxJnUvBEZMIZK6n+4Vt2X72Td1wX1VH+SP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=eC2MEHdLAsuZgsM6/ln+QWOcxR9o897nfctxg2dELsk=;
        b=YVCNW7BfuMxbOPcpZSB98yKDEXvMvdto6OuOJ8vGVPKmPpe6VwgWJ3yx0P+v1M6UFA
         k8uzEUYFeoSIM10Tsm8zk0wcL01tnCq/9HwDI5zES3J/TnmeCikrMhu2iY5/D93MZQ5T
         /Mr92sVLppze2u9LGILDjNJkBsG4zS87p4hC/ZxBKTptN/S4/WSBs7VnG2iTt80M/TCA
         ZwTuzAcPLhDTOuL3wDR6M0S0Jy1u37a++YM7eWoH3d6/B5NIo6mSl2nNtSeWkyMaF09V
         4kbl8pjSCIjTFG8f5P2sF5ywDv5llZARpzOE9+POq6RRnkFHYSDd11+e2du2p+xax2s3
         /O3g==
X-Gm-Message-State: AGi0PuahFT3JUrFqn/Q5rbPuob5rziyoKxzwS9Xj9XDZ/SAb5jMEnsEU
        23vavmHT6DFiYy3Wz6FkpUvIinZXnCY=
X-Google-Smtp-Source: APiQypK5YeG3+cIFNKOKytz3S6ftOZYnIEwkaXMhVzUezQHx6huazKccZyOWUp0WHXouALSMQUH6Ig==
X-Received: by 2002:a17:90a:d78b:: with SMTP id z11mr23780945pju.34.1586812627228;
        Mon, 13 Apr 2020 14:17:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q200sm8752985pgq.68.2020.04.13.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:17:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586703004-13674-3-git-send-email-mkshah@codeaurora.org>
References: <1586703004-13674-1-git-send-email-mkshah@codeaurora.org> <1586703004-13674-3-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v17 2/6] soc: qcom: rpmh: Update dirty flag only when data changes
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mka@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        dianders@chromium.org, evgreen@chromium.org
Date:   Mon, 13 Apr 2020 14:17:05 -0700
Message-ID: <158681262575.84447.6103170873953765147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-12 07:50:00)
> Currently rpmh ctrlr dirty flag is set for all cases regardless of data
> is really changed or not. Add changes to update dirty flag when data is
> changed to newer values. Update dirty flag everytime when data in batch
> cache is updated since rpmh_flush() may get invoked from any CPU instead
> of only last CPU going to low power mode.
>=20
> Also move dirty flag updates to happen from within cache_lock and remove
> unnecessary INIT_LIST_HEAD() call and a default case from switch.
>=20
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state request=
s")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
