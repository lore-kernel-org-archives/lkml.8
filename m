Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F508C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9BB20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RyTjRiKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDXChm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDXChl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:37:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365AC09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:37:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w65so4053091pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=fEKcHPMVpq7w5QdP3SvOJT0wRkjikmlCTW2T7tBcG4c=;
        b=RyTjRiKqz43EwGmHmvWzKxVzC2fgISK1yibeOGx4dXinZb9g7m3m6BsnClMA2sy8xx
         UVdneOUncjAH9bZtu73dLPDIDy6rJ4qI3EiaNtoN9fZ8+aZNsH4CFhrVQc48q4ru1iuK
         vbRmdmXDKFWXYMEYw2mX+R9UfIAFC09dIZPH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=fEKcHPMVpq7w5QdP3SvOJT0wRkjikmlCTW2T7tBcG4c=;
        b=L9w9nBvxO1SMy4F0jc6P7+XAU/itwPz/6sdNwTEWP2qXUFUSiSXQ8D6leL4y7o0hn5
         4tLcT7NNFbdKlIBaURlTxgaL44mrwisevz1LOckjKNhlkV7f8lBeJEBOnJWrBp2TfyfD
         3K9ao47gR8d2RPVkpIKU9CrTtX218LGkbBPqT+JPnTCLZMdXE5mxJZtO8iVfNH8Auc1q
         BGmn634Z+tHwR/CL9ubyVzBw2WK87lYtMMEgVFB9vCshYVc/qOCyTlzRFVPfKE/4rPi/
         9JKmf3BoemOBPVEpIwfiFnkKrSDuIUtVGauqGOZJVG/l+K67A6HnlWjpUQ6E2wAaTxN5
         w8HQ==
X-Gm-Message-State: AGi0PubUrxHCS8qUkWx5G9pY5CDlJitJp94jUW7r2LSwfb8UyQzaxeNh
        qsGo+cCEvRagbWQLIaHXVUd0fdN9R60=
X-Google-Smtp-Source: APiQypKF0UGXhTWB19TllAfo2hJ2+KhgL9Z9Q2/DmvmBaj6+cpxwTikdmKurZwoua/eSb0RYIInMCw==
X-Received: by 2002:a62:1789:: with SMTP id 131mr4003804pfx.287.1587695860466;
        Thu, 23 Apr 2020 19:37:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l185sm3932639pfl.104.2020.04.23.19.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 19:37:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7cb97940-18d6-75b1-f4d2-7a80a6fe68c8@codeaurora.org>
References: <1585586460-3272-1-git-send-email-mkshah@codeaurora.org> <1585586460-3272-2-git-send-email-mkshah@codeaurora.org> <158682455899.84447.8337952928773625866@swboyd.mtv.corp.google.com> <1f1322be-c93a-f2f2-c2fe-541f26d8682c@codeaurora.org> <158693796555.105027.4658047860202135403@swboyd.mtv.corp.google.com> <bddc11e0-8d9a-dd55-3aab-42aeb18204f4@codeaurora.org> <158755213744.163502.17257131401798918469@swboyd.mtv.corp.google.com> <7cb97940-18d6-75b1-f4d2-7a80a6fe68c8@codeaurora.org>
Subject: Re: [RFC v3] irqchip: qcom: pdc: Introduce irq_set_wake call
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, linus.walleij@linaro.org, tglx@linutronix.de,
        maz@kernel.org, jason@lakedaemon.net, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Thu, 23 Apr 2020 19:37:38 -0700
Message-ID: <158769585826.135303.15159589318457908652@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-22 05:14:21)
>=20
> We discussed this in RFC v2, pasting your reply from same.
>=20
>> That looks like a bug. It appears that gpiolib is only hooking the irq
>> disable path here so that it can keep track of what irqs are not in use
>> by gpiolib and allow them to be used for GPIO purposes when the irqs are
>> disabled. See commit 461c1a7d4733 ("gpiolib: override
>> irq_enable/disable"). That code in gpiolib should probably see if lazy
>> mode has been disabled on the irq and do similar things to what genirq
>> does and then let genirq mask the gpios if they trigger during the time
>> when the irq is disabled. Regardless of this design though, I don't
>> understand why this matters.

Yeah. I'm saying that the gpiolib code that forces all gpio irqs to be
non-lazy is broken. Please send a patch to fix gpiolib so that irqs can
be lazy again. I thought it didn't matter before but now that I've
learned more it sounds like we have to use lazy irqs here so that irqs
stay enabled on the path to suspend while they're disabled but marked
for wakeup. Otherwise I don't know how to make this work.
