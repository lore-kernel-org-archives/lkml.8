Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B660C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD525206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVlG2fTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgEEGb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 02:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgEEGbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 02:31:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A567C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 23:31:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so238784plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 23:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=WsDerNjxdxesEJaFr/5T4NQdjiDHk0GUg7G+n6u1IqA=;
        b=dVlG2fTtHeRTrSzkk+hruHFfudqXYD66L/lgzYjYzhuDiDs2RF3289WRvJqBKtNVQ/
         +oGNGzu6OOVOc5v6HCvATz+ur7U7ocHHaaTb4Lngy6XA/vKAv5owK/s199JqpN+2ejH0
         boG8ds6+QrQyj7yqLIzqHVseboTWJQ4WMx4Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=WsDerNjxdxesEJaFr/5T4NQdjiDHk0GUg7G+n6u1IqA=;
        b=IH1AiHgPiVOP1mPAvEdPp2JfPdaLKCS86NrX/+FKm67W2izcM3haLj1SoyQN4k44J+
         SSbjVzOJjLTgUdaSkvSURy76lad7zXk6zU6mS7cW2QSA4zU9O8Ywz6mcVx+jSu70PD9E
         2yBDuu3H1CjP9hz1gpW7b49f3Hb9IaaqhUHl1Sw2GMXcXLhB5O3sh5iwhvmUf04vWHRg
         7oSlRzTJcSpXfozmpSbVzy0s9YI0hA1dDYKoondPifLX/6rvPL1vdczslR0I3+oheppK
         4mXxA9KaGV8tuG9q32iu9PqvEV73Y61S6Hdn3uWwHc5ZhDKigI44awwpBhZ308vpEnmX
         0zqg==
X-Gm-Message-State: AGi0PuZBoQG2kh+Es2iJxLlx69uPtZunDFcUmrSSPIuskAG6NE8Jx5M2
        5aBPuOpw4xc3JtSatoQ6+88w1A==
X-Google-Smtp-Source: APiQypLEK4LRaac0ooJpXvg7SgtB+YvPX2y/SyoJ6VDM8uWvsO7Az4DL6KhPp1T1qmhiXi1rCqVAjQ==
X-Received: by 2002:a17:90a:648a:: with SMTP id h10mr1123129pjj.69.1588660313926;
        Mon, 04 May 2020 23:31:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y24sm958645pfn.211.2020.05.04.23.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 23:31:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
References: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
Subject: Re: [PATCH v6 1/5] soc: qcom: rpmh-rsc: Correctly ignore CPU_CLUSTER_PM notifications
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     evgreen@chromium.org, mka@chromium.org, mkshah@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com
Date:   Mon, 04 May 2020 23:31:52 -0700
Message-ID: <158866031221.24786.9383478212951903220@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-05-04 10:50:15)
> Our switch statement doesn't have entries for CPU_CLUSTER_PM_ENTER,
> CPU_CLUSTER_PM_ENTER_FAILED, and CPU_CLUSTER_PM_EXIT and doesn't have
> a default.  This means that we'll try to do a flush in those cases but
> we won't necessarily be the last CPU down.  That's not so ideal since
> our (lack of) locking assumes we're on the last CPU.
>=20
> Luckily this isn't as big a problem as you'd think since (at least on
> the SoC I tested) we don't get these notifications except on full
> system suspend.  ...and on full system suspend we get them on the last
> CPU down.  That means that the worst problem we hit is flushing twice.
> Still, it's good to make it correct.
>=20
> Fixes: 985427f997b6 ("soc: qcom: rpmh: Invoke rpmh_flush() for dirty cach=
es")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
