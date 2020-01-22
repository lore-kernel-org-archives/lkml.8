Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B92C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA492465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOv4DwOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAVW0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:26:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39623 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgAVW0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:26:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so422964plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 14:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cxNVjgQGWzacnqlCZNmJQJkdYDIqlJE10RKfm1uE9mM=;
        b=pOv4DwOm5vOgZ+PrlXxtrPOfWsAyaYxbfU0ipKfrLvdyaCWIZfNb3Tng6PIcTsdm0L
         ptJZCs9pnIt/C29i4j2b84lpo9l50BBU61Ouw2z41al6f33wRE/NdYF2iVzvLlb/6xBZ
         e/xmNQSI16yFl3/XernW55vcPqz8JpeiVTq4YKG9NOrD+4+pJOVyk3xoMA6jnIJwjKQi
         4fs9zHCqRJAdjI2c5RirLb7u0ddIDol/VF//LhFEDDx4xDKLymEfbLlMjiDFaBI99kEV
         pnIxClfbDRiNjxCEHchG1D9XUAl32oxJRBRlSd5OAx/ZLJUOQgaJYg1KXShxMTVer1kH
         x8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cxNVjgQGWzacnqlCZNmJQJkdYDIqlJE10RKfm1uE9mM=;
        b=jd6/IByoCg37otfMPGDc2ryNYm+58MuFTS5t+4Ii97ha+KS2li7GAVocoZ7tBl8nck
         KkHOlMK7HnxxUeqDH8PhnOlt4PyP1OnCN7kJtHDzE93LAlHVIwy+jACBdsW1ZRnaoe4T
         L7d6Xwb1V9qmQsCbPrBG7tYzXa/uSHSbzFkPBLPSkMa5xqOgATK6URCAL6I8Nl9Xgu96
         WetxDzRyz4yxnzUBuVozt2IuD7V+O1j2dhaHcn4b3Muxp4hcG8VUUIlnC45Mg3CFtHyl
         TEL+qNZPwb30DyfBnXk46ZXM1jXd9mwWajbxUa5Xopwo/bWva+RFMkTChhuIWtxyMVSd
         JDgw==
X-Gm-Message-State: APjAAAUUmKq0f16Ax9RkJ9N0YGTDBxf0EwluyJCyNU8OCVy011T1U3rV
        4WRUe8vsMTve5xrJAKVqyRJz/4g79w0=
X-Google-Smtp-Source: APXvYqwTOHRjwf4d8GAH3/wqyQXJ/KEyA6qmWmh3w2qWEbuYZc+PmC1vhzKke3graUr1g49XLUJdlw==
X-Received: by 2002:a17:90a:d0c5:: with SMTP id y5mr808414pjw.126.1579732010599;
        Wed, 22 Jan 2020 14:26:50 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id a28sm47793509pfh.119.2020.01.22.14.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 14:26:50 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [RFC][PATCH 0/2] Avoiding DWC3 transfer stalls/hangs when using adb over f_fs
Date:   Wed, 22 Jan 2020 22:26:43 +0000
Message-Id: <20200122222645.38805-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
  I wanted to send these out for comment and thoughts.

Since ~4.20, when the functionfs gadget enabled scatter-gather
support, we have seen problems with adb connections stalling and
stopping to function on hardware with dwc3 usb controllers.
Specifically, HiKey960, Dragonboard 845c, and Pixel3 devices.

Initally the workaround we used was to simply disable scatter
gather support on the dwc3 by commenting out the
"dwc->gadget.sg_supported = true;" line.

After working with Fei Yang, who was seeing similar trouble on
Intel dwc3 based hardare, Thinh Nguyen mentioned that a fix had
already been found and pointed me to one of Anurag's patches.

This solved the issue on HiKey960 and I sent it out to the list
but didn't get any feedback.

Additional testing with the Dragonboard 845c found that that
first fix was not sufficient, and so I've sat on the fix
thinking something deeper was amiss and went back to the hack
of disabling sg_supported on all dwc3 platforms. 

In the following months Fei's continued and repeated efforts
didn't seem to get enough review to result in a fix, and they've
since moved on to other work.

Recently, I found that folks at qcom have seen similer issues
and pointed me to the second patch in this series, which does
seem to resolve the issue on the Dragonboard 845c, but not the
HiKey960 on its own.

So I wanted to send these patches out for comment. There's
clearly a number of folks seeing broken behavior for ahwile on
dwc3 hardware, and we're all seeemingly working around it in our
own ways, so either those individual fixes need to get upstream
or we need to figure out some deeper solution to the issue.

So I wanted to send these two out for review and feedback.

thanks
-john

Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Yang Fei <fei.yang@intel.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux USB List <linux-usb@vger.kernel.org>
Cc: stable <stable@vger.kernel.org>

Anurag Kumar Vulisha (2):
  usb: dwc3: gadget: Check for IOC/LST bit in both event->status and
    TRB->ctrl fields
  usb: dwc3: gadget: Correct the logic for finding last SG entry

 drivers/usb/dwc3/gadget.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.1

