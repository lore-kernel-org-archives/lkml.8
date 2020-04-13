Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0348CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02EE20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ij6RHwAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbgDMVhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389040AbgDMVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:37:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53137C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:37:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so5105419pfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=7qyucYgyQkYga8+f4et90BVzvXhduqRHKSj0Lf6wTRw=;
        b=Ij6RHwAXXioOuRGQHNnZyMNnMYfsEskYPs+Wrp54L2nFCet3CZWAwNi/kASYJJe1+Y
         D8Z+p4MK9ZuUQGoURj6e6No07DqBsDFmXu/+6uWRtv2Ybw+j//xJnlkZaAYU8vur5WhJ
         6E03HRRhVpenOfmd77a1y/hy2AGZMjotHNFRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=7qyucYgyQkYga8+f4et90BVzvXhduqRHKSj0Lf6wTRw=;
        b=p8Pk8qOmjHgMhq/vSjFEu/5HDA+yfbV5P+svW6TLOl+G+1n/i6GHdTAcnGHyR1V+Q/
         3g6T+gyJHkPiQy4c44McyDxkDLW4HVRoQVUHM1XnIPfMSHYkns7eIfHDUBNa5DrtWBD/
         PuGDfgtwpndfdcziU/w84RSj9hRdj5f2x0vOpI+hg1yIHjSPFHNQ3PEp1v0W75xbpEoA
         TEJssx3BlA/29869UbuVwj63+4dSD2/AS90Pl7wZf8CWt6jakLkxKyR+7zYRbMU2I64f
         XJC5B6+bqpnQGl3BWr8NkvXmhivDSDn6bTE7C3ih5mgNMCbwWYJ0qIaTTFb/7QEmHhhQ
         RplQ==
X-Gm-Message-State: AGi0PubIX3hHszCAyFmro/QlGA/DGIJp//w1gqInPJxEMh2kRHcxQi6C
        IztKceRR9don/3jxeroxnHHWTQ==
X-Google-Smtp-Source: APiQypJKwt5rWWZnyYPNyNuJRifLWgS79KfBhedY4qcp7dbbw6tHoD0a/FnxezPRt6r0I5G9WUnzYQ==
X-Received: by 2002:a63:1853:: with SMTP id 19mr12063242pgy.108.1586813822914;
        Mon, 13 Apr 2020 14:37:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g197sm7948102pfb.54.2020.04.13.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:37:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200413100321.v4.4.Ia348ade7c6ed1d0d952ff2245bc854e5834c8d9a@changeid>
References: <20200413170415.32463-1-dianders@chromium.org> <20200413100321.v4.4.Ia348ade7c6ed1d0d952ff2245bc854e5834c8d9a@changeid>
Subject: Re: [PATCH v4 04/10] drivers: qcom: rpmh-rsc: Remove get_tcs_of_type() abstraction
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Date:   Mon, 13 Apr 2020 14:37:01 -0700
Message-ID: <158681382152.84447.13632615241826216057@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-13 10:04:09)
> The get_tcs_of_type() function doesn't provide any value.  It's not
> conceptually difficult to access a value in an array, even if that
> value is in a structure and we want a pointer to the value.  Having
> the function in there makes me feel like it's doing something fancier
> like looping or searching.  Remove it.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
> Tested-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
