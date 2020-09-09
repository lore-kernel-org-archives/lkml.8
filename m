Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F292C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB13F208CA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599683110;
	bh=b9zCDtaMevyXYsoQeKFjxvLJTU6IGxkADFSbp6S5Iak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kGEugJISuJxYXheWgAzNqNTa2R6GBG3soZu/ev0YSfRSfwl5ORIu67a7A5nBgysSy
	 ojybdgCuurA31efqO/IBWdvfOZYQr4G2RbhOh+TQG7ln7k/hTsTUwUGQWHHMce7Ei8
	 Mx9R3LEknNxRyWl5J9Tp05Gy+RMr/bS9B2d+O22s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIIUZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:25:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40735 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:25:05 -0400
Received: by mail-io1-f65.google.com with SMTP id j2so4620751ioj.7;
        Wed, 09 Sep 2020 13:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mvq1pc8VzaCkfmrY21Z3+UytzMH3TjOpdxcopW0FID0=;
        b=FYQDHWhXYJjZQLj9IaSmB36CLN4yOahsc3+dY+zJiBXbMDUMhwqFfZ0/X+7FxDefQ+
         SOCIjuThggc/Gvp8HFU4VzijjkoK2w1HBcMQxsdvFZTRuqrDU2vCmW/zo4ydjPb/fm7L
         /hulI9hdAobRTvWdwttvz4mnqQvE4pndyZf57L+IojfcA7/bHb1cn2WxRyDuiApNHbBe
         zGnVwFSixieGCpdp83IwdbB0KTTN70oFg9uHIrTt9hA9SLlO6n2yb0/wvasIozRPd39y
         fG5viXeC1jfJylc84pt3hSUXw/TX4OC+BUfbCQ0ZujGSpR57YsYFz7ibhEr6/8QNZ/U2
         Oe8Q==
X-Gm-Message-State: AOAM531IhBCgvN/UGdamWO/Gvq9iuQ9lhpted2lymyndIGcOkpST7R9+
        pzDsmJWF+pCDU45RV8dc06smYCIHPR4T
X-Google-Smtp-Source: ABdhPJxJkzwcUL1S24Z0tbRq+VDKpX3tiUGts9lRxpl0Nh4IAME/9iREuCEOedUc1oO/rQKVZ5HRcA==
X-Received: by 2002:a6b:908:: with SMTP id t8mr4795468ioi.124.1599683104321;
        Wed, 09 Sep 2020 13:25:04 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s15sm1840787ilt.62.2020.09.09.13.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:25:03 -0700 (PDT)
Received: (nullmailer pid 3020163 invoked by uid 1000);
        Wed, 09 Sep 2020 20:24:56 -0000
Date:   Wed, 9 Sep 2020 14:24:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: rtc-2127: Add bindings for
 nxp,rtc-2127.txt
Message-ID: <20200909202456.GA3019412@bogus>
References: <20200827091441.12972-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827091441.12972-1-qiang.zhao@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 05:14:39PM +0800, Qiang Zhao wrote:
> From: Zhao Qiang <qiang.zhao@nxp.com>
> 
> Add bindings for nxp,rtc-2127
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,rtc-2127.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,rtc-2127.txt

Bindings should be in DT schema format now.
