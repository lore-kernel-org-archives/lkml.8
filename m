Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99991C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706C22075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXvrYXog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgH1I6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgH1I6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:58:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81BC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:58:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so558855wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=OmwbqZf0nRInFfgIxSk2N0DA+jXfjPxhMjoEbK8eFkg=;
        b=TXvrYXogtUF8kFQPYmzkpGiaU2tHcoybjEd48tF/Z28LVdLwWLREakQOoFRkKh38+4
         gEPe8uVUbjyJVAf/j6fJUCfg0SQWpIIuORXkKx8Eo4ivzLGDGUn6I5XZlWDAUsfRbqji
         hiWRZyRT7TN1R6seVzHjfIdRcr63WrBzC4l1Z8WgnHGvCFmAl+ua25d2sgpjPyA4lerS
         W5G7jlLbqTM1Dgs5SovZnr046dac3Ob59llIvfwETVup57S/h15wnJb7+cYf0z8XY2wV
         6Vww5KLCEytYQdD75uppJlH8ylRvuxcmgQMLvLlV6ec/+bkv5WYr6AN7JXaby4GPSHmA
         V+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=OmwbqZf0nRInFfgIxSk2N0DA+jXfjPxhMjoEbK8eFkg=;
        b=TMT9g5Pf8ZYPDut5RGa0YIhZoVQ3VCGaTFbcLvVg1pPl3+N1+kiWFRZ6RHSg9Lj/RX
         fIi196LgqJPjFukydgnGBd3UAghvs2TpFha7I2xvD2jv+Ig1SH0K2smSyNnlpiy+MUjC
         2hPO/+gbVm0CJ5qEfqmLsphpY+Xsl205t/UNShWb6qzIOJoWirvKkfj8Dk2cvsN2o3xe
         sxlQbqJpdWkXzNoYA2MWO9M1ZA3kbSvbqyCbnaovVXEkNofZhtGKBz9OtK6KVH/6w6K6
         Ff7/whhWgBt0mWN6ylUx+FY+FPiWaM5d5dZNzjuCjyRC6gL6gWxyMAvcLVd+2aHWLQXn
         Jezg==
X-Gm-Message-State: AOAM530qPUei1hl45Q7w/ArGnaDylHNZ3SSgJRdmqQ2zYudFbOwAJvIn
        /cRFQVWramyxWtI7K7aWuUDCC/733sNkrg==
X-Google-Smtp-Source: ABdhPJyaA+Ey3Nyq6Xz05kwe7MkowDZyCfS9bkUTSioWOoSwHgLsVpa/xVzbET64JvJlwfSlJ7rp0w==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr556626wrp.6.1598605097307;
        Fri, 28 Aug 2020 01:58:17 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id g7sm764972wrv.82.2020.08.28.01.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 01:58:16 -0700 (PDT)
Date:   Fri, 28 Aug 2020 09:58:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v5.9
Message-ID: <20200828085815.GA1826686@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.9

for you to fetch changes up to 22380b65dc70f5b132c5afdf6b4011e2a84ec34a:

  mfd: mfd-core: Ensure disabled devices are ignored without error (2020-08-28 09:51:41 +0100)

----------------------------------------------------------------
 - Bug Fixes
   - Fix double free; core
   - Handle Device Tree's disabled devices gracefully; core

----------------------------------------------------------------
Dmitry Osipenko (1):
      mfd: core: Fix double-free in mfd_remove_devices_fn()

Lee Jones (1):
      mfd: mfd-core: Ensure disabled devices are ignored without error

 drivers/mfd/mfd-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
