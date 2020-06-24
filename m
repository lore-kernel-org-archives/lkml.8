Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74593C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B30720738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wca+aKs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405620AbgFXRoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405567AbgFXRoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:44:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F72C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:44:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so1323226plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=blPOdTajVn4OJWy527Nm/cJEP9dim0oSKgwxjjYh5Yk=;
        b=Wca+aKs6OCeCLlQZHE2jtvWB9Igz6JI4h9CAPSmdajSZfhp2ZUPUCRDHujdfiLw847
         RY+1k9HzrWuintQ1IOg0AvP8qZaBBwDF4rut0xOtMGygpnJK8PHQskMf03hSw+HiPVN1
         oxn1UkEEkBskJoSBUGnoEZcMTz1dNz834ktawILifAj0yQ4aUyK9pBs6xHm+h0Ljrf+y
         rFbYYzWRA5j14xgc5ygP+TrFiJ3HazqFe2tZLTx5XJ8stS8GbnLwxdSUQj0nGIGycoYP
         ZeXu3B8KwzSYDlcjgCzItlFn+A2QCmb5X4lC1VIJd3pDehc2NmqWTjMxU68j3EGSHcex
         Gr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=blPOdTajVn4OJWy527Nm/cJEP9dim0oSKgwxjjYh5Yk=;
        b=TGQBBr4yHJmXatEEejZ6fspLXxNAiJYTZNzez5xWbwKFaH7YQV0wsTGNif6A1tbF5Z
         nNQulDwKK1hNb+wYPfkFRLkkZ3hlNeJzeDyGXLRg1HKQGEvbeh5rpv/5wanZJw0FVRUO
         Afr+8zhs30RWnnTGKcemfhxFDucqlx1XS7u3d/2oqLgLGnEV8G8I3VMBC24X8QfGsiM2
         Yjcb0nXpz+TRsV1srT8Q2hBEiUMxvoX8Mjt+Vm+U40h389hYYDnZf5Qh6upoHZuZXcq7
         FTKngjfS1wr3eMOrMu6q/E+pF7/aznF0PbAXVXh66uZdwi4yH/XY/VZLWVJrGr5B2iEJ
         uyhQ==
X-Gm-Message-State: AOAM533+sC0dPXJl5f3KqIJyc8uCFR3esgm73LVkFmf6eIwn/NynGJHZ
        11VR9oxQJKjJMx4lGtxP+1NrYw==
X-Google-Smtp-Source: ABdhPJyNVz7Caxp0j/OEjoO/h6oiEfmM/aIeAAklNOAuzgysJYahbgohTEF9YUzi6hvucALYQ5uqlg==
X-Received: by 2002:a17:90b:238d:: with SMTP id mr13mr30519050pjb.19.1593020639461;
        Wed, 24 Jun 2020 10:43:59 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h13sm20588371pfk.25.2020.06.24.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:43:58 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:41:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>, agross@kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 0/5] Enable USB support in IPQ8074
Message-ID: <20200624174117.GU128451@builder.lan>
References: <1591625479-4483-1-git-send-email-sivaprak@codeaurora.org>
 <20200624171834.GH2324254@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624171834.GH2324254@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24 Jun 10:18 PDT 2020, Vinod Koul wrote:

> On 08-06-20, 19:41, Sivaprakash Murugesan wrote:
> > IPQ8074 has two super speed USB ports, with QMP and QUSB2 PHYs.
> > This patch set enables the USB PHYs and USB dwc3 in IPQ8074.
> 
> Applied 1 thru 4. Bjorn can take the 5th one, thanks
> 

Thanks Vinod, I've applied and pushed out patch 5.

Regards,
Bjorn
