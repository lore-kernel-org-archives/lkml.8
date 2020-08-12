Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECC7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2320774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F038C5a+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgHLIWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHLIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:22:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E41C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:22:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so740359pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Qt2PjikeIkI2EUX4ADEcXn16jTvw0LsjlGfLtlN38oE=;
        b=F038C5a+nLvJOfAonRrqZA0FIkVAhCSoLb2/qlDVx5+e7m6jSFI+IRIAk71igRv6VC
         iv1dtE8ZfnqpA2aqjolHpYjxJ7laKe1EDMvbqz1d/jOyTSrGQRAktKXnb2ca86SL3w8w
         BdNiVpzce1xc8tt46zlmoSpB/BdiN8H0f1TiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Qt2PjikeIkI2EUX4ADEcXn16jTvw0LsjlGfLtlN38oE=;
        b=tqHWfh9mizAhtGBFjA2dk1tJCWG9OiQW4At9MVP0LMrKEN+rdAwPkjNnZ5r+oQ2qIz
         gAg5j8M0UNiDiCtRQPl5qx92PJ8Z1pRHCpxj8XxKHnrQ69PS0pLjkglNLGK2IOqkYdOy
         UG9C0uRl63kddE9IgePiiWVWGSSdlcXR3dIN7KvMqpeYZYnmkfeZRZEg90l3P7rL8HRN
         X2e26cHX5WOaduBiOE4NPecumvNi3xXnh/0GSuMU+N+Z7W0gKW3lnzjj++Pddm1et3e/
         rz4QI356vvEq7Q9G4tgehAOnwIfadEKeyP7gac+CyB8HN6V7dcAQsto3yuk5mLBUZysq
         cRNQ==
X-Gm-Message-State: AOAM532If0C4PaZNZ6wyuGhnIaWU2yMpPavqIGACUDHTvAjPPvuuZqpH
        5410OUn9FlD+95a6xLI0PVJcUA==
X-Google-Smtp-Source: ABdhPJxUu7oGLLG5+Yc0JrlYpmac2lDJvq+Yfl+8kSn6NlG+H76p87SJVx3Xmg+Duprs/I1Obmm+Fw==
X-Received: by 2002:a17:90a:80c4:: with SMTP id k4mr4808663pjw.222.1597220529963;
        Wed, 12 Aug 2020 01:22:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 144sm1498207pfu.114.2020.08.12.01.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:22:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200812082013.64xc6hmt4nchcmab@vireshk-mac-ubuntu>
References: <20200811212836.2531613-1-swboyd@chromium.org> <20200812082013.64xc6hmt4nchcmab@vireshk-mac-ubuntu>
Subject: Re: [PATCH] OPP: Put opp table in dev_pm_opp_set_rate() all the time
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 12 Aug 2020 01:22:08 -0700
Message-ID: <159722052820.33733.14125029118837266849@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2020-08-12 01:20:13)
> On 11-08-20, 14:28, Stephen Boyd wrote:
> > @@ -905,7 +907,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigne=
d long target_freq)
> > =20
> >               ret =3D _set_opp_bw(opp_table, NULL, dev, true);
> >               if (ret)
> > -                     return ret;
> > +                     goto put_opp_table;
>=20
> This was broken by a different patch.
>=20
> Fixes: b00e667a6d8b ("opp: Remove bandwidth votes when target_freq is zer=
o")
>=20
> I did split the patch into two and applied the correct tags (not yet
> pushed though).

Ok, makes sense. Thanks!
