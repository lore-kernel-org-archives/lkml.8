Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A9C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48820206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NlaN8NZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgBLQ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:58:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38488 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgBLQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:58:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so1519861pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 08:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=bK+cvl8zl3lFOBR7bGFC49ixHUgxXY0M1LIjl6eCa7g=;
        b=NlaN8NZnHVoC2MsosIgILZ3NWppGuVSUhrH+t3G+ZjgTaeU9geNHIZoJ4yrqViRc4S
         GuvHMdMQsjB2d7o2umi7zud7ryWUw8IRQTdPeV3ucViDk0QkOJLkT0XQHyI9toUPWM1h
         TlTmAY+Eu0E3f0YiwnQMZ3xGlVVIEQiapH5bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=bK+cvl8zl3lFOBR7bGFC49ixHUgxXY0M1LIjl6eCa7g=;
        b=gq08M/maz0qde0VvHLUUtCCVRjPQv4/mgZ530F0GHLboNs6CM/xqoKkMTtYF7oOVon
         +LExeadqaxaKgtTC/aUJxMIv4HKkx3WmIHIlXXgpBvU0DhQaYKma68Iqf/7UE0+raeXg
         QCevZu6U1hpOIaWMUIMPcRID1y7ui4m4MaaLo/4affe+EL5gOl5KbC6WIHpPW4eEr2II
         htinAQ5KIfSa0rqjo+pxKSzQD/oJLNEm+7QMfGzsq06J78EaUruMXGgnAsDywTKiyvnf
         j9F+Zs3qZI/yvgHospXpcxbA/QOkRy8dRWhQBKSmrdGT650vVdQP1a52AQNZS7rVBlnv
         AkHQ==
X-Gm-Message-State: APjAAAVhJA6A4adcCCNaObCxlEghU8R5VESCHwZOrv08Vr2z5CfCVIVq
        0CT9V2aRK/WV1CTRq1b2Yod3xeF1Sgg=
X-Google-Smtp-Source: APXvYqydHiVqEawLuj0kN/UatDCVMzDQCKH2Edo9QUQTHOVoTBw6W167ZCYnwSPn4e1U0H9BAmp+Iw==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr9136009pfp.97.1581526728668;
        Wed, 12 Feb 2020 08:58:48 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 13sm1497030pfj.68.2020.02.12.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 08:58:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581492673-27295-1-git-send-email-sbhanu@codeaurora.org>
References: <1581492673-27295-1-git-send-email-sbhanu@codeaurora.org>
Subject: Re: [PATCH V3] mmc: sdhci-msm: Update system suspend/resume callbacks of sdhci-msm platform driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        vbadigan@codeaurora.org, rampraka@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        adrian.hunter@intel.com, mka@chromium.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Date:   Wed, 12 Feb 2020 08:58:47 -0800
Message-ID: <158152672736.121156.11425666862560332951@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shaik Sajida Bhanu (2020-02-11 23:31:13)
> The existing suspend/resume callbacks of sdhci-msm driver are just
> gating/un-gating the clocks. During suspend cycle more can be done
> like disabling controller, disabling card detection, enabling wake-up eve=
nts.
>=20
> So updating the system pm callbacks for performing these extra
> actions besides controlling the clocks.
>=20
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>=20
> Changes since V2:
>     Removed disabling/enabling pwr-irq from system pm ops.
>=20
> Changes since V1:
>     Invoking pm_runtime_force_suspend/resume instead of
>     sdhci_msm_runtime_suepend/resume.
> ---

This triple dash should come right after the SoB line.
