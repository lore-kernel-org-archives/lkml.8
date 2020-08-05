Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A50C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1866F206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6CnF3IF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHEX5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHEX5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:57:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:57:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d4so5534711pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4ifd5xwQw/fF71sDAVj0NW6xVjjKI1lLoO8YrlRE1c0=;
        b=W6CnF3IFM1qV4vtyI4l+BsHliSAapqyzRfwP5beGaDhXjDfZFPIU6UStOC92nizOTo
         aWkDKwkFohx7OKn2mg8i/RSJrfwtBoR5s6iBJWAGa9yjAqbJVL7kn4mG5Ax8Ih/a0UGL
         b1ZjUdMSZyOOwYExEooYKVQan12BTOgKsSKo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4ifd5xwQw/fF71sDAVj0NW6xVjjKI1lLoO8YrlRE1c0=;
        b=pwLoudeSUjtBdMbEHGiplvjn0LIw4MXUtP8Nr4xIwVvmzpBr+Wy7k3qVvRz6oaHTz5
         toDGFgmt9xkTeP51DAagygnBtL/8w6czZxIV8siFe/R6lzT6A3JpUIKLTIS6MeBgCZLs
         YoW/we8RWv2mMIyOFH/Dal49YiMh89yrlPoKP8X5cRyGUiAvl9Xz2tS1cQzDLJgHlRas
         MNWkwrhTs9ZFOsWoFDVSes9CW/APmPRjgsE9sHlw0WYd57vBtzC8+eefqZ2roLTkjvbr
         UR5bXxB6pPgf1j1gKPuhUc7jIZi4/KBQnKnSoZpLVgt429vL5pnec9QdQLqDvjVnZTWI
         9v4w==
X-Gm-Message-State: AOAM531pVk0+Ac2sWUf0hlA0wM4/9A6IptQPLReP+f/WYKNX2GX5Fu41
        EnzUwcbnGrQvhwm3gdC6C6JP+A==
X-Google-Smtp-Source: ABdhPJxdV4c+ByHIoyl3UTQ5JOq/H3l5NMy7snS9vWIKQev3DSMuRd8Yi8bmuJJTKYnajrrlgKX1jg==
X-Received: by 2002:a17:90a:f68a:: with SMTP id cl10mr5578673pjb.40.1596671864307;
        Wed, 05 Aug 2020 16:57:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id go12sm4214725pjb.2.2020.08.05.16.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:57:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <98050322-9ba6-303c-4ca4-07baa56ebd80@codeaurora.org>
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org> <1596541616-27688-2-git-send-email-rnayak@codeaurora.org> <159660954201.1360974.5176671532597020049@swboyd.mtv.corp.google.com> <98050322-9ba6-303c-4ca4-07baa56ebd80@codeaurora.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: Introduce 'assigned-performance-states' property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
To:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Date:   Wed, 05 Aug 2020 16:57:41 -0700
Message-ID: <159667186194.1360974.10053425753327700919@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2020-08-05 01:13:06)
>=20
> On 8/5/2020 12:09 PM, Stephen Boyd wrote:
> > Quoting Rajendra Nayak (2020-08-04 04:46:54)
> >=20
> >> +       device's performance, also known as DVFS techniques. The list =
of performance
> >> +       state values should correspond to the list of power domains sp=
ecified as part
> >> +       of the power-domains property.
> >=20
> > This is different than assigned-clock-rates. I guess that's OK because
> > we don't need to assign parents with more specifiers. Maybe it should be
> > worded more strongly to clearly state that each cell corresponds to one
> > power domain? And that it should match the opp-level inside any OPP
> > table for the power domain?
>=20
> Sure, I'll reword it to make it clear that we need the same number of cel=
ls
> as power-domains, and as you pointed out below that 0 corresponds to not =
setting
> anything.
>=20
> For the matching of opp-level inside the OPP table of the power-domain, I=
 don't
> think from the power-domain bindings we limit providers with only OPP tab=
les to
> support performance states? It could be just a range that the provider ma=
nages
> internally?

Ok. The example made it match so maybe that can be clarified as well
that it doesn't need to match any OPP table performance state.
