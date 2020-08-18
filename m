Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA10C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646D32075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtvHb2JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHRIrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:47:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789EDC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:47:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so17423948wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NRXSlg5+U42+r5yz1HaufmNO5p1AhYU7aGg04+6KXs8=;
        b=qtvHb2JIL3T8E/cpqHVqVZTwC+2u6wi/BU8buEwdhurz/5FqZ7HmYNki9XMvQzeEOh
         6WFyeYstY9bzdFkbf8+St/om42mXRQ7aC2eqZbXYC9A+zEfAFgZ3tJQ5207yU/kkGSPs
         gjyZcAQFPk8J3lGiKEqb20V6lYuRAeGn0UctPicSNM/modZhriw7Gh3UBrYMqzsrnHG/
         SHJu+fPKnq7F5AwzuI+Vzf9zqK2tHq8sxUGh/DihhIYv1twN+w1XaJkMseultI1K1L1q
         oaNqI6wiYSSeth7ZAFKZjYHdwrgGbZ2GcqWzoDEw7ri3Qj8c+dOFGFuQWLoiseSfkGdk
         YU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NRXSlg5+U42+r5yz1HaufmNO5p1AhYU7aGg04+6KXs8=;
        b=VLsInwz8Md2NcZikbaIrYge/vpz9+q5Pd8scZvDg2BMcPzQRAvyDEDuiadUVvs6Xdd
         HZaaHJCSHnbq04cFhSRzYdgydRj+ee332TFSPRk46FA7iNydlgtpskc0nPwsV0ctoFkS
         nIDX1d5bseCSF6ALMoga4OltJuNdKjnboEAfy7CG1L6mqGwYEYcS4i8qU6ginyCe9ZJn
         62kKQgrgw2Wf3yQiUzSBMT2s4Hsl96YzkTgeFXDNScs+xOfgHNTpOTCURmOd8BqOWmGJ
         UnVsWRdE1H1qFcEU1/DnIwuM+VunciHBSmvkRKQ5UJZP53/ZJfJBWmf+uM/wD3Baqz56
         omVg==
X-Gm-Message-State: AOAM530ZnNDnGLRCnZ/dhgtI5JdjEDU06K1YJrWB3+WzhTX/WD9mVwfV
        0KzMBcn87KD5bIP0lTJ2eU0=
X-Google-Smtp-Source: ABdhPJxYBgGknEAQK8xsd1B/rwkA33jfkZZNMZ/DlgBKDOAkmd6M6OvtzohckbpoiaN34Csc8pKccg==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr19935544wrs.27.1597740428207;
        Tue, 18 Aug 2020 01:47:08 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id n11sm26064727wmi.15.2020.08.18.01.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 01:47:07 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:47:02 +0300
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
Message-ID: <cover.1597740422.git.tomersamara98@gmail.com>
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
