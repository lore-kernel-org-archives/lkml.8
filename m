Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE29AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C026B2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYbTNLLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgHaSTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbgHaSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:18:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s2so234687pjr.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MpFriyvAVeQ141rIrcIndLwo0DUmN70bXB2sWFslHOk=;
        b=CYbTNLLmCL49w91IM5M3uXNUfoSE6oHvpIAkNLlVESMhUK6NmISqV1D+AkqANbx7XK
         tOBGuw0pBMvj1P7ufyt3JsggppG+gUW9bk1PEBUkl3mu/WNyHzZJX5Tkzi1GCiCm0BZo
         0U7mPqPBe741/nE0YMT3Xpo7dhG1EzYx860aDt5e6HFSrvdaI8umZVJL3zI6bJYaBDx+
         4UjPigd1KKIapNzv3snW2bGwrAa1KoUJPr2IZadaifIjXekg31xDWuL1Z33irviJZ52B
         xEHWXbSBMvw84ul/PC1myxzJfrA4h500U02gF9hEJpFeQYY3YFsVW2Ay5dk5fLDGXgLz
         37Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MpFriyvAVeQ141rIrcIndLwo0DUmN70bXB2sWFslHOk=;
        b=RjjCS4onBz7E4p6YDa8DULavLpaiuxuiocPojP5oPj8yr5Cl9XmTHYxRjrQ6wFQ/mR
         2Ci80TWt6YGwd1VIJgrDnJ0nmkt2fsmqOLtfGHJqOR0bzgsyA+ZY472wYkyroMyAJMiq
         SVYoUpb/YATMKjq3mVzcPEyJpdsBg1PYJtK36rec0zgwxZTXIJ/z/YpklFjpZ8aFF+Qp
         v+NqFjqoc78v1XSOW0rvZ2rhUO1JvZQl5AOpUPM932gl6m7JTHbNzsWawK0hOs4VgM3g
         9QzgXENeuenxPqLlhs2VOHwO/4QhEO6ffozYIok5T8UVzqy8V2zxGWIaDw0jghfXPD5F
         80cg==
X-Gm-Message-State: AOAM530eh9qGKvs+ty0XF9ZJrUNkckLA5sKhPtVvU1+Gpb/qXqAvd1gh
        u6sMo8s5SCHQYv4FgkxPHJfu/m6P1G8=
X-Google-Smtp-Source: ABdhPJwP7zltm3ArpzQIspT7vqdtpmsGr+eUheO6zFc7IftXzIUHuCABd0FmfCHiIODG0bQ3x9S6eg==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr1960303plo.328.1598897888174;
        Mon, 31 Aug 2020 11:18:08 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id y128sm8672547pfy.74.2020.08.31.11.18.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:18:07 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 0/7] IOMMU user API enhancement
Date:   Mon, 31 Aug 2020 11:24:53 -0700
Message-Id: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU user API header was introduced to support nested DMA translation and
related fault handling. The current UAPI data structures consist of three
areas that cover the interactions between host kernel and guest:
 - fault handling
 - cache invalidation
 - bind guest page tables, i.e. guest PASID

Future extensions are likely to support more architectures and vIOMMU features.

In the previous discussion, using user-filled data size and feature flags is
made a preferred approach over a unified version number.
https://lkml.org/lkml/2020/1/29/45

In addition to introduce argsz field to data structures, this patchset is also
trying to document the UAPI design, usage, and extension rules. VT-d driver
changes to utilize the new argsz field is included, VFIO usage is to follow.

This set is available at:
https://github.com/jacobpan/linux.git vsva_v5.8_uapi_v8

Thanks,

Jacob


Changelog:
v8
	- Rebased to v5.9-rc2
	- Addressed review comments from Eric Auger
	  1. added a check for the unused vendor flags
	  2. commit message improvements
v7
	- Added PASID data format enum for range checking
	- Tidy up based on reviews from Alex W.
	- Removed doc section for vIOMMU fault handling
v6
	- Renamed all UAPI functions with iommu_uapi_ prefix
	- Replaced argsz maxsz checking with flag specific size checks
	- Documentation improvements based on suggestions by Eric Auger
	  Replaced example code with a pointer to the actual code
	- Added more checks for illegal flags combinations
	- Added doc file to MAINTAINERS
v5
	- Addjusted paddings in UAPI data to be 8 byte aligned
	- Do not clobber argsz in IOMMU core before passing on to vendor driver
	- Removed pr_warn_ for invalid UAPI data check, just return -EINVAL
	- Clarified VFIO responsibility in UAPI data handling
	- Use iommu_uapi prefix to differentiate APIs has in-kernel caller
	- Added comment for unchecked flags of invalidation granularity
	- Added example in doc to show vendor data checking

v4
	- Added checks of UAPI data for reserved fields, version, and flags.
	- Removed version check from vendor driver (vt-d)
	- Relaxed argsz check to match the UAPI struct size instead of variable
	  union size
	- Updated documentation

v3:
	- Rewrote backward compatibility rule to support existing code
	  re-compiled with newer kernel UAPI header that runs on older
	  kernel. Based on review comment from Alex W.
	  https://lore.kernel.org/linux-iommu/20200611094741.6d118fa8@w520.home/
	- Take user pointer directly in UAPI functions. Perform argsz check
	  and copy_from_user() in IOMMU driver. Eliminate the need for
	  VFIO or other upper layer to parse IOMMU data.
	- Create wrapper function for in-kernel users of UAPI functions
v2:
	- Removed unified API version and helper
	- Introduced argsz for each UAPI data
	- Introduced UAPI doc


Jacob Pan (7):
  docs: IOMMU user API
  iommu/uapi: Add argsz for user filled data
  iommu/uapi: Introduce enum type for PASID data format
  iommu/uapi: Use named union for user data
  iommu/uapi: Rename uapi functions
  iommu/uapi: Handle data and argsz filled by users
  iommu/vt-d: Check UAPI data processed by IOMMU core

 Documentation/userspace-api/iommu.rst | 211 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 drivers/iommu/intel/iommu.c           |  25 ++--
 drivers/iommu/intel/svm.c             |  13 ++-
 drivers/iommu/iommu.c                 | 205 +++++++++++++++++++++++++++++++--
 include/linux/iommu.h                 |  35 ++++--
 include/uapi/linux/iommu.h            |  25 ++--
 7 files changed, 470 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst

-- 
2.7.4

