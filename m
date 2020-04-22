Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C7C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06EA20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnkTXDmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgDVR0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726466AbgDVR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:26:51 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78087C03C1A9;
        Wed, 22 Apr 2020 10:26:51 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x16so681421oop.13;
        Wed, 22 Apr 2020 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CyDxYg/d/BHctTKeJMKLE3tGOOXaZthBF/XEfyGaAqw=;
        b=qnkTXDmGswT4iyN9GuRwxyY80cUpcTi4rcFeiWAW5kqHLdigdTV3DwdX7x5+3tVtBV
         4Uobu6IPWm7fc7X+xsNGIhoId78ji0XRVb7aoCuAGJ5Cjm1qppAvbFa11bwptRvoyKsh
         absfxjFC9lLDIGnKvXAZZxrsJ0AcKmxR7Ef+QzmmZNqY7plSQyi3/aUaBF3fWeEhONhT
         M7/kCmJocwKD5D820VedOEj9WkUL77HAMXKlk/4a0i0LJN0kZrX7v4HuH1QnzskQ+Is1
         pi/wO1QW6FI3cF0aUHTfP52FDmYrXG18XCN67FtY0+2j0VZK7S6dauoThbt7eG4rSPV+
         kc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CyDxYg/d/BHctTKeJMKLE3tGOOXaZthBF/XEfyGaAqw=;
        b=BBxHPyHXJv7WJYvJQYGytsZwsEPaNK0rl1WHA1mYQfK2bn06XprYbU1QGg2IScn1zR
         PWsoezxqVkK2l/sDuoWXpWRsGeCjD6BFG0AHNNrBnDSHlGaWjDFaYAV5HmjXsNTf6Vrw
         t0zCT+LCctaUWGAkg9A+twXMwWU/e+iPZMd5h27SL7OGGkUgwG7hIBm0meNZYagyrfLS
         v661BLmeVn75S2o99Vza3W3fXgu2/DwHHa34TZ1+pTyclyVnZCYxJsFGlnpLQk3mcGia
         XHEt/65VzVCItxb/tXfjVVWKYorPDcJ3MDY8/0ZQ4fF/24Z8mpJRiXb2hxciYO5f1nOc
         +jCw==
X-Gm-Message-State: AGi0Puat4Yo5DvDCIitJM6aLo3yH+EW+Bj0L3F9jzy+/OXb3UnjJEiQ9
        HYVPHzKLIl+ohrRHNWUjOxK0M7JMy/w=
X-Google-Smtp-Source: APiQypIgSYBfBZ9CDXKE3REoHtlnQQ8kP4Hf+oWYWhtG4Ob2yZGzrbEuW4jmAFeiA+KIbpx+m9eoXA==
X-Received: by 2002:a4a:c217:: with SMTP id z23mr5666116oop.21.1587576410863;
        Wed, 22 Apr 2020 10:26:50 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id h65sm1663251oth.34.2020.04.22.10.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 10:26:50 -0700 (PDT)
Date:   Wed, 22 Apr 2020 12:26:48 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: [PATCH v2 0/2] hwmon: (pmbus) add debugfs features for Gen 2 Renesas
 digital multiphase
Message-ID: <cover.1587572415.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds debugfs features for 2nd generation Renesas digital
multiphase voltage regulators. The new debugfs endpoints allow users to
utilize features of the VR that are not compatible with sysfs.

The series contains 2 patches:
 - patch #1 adds the new debugfs features to the isl68137 driver
 - patch #2 adds documentation for the new debugfs endpoints

Grant Peltier (2):
  hwmon: (pmbus/isl68137) add debugfs config and black box endpoints
  docs: hwmon: Update driver documentation for debugfs

 Documentation/hwmon/isl68137.rst |  34 ++-
 drivers/hwmon/pmbus/isl68137.c   | 460 ++++++++++++++++++++++++++++++-
 2 files changed, 490 insertions(+), 4 deletions(-)

-- 
2.20.1

