Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E95C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7320A2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZCNPNtFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbgDMVTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388968AbgDMVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:19:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C253C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:19:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n13so5023830pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vbJOoG679zi/qFWY2YZaUKTVd6EhUDRK1VZI5sNPfg8=;
        b=ZCNPNtFaiv+4QlDiIG+LvypR67Tiyae7TKZcSzAl6XY+4FFw1fSP9hg1ZY6pyFGEyb
         9/o32SU/W5KVlrLSiUUbSe/pGhq7kdbFgy6NvvUILFQL7IBnh7dWkagDzU8PNsiv5uVF
         ruTQIH4t51akbADSxUnjx4CDCBXsS1jQFKqHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vbJOoG679zi/qFWY2YZaUKTVd6EhUDRK1VZI5sNPfg8=;
        b=V6UbbD1x6fiX4rcxWMnvU+wq7wkySc/vzkVc9Q8hoHvF+wvP94Kd55oBB5g9g3k+a9
         ydc+NSGkVXCQ6wF5XXkOA78JdBRHhaG4JiCVGlbideRCa0YQRCsf54gEoWQzNGCLv2oT
         uyZUHrUGCyDfOqbOe8Jqjf//L2HO+MltuVHa+x6E35pQvI2uXCJekDiZClXOTZwwGiEx
         EDODCrr4gjL8gcs0WMw0aKFg0PZZjluTtLO1eJDFNqkrLYQpAKrEwMyA/evCm1jVvYOb
         MYD5dyVX6YpffVCJVxlmCa7I3ou8AhfiOKJLHe0YBeXWkZmpuI4DoNTjdqIG8c+A0HVn
         vwVA==
X-Gm-Message-State: AGi0PuZyOhUZVlFRd3aRTiIP5dgL51y2GWaJtUXABz0mTiMejaTvvNtY
        tPAGgndvQJQYCRE0H7lP2zKFUuGHiv0=
X-Google-Smtp-Source: APiQypKIZ7hgkjyovM+t2L5zKXzaV/8Ced5/Waha0+kHe5vS78RBSVR5jzDArQZ1iMCCSo5810aMzQ==
X-Received: by 2002:aa7:93cd:: with SMTP id y13mr19217358pff.213.1586812755806;
        Mon, 13 Apr 2020 14:19:15 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e4sm6735645pfn.199.2020.04.13.14.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:19:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586703004-13674-7-git-send-email-mkshah@codeaurora.org>
References: <1586703004-13674-1-git-send-email-mkshah@codeaurora.org> <1586703004-13674-7-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v17 6/6] soc: qcom: rpmh-rsc: Allow using free WAKE TCS for active request
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mka@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        dianders@chromium.org, evgreen@chromium.org
Date:   Mon, 13 Apr 2020 14:19:14 -0700
Message-ID: <158681275440.84447.11477105660134588481@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-12 07:50:04)
> When there are more than one WAKE TCS available and there is no dedicated
> ACTIVE TCS available, invalidating all WAKE TCSes and waiting for current
> transfer to complete in first WAKE TCS blocks using another free WAKE TCS
> to complete current request.
>=20
> Remove rpmh_rsc_invalidate() to happen from tcs_write() when WAKE TCSes
> is re-purposed to be used for Active mode. Clear only currently used
> WAKE TCS's register configuration.
>=20
> Fixes: 2de4b8d33eab (drivers: qcom: rpmh-rsc: allow active requests from =
wake TCS)
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
