Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D338B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9OgGTTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHRJRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgHRJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:17:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D3DC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:17:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so15570378wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition;
        bh=NRXSlg5+U42+r5yz1HaufmNO5p1AhYU7aGg04+6KXs8=;
        b=g9OgGTTcV/DXM6qez+st7dlpEcxogyEG4ViV8vAbxiou4UWZUTVZlGvQQnEsaXmK7C
         9BtAUXQ0ufpOR8INAF8VnE9R6Yv/DN5qU4VeK7gTcRiiZxRKtRRy+GrskhhnlZEiTVy4
         quFw1+DtoCBmh0yzghiBwfP2KyexcnOFlBSR6OcLmAqf8Wfao55RPRi3Pn2X+SrpyQd1
         wA29DespuXyhBfIao7fGBCKqTvF4/RovqRxC2yUsaF/MYUZpDUUTtecWE+t9R2dFSanU
         T4/918oP1D9wI7RNgfAWtXMQxj/k5xEjDPu3IfTJERJhkD2h3C7far8lDFqOIMIiwkF2
         wVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NRXSlg5+U42+r5yz1HaufmNO5p1AhYU7aGg04+6KXs8=;
        b=msj3RSdB/qcPyBeQ89H49kHwM/aBn5Wothu7z2J62DZlKSSd3EtY+nI47CU9xCvN4v
         q5mSVAS2WVy1wL4ZDyHK/DXHidXZzcKK+SdVDN+jBAR13mvsGOMGg+a8QcaJ/YHYoEZI
         I4Y8Iv7aVVz5dgFi5M474ZsEBT7STF+PSRu//lFT36H2FPw6hRM35vckU45XFua00lhI
         Wzw9b92zIz8NWswdQGPt47p+wTFjr+F2/dVtKdMWR190kFrGvXsWSMMdtCFv9WwciMwH
         qL1W39npD80GQlr3/Wfkr7IiaK1HFh5FxKgDUMHBJnF3LMlwLx4wY+/2fcgJoy6+30oY
         pWKQ==
X-Gm-Message-State: AOAM531lZPN2INlFEGPEs3LZleu5dFYp4/0ZYB5c7/vVEewcszNJwZ9r
        ET6hj+ckUaStVtndfsK70VU=
X-Google-Smtp-Source: ABdhPJyYEBjemYYY66shh3k24o9Ej5PDwHQXqhemqLsfFbOHmDuOyo1Kt5S9D7qQU1rAMIolcBmj7g==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr17315460wmb.96.1597742233220;
        Tue, 18 Aug 2020 02:17:13 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id g25sm30855540wmh.35.2020.08.18.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:17:12 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:17:08 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
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
Message-ID: <cover.1597742228.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To:     unlisted-recipients:; (no To-header on input)
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
