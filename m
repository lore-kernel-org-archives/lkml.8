Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34462C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8BD2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XDyZS+++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFQWpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgFQWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:45:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC7EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:45:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so4908277ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yawPnxDk49botwMdb+iaW6FZN+F8UQyFiiskYiOSfeQ=;
        b=XDyZS+++Zkn6BIBUSi9kkFoJ/8TqtbS8h/v3gA9xSe3Ij7PK8at9hy2SlW/d1Jfo6o
         7eNj2kG5JhYecfrqlAgHCWpgrSHi8DGUbTKdHWVoVf7ojfbVlbjRIAT7t4jjxX49kfTo
         BkeSsnuxB03xXOKCVfjEVFSMvjQrIdu1Q1qV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yawPnxDk49botwMdb+iaW6FZN+F8UQyFiiskYiOSfeQ=;
        b=lJTShjCsGHpW8hcriGFqHuKWOHk1gmKo9vd61oVIgw9FwZj7kSxFNb4IhaP4ziz1ue
         eDueK5BdSGmUrNh8rcXJXUV31M3MF21jkWQYvEfiiLNGCpXVV3NXcmzXDIj9zX82gqBn
         juNuUqpDfSk+0SQ+PS8iAP/PmTdfPEYvV5hINeAQbHtpWkXfDW79BTzEGgsJTU5eo1XA
         UzbROKOV6ZXTxsYkHE48v9iwG2sGatQvFbicAvGO+CXYnFxGkiQ6y2rooxbnLm2ba8wT
         6WwpnVa6WHQJRQtjxnoDEaoiytrWSD9hNG0kY//ts/z6/61GEqVoIkI0uIEYKHORigHj
         9ELg==
X-Gm-Message-State: AOAM532I1n7FkzugjFFmhOS5Ba4bGvIN1fDZSm7nW/Zd4hHXX/AbIcP6
        xaHSwUA4WONYmMO3ll9otWmSPOEz9s8=
X-Google-Smtp-Source: ABdhPJxLh7SL1gMCHCZtZ5Ssyd4k9LhCSB5FiJ01GucgZLRH9BKiQIiesfJOkH8X5nR9hz7jhCipTg==
X-Received: by 2002:a2e:89ce:: with SMTP id c14mr818051ljk.406.1592433952177;
        Wed, 17 Jun 2020 15:45:52 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id o19sm224688ljc.23.2020.06.17.15.45.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 15:45:51 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 9so4891917ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:45:51 -0700 (PDT)
X-Received: by 2002:a05:651c:1181:: with SMTP id w1mr707524ljo.432.1592433950682;
 Wed, 17 Jun 2020 15:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <1589946996-31264-1-git-send-email-pillair@codeaurora.org> <CAE=gft5pcHwK8yjObNSSH=U_B6Pz++bDaeUxZhPyJfG2E7LRAg@mail.gmail.com>
In-Reply-To: <CAE=gft5pcHwK8yjObNSSH=U_B6Pz++bDaeUxZhPyJfG2E7LRAg@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 17 Jun 2020 15:45:14 -0700
X-Gmail-Original-Message-ID: <CAE=gft5So9Uk2UqRWs2zFO_iD+6ofMy97bKP4HpgM1Wu6Duxvw@mail.gmail.com>
Message-ID: <CAE=gft5So9Uk2UqRWs2zFO_iD+6ofMy97bKP4HpgM1Wu6Duxvw@mail.gmail.com>
Subject: Re: [PATCH v11] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
To:     Rakesh Pillai <pillair@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Thu, May 21, 2020 at 9:19 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, May 19, 2020 at 8:57 PM Rakesh Pillai <pillair@codeaurora.org> wrote:
> >
> > Add device node for the ath10k SNOC platform driver probe
> > and add resources required for WCN3990 on sc7180 soc.
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
>
> Reviewed-by: Evan Green <evgreen@chromium.org>

Looks like this never landed anywhere. Is it blocked on something?
-Evan
