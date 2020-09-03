Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0972CC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE5920716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Js5qc839"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgICRRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbgICRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:17:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C5C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 10:17:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so1779830pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GcJIsnK88IUx1B61WKTmTuAeYWhCDjmtS5xMB35oYuE=;
        b=Js5qc839Y3FzIgtCD/uRo28WTGpFwIfb5AdKWX1KKOcQ0E/wNUtydqYvw1ua1HrJJe
         LLYa70ILIUbMMUmVCbTViR36bE1UNUQRqdu3niQ87S3g+QXeEXHP2aHRhAAwtY94OElu
         jpPK5a15AKuMH994MGM7Z6MeT8IO9uvDHcXiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcJIsnK88IUx1B61WKTmTuAeYWhCDjmtS5xMB35oYuE=;
        b=rJdIBtzbqMKgEY0scNuLr6NswGil+HV06GexLMyCKezzY13ITPqFbq7tBxGYqP0EVr
         SliXh0KOQsUVB/0AjDWfRIegbJct/t68rOTFFgiyI1Rqj0NsotVd69mqFSbobmZIq1b8
         +bpKnjffBRels5B6rhJpnZdhVIB29Wc10b2zScjVzLjOHVA23dR9id79lZVIokXZyaN3
         iaw1cfJY6QncyoMMb85k7Nq83xb0E0mKJYH7LPxSBdKarAXH0mTbihuL2xC1WhoUqvNZ
         A1XcDMf++K6pARxISxGHhP+WUsvk0RzW1T0bDX+okkmYntJ8g9bJw6ZZZnwMxqJqFahI
         asLQ==
X-Gm-Message-State: AOAM533rOzIJBoUIW2R8HKTZ03eUfMpG9qRw8HZNpxS7tgb9VhlZJ+mO
        zG+U8Cbxb/0L66sV1Ot86q8lIw==
X-Google-Smtp-Source: ABdhPJz/dLdww+y6pBg8VrryrAW1gmW1DFrBsiMS6fj9gYpavoVd6+ioxihfCfTza+UPEP3M2Pz8oQ==
X-Received: by 2002:a17:90a:5216:: with SMTP id v22mr4080085pjh.97.1599153432782;
        Thu, 03 Sep 2020 10:17:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id i11sm3309891pjg.50.2020.09.03.10.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 10:17:12 -0700 (PDT)
Date:   Thu, 3 Sep 2020 10:17:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V4 1/4] arm64: dts: sc7180: Add wakeup support over UART
 RX
Message-ID: <20200903171711.GL3419728@google.com>
References: <1599145498-20707-1-git-send-email-skakit@codeaurora.org>
 <1599145498-20707-2-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599145498-20707-2-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:34:55PM +0530, satya priya wrote:
> Add the necessary pinctrl and interrupts to make UART wakeup capable.
> 
> If QUP function is selected in sleep state, UART RTS/RFR is pulled high
> during suspend and BT SoC not able to send wakeup bytes. So, configure
> GPIO mode in sleep state to keep it low during suspend.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Reviewed-by: Akash Asthana <akashast@codeaurora.org>

One more doubt: does it actually make sense/is it safe to add the
sleep config for all UARTs in the SoC file? I wonder if there could
be undesired behavior (like noise on TX or RTS looking active to the
other side) without the corresponding pinconf in the board file. If
the pinconf is needed to avoid unexpected behavior then it is better
to change the muxing in the board file to have a sane default
configuration in the SoC .dtsi.

From a quick grep it seems that most SoCs don't specify a sleep config
for their UART pins and some boards add it in their DT.
