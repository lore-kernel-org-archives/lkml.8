Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A14EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C662075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vc827jb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHRIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:48:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD5C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:48:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so15508892wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NRXSlg5+U42+r5yz1HaufmNO5p1AhYU7aGg04+6KXs8=;
        b=vc827jb4szDiGQJWmjUQ76hKkmHzF/ge+sfUGIPsfUDsMxnYixvT4lsbABYjtQqXTj
         TNOz+/t7e/1NgHV2D/rOOLE3iPXBXz7EAdXqTr1yqgTqIVgCWGY7axTqxmZMMxmq3MgT
         7yRHKdaN+LUxfHmj0PcBIq9GRnL71M+EkHVlyAXqpTgtba2IgXjj6WM2RTEXRfOl9JE3
         UQK9G/5lo1CdniCpR4QGKfkxXaWPDbI0MdceWoL5oDA0C7sysUZRjHgUANE5nxiwS2NR
         lCfIR1Qg///3vtBA0s5qNFBgEIIjryLPUskiQf6ZbrM6faTFPcO2RLbFr23PleZxkVYi
         gDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NRXSlg5+U42+r5yz1HaufmNO5p1AhYU7aGg04+6KXs8=;
        b=BVC/30S343rn2f8svuB0dv8os1jKJ6IXOrxzNqliWrCCgcJmXhYDPHrdlEalOjexUQ
         ejzlId+j7On5ClfFKDtSP9bJRgAMygiALWlJQMhZBbvtzHH1VhpCoqB1waC/WPiW3LS/
         MytDSUQ+ucu9iJhba1TmQRRBjCyQd1y7yAjHfjj/cf2cwyrBeV7V2OPLyHOC8CBry0xj
         tDk8JTEBon7oUTwFJln6BMU5UBlI8pilozek9WU9iVIg3lAR6/pLcTFbJSUEsaRjdIQi
         kWzDeCY2VGz07y+L/KhpmQTeiCHXZs2NvrQjI2ccguOdNf7JDDPXKI6GUyEh/hr5I5ey
         SK9Q==
X-Gm-Message-State: AOAM532q7i0fdkxY36UwDn7eWHnN1VKTMLKLPY1v4wO3wxOOz5T/kvT2
        4eiJdq7cAUS2BFydBnIh33o=
X-Google-Smtp-Source: ABdhPJye900/ysQfZWKaE9AhCw6mlBB1MGafKxJSt9lQpG9zmDRY9XErEpATc4JPKMBIjBOoN7VY8w==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr17956380wma.158.1597740485923;
        Tue, 18 Aug 2020 01:48:05 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id g70sm33434413wmg.24.2020.08.18.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 01:48:05 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:48:02 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] *** SUBJECT HERE ***
Message-ID: <cover.1597740482.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Tomer Samara (4):
  staging: android: Replace BUG_ON with WARN_ON
  staging: android: Add error handling to ion_page_pool_shrink
  staging: android: Convert BUG to WARN
  staging: android: Add error handling to order_to_index callers

 drivers/staging/android/ion/ion_page_pool.c   | 14 ++++++++++----
 drivers/staging/android/ion/ion_system_heap.c | 16 +++++++++++++---
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.25.1

/tmp/0001-staging-android-Replace-BUG_ON-with-WARN_ON.patch
/tmp/0002-staging-android-Add-error-handling-to-ion_page_pool_.patch
/tmp/0003-staging-android-Convert-BUG-to-WARN.patch
/tmp/0004-staging-android-Add-error-handling-to-order_to_index.patch
