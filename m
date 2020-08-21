Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3711207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyOQFfUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgHUP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgHUP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:27:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0FC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:27:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so2290971wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zw/VDtloWxTMBmKSwhrENnZrVtO+U7yJP3Ir4rxEdac=;
        b=QyOQFfUyFM4JBaS8ilL3u52rxZcD+q17wgykSmXsRnmcB4Ssbxj/1tNZgsLv1LYhSz
         HIpEj3W9jBmxD+vFzuyH2swn+FUK2I37JZi16oTSCg8AP7AByhvhWMwCpvCfQx5DBSNL
         evbOBIWMvL21DwF6UrxAQNIqGz6magZk09dU2kRQ8p/XyE6R4lVyyhZ9q3SUaLne7Alm
         f55D6JUfoYDw8fBzAvbIie7LC7sr9CbesYo5kbDrRQKzQLCSLa25ZzzPrak9jS/Pb9fU
         3jAwWpvInnY2ragogDkCfSE2DaHk3u2EqSmZTGR3dsaPo4LUokGwNwq/xZQPVGudteJW
         SKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zw/VDtloWxTMBmKSwhrENnZrVtO+U7yJP3Ir4rxEdac=;
        b=c6PdI7q4A7auckZ7X2ya4aabeCmw751yzPhzin2iW2NzlrGMtojqdsV7Ux0DGhzFla
         pZQyyOYB4mNZpleft9ZygjePe7GJoj8AFY2iaNm56IczxHqKP0kCuWao5UXS1o9nN34o
         2vQcuJNvE39et3I+kV9V+90r/r+ucEnNzk9sTPEx8dyQjrpCwmJBV9XFdaV8u+MrECCw
         zplNA7+3GbFprwI5cCYQCtQCZVMh9AGwPdj0gwUM5BnAuyT6JL0qZ7wmXBRlEDBsEVTO
         V0nRDVy2Xrxw6AtA1aF4tH4E1b523SXHWThmowgD9mjMKSUFsKRUu0INtl5E2qlR+bYF
         SXFg==
X-Gm-Message-State: AOAM532UO5V75ny/33bMYxFYD+DdVpKmrZ1GivfeY4lgT+YkeES4Pi3v
        J3qWv2/4v3XeaPgnK/X0xk0=
X-Google-Smtp-Source: ABdhPJxhWkhdDX+RnJTqaXlCpDIE7cYQ0ES9HhfiNrQ8TgSgajEZN9A9Ao5fD3ga/NMsjYjfJg7hKA==
X-Received: by 2002:a05:600c:c7:: with SMTP id u7mr3881615wmm.135.1598023630998;
        Fri, 21 Aug 2020 08:27:10 -0700 (PDT)
Received: from tsnow (IGLD-83-130-85-196.inter.net.il. [83.130.85.196])
        by smtp.gmail.com with ESMTPSA id r12sm5451960wmh.46.2020.08.21.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:27:10 -0700 (PDT)
Date:   Fri, 21 Aug 2020 18:27:04 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] staging: android: Remove BUG/BUG_ON from ion
Message-ID: <cover.1598023523.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove BUG/BUG_ON from androind/ion


-v4:
	some changes based on Dan Carpenter review:
	- Remove error check at ion_page_pool_remove (conditions are impossible)
	- Remove error check at opn_page_pool_alloc
	- restore WARN_ON at ion_page_pool_free
	- Remove unnecessary error check at ion_page_pool_shrink
	- Add /* This is impossible. */ comment at order_to_index
	- Remove error handling of order_to_index

-v3:
	remove WARN/WARN_ON as Gerg KH suggests

-v2: 
	add error check to order_to_index callers

Tomer Samara (2):
  staging: android: Remove BUG_ON from ion_page_pool.c
  staging: android: Remove BUG from ion_system_heap.c

 drivers/staging/android/ion/ion_page_pool.c   | 6 +-----
 drivers/staging/android/ion/ion_system_heap.c | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.25.1

