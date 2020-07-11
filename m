Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3722075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="uJrPPKby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGKB0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgGKB0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:26:40 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C999FC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:26:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so6007590edy.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FjrM6YbUyqhD93+HtMW7ZllqWvaztpbqB/gNMOtGURo=;
        b=uJrPPKby1RgmkwDyZHBpFkBfJ9KFD0OuqUmYfgNoVzQzoUKJzLQkskDmDAfFHuZ2NY
         T2BnhLWVnZfDeL/yNilOhadrYLWHfVnzL4/E7e49tjrdHqiCuxoV+erP5Osq8v5yGCql
         PwHGs6YSAcPgrF8YzfqA+s6TH+U8vt96voUmimZR66l1K8R5RK6nOwADrW3d2OMdBFoM
         UN+2SEbAkTuqKfE30XdGW113kx05fAgVeX1Akar1FM4eci8rNx2nRaWp1vYwUmff84jZ
         b94ym6jIEU4Cqnni62TODUGGnvtFaavfr4EcIyPQymSWLag08SYG4K+kSfqtGhlvgdoK
         XqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FjrM6YbUyqhD93+HtMW7ZllqWvaztpbqB/gNMOtGURo=;
        b=Y7kCdB+JmNOfPKz2xQiIchnmVSfKxlpvrQDOur5nsBcycHFKinhQPSw1fRx+wpypnB
         Ovp6dEZkKl0i/BJiPar1+SLiz2PLhEpF4ER87Q1vpQQE+2TZeIUd0LkI5JmuyVRB3Od2
         BFMJE48RG84aVra3g3R60P3W6JqmQLOCn25yfONCX1y7OAH1k12RGfMdLk2WYR/62n0a
         d+dEeov2DUWAUALnD9/69KN7rF0f3QmeUIK2IclblDttz2dOOXo39pUS3GD5BomCqN1O
         rNndUgcDlnkZbC4lc5pWMQh18nZ3JHmTeFr28apMXRIWJV6JbvloIZxoi8l61YCGjWgz
         DF+w==
X-Gm-Message-State: AOAM533UEW/Zc5mGasfgPYkKF/otw7k/zX27bnp2moMn/nWLAzX3BzYp
        31zA8xA9Mx5Rjty1dMR3mVTWFreoJM+/TCQDa1GAepNn+VY=
X-Google-Smtp-Source: ABdhPJxaZWb0EaVxpvyuj0PNC4kHH62YNE23Hgn1jOXx+/IdRo57yhZxCnNSc+gMvja7FX2n7rAL1tZGmTOYfy3RY6I=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr79608854edb.296.1594430798458;
 Fri, 10 Jul 2020 18:26:38 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jul 2020 18:26:27 -0700
Message-ID: <CAPcyv4jSHxx-dscb7PAadNVBWhVWgT_iczah_6TQ=JSprw9ZNg@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fix for v5.8-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-v5.8-rc5

...to receive a one line fix for a regression from some of the 'keys'
subsystem reworks that landed in -rc1. I had been holding off to see
if anything else percolated up, but nothing has.

Please pull, thanks.

---

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fix-v5.8-rc5

for you to fetch changes up to 813357fead4adee73f7eca6bbe0e69dfcf514dc6:

  libnvdimm/security: Fix key lookup permissions (2020-07-08 17:08:01 -0700)

----------------------------------------------------------------
libnvdimm fix for v5.8-rc5

Fix key ring search permissions to address a regression from -rc1.

----------------------------------------------------------------
Dan Williams (1):
      libnvdimm/security: Fix key lookup permissions

 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
