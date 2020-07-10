Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A61C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B8D20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XxwiBGAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGJGRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgGJGRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:17:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B5FC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 23:17:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so1820212plm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Dm+DnuSu65AAz7ad3kKqpwMvvV9c9j5Xmv9xtyqJu+8=;
        b=XxwiBGAN+c26EFwmdNtyCR5546KEhOr6l15A/2WA1cMLP8pN66LrG3+GuOSJsd6Hp1
         P3RLqUYcFx0leBYljcKfft2ychVjMOysL/rNcIN+uHyImok3/nIrLFNcnANED1dCbRYj
         AS5NtypFHnNy0fI3n6QTErnWlMhhZ+KYQiiF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Dm+DnuSu65AAz7ad3kKqpwMvvV9c9j5Xmv9xtyqJu+8=;
        b=ei0KYjCXfGZytYelziDVtFNzZB1GBzbxno/ZEA0uCenFdHA3qeHpCjxKsJateqg6hI
         nB6Fg6n89V8MTFTVsNB/k7n4JBKzBV29r4yTZcrXfgT7zd983ePF9BA2AfipL23KHyb9
         ck30zK/lKS+MFja0R2xJRDMuHEbcc6YpdqVe+hUhDAFxUxxZvpz7m6NnaI5Df9g63ErQ
         e0B6hhnNsZ1r09beXzIE91DvqmS4qIYtYj7yA1gP+o+r/9llMov8cid3FO+DaE72davA
         QDG8Zd0yxQ2DGjR/Xqo35/1+67YzGCKlAzAfq8fduNf5Z0tOn+/u2rAv/eBK+WEpR0fd
         QHdA==
X-Gm-Message-State: AOAM5300nemlEI+xcPrFISB+JBQZG8ySEfMK6pm80CUwRfj6mEXCpzJQ
        oHYBixO0yPJ6YrTrcG8ZpC0eIg==
X-Google-Smtp-Source: ABdhPJxeORysV4VYKgc1U20BRm3mRz4m6pPLeqkD6XUKkuZx9wgWwg2gIJCbKPZnAH4/WMJhJFYXPw==
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr4037122pjb.32.1594361821473;
        Thu, 09 Jul 2020 23:17:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id v197sm4888519pfc.35.2020.07.09.23.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 23:17:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1594235417-23066-4-git-send-email-sanm@codeaurora.org>
References: <1594235417-23066-1-git-send-email-sanm@codeaurora.org> <1594235417-23066-4-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7180: Use pdc interrupts for USB instead of GIC interrupts
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Date:   Thu, 09 Jul 2020 23:17:00 -0700
Message-ID: <159436182019.1987609.12377232042152594056@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-07-08 12:10:17)
> Using pdc interrupts for USB instead of GIC interrupts to
> support wake up in case xo shutdown.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

I suppose wakeup-source should be added in the board files.
