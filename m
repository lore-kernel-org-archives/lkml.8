Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7C4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47835206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UUK/8ULW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgEUQU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgEUQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:20:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D7C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:20:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so4796395lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhSteGsD4RiqQuK5YmLBZC6UpLmDwoaKdLBagEsgYl4=;
        b=UUK/8ULWjMB2mBygCKclhU6LqqpSWv9z30+t+BDLxfb3VTXARp03TokADV8sjD+Rm3
         OFL0u+IlZG9t7sz8xdVVkBlMtP35b0P9vK22Ys0vOVkK66J0NVlx301AHSdzgwFINPFm
         A8cTPxfFHhEdOwPW+3RdCzCQfr98gE40Qk7QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhSteGsD4RiqQuK5YmLBZC6UpLmDwoaKdLBagEsgYl4=;
        b=H6mf3qvcaGTB92I+YNmySRRVgVjlcujjiNtgpKVJfMdZXFaoKNbwWGB+1gIUwBsDvD
         KPjLg/46CeVYfTNPZi73fQlnGJw8ho5G+0mGC0RjKQfitOG2H28F+mmWQKmFzCRlRD1N
         tT+Lm+3CKrmt7ZjWB5yQQY9og/SpPWnoM39TMdshUG2krBjSZsa5gkeKl5EsaBPbiAP4
         PCZX3QQOeTtJy1R02M1ilk3b1AH0eAdllTn48/zfniTrj2Zy2W3STpuSK7pOyl7gg9cm
         k5lv5nUq7VSF+xveuzTCZ1mmXXDNSghzMoCgy+QROE4ZliI+RJeo49vvp9SbKCi0Ipxq
         4wBw==
X-Gm-Message-State: AOAM5327U2VUiFLThAe1IaOEmGYONPI1TZ5kVRmoSEhR/iCcUH1t1FY8
        kehI7thWAbt4ysIScsU37Xo/BLTkqoo=
X-Google-Smtp-Source: ABdhPJxX4ahixutInODKAMUDvd08OULusyrlwMWXiM84h/gX3jatESO/c3gFxgWkIri2vMwVRtQyKQ==
X-Received: by 2002:a05:6512:3a6:: with SMTP id v6mr1067866lfp.136.1590078022339;
        Thu, 21 May 2020 09:20:22 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 6sm2059321lju.54.2020.05.21.09.20.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 09:20:21 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id q2so8946552ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:20:21 -0700 (PDT)
X-Received: by 2002:a2e:8018:: with SMTP id j24mr5189945ljg.99.1590078020706;
 Thu, 21 May 2020 09:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <1589946996-31264-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1589946996-31264-1-git-send-email-pillair@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 21 May 2020 09:19:43 -0700
X-Gmail-Original-Message-ID: <CAE=gft5pcHwK8yjObNSSH=U_B6Pz++bDaeUxZhPyJfG2E7LRAg@mail.gmail.com>
Message-ID: <CAE=gft5pcHwK8yjObNSSH=U_B6Pz++bDaeUxZhPyJfG2E7LRAg@mail.gmail.com>
Subject: Re: [PATCH v11] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 8:57 PM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on sc7180 soc.
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
