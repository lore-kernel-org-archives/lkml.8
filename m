Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E3C3565B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAB4207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eCmldwwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBUTkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:40:15 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36667 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgBUTkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:40:14 -0500
Received: by mail-pf1-f180.google.com with SMTP id 185so1777292pfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=727EAsMQRz3BzcKFq+yjaGZ0smZaJ6wq5lYL4hCxQBw=;
        b=eCmldwwmaGs6a9choQrTabZ5muMpoPYd8pgAxRa2sPm9ihylVfr8YYvavuA8os4vI5
         lJ3Yvnf196RWlWv5F8A28esZrv737PYuvntY+Ld1Yk/K50DesbseV60ri7BfqTQ93LsS
         y9j6cc4e3NrOsQ3mCtn3QVwYGVV07mts18kio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=727EAsMQRz3BzcKFq+yjaGZ0smZaJ6wq5lYL4hCxQBw=;
        b=Nv8gLAwwwxzDNwTa/W3xMb6TbL6IRv2drgu1TpCvTuCgWwc8E/4JUsiguCVOf+pdgF
         /jmf38d1qcvAQ5Utzutk5zxIGWO37wNV2p2dYSRoSnpCGCaEulDKRdpBfAXtjTopmZW3
         vVbbdrKzRU4zxcp/VX5+hvX6l0Hf8bjrD4qaL7uvyeNlGMRu8Y0MDtkiqdmSooff2x4E
         3CUrkN+vwf8yCdFgRXE4BdwGE8hwrWKjwS/vtlEB0bl6O4HxgQTr8OZe0bCJHIo3XjW9
         CNWVqRPx0GZg7EAvSGPNW6WUbDMC92nYOuX9DxGvPM/kkrCNdnqiKugYj9Ju6S6J+2Fv
         R9HA==
X-Gm-Message-State: APjAAAX7uEnxUCIDbBQjFTaPkuoqMWpWMPZUSRhGdARKXwsA/QiZXzGY
        MbBpkfqOLG5T79yCPPPZBmxBMg==
X-Google-Smtp-Source: APXvYqzbFTpLuLBYG3azYe9VcGVTO7fozeU4ULbuEPbtS0mD0Bzq7RD4RTc+o/ZXgvYmXYycUD12+w==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr38752067pfo.139.1582314014078;
        Fri, 21 Feb 2020 11:40:14 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q8sm3289342pgt.57.2020.02.21.11.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 11:40:13 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:40:12 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V3, 3/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
Message-ID: <20200221194012.GF24720@google.com>
References: <1582277450-27382-1-git-send-email-okukatla@codeaurora.org>
 <1582277450-27382-4-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582277450-27382-4-git-send-email-okukatla@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Odelu,

> Subject: dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings

This patch doesn't add a binding, but DT entries for SC7180.

The subject of v2 was "arm64: dts: sc7180: Add interconnect provider
DT nodes", please go back to that or something similar.
