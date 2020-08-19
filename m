Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0081207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It2/zMJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgHSTev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSTet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:34:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85737C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:34:49 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so19077545edy.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IBIAq/aRalQqzRlQ/lTXnrrK/pEn1oTsWEQW2pLJvVY=;
        b=It2/zMJhpbNifDeupP5coNvZtaSNVOZRoWJGfjQgSuBzlPVSMNl4Q1ow7pWpVWh96+
         jOejtEagAblDa/AFoA/tK2luH611bwiDz8BYFsz2MPs3qiF654Q1AR0F1lFfpmK1+Mfh
         UEjAyGgd3AWoMdjJRRyXMSzoUpFvz2FrUddK65BN+WJz2nXHMv9YEiy5/6yoPr9eHaHt
         W9KdVlcdY/1C/4cwT9QrxU9rxjFLgHV6z5utZl6GHNUGd3hyZ33VEcrW9iBP9S91kkqH
         tjeGmmxoT6gwy9Tv0GLQzIKvJDoL7OCSlaEqximGXwWYsmBg8zRGKZeiRZzn5VDBOZSN
         r8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IBIAq/aRalQqzRlQ/lTXnrrK/pEn1oTsWEQW2pLJvVY=;
        b=JJ96IvO7mM4CT4HjKdRPOxKWMyGAieUaRk3wcvBuo95qc9T3hFZQk3U01l3sJ7mO4t
         0rJ3gBR8KOvZanmI4of7/j+lvIxBpLRQH6s5WJuuBj4tNzZ2m09FbzISHziavTB8P3mD
         /dy4K1cfxMh0vasEuCmc1fnyxq2+edFdyGv2Z73/6TceQ4mkRptW13Lppjqj1hTP4xf0
         NdijC39vOZLJlWlxvzlqwrc8e2DMeRRBkm+BXtbPly4RqQ13JowMRbO7dzrnpONe7m99
         r/Mg2RL/kZoJKi/37aNhB2pPSnIov48pmfr6AdW/cF0l0j0pKq51IbxFdBi4WgO6isQ0
         ZACA==
X-Gm-Message-State: AOAM531teCMuoLyRVKQWqTyGmPr6Jit52+0vzaSKYpRMlu3v38zHw78q
        yV5Qk4vuau5KWj/cBbbfW20=
X-Google-Smtp-Source: ABdhPJx2cuOSho44M0UYvQyss6pr9d/vxjK+w6u+ICzKOppEkPxELogJ467lERx1j0FL2Fuc8HNNFA==
X-Received: by 2002:a05:6402:28f:: with SMTP id l15mr26430494edv.233.1597865688290;
        Wed, 19 Aug 2020 12:34:48 -0700 (PDT)
Received: from tsnow (IGLD-83-130-68-114.inter.net.il. [83.130.68.114])
        by smtp.gmail.com with ESMTPSA id e14sm18640165edl.86.2020.08.19.12.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:34:47 -0700 (PDT)
Date:   Wed, 19 Aug 2020 22:34:43 +0300
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
Subject: [PATCH v3 0/2] staging: android: Remove BUG/BUG_ON from ion
Message-ID: <cover.1597865295.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removeing BUG/BUG_ON from androind/ion and add error handle to calling
functions

Tomer Samara (2):
  staging: android: Remove BUG_ON from ion_page_pool.c
  staging: android: Remove BUG from ion_system_heap.c

 drivers/staging/android/ion/ion_page_pool.c   | 14 ++++++++++----
 drivers/staging/android/ion/ion_system_heap.c | 15 ++++++++++++---
 2 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.25.1

