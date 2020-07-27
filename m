Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640CAC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DF620729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AaPrVOqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgG0TUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgG0TUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:20:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EF7C0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 12:20:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k18so2394270pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t8hLkFIbtpdEX3UBYFfNbS3mhtXXCA/FYFZZm/zp7IQ=;
        b=AaPrVOqNWMgqMpxH88BEQJnuih5t7lG8Pv8holLzmGEU4PKPfhWaJFBe3+epjBa5TG
         Keaw7CEihV8ZtlT6zoxgh/RsdsdBJpqs4TK1Q0FOtw+Q+IDZMp3VNvwboWf9iZB/5Gh/
         RmXdaa/Uox3jj+vCZXTE35yj488G1nA9Bf82c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t8hLkFIbtpdEX3UBYFfNbS3mhtXXCA/FYFZZm/zp7IQ=;
        b=S6Zgrlkk/M8MfbcJB8W7kS0+pAyrcehwskmEbsWVG9yJG7Es0+vBROjKYC6QkLu8gI
         caBPoCgAMj1lm4akh0HH5oT0Vx7CCH9b+s8O08wXzbS2eMIx6tcgc1l7qCycBUwUOy0L
         e6CAge56BxajdiKzOIl6G72z8vvFOvGy+S6RYvEMqOhF39FVD0IRug50Dhx6sOntEXWI
         iQLrfeXMglSqVd0xxHE+vOBBT+5b4s3/QxL7VEc8vI3CRJF4zO109SweHAfvPxMIS2ar
         N2Fr+R0T6wWm16T+1bRzCb6+Q1uhY24KoRyJeO/tI7SKl7PCEpbVwgNy95+3SDFeUBQg
         DehQ==
X-Gm-Message-State: AOAM532/0Mx3RmX89sqbeiTcad3lp8jDF6rTob1D4yE4MeZPpa8dKPGu
        pErHk9ERyJlYt6bVofy+Ms+EeA==
X-Google-Smtp-Source: ABdhPJx0j3o/dfARdxLCxZFu0QCg2nY4pjGflu6c0tuLw5tUQhIucFl39ZjiLASPZto5FWJNbE3ECA==
X-Received: by 2002:a63:6c0a:: with SMTP id h10mr21194250pgc.11.1595877651605;
        Mon, 27 Jul 2020 12:20:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id u24sm15605054pfm.211.2020.07.27.12.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 12:20:51 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:20:50 -0700
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
Subject: Re: [PATCH v11 1/2] usb: dwc3: qcom: Add interconnect support in
 dwc3 driver
Message-ID: <20200727192050.GD3191083@google.com>
References: <1595869597-26049-1-git-send-email-sanm@codeaurora.org>
 <1595869597-26049-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1595869597-26049-2-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:36:36PM +0530, Sandeep Maheswaram wrote:
> Add interconnect support in dwc3-qcom driver to vote for bus
> bandwidth.
> 
> This requires for two different paths - from USB to
> DDR. The other is from APPS to USB.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
