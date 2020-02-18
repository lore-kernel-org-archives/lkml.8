Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8B5C3404D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43822173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582066966;
	bh=TEjhYB0IsTZAHR2KK7F/QjCeXx94uXQXiTd8GOVaUuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VLKed+4oHnY2PUx6O5ma059F0rBOB7OFQ2r7XvLhSvxPQQ0JAbhLOYe9HvmH46PYq
	 8Qa7K5SvljwI7rs+dtR0/CujIPBjbjXHSyeO/etQkBlgXMtxd9p9ti7AM51iKFEsls
	 XC60b/YEsIfYwlK4lfrrjrtl/tvcTgUhJsyZqARs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBRXCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:02:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39378 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBRXCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:02:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so21895491oih.6;
        Tue, 18 Feb 2020 15:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Qdurl6q3a3eB4GyIQmTlaPHPli9FvMDsggjNiK6b9o=;
        b=OxFicn/Y3pMVTnHB/boxzIuUtNlLM9Oj+ACMOYFv/cbm7LtHIKV2OltbTy7zO5FZRm
         JgbYUN4q8gkRdj2HjfPAqBI5zlYDqMbh3dh+0BYuSxY5F9O9xLsA1pu8tYNQvyMppIeb
         T5kOqZs77CRywximPhf2YWftppxcYRI9i3gX7D3jtmlEgBAzbagufDdx3rRvQdTuZWgj
         6jVFPnKHLlX+Y9jNJPd/9BZttgjBoTKp/Z6cbzVNwOj9NCHx9AsxaCeZrxtysMCP5aPw
         PwXUa5NY8ucysXsjclacxQWuFwFRBHZzsYRQ4B4lwmdNOtUwyFaw3LauKTpBNULNbKLO
         w5Jg==
X-Gm-Message-State: APjAAAXmlgFk52f3TVG3PcQ7NrQl1O2PNEZfdUTEGOy3uccwMThOmlTZ
        LtV4nwfGO0lAdgvqt+Fwv8ShZr5Niw==
X-Google-Smtp-Source: APXvYqzmF4QLmggvkwY8/szwJ4ToFkj6ea0y9bI9QY90+bM3sJJowbM21nmt30gu9Lr3d97D28YFkA==
X-Received: by 2002:aca:1011:: with SMTP id 17mr2961684oiq.72.1582066964108;
        Tue, 18 Feb 2020 15:02:44 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm1879234otu.45.2020.02.18.15.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:02:43 -0800 (PST)
Received: (nullmailer pid 9843 invoked by uid 1000);
        Tue, 18 Feb 2020 23:02:42 -0000
Date:   Tue, 18 Feb 2020 17:02:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: clock: Add support for Modem clocks
 in GCC
Message-ID: <20200218230242.GA9790@bogus>
References: <1582049733-17050-1-git-send-email-tdas@codeaurora.org>
 <1582049733-17050-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582049733-17050-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 23:45:29 +0530, Taniya Das wrote:
> Add clock ids for GCC MSS clocks which are required to bring the modem
> out of reset.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  include/dt-bindings/clock/qcom,gcc-sc7180.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
