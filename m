Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE94C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAE42070A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFVssbIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgENOGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgENOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:06:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C523C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:06:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j5so4313902wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNkj51r2L9rZ0K9EyWV0hvRQYzmcF5SBVqNFyVyFPAo=;
        b=FFVssbIpXryFajjJXelTChxllm6xJFU04WJDqYHF38lQ/dFAnf2M7LYURSvd2MAZLH
         1aFzJ5ydJ+ryiTLpYI4YhCocurxWwXswgOTYigjFTMJstIFj/kqzctDv7RL4JFBcM55O
         +ZKs8WrMfnD+KDmRrrXs8Z/FeIbgrcGT3m7Rn28Ve7jUxrDRv4iah9/vpyOz9A7RC9kx
         ilf3YTjrAeBfYkZnxl7oVDtVX5zOe0QTre9YKfBEldQO+nq+dZRH1JJTuU7lnGhbE/UG
         yM7qAoLViyV1mRjKxwVf5+28hiHEm9lkR5c2ODp4AA2GEtpKS1GdNnrVQVkyTtf5kSgh
         78OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNkj51r2L9rZ0K9EyWV0hvRQYzmcF5SBVqNFyVyFPAo=;
        b=aP/yfu948JF4/kopyhih0Z0GLQta7ZynX8wTLcPK4wI87rnAnAy1M5hm/6pyuI6rRO
         WwvA5sIOq6KKVmNy9Rw129kGzIbcdgheS12PpwjYqYghtXtpl8rUr51+vIJnwwg4OvA7
         FCXrEithXwH6Qr6pwQKihCh9BpQDJ1QQCS11y0fZoY9supE2E34AzxpPnRSujMkYlZ2Y
         Ph2ENpLLMml7ZZhAu7q1HVzIWsId7Kb9/ROL1d8cXk8a+XY26O4bevmzwmep1Kjy4UJk
         UasnLNbkEpV1q0DAAN3A0Ns4dqalMuSDyAVrHurapY9gcGwe/WKUs65CrvVb+UgzoePf
         YmNA==
X-Gm-Message-State: AOAM533Bpx9d0dpYsVhzeuqK7kDmSyCJgkctVYKSi9qqm1WOQ+bjf4YW
        fxO0p955vNnZzZu6JKpHRna21w==
X-Google-Smtp-Source: ABdhPJwWfEo76YwG+HFwYeVUwbduEOE4F024tHFCHqVD7jVePGd1AlpWVV1SVylPxSX56t17X0n1JQ==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr5583058wrv.242.1589465200349;
        Thu, 14 May 2020 07:06:40 -0700 (PDT)
Received: from localhost.localdomain ([37.120.32.219])
        by smtp.gmail.com with ESMTPSA id t22sm10487621wmj.37.2020.05.14.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 07:06:39 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: c630: Add WiFi node
Date:   Thu, 14 May 2020 16:06:06 +0200
Message-Id: <20200514140606.1343766-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20191018055841.3729591-1-bjorn.andersson@linaro.org>
References: <20191018055841.3729591-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Specify regulators and enable the &wifi node. The firmware uses the 8
> bit version of the host capability message, so specify this quirk.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
