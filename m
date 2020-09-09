Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41917C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2E021D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WDDG/wks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIIVB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:01:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71229C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:01:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so2970522pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=duyVyKDxPe1AVCpSV8nmqOMfTiZWSiAAWpLSXZctuCQ=;
        b=WDDG/wksKWGosu3IMdzqGPi7tJ00A2nker4TK2MQr4gMxAJ0Hv/9J7iEGSdWQABZS7
         3Bzjz5we0K9w5ZOXO/2ZOWqxAJ89FrGo8H2zTRFwjbbfWzIUht7jS1zsoWgOkWHwteN/
         b3wY30sv0huQRQw8irbr0tUtTaFiJolNWCk58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=duyVyKDxPe1AVCpSV8nmqOMfTiZWSiAAWpLSXZctuCQ=;
        b=BQ6DAfNum2BDhLeeaMHSoKWBQsyGJNIKWzViP099evjsmxdOtbbYE5aMuMimHPDk6Y
         w8fHjW2WsRVbUtGXgReTakUKDbzawGAavdt4EF24slwOBBrvAliSSdtQpM6I4FJ2OWrp
         8S4doC8QgvtKn0RyvzgLdBlkMkgjb0GgsrzfhnwHcbbgj1kRayG2MnrfZoeuBFr98P+k
         RBFIZRSJQAx9Mlv3W9CBmzdBERshRkY9kyHqwtEoFJx9iH2yPQrCDeOTkFxDkqhogO3P
         uA/Czqukf/MlPQm1Ap2KFBOlAsNOkbKEgFjzab6Z6B4yWRg+U+CGMCN91qBmLQuUEuL6
         fOyg==
X-Gm-Message-State: AOAM531qmm5K72og2+1oKNWIdKsPoBlKDZ8s2b0LbUbaTfHS1gvfH0WP
        eyRyU21l2rdxjZTi2SSXR1fIiA==
X-Google-Smtp-Source: ABdhPJwJsKtee7G0BdFWC5QA9AFECTGvN2nTCL5ApuQihIP7Apej3l/19Ja6S8vixGqws9tOBfI/fQ==
X-Received: by 2002:a65:49c7:: with SMTP id t7mr1943498pgs.131.1599685281943;
        Wed, 09 Sep 2020 14:01:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id s9sm2984482pgm.40.2020.09.09.14.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 14:01:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABXOdTdYJs4_nS=Oj5J=_Y0Q34Uo_i0mY=KKkr0PvUOjOOxG-w@mail.gmail.com>
References: <20200909202609.1630698-1-swboyd@chromium.org> <CABXOdTdYJs4_nS=Oj5J=_Y0Q34Uo_i0mY=KKkr0PvUOjOOxG-w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Don't populate lightbar device if it isn't there
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <groeck@google.com>
Date:   Wed, 09 Sep 2020 14:01:20 -0700
Message-ID: <159968528004.454335.687873020977684163@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2020-09-09 13:48:41)
> On Wed, Sep 9, 2020 at 1:26 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > -static int get_lightbar_version(struct cros_ec_dev *ec,
> > -                               uint32_t *ver_ptr, uint32_t *flg_ptr)
> > -{
> > -       struct ec_params_lightbar *param;
> > -       struct ec_response_lightbar *resp;
> > -       struct cros_ec_command *msg;
> > -       int ret;
> > -
> > -       msg =3D alloc_lightbar_cmd_msg(ec);
> > -       if (!msg)
> > -               return 0;
> > -
> > -       param =3D (struct ec_params_lightbar *)msg->data;
> > -       param->cmd =3D LIGHTBAR_CMD_VERSION;
> > -       ret =3D cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> > -       if (ret < 0) {
>=20
> I am quite sure this conflicts against the patch series I submitted
> earlier, specifically "cros_ec_lightbar: Accept more error codes from
> cros_ec_cmd_xfer_status".

Thanks! A pointer to git commit would have been helpful to find it even
faster but I got it now. I'll rebase and resend.
