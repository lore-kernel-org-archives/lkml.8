Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61983C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9712067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmAj8K/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHRIwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRIwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:52:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284AC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:52:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so15505883wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition;
        bh=NRXSlg5+U42+r5yz1HaufmNO5p1AhYU7aGg04+6KXs8=;
        b=KmAj8K/cYU+TcoE/PQdjWenUy4DPWY+a4IxIpXihWl0Go9S0wLueKJm66vzG9xZFaU
         hV2NdvkdxPSzs2VfMV0meYreAH0ywZTniyq50amKdRzhJt6WTumlc6/5nGQwiFWX8hQn
         3fbAdb3qPwZKWQKq2rXx6kuMcuKAcU6QQMQSn3XH1xqKOaae688ZoGFFtOENbKQbSgxa
         RWBXwpPPbu1GxeQBK1yEc+XKvi/vvf//JLwv76mfU9VMgSDRb6xxj1Tkfpkl6XvfZlr9
         TV7sFWCJXS9isSuwWuMOHsxntrJSE42Zzef4MnEqcBJX+bnmTaLWyA3YNDBHYmggLAk1
         eIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NRXSlg5+U42+r5yz1HaufmNO5p1AhYU7aGg04+6KXs8=;
        b=O1TVUuymbMUHv/YjaKv9sRlVGIwauFHj0aQwgavKUueoTxDPWGs0A4TFCPAKFKZjRZ
         RRRb6tBVf4OMEZPprXacrLKcVFk+4i7shgO1AiI20kwm7Q8VzIrhv1onGX9tSjft0xBn
         VJcB+GU2isz2JDRELNIiqZtUKTj/p/lSyv/Fh1KRIBx3ii77lVlfskjXhNxXhI7UtW+J
         H8z54NRiXq84/nSwnt7xljw+MtVttD13+cobJBbq5si8UwO/v8GLSMn7z7rI8dJkuI7C
         zRKZk8HGeUYVEBtqSRdM97LF7hcSlzBfpkGJwv3EGmLUrmYLMQovAiLIGY6Rz2kTM89O
         0XUQ==
X-Gm-Message-State: AOAM532G8PvL5v3iGItI5T2oXM5rYtBmi9FBqeEwxTAfwSdzVjBLJfNp
        UcgGm4WpAsnvyrpHlN7Ki3U=
X-Google-Smtp-Source: ABdhPJxnlP0vZjXNWran/cULmdsS5AmAYwn4ztkVU7HYOyiC3uxCdjIT8N2W+JNr5NvyqtJsfSq2DQ==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr19248587wmc.155.1597740727946;
        Tue, 18 Aug 2020 01:52:07 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id i7sm35425407wrs.25.2020.08.18.01.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 01:52:07 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:52:02 +0300
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
Message-ID: <cover.1597740722.git.tomersamara98@gmail.com>
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
