Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4638BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 00:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF13A208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 00:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIXLBDWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKAxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 20:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgIKAxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 20:53:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F4BC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 17:53:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s65so4282480pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=J/p2zeJal7lu4jnKjS6joWIHZVCnBy6PqNOmdrTgyn0=;
        b=TIXLBDWRYtUn6eLA80L6O0uvCk6TBjj4AniC+Bi8kNOuAKvzYRvLYYGIwEkpqL5nsl
         VaRW9u/quuoqKPHte6KKaIcjzz947FVFK1BfypoqPmk0HT5GELckByn3S1SujPonoAtb
         PZrRYCXHvg/zcMYnn9zT3RxYs164icUe0hsYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=J/p2zeJal7lu4jnKjS6joWIHZVCnBy6PqNOmdrTgyn0=;
        b=bhNDfHS7fCAbzhczlZiE1AnfejoeQ3hyjG/MWjwMzNxWANXcXezU26tWbnH3V1SfXA
         s6CDyOEl0h92DUd/tVkkI+e+bXfcHPxZaIOAPorcfIyat7ZdcB3lDS+8M18NulXaJRPI
         hwuvFmMXyVaTizlNlutctjTxavGxEIWelqFvcoBxm9kFJPElLO0UdnI7qVgwC5m+Zfag
         AQnsKzdQZin56i4eRpOQGMKy1zMAdSB4yw/5SK7igK1E1JX8gL3buCbK2uVJHs4xM+Jt
         GOLeNCtkD9MvDx3fMiqao/2fKdStSZu7VemsNIHpIqXdNpteDlNFtnPFO+73vSAfgu7/
         m32g==
X-Gm-Message-State: AOAM530d9qXACiy0CEW3j+83Ek4qFO2tWkoKPC6x2FF5WKgT55V5E8a3
        /zZCyEPVPy2zP7h3HlcHogd4ZQ==
X-Google-Smtp-Source: ABdhPJzEhTs8rrBBAS/FScRg+begABhEBAZq/5TLsIxOT8LJlFtDnMk0L4zXeTMfg5n0NjPM7rPzyg==
X-Received: by 2002:a17:902:9a06:b029:d0:cb2d:f276 with SMTP id v6-20020a1709029a06b02900d0cb2df276mr7936425plp.15.1599785589359;
        Thu, 10 Sep 2020 17:53:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y4sm287648pfr.46.2020.09.10.17.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 17:53:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6b546379-d5ce-f0bd-7907-be36f90c15ed@collabora.com>
References: <20200909224226.2177401-1-swboyd@chromium.org> <CABXOdTeWfuZHLywMU1d+No-NSZ4uusAgkhs=2hNZGFM-uYz2wA@mail.gmail.com> <c3ba5d92-8bfe-30d7-44f0-c8a3e40d1906@collabora.com> <CABXOdTdsVyae9oHKEMSbXOsi5VWUZhLbKVxeNVedc4redZineQ@mail.gmail.com> <6b546379-d5ce-f0bd-7907-be36f90c15ed@collabora.com>
Subject: Re: [PATCH v2] platform/chrome: Don't populate lightbar device if it isn't there
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@google.com>
Date:   Thu, 10 Sep 2020 17:53:07 -0700
Message-ID: <159978558757.2295844.13766111546939928492@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enric Balletbo i Serra (2020-09-10 08:49:42)
> On 10/9/20 16:52, Guenter Roeck wrote:
> > On Thu, Sep 10, 2020 at 7:32 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >> On 10/9/20 16:18, Guenter Roeck wrote:
> >>> On Wed, Sep 9, 2020 at 3:42 PM Stephen Boyd <swboyd@chromium.org> wro=
te:
> >>>> @@ -206,6 +209,17 @@ static int ec_device_probe(struct platform_devi=
ce *pdev)
> >>>>                 }
> >>>>         }
> >>>>
> >>>> +       if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
> >>>> +           !cros_ec_get_lightbar_version(ec, NULL, NULL)) {
> >>>
> >>> Any idea why the lightbar code doesn't use cros_ec_check_features() ?
> >>> There is a definition for EC_FEATURE_LIGHTBAR, but it doesn't seem to
> >>> be used. It would be much more convenient if that feature check could
> >>> be used instead of moving the get_lightbar_version command and its
> >>> helper function around.
> >>>
> >>
> >> IIRC it was to support a very old device, the Pixel Chromebook (Link).=
 This flag
> >> is not set in this device but has a lightbar, hence we had this 'weird=
' way to
> >> detect the lightbar.
> >>
> >=20
> > If that is the only reason, wouldn't it be better to use something
> > else (eg dmi_match) to determine if the system in question is a  Pixel
> > Chromebook (Link) ?
> >=20
> >              if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
> >                  (cros_ec_check_features(ec, EC_FEATURE_LIGHTBAR) ||
> >                   dmi_match(DMI_PRODUCT_NAME, "Link")) {
> >=20
>=20
> That looks a better solution, indeed. And definetely I'd prefer use the c=
heck
> features way.
>=20
> Gwendal, can you confirm that the Pixel Chromebook (Link) is the _only_ o=
ne
> affected? This one is the only that comes to my mind but I might miss oth=
ers.
>=20
> I think that Samus has this flag (I can double check) and this was discus=
sed
> with you (long, long time ago :-) )
>=20

Sounds fine by me. I'll wait for Gwendal to inform us.
