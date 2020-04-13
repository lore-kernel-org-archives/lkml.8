Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F3CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D4A2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dAUxCQ70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbgDMV6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389370AbgDMV6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:58:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386FBC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:58:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kx8so4360207pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4yg4cfYF/sNkW8+TUUHu2JRz/noHOMFhlz+WSJz8tqM=;
        b=dAUxCQ70O8hf7bA6Nz3dj3UDpftoDbgZdghOpY68vKibO4SPPSQ1WDDae1yCHvATj2
         i/8uDwabOWzJoheUsg4ck7tJVE/Tqzm0UVEfGPcXuQGLTs9kbM/Bz89I0bxcc6b21E20
         NT64p7pbBMP6CpmJ97dp20YaFJoregOHYQnys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4yg4cfYF/sNkW8+TUUHu2JRz/noHOMFhlz+WSJz8tqM=;
        b=oSwyDuFk4gRufEnFs/USKo76yoCNbpK3QXiIrdLnxsCgkZkIiKJMxZKexB1DNEx85P
         lCqPdQWVJDZLIbZ5Jeq+145w81iCFZ7SQVti91JBX+wuLI4M6yLaYxYicGpjGRND73V4
         T3CqwDsXOdTTjIGCxwqSppK36HoQ8xd6JUg7KyhNAW3ZP23l3YBhsWpF8eT9zKpbd1yt
         4i24XeicCkwjY/ba+WtXQ0Xs6+jhgnmmGvnm93fqyZICeZTRX4qHY+mQigVlSfEhmCy2
         c5HBJkiiJ/KXGRrMUc0DZaAP7Vf6J2AOAa7Xw6MdxJRBx2x/xo/5LnIZHs7CzwyykN46
         780w==
X-Gm-Message-State: AGi0PuZKSTGCr3MfRID+3E+iE6gAWAKNoK+nL0u/dofBfhO7BzCS86Fu
        yYCngxcgOR5NdCxnJFSXFIImIA==
X-Google-Smtp-Source: APiQypJByUsTV/6lB58pySnt/9BCm3s101qWxoZyP62uO/RT1Fq7PreHTBypDOkFgDv6wBRrBS5PYQ==
X-Received: by 2002:a17:90a:138c:: with SMTP id i12mr304081pja.36.1586815129717;
        Mon, 13 Apr 2020 14:58:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z13sm4478207pjz.42.2020.04.13.14.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:58:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200413100321.v4.7.Icf2213131ea652087f100129359052c83601f8b0@changeid>
References: <20200413170415.32463-1-dianders@chromium.org> <20200413100321.v4.7.Icf2213131ea652087f100129359052c83601f8b0@changeid>
Subject: Re: [PATCH v4 07/10] drivers: qcom: rpmh-rsc: tcs_is_free() can just check tcs_in_use
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Date:   Mon, 13 Apr 2020 14:58:48 -0700
Message-ID: <158681512828.84447.14396271948475958119@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-13 10:04:12)
> tcs_is_free() had two checks in it: does the software think that the
> TCS is free and does the hardware think that the TCS is free.  I
> couldn't figure out in which case the hardware could think that a TCS
> was in-use but software thought it was free.  Apparently there is no
> case and the extra check can be removed.  This apparently has already
> been done in a downstream patch.
>=20
> Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
> Tested-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
