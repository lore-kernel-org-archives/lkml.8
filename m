Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5AC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADDD20719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jYbLK+sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgG0TRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgG0TRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:17:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CC2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 12:17:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so10434552pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nJD8ANcLO/VUZAQvdaY1B7X+QEC8ivatXB0HOFF0ZtY=;
        b=jYbLK+swZ7oxpeCHFmdwpZfHpXputie5W/EjIQUbE8weTwlTEepQhsfFuOurIFeN9B
         GswDdi46JYQ9aLEeP6SEQOpDHpVuNdXW4MZ/cG9ljtiIVjQct65sI7OUGEQKxmTnESOE
         4D9DRhVUAC18CbCTeCtF2sGDcMNnIaJjApsoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nJD8ANcLO/VUZAQvdaY1B7X+QEC8ivatXB0HOFF0ZtY=;
        b=GVPRZRHyF4dxLBtDfH93XtWVtFGALFniT5CaBlr/x1WlweP39xpouBV+bSWVB6rX//
         S1FCN5TQHs4eqbAsxO4rctQqZ6+xPaHGlWTFgKoRb155tYeqHsaV6EBWTA5TymlI0Vlg
         gyEIf+0KUjdo+k2fMsij7cYIEzgOxQBtkIG4liXl2OzqhXy80UxajSoLW5MuETQDH+SR
         dpP5suJtGWU7xueAsQT5UjrBJ4dkOgZT69zlDbvd/oUjnzC1EEBf8lRAOHGmjNTB8qbS
         W98SHp5FlrBwx3/BElAqhkcuPPcg/rU81ImPtF8vRn2FwHXSFFsWLS8HSg6Zv7q8lAy2
         GQfg==
X-Gm-Message-State: AOAM533WtrM74LyLM+QRKxpothRj286NglM80ftYirv9o5gt0Cq6hoH8
        5OM82ROj3ZLxiecijUXjbogDdg==
X-Google-Smtp-Source: ABdhPJyxz8nTCcV4GFjF0/DzhCHEFEk9iyfb6jBZGO5755r2yYlLAHzxDMoJDgSbCpD92ecQxHBIqg==
X-Received: by 2002:a63:182:: with SMTP id 124mr19887757pgb.288.1595877441496;
        Mon, 27 Jul 2020 12:17:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id f18sm15177144pgv.84.2020.07.27.12.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 12:17:20 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:17:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Subject: Re: [PATCH v10 1/2] usb: dwc3: qcom: Add interconnect support in
 dwc3 driver
Message-ID: <20200727191719.GB3191083@google.com>
References: <1595528857-25357-1-git-send-email-sanm@codeaurora.org>
 <1595528857-25357-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1595528857-25357-2-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 11:57:36PM +0530, Sandeep Maheswaram wrote:
> Add interconnect support in dwc3-qcom driver to vote for bus
> bandwidth.
> 
> This requires for two different paths - from USB to
> DDR. The other is from APPS to USB.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
