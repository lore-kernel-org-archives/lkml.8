Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFA8C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874122065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yo+dSWbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgG1Tvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgG1Tvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:51:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9437C0619D5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:51:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l2so5237131pff.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=raGVKOv2WKcQ/HrShbgsHsL4qqFT5p7jAaAAKZ2AdxQ=;
        b=Yo+dSWbzGAgOCDS7Yh9qW2rJwOKdOEATdhNeAi49R3TUJ0nG8LHe75MIpCYgi9QynD
         G8rKEyC7zgPO2D994sTx70TN3SHAwrX9jQuJyBbDgZsYseYmZLcWmNMXUbhwK623KX/9
         4ZLQRf6+FjH0ixTrvr0+KE4hRE3vhnO54Y/x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=raGVKOv2WKcQ/HrShbgsHsL4qqFT5p7jAaAAKZ2AdxQ=;
        b=pRA2AORYz4GfNjfcBlhbu0vo+IMwBYlY3EOC2CGkL3f3+fPNAbMi+vCMbk7BHA6MLz
         98UjJfuGfnxtZXiJ7cdJ83505q48LCHF58M11VSMZ16bfAdLIP+FMP+AgDmwzASSaaN4
         d5+GTF+R6vUxiF9svQCqrXIFqo7qj9Oe0O0YDlmo4JEludm6H/ghfan3zYh/6gsgnx+s
         uioOOP2g6D14ylOYpp8vj75k8gy1Dj289YgWh3s1TyX7wVjbziIAXFa6FFgC+xm8aDka
         f3c3h3NW8FUJbovCGq1/RvOHiQGdFDLSZXYGNbUQIHWDNGDwZvSDWCpEGQikqz7ZGZkx
         WxjA==
X-Gm-Message-State: AOAM533PKtWA7S9L1+NQsMHeHXWchVknVzlNIYB0jRLc7Da1GGrgKqxw
        tNsrR4S6F1NXn9nVRDtjTqZ6zHDQK8I=
X-Google-Smtp-Source: ABdhPJxJW8dnWHrxxPAXD96L95gMYdQW3Uds0KfVtVFZUPyALLIf4NYdk+96AddTTn4x0K6CmMWeDg==
X-Received: by 2002:a63:3c09:: with SMTP id j9mr26042217pga.206.1595965906280;
        Tue, 28 Jul 2020 12:51:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j5sm7217037pfg.80.2020.07.28.12.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:51:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728165212.GA32586@codeaurora.org>
References: <1595503612-2901-1-git-send-email-rnayak@codeaurora.org> <1595503612-2901-5-git-send-email-rnayak@codeaurora.org> <e68ff810-362a-5b99-206b-f676b204101d@linaro.org> <654e0fcb-ae4d-c151-fa8a-4d029fc823fb@codeaurora.org> <20200724162825.GH9185@codeaurora.org> <159589714088.1360974.13205114501389777927@swboyd.mtv.corp.google.com> <20200728165212.GA32586@codeaurora.org>
Subject: Re: [PATCH v4 4/5] arm64: dts: sdm845: Add OPP tables and power-domains for venus
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        robh+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Maulik Shah <mkshah@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>
Date:   Tue, 28 Jul 2020 12:51:44 -0700
Message-ID: <159596590401.1360974.283437162250734878@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2020-07-28 09:52:12)
> On Mon, Jul 27 2020 at 18:45 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2020-07-24 09:28:25)
> >> On Fri, Jul 24 2020 at 03:03 -0600, Rajendra Nayak wrote:
> >> >Hi Maulik/Lina,
> >> >
> >> >On 7/23/2020 11:36 PM, Stanimir Varbanov wrote:
> >> >>Hi Rajendra,
> >> >>
> >> >>After applying 2,3 and 4/5 patches on linaro-integration v5.8-rc2 I =
see
> >> >>below messages on db845:
> >> >>
> >> >>qcom-venus aa00000.video-codec: dev_pm_opp_set_rate: failed to find
> >> >>current OPP for freq 533000097 (-34)
> >> >>
> >> >>^^^ This one is new.
> >> >>
> >> >>qcom_rpmh TCS Busy, retrying RPMH message send: addr=3D0x30000
> >> >>
> >> >>^^^ and this message is annoying, can we make it pr_debug in rpmh?
> >> >
> >> How annoyingly often do you see this message?
> >> Usually, this is an indication of bad system state either on remote
> >> processors in the SoC or in Linux itself. On a smooth sailing build you
> >> should not see this 'warning'.
> >>
> >> >Would you be fine with moving this message to a pr_debug? Its current=
ly
> >> >a pr_info_ratelimited()
> >> I would rather not, moving this out of sight will mask a lot serious
> >> issues that otherwise bring attention to the developers.
> >>
> >
> >I removed this warning message in my patch posted to the list[1]. If
> >it's a serious problem then I suppose a timeout is more appropriate, on
> >the order of several seconds or so and then a pr_warn() and bail out of
> >the async call with an error.
> >
> The warning used to capture issues that happen within a second and it
> helps capture system related issues. Timing out after many seconds
> overlooks the system issues that generally tend to resolve itself, but
> nevertheless need to be investigated.
>=20

Is it correct to read "system related issues" as performance problems
where the thread is spinning forever trying to send a message and it
can't? So the problem is mostly that it's an unbounded amount of time
before the message is sent to rpmh and this printk helps identify those
situations where that is happening?

Otherwise as you say above it's a bad system state where the rpmh
processor has gotten into a bad state like a crash? Can we recover from
that? Or is the only recovery a reboot of the system? Does the rpmh
processor reboot the system if it crashes?
