Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696DDC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497D82078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1Tpjb1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgHVTme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgHVTmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 15:42:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BE0C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 12:42:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b66so2544951wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/FaXkTTvbwZErSBhMWgpJ+vVSqlKKdjiuZmdcAQZjG8=;
        b=Z1Tpjb1ir9zO7hPN1UUHbgsx9RjpM/Um089u7XrhvHJ5nuVjWwkL3erLU0Y/umi1Wv
         m9kuEJ+CTzhh2Ykd4itN8Vv3tG+vgSTt7BHe5kR7AyGp/X97Bl7i7fP4elG/zRIm2SO8
         EK7ow4uQSyyuZTgIjRMEUraZ9isZ66xQQATQf/OIWQVi9ufyRNRoW3eoI87LwsTOYyuy
         7MFnc1nHZtv7fWM9ANOqah2R2EQsaPABIokBe1evXXY1n2Ne6zS2chDrzbgJYg77w1is
         xkTjUmdDQN9oTEg6M8uCK2lE50/9WgAATtZjRC671HmpF4tuxgRDa2R1NI3tLR8eVJE1
         KQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/FaXkTTvbwZErSBhMWgpJ+vVSqlKKdjiuZmdcAQZjG8=;
        b=sHNLsOKJ3zFOyppcI+Z0kHeJnnOhdur7pY8EG5a92a/5/SqVr0QsyDgAxcp4FKvGCg
         yEup3g33u01PlI1Gi3iqCujjS/ddqYgalmZFtlTZJLq4EPGvBxzYKtdAtoPAiGaHSgHr
         ZZrwWHhKgU1u7+DuUEEn3d+2nHOxaIpVSm8E0FkbjAf0GeifpbPn0P5O9D4J/eYP6HxQ
         a4MJTYud/VaILKaWNyl7M+oG21/OXYdkRn0MNtuAjRNalC4rBPDULxyXKx5vdPMAnyEz
         4Bi1COWOei+36kP0c//tswK3ahKkGbguAaOIQjD1wgw1AHH6LewUKi9rBiWamuAwf0TC
         eeRg==
X-Gm-Message-State: AOAM532BBkhqpfl+6TEkmdj2u7iysQ+9hW92EruT/b8lWWsXx3NagIA3
        plPB9ZQcYXl2zrKc+6WJmMc=
X-Google-Smtp-Source: ABdhPJzQZuy38Z0r04hEC3wXtjUTy0THHcyaQC8KBkpYCKawKwMJzppxfAkksADg4SahzODcEl3jSA==
X-Received: by 2002:a1c:f017:: with SMTP id a23mr8409537wmb.164.1598125350015;
        Sat, 22 Aug 2020 12:42:30 -0700 (PDT)
Received: from tsnow (IGLD-83-130-62-237.inter.net.il. [83.130.62.237])
        by smtp.gmail.com with ESMTPSA id n8sm12931002wra.32.2020.08.22.12.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 12:42:29 -0700 (PDT)
Date:   Sat, 22 Aug 2020 22:42:17 +0300
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
Subject: [PATCH v5 0/2] staging: android: Remove BUG/BUG_ON
Message-ID: <cover.1598125227.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove BUG/BUG_ON from androind/ion

-v5:
	remove WARN_ON from ion_page_pool_free

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

 drivers/staging/android/ion/ion_page_pool.c   | 6 ------
 drivers/staging/android/ion/ion_system_heap.c | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

-- 
2.25.1

