Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82942078E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fortF6f1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLWrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFLWrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:47:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29EC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 15:47:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x25so562981edr.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2LCJlPjQS0gd4aoPiMI6xbg97Spn/0YYSiPlNrj5IrU=;
        b=fortF6f1kvl3IV2y2CB+0zJ6WvpATfMGUcgF5oUrAxMu1rYMY5zjRkS66sDRr5nOJ0
         ytTSAEhGL/y84gWKEKvIXRyFFD2iY39+jorRG3+9kimLTpbBPrbKtFuHOsswExzf1KTf
         jFmHBd50RTeoc7e/9UkxpLSz1rzGd+Jq9e+qPU0pWtKt4FEsOutCOLS3VVEWNvBxOiCo
         GA7/JVMenN8HtZRAIJBbmajGWbHanikY6jtrimLmqPEGExtcuJGpbQC5l4B5+v300JXr
         V5QKd+4VKibZzffoCyi81sjd3NCoSLnvh7h0PRni7WwWh6ZYvtxWcZJOP7Krv/VgbFj7
         ZAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2LCJlPjQS0gd4aoPiMI6xbg97Spn/0YYSiPlNrj5IrU=;
        b=l+E1y9muu1bftFmEY7j8XZZhOH8+flIPyVERw0uuNIR/MDPh+T8TFq1VEnoAmTfEGC
         wGVXfQwMSkbnR2+thgsoBLttFhl4haCuiP+aZBpG4EjGnm2EdPfFyn3ysQxn6IahLzAW
         4v+l66aFSFmnNND69Z5LALWyA490v2cb/h1L+zFecG+ZGSE4vTKVvo1T8/d3Vm+suVUZ
         sBTK8e3v9bnNbiPwt64EuBM6GxivFG+HUSl4lE/cl9EXztWL1Tu3MwZpu9WXZJ7xk4XL
         I+h2mQMlBz91LXOeaLWVPzuHVyS/z+ityWgGliq/6Cf3+kadluWO46ri2lgCqVLv62Oj
         lQcA==
X-Gm-Message-State: AOAM530GSh1Ypq628kT8dJnVemaDWNW8ADRuQolm8UdwTYeb5cRBYrYA
        hcWllCy87XOkJb/QafktblKP/k/VlK+raRvcixPX+A==
X-Google-Smtp-Source: ABdhPJxNe68eLGh3J4q+DFbYhyzpnTNd+T3ljiVc/zosVTnbXp/wpXXs3GloAfAO/DB7e69vJ+Aa9oWtwEehNctjfbU=
X-Received: by 2002:aa7:c489:: with SMTP id m9mr14552170edq.102.1592002021252;
 Fri, 12 Jun 2020 15:47:01 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Jun 2020 15:46:50 -0700
Message-ID: <CAPcyv4jDQ9VVZJTD=cz+VvPxo6FNQGbW=BYA1Qhix-yQkSWeCQ@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.8

...to receive a smattering of cleanups for v5.8. I was considering at
least one more late breaking topic for -rc1 (papr_scm device health
reporting), but a last minute kbuild-robot report kicked it out. I
might bring that back for -rc2 since it was nearly ready save for that
late breaking test report.

Otherwise, this has appeared in -next with no reported issues.

---

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.8

for you to fetch changes up to 6ec26b8b2d70b41d7c2affd8660d94ce78b3823c:

  nvdimm/pmem: stop using ->queuedata (2020-05-13 15:15:37 -0700)

----------------------------------------------------------------
libnvdimm for 5.8

- Small collection of cleanups to rework usage of ->queuedata and the
  GUID api.

----------------------------------------------------------------
Andy Shevchenko (1):
      libnvdimm: Replace guid_copy() with import_guid() where it makes sense

Christoph Hellwig (3):
      nvdimm/blk: stop using ->queuedata
      nvdimm/btt: stop using ->queuedata
      nvdimm/pmem: stop using ->queuedata

 drivers/acpi/nfit/core.c | 2 +-
 drivers/nvdimm/blk.c     | 5 ++---
 drivers/nvdimm/btt.c     | 3 +--
 drivers/nvdimm/pmem.c    | 6 +++---
 4 files changed, 7 insertions(+), 9 deletions(-)
