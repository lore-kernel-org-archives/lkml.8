Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5403C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9456920756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XsNVU5IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEOSja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgEOSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:39:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4350C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:39:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so1377264pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=phaOl4UmRtsq7El/zXDiXXLmxp5U/M6vGOmuvPTWkEw=;
        b=XsNVU5IShN9fJKPkoBVuH+Y35AROQc4c4/lXaeXGlGS94mJJcFgEnq1I5NwLej/D/J
         o8cLPSHHchNGnwn6sT6S7OWZlGdC1O5VdQ3NCw4NrrEyCMDodE2BLoQ1px5PTXhTDzKN
         4iDIb8k0OE1A4S7K0K1zWbBp4Smr2GqOlkhj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=phaOl4UmRtsq7El/zXDiXXLmxp5U/M6vGOmuvPTWkEw=;
        b=mBGqYEF2AUkDyKeBoUWq2AKQndIlgMO4XB4iO2+p7/0FxufS5qpoUoPVG0D2KTqLjb
         f+vVoYKGTAauIPzGDQtdpWxOQlDhe/hWoEwS0TS4hgIB5XXBXaBMYZOsvVd5vjHEfvp+
         34IXO5oGAX7Uwodsb2yb/FW+Zs9b2Q1EP7ZGkobePkWo6QG56MW/kwRrJsS7jjkKhN7C
         sgSkfrm7RbGewWrwE7uFCKGLiYw1oT9SBbqlAD1Pl/xuKCtpf3XB2SbE5aXH2fh88uq5
         96sZbPhdsPLvc0PiZhgfsxAI/PbZqrNdb0/H+vz7IXI8TA3VXsgMM4Wm+tqjRogdC4VM
         yXPw==
X-Gm-Message-State: AOAM5338+SZ+phbdpqCCVssb2ZqUP7Lf66jqoMiwbp8OZFIxts0Rn6kW
        SchbGmlrXST7xE7ZZM5+gzUMAQ==
X-Google-Smtp-Source: ABdhPJzoos6SroEbTwNgchhW8pq9WTD4Qe0ecUkShREHdGCuNK6bU3WSbJHL54SN3cHNcpk6GH5a2Q==
X-Received: by 2002:a63:3449:: with SMTP id b70mr4570122pga.289.1589567968230;
        Fri, 15 May 2020 11:39:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id j35sm2232570pgl.74.2020.05.15.11.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 11:39:27 -0700 (PDT)
Date:   Fri, 15 May 2020 11:39:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v7 2/4] dt-bindings: phy: qcom,qmp-usb3-dp: Add dt
 bindings for USB3 DP PHY
Message-ID: <20200515183926.GZ4525@google.com>
References: <1589510358-3865-1-git-send-email-sanm@codeaurora.org>
 <1589510358-3865-3-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1589510358-3865-3-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 08:09:16AM +0530, Sandeep Maheswaram wrote:

> Subject: dt-bindings: phy: qcom,qmp-usb3-dp: Add dt bindings for USB3 DP PHY

The subject is misleading, this patch doesn't add the binding for the USB3 DP
PHY, but factors it out.
