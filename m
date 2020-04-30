Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A71C83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB702082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uU8jiMQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD3GPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726412AbgD3GPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:15:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF28BC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 23:15:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so294226pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 23:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x7/KKFn8BCkAckmQr7phq+s/+BjeL7Rl1CFL6HKpG5M=;
        b=uU8jiMQxr10bGxm1TozvntSNrpr/ofFVgKkcU+ecnvJtkVeym8FAECunFnlZFR0G2Y
         WhyOkbEirdhHPcBYUu1pigRboOOZG2esfQr8eoOFw0OXW9HJcjtuuD3ZkNIP3RYguMoc
         ScHCiHedlV342uWa5kG8ZeS/ITDKoWZ0ngJICR6hnpGdkHIF/NUUM2DDVbpSg9QMFUXM
         BJI50pwbVHokPxJGuiWJRQo6No6yo1uEFAyUm5dvpgknd385NcgRv1vH3yjTYwsdkMw3
         pcdV5B6DFjV8SeOz5ql+qKl53Rg1N+kVpXDFYoyKRBGViIvdCTSWC4YDxtK8r1IRce2j
         VBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x7/KKFn8BCkAckmQr7phq+s/+BjeL7Rl1CFL6HKpG5M=;
        b=XttjDDGzkEvz7FeSvbPuxPwTaVwwwGh9Z2BJAPffUHuk+dZNk5BExwMUh3GmrHkCSN
         T4/PZvn0ZWq0JqxxTvpTpm6GCirhbs/kBbZ8laWlP+n9NmwSXLWie8HBN6PKK9uJXOcY
         U70IwvsP5CkFt9/w5AlFiEE0MwQkHRAF7IOdvCDchfiKrkiIXoHPTPy1QiuWVqX2lFEi
         VGgtWec9PoXysUOFTpDKdGmKlmkwlbMAk771jU42qb7uvVNL9JKei8h78qkev9CX7uPj
         iSA/Wey1RUrtVapS9blh180yc/ZEMqeoExl4b7V3KnKRQ4gAva1LaKOccU2fF7wjd4FZ
         yRNQ==
X-Gm-Message-State: AGi0Pua+qgVhXjttH1GwONaHDmDLzwy/cPpmVQPQKcNL42UhhzOUA1r/
        xgEilkZ9lWZEPXkHwes0Z2scn/yiJ4U=
X-Google-Smtp-Source: APiQypLAiOVZAO2gmBRBnYBAlX/vRL0D7u6b7kPT99EVAW2lZmw9h7hDYcoo39quYJ+JkeBMpT6Wrw==
X-Received: by 2002:a17:90a:5287:: with SMTP id w7mr1254117pjh.66.1588227311459;
        Wed, 29 Apr 2020 23:15:11 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id s76sm2283379pgc.85.2020.04.29.23.15.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 23:15:10 -0700 (PDT)
Date:   Thu, 30 Apr 2020 11:45:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3 03/17] arm64: dts: sdm845: Add OPP table for all qup
 devices
Message-ID: <20200430061508.6ktamklc4nslf5qp@vireshk-i7>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-4-git-send-email-rnayak@codeaurora.org>
 <20200429000234.GK4525@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429000234.GK4525@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-20, 17:02, Matthias Kaehlcke wrote:
> Judging from SDM845 (which has more OPP tables) the convention seems to be
> to add OPP tables to the nodes that use them, which seems reasonable and

I don't think that's right. The same DT opp tables are used for
multiple CPUs and they are placed outside of any device's node.

And that is the reason we have handled that specially in kernel (which
Rajendra shared in another email), to not create a platform device for
the opp table.

-- 
viresh
