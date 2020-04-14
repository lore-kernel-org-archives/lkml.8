Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C95C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EFD20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXtZj/Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633491AbgDNU5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633447AbgDNU42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:56:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736AC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:56:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l1so491432pff.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=NtGBbRMFHuGLYVWwP2S8WNTOMnjyQJo86GhiRsq/RLI=;
        b=UXtZj/Hxj2RogzSqhPdsIrV+Tb1Mi6cLH48af5r9FlBJkIsru50FCL5CzAaQQeqJ7n
         rsIoZhTl1LDgqnD5qEIf3p202tMUHA7FkZPQ5/P1FGdHN3SH3xTUhgGA5Dk5VXQ7LnQs
         3UcGLqg1dTAzptGp9XrHAIY2rkU1JMmoyOJsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=NtGBbRMFHuGLYVWwP2S8WNTOMnjyQJo86GhiRsq/RLI=;
        b=jTV8lR45ts2gq1lQLEwjwOv0+CECIQz/qN/ObU7cNs6dvPFSIYNkHR2bNSgXFiyFs2
         j2kVD540EAURwRNv3b3K0PF/CtIbITne83WJmZTcem5NCsffd0yOaL4Rvp8tv2XcOA+N
         KYUUKQ5O2NAbFEIDimzuDaBFVzYQqHwM5WjWNMzWzLlyO9XgDhBPwDD9iZ+G1v3K/r1P
         9aMsP5LoSDPijGBbUegOxuz4PGRe0wYkPs7qruMo36Un/Uqsmq20WBNChUzP/LJcY/UQ
         HSCrgRuSPPKGPRoCslBF0dEfWaZVgYr4e9s+Hzz1+zdmPNPfXfAZrk97npgqore8W8Ya
         lRGw==
X-Gm-Message-State: AGi0PubJNOK22LIVZjfW/oKeiR3S0dulVc38R4OOZ8C8E63r9o4KaLpn
        nQGPAJaVxmamEK02e553KXm7lA==
X-Google-Smtp-Source: APiQypK6gPQlntq3g5CB8LbqghejJJbCs9iCRhnLW7s+orakW8jOYEegO8lYlVr+WaR9N/K8T1o/Xw==
X-Received: by 2002:aa7:8505:: with SMTP id v5mr1947475pfn.224.1586897787330;
        Tue, 14 Apr 2020 13:56:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b21sm6889644pfb.130.2020.04.14.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:56:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1585809534-11244-4-git-send-email-sanm@codeaurora.org>
References: <1585809534-11244-1-git-send-email-sanm@codeaurora.org> <1585809534-11244-4-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v5 3/3] phy: qcom-qmp: Add QMP V3 USB3 PHY support for SC7180
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Date:   Tue, 14 Apr 2020 13:56:25 -0700
Message-ID: <158689778567.105027.9816194008999279570@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-04-01 23:38:54)
> Adding QMP v3 USB3 PHY support for SC7180.
> Adding only usb phy reset in the list to avoid
> reset of DP block.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
