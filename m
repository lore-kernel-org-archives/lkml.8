Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE9C3F2D2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6E5246AE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 00:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="drg6vS1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgB2ALN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:11:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36640 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgB2ALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 19:11:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id s1so2881806lfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soF+XNnQcRWH9WEz1Qgu4eyaAJkJ/vm8FJWGg8joEIc=;
        b=drg6vS1hx18eHnCXRrGQ5GLjEMSfmRY2PzYoDE87GSE95WIYLG7hgVQOgKgWgEMx7c
         LOHkgLrdw3gkZ3Hk/eKZvKgsDNviOJBFj0KDVjzmy4tqsn1cSTTTArhz9NFzVmXYdsTH
         OkA3PEYdCXfvsW81Rl0F3v88UAMpEPZ+txtnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soF+XNnQcRWH9WEz1Qgu4eyaAJkJ/vm8FJWGg8joEIc=;
        b=HcbIOc8opTwvznDDCsS4I7BmtJxnBKLcJZSGEFdRVBn5q0koYZb1IXa2CZ1W4D91yT
         +ZlMawfdTHIcY0Zd7rPbgQk91dNcFjq6hnadxhJMZjpTswOquP4aJa57ZeNDCeNa5fin
         qwHg7Q/5CnnDt0to1J4a6AzQ+raqvW2uaGKXp+kWVDtygUsVA3oE9kUPKqG9IP7vkWzo
         5SaaJanLjUJ2LTaiBND0+qqWsUShX7VDwaj4DLRA4YY/Q9NelieF30VYB7v3s2CCvVsz
         Hf3rMdPiGRiPbwNZGHkEc0yVAONodyxSlyXYCP7gK7cxA+Ob7lKcHNHIoJlrQjjeJoV5
         wirA==
X-Gm-Message-State: ANhLgQ0nACJCNyOXWfltBSruzlHPXsUM2j6n3bcFk25xYk4pWso6RB/F
        k94SJ4x65mEoPnku4grmW9eJjCgUNxw=
X-Google-Smtp-Source: ADFU+vuS7tTosc0kIEpPPtjNrtsDQNQJFM8CtCisVamH7aKlLjz2nbfhFm4qj2U2v/4ArI0GN7UvWg==
X-Received: by 2002:a19:6445:: with SMTP id b5mr3800788lfj.187.1582935068768;
        Fri, 28 Feb 2020 16:11:08 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k4sm4088397ljk.12.2020.02.28.16.11.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 16:11:08 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id h18so5099033ljl.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 16:11:07 -0800 (PST)
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr4350118ljg.3.1582935067385;
 Fri, 28 Feb 2020 16:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20200227105632.15041-1-sibis@codeaurora.org> <20200227105632.15041-8-sibis@codeaurora.org>
In-Reply-To: <20200227105632.15041-8-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 28 Feb 2020 16:10:30 -0800
X-Gmail-Original-Message-ID: <CAE=gft7=myM5gYLpuTA48BeUiwwN=Sk157LGAQ_nuz8fi=t0mg@mail.gmail.com>
Message-ID: <CAE=gft7=myM5gYLpuTA48BeUiwwN=Sk157LGAQ_nuz8fi=t0mg@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] arm64: dts: qcom: sc7180: Add OSM L3 interconnect provider
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 2:57 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add Operation State Manager (OSM) L3 interconnect provider on SC7180 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
