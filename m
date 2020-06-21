Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067EFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBC622282
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJ/k2J9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgFUHgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 03:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgFUHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 03:36:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5F7C061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:36:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so6104961pls.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4G7rfXIuXtIqafGfH0y8x3Zdpo0l2VCJjWiyyWzqbR0=;
        b=FJ/k2J9QaZ9ZMtOAKL+9EWJv9i1+nd2l0oO00FwgN0N8J4/qppUWk0LMbaYdcVzHTU
         lSTOE7lzJ9bjIh98iYbmcKyR6T2WWXuwSiwQCVDEyX+ByS3wRtiZ8XxCEjmykPp1uRFl
         Q1cjXUuVnq95i3M/55s/LxSOWrh/1r9+mG6FHbeFJH0JHBUKGaxV4fdbhtQImCzV2hPC
         bDHEBGpsn6YTJJFdl89GRhR/0bjWdqYrqqnYZqU4PlakMYRo2H+CsWNrLWVU1I6IAafj
         oM+CLwgk9yGrJjIveD4eRxqTtPwnrIwrYOR06RSeh0sb4Lf2EqsZRcLHMrOO2zxxzHrt
         tIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4G7rfXIuXtIqafGfH0y8x3Zdpo0l2VCJjWiyyWzqbR0=;
        b=Xm4ojVNhfsFAPKbkcQlGzRbQmxBbRdyh5/99zEFx1JvAl+ms4YR/fu+2UcmSk/fZXp
         beqEC1ZLZbV8dwGwwKfKG9jFDhtO2MY6chxNVTdfDdBwbcRczUmrCoY/z823Euy8NCgf
         vsd/RdSCqkuejvyC/Tgz5UH6ru3FPD+p/jZG5IFNv3cSj58gN7n534xKu8fG7q+BQqaV
         /UgOiEajIpeUCPL2zihn+mf7hrovI5m8xoSqF5gPYYvhdOOF4nA+0M85uvlTUErX3zEC
         TCbyVB6VcGGiynAxoaj5cmk55qGIhbDUyAdoQwo+yLkNAEtsacpdwq1vuWC2fEyzZnS1
         k6Yw==
X-Gm-Message-State: AOAM532cPqnhfpkKDkVjuocIYxbTX2nUc980Vx3tdneye+GYLcCwph8x
        b14HrQWGL94YdZQiEwHTiJjXID65UCQ=
X-Google-Smtp-Source: ABdhPJzDDEUMHD1pZ6etyMkMjEO533cH9YhgXfHiA12gTCuscJtDeAnJww8MPQIwpSxkosB3znkelQ==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr11962467pjq.73.1592724968142;
        Sun, 21 Jun 2020 00:36:08 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j13sm10297079pje.25.2020.06.21.00.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 00:36:07 -0700 (PDT)
Date:   Sun, 21 Jun 2020 00:33:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCHv3 0/2] Convert QCOM watchdog timer bindings to YAML
Message-ID: <20200621073320.GI128451@builder.lan>
References: <cover.1581459151.git.saiprakash.ranjan@codeaurora.org>
 <c2b8fabcf82b27c7334482bd53ebba62@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b8fabcf82b27c7334482bd53ebba62@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16 Jun 23:56 PDT 2020, Sai Prakash Ranjan wrote:

> Hi Bjorn,
> 

Hi Sai,

> On 2020-02-12 03:54, Sai Prakash Ranjan wrote:
> > This series converts QCOM watchdog timer bindings to YAML. Also
> > it adds the missing SoC-specific compatible for QCS404, SC7180,
> > SDM845 and SM8150 SoCs.
> > 
> > v1:
> > https://lore.kernel.org/lkml/cover.1576211720.git.saiprakash.ranjan@codeaurora.org/
> > v2:
> > https://lore.kernel.org/lkml/cover.1580570160.git.saiprakash.ranjan@codeaurora.org/
> > 
> > Changes since v2:
> >  * Add missing compatibles to enum.
> > 
> > Changes since v1:
> >  As per Rob's suggestion:
> >   * Replaced oneOf+const with enum.
> >   * Removed timeout-sec and included watchdog.yaml.
> >   * Removed repeated use of const:qcom,kpss-wdt and made use of enum.
> > 
> > Sai Prakash Ranjan (2):
> >   dt-bindings: watchdog: Convert QCOM watchdog timer bindings to YAML
> >   dt-bindings: watchdog: Add compatible for QCS404, SC7180, SDM845,
> >     SM8150
> > 
> >  .../devicetree/bindings/watchdog/qcom-wdt.txt | 28 -----------
> >  .../bindings/watchdog/qcom-wdt.yaml           | 48 +++++++++++++++++++
> >  2 files changed, 48 insertions(+), 28 deletions(-)
> >  delete mode 100644
> > Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> 
> 
> Gentle ping!
> 

This should better go through the watchdog tree, so I believe Guenter
would be the one to pick this up.

Regards,
Bjorn

> Thanks,
> Sai
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
