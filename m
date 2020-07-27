Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763DFC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D792073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="naMvyOJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgG0TS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgG0TS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:18:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5529C0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 12:18:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so10420124pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xySvV1IjY/ykAIVcs+vE5LOnvW22SWhPjf5yGr8ub4=;
        b=naMvyOJdT0LmNEVjAZJNPFto3+cHVILBVTkAr9eDy2kEWatCjbsevbDKbZEUwUxrN1
         03PXmw7vaaifaTs5uxCJxs/K0Mn5g3/tJ2r2VLcCYE6VH4I/9dtNCbtcdADpwbwuUFmA
         TeD/KFkaSOzBnAybvvjtjX5wmagf37ExNGMpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xySvV1IjY/ykAIVcs+vE5LOnvW22SWhPjf5yGr8ub4=;
        b=DmC8xKftLow43rPvzeTVn5egJAlxre7NMN0U4ptVww3ixmLTzIz7BZPhLt3zDHo3O1
         6WDNSifN+25NEiOqQo3eCm/SffRpbeeLmtXdfkN4W9z8mSq/F8lP2n81JDk9fHW2aDy6
         ocNStDIUkm3OeVkpSmX6OlcQOmACOO2f9TdKtANiIS7W0lJmg/ahb9imP+oxqzJHVbw7
         3cmsQo/GWphsD1WycnQTZd1PhZD2eI4BF+T8eT2O+e5b5HXkYnm9CiYAgeLigoDjEv9W
         aBSRcHjB7xWfzUrU8O9G+3ZrOSKUGGGN9NOhKCpq1s6zHKibJfqwQ0UDQ0u4bQKqkElq
         +d4w==
X-Gm-Message-State: AOAM5312QKeZz1eINOw6oUvGW8e76KQpbBI3EiWozrAANZlBZK/pVZKm
        Gv2iwtX3YM7Zoh6PWXka9Qx8Yg==
X-Google-Smtp-Source: ABdhPJxHxU54eoeuYUvz0gC8SenG8BHXpKDdQtpJ9uHUXR3Pw/fdpX8ZlqWMdFH8+3KSnha9vSr3vQ==
X-Received: by 2002:a63:df03:: with SMTP id u3mr20314068pgg.84.1595877508338;
        Mon, 27 Jul 2020 12:18:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id f3sm356807pju.54.2020.07.27.12.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 12:18:27 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:18:26 -0700
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
Message-ID: <20200727191826.GC3191083@google.com>
References: <1595528857-25357-1-git-send-email-sanm@codeaurora.org>
 <1595528857-25357-2-git-send-email-sanm@codeaurora.org>
 <20200727191719.GB3191083@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727191719.GB3191083@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:17:19PM -0700, Matthias Kaehlcke wrote:
> On Thu, Jul 23, 2020 at 11:57:36PM +0530, Sandeep Maheswaram wrote:
> > Add interconnect support in dwc3-qcom driver to vote for bus
> > bandwidth.
> > 
> > This requires for two different paths - from USB to
> > DDR. The other is from APPS to USB.
> > 
> > Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> > Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Sorry, that was meant for v11
