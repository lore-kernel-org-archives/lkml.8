Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9AAC4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 05:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5793A20714
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 05:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKWpn+gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgCUFTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 01:19:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42208 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgCUFTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 01:19:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id t3so3399915plz.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 22:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HwV15WoyVyVbpewAvJytS8epui4w+ugiRqhZA6TUZoI=;
        b=oKWpn+glfxGxpiWkcMZUXSAHlf8DfYlA5h6xjZ9P9hxcS4pvKOJJsrEO/PLJ0LcIYc
         /+ke5jJ4qAfjZkk6vqZMU/aZwoJhW8PxbqHXf9iTuW9Iw6yBGv8VRTdEK6pa0pgwLHfx
         F4OvgCDygaQaSbEkZsnIrQYD1KaoC/ANGvP9gvLDl4INgws2WDN0zeGMq43iFFnbu5wd
         8ErcqYlVzE7Ghy+pQcDaKvkpGyfwGmHfNXodndpQrbKT49tRBdlvgQxla4rtJyaJoLJi
         NROuJ8UJ3bcqa9JIX3sfccCDz7UbW4zu1+pwlnR/AZDJmPIH4TjDREHPT2dfHnbyJ1m+
         JJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HwV15WoyVyVbpewAvJytS8epui4w+ugiRqhZA6TUZoI=;
        b=tUQCFKj+PEk5KzI7K14sSvO6cAxqEqY25BKhaNcDIbRRo1N3LZHSQWLYEQ4+ibo6zN
         Oa9kv+h3h553D+ZBkYiXc7jMMNsiJPTjzmfJ1/6DGS+3np3HyWURuXmeB25OfUQgvPfD
         b5Tmdi55494TXzCEtV/tkX0XmTyHkxkG2UR2H4VefCHyNTGhnurSsOPcmXARxTDTOFs2
         ji38AyY63t485zu0fJvsUR8QjL+1BVmcdbT1qHvJ4jeJIS6yoR5iLwh8/soCTdf6bHS9
         EUr68CD0Xh80zdJXeV9+LRhl9xzeSAbwZGvm00XR33mUaEVNNhqjmlbieYSoq8zrZEGn
         yUww==
X-Gm-Message-State: ANhLgQ1IPYwyoXPEjjjGO8lk4kPyK2Q6UgLLp5Oh7srJ5NORrL2FTpSD
        qpYvGY7Be817dQ5FwpJnF/il/g==
X-Google-Smtp-Source: ADFU+vuiu4Jg9AZa6M6+hcOJfLFGyMX4eDIRg2sMJ6njUFadvUh1bQeuNWOq2zlNYm+ZrGYFBCGvSg==
X-Received: by 2002:a17:90a:a005:: with SMTP id q5mr13742862pjp.33.1584767985296;
        Fri, 20 Mar 2020 22:19:45 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b17sm7018890pff.81.2020.03.20.22.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 22:19:44 -0700 (PDT)
Date:   Fri, 20 Mar 2020 22:19:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: db820c: Add s2 regulator in pmi8994
Message-ID: <20200321051942.GB5063@builder>
References: <20200319053902.3415984-1-bjorn.andersson@linaro.org>
 <20200319053902.3415984-4-bjorn.andersson@linaro.org>
 <158474719731.125146.2453513105696205383@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158474719731.125146.2453513105696205383@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Mar 16:33 PDT 2020, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2020-03-18 22:39:01)
> > From: Rajendra Nayak <rnayak@codeaurora.org>
> > 
> > Add the SPMI regulator node in the PMI8994, use it to give us VDD_GX
> > at a fixed max nominal voltage for the db820c and specify this as supply
> > for the MMSS GPU_GX GDSC.
> > 
> > With the introduction of CPR support the range for VDD_GX should be
> > expanded.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > [bjorn: Split between pmi8994 and db820c, changed voltage, rewrote commit message]
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> 
> These two dts patches don't need to go through clk tree right? And the
> first patch can be applied and regulator core will just return us a
> dummy supply so it's safe to apply now?

Right, the two pairs can be merged completely independently; we just
need to agree on the _ vs -

Regards,
Bjorn
