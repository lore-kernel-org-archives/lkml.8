Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F0BC55194
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C6320728
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i3Lalq5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDYTjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgDYTjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:39:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18775C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:39:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so5410251pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=FFJ+RlIhSOPxhMwKLc97vVcR1rOxDF8GYeyH64M0ydo=;
        b=i3Lalq5cuGCVKoML246R4E8KH9Vsvt1oOUaMLmiW0f02n1iwTSO2C7ec3YfI6FkZY5
         dyC8mB7Y4nHzjjPkMlSt5hkzbzMJMeRAj9M3k2cZtyFEmLRfmaNs5b5z/Q3XkJgJNsIK
         WAVu/yAWl3WZ2xxyUxnFkKt7QWECEHLjbbvzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=FFJ+RlIhSOPxhMwKLc97vVcR1rOxDF8GYeyH64M0ydo=;
        b=VcQ9ABhxLqZPc3WQgV1J2tOCjb1mCIs5cgXLUlcI8fVRnsXfrOSS0r4wSY7TUNh4PY
         y8kuEL0whceugxJ1L1xNnYp10Q3cJv3KEQcvOOk6mogJUq5tq6F2M/Dqpa9tfgocWfaM
         eJQeKpqiE+peaHgE/2bxxtoOzw4gRHXDZuA0/9XuNPNOqDG4gA4WEtD+jYUKjX+NuGrP
         DDXc1CnB4YW9N65Jw5tuiugDe7p+9yz1G4RC6E8vmwouRHh3rEfA7hhnyivvfpGXpylP
         QmRxwr7kgCqKcjiZ1t5m5Dy+xdyzdIdURRLG+/5dRNLeldf7lO+xwtSbgyi/uXpIhxPO
         Uwmg==
X-Gm-Message-State: AGi0PuZjCLVNHCI7oKZU9Xko9KeGkqVh4XzxXHUnP+jN4+eNqoetL18Y
        tBQx4oCiYYtlA+PBEiSk7YWXYQ==
X-Google-Smtp-Source: APiQypJjb7QoZatoPvZ0C5SA3OcumKCIMFSbn7THfXcy0NM0yccE/7t+zWNjac26pi33jCqWjxp58A==
X-Received: by 2002:a17:90a:d709:: with SMTP id y9mr14198065pju.50.1587843570681;
        Sat, 25 Apr 2020 12:39:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n16sm8679956pfq.61.2020.04.25.12.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 12:39:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200424111644.27970-1-saiprakash.ranjan@codeaurora.org>
References: <20200424111644.27970-1-saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Support ETMv4 power management
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        devicetree@vger.kernel.org
Date:   Sat, 25 Apr 2020 12:39:29 -0700
Message-ID: <158784356931.117437.2821018841391441959@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-04-24 04:16:44)
> Now that deep idle states are properly supported on SC7180,
> we need to add "coresight-loses-context-with-cpu" property
> to avoid failure of trace session because of losing context
> on entering deep idle states.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
