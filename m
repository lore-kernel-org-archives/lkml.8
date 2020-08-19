Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B29C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166ED207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcdqs2SG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHSTiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSTiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:38:08 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49909C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:38:08 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so27692816ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=doOVIJAl8aLbOgFBDKcIqb/ccFDrxWvGVJaNvG3le54=;
        b=Tcdqs2SGsYZ0JWSHaz3cq9atV1buOc/Z3S7+pouyoYfnhhaFd5rMUYsopHHjbbwUPj
         0G3UxSPWgoPBo4+bz5IXvoJGkZiYOo71TMJJWsTbtEWp63hs6rFIlKtiCcjKF9DhC2uH
         t2EXW/ivJ/6qFfVYyvp372hQX0ykJz4IozOHLKWzIgq+/cLJAbN8f9pbppPlS0J15HaC
         rNkuZW7zBnNy/Kbqu+t85E7PfPRSoxM3v4ImEoksBxKsyjP3MhSwWvRh35F7/T2WMDbY
         jPh5sAmKTwd2HF4dum2Yj3HjwqOKn39sD+61lwjQCKj0+tsJujkvYq4BWcqSgdH2KjaE
         J8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=doOVIJAl8aLbOgFBDKcIqb/ccFDrxWvGVJaNvG3le54=;
        b=Mpxr37pfwo1PLy7HEcvpg/hRUKenjbFKT0JXtqtmP4oT+aOhd7Qrs4XYmaa8LlSS1u
         ZpGhzUzQvhMbewwpkkzKYPe+NF0dKv0oAFQ3NAHE8FNI88jI3fxszIEX0AufHBYQT4VT
         7fcoa9VwXQDXg5DfEnTiEATB9/IZZBuXQsWe0nOkOTWZDL7DvgnV+fd/C4fdYK2KD6Nm
         F0HhyRbgpO6zqBr4Tu3XmS8Fbq4PfC1aS/HEllldhFF5MH4liAX3ef01T9D3tWuaWyoQ
         d7wUTmrWaK8tYEykV/1SmuUZaaGSyAtNxbIHU1q3Hw0eXabElAcgFw/rxBmmQYNCmhm/
         bPJA==
X-Gm-Message-State: AOAM530TmnHExGmqsMDmyicgMd1wbKvvpVld0Y0yPqSsiU7uhraKJQfv
        hVmAnlIdDIXyyjwinEZex1Q=
X-Google-Smtp-Source: ABdhPJxmx3IkW3gTtNbDIal0hKTHsYWoX6DaIFrxkZ9x+FUQvRGrfHzoGsS6nFJi9uayR13xyljY6A==
X-Received: by 2002:a17:906:d054:: with SMTP id bo20mr28105958ejb.9.1597865887048;
        Wed, 19 Aug 2020 12:38:07 -0700 (PDT)
Received: from tsnow (IGLD-83-130-68-114.inter.net.il. [83.130.68.114])
        by smtp.gmail.com with ESMTPSA id hk14sm19573503ejb.88.2020.08.19.12.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:38:06 -0700 (PDT)
Date:   Wed, 19 Aug 2020 22:37:58 +0300
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
Subject: [PATCH v3 0/2] staging: android: Remove BUG/BUG_ONs
Message-ID: <cover.1597865771.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove BUG/BUG_ONs from androind/ion allocator and add error handling to
calling functions

Tomer Samara (2):
  staging: android: Remove BUG_ON from ion_page_pool.c
  staging: android: Remove BUG from ion_system_heap.c

 drivers/staging/android/ion/ion_page_pool.c   | 14 ++++++++++----
 drivers/staging/android/ion/ion_system_heap.c | 15 ++++++++++++---
 2 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.25.1

