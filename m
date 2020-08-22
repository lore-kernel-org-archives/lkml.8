Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2924C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC102071A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loWFE4rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgHVE2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgHVE2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:28:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57C7C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so1675938pjd.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYpeb/PkPwRbYOwET4nNHLv4kDK8jDR1mJWP198+wu4=;
        b=loWFE4rMVDX8IGXeu/alOJRUkonwP9feeX6uYFVfzGYkUYTqL0rN1TSZox0V/jBcyE
         ST0IcVmRzqfvHAw59t0VXChNV9zmzKHttulB69GBPiMG+Zrf25IK179q5Z+pPQY+X69a
         BdTrJxCFPs99S9DEJGUsAljDdRDO0zuWgQeODz3iY3GcIi6iqLbsT22dMqgr/ZA+7ulJ
         fDeI4TBx18g9TnJnrtonVP9OLRI2oiJt32HScRYg4A3t22ALg9tfafoLn+MEo+T0Xeho
         kg7zMvakUzqOY6fTRrb/HvAKBjQJ99Iww5ownAxZe1ZpugIu1tbk8qh1uF/Uxe0VkhJZ
         B97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YYpeb/PkPwRbYOwET4nNHLv4kDK8jDR1mJWP198+wu4=;
        b=Z2DSw3G71JEeJnoFsdTKvgmRV1Z4zu8zPycGSMuTgGKrZFGF810diVIMyLNkyHcUj1
         lV1oTasODgBjhC3/TMAybZMYuyRCI2DHiVWiOMrLbLVMAkDb8hSjca+kDOroEwG7QhCH
         eUJ+OG4AZbQPt+ik1v3C0SkW9G9Sd6x/iKs2Mgobd9Y73hUFZnjgFPXYvhhf1r2Mzz7j
         qBmDPGxAp+MzxYR47whkHBfsGSSj1tIUg3MWVOBklQJV80lTjKn7SKWnr54wTeSWOhgV
         607tXSsUrZ/FTPuai0O63fXk/sqEXykNbWDLdmQjBuCDkI/Lln0NHyK0Owvd1EfGRWqq
         x/bw==
X-Gm-Message-State: AOAM5308v0FufrUoEo/DQkcTiuXpgvjoatW+QNLsPhsCwuGuxLuplJgu
        BPf6MHWicT3fkwqpa8t0Bu4=
X-Google-Smtp-Source: ABdhPJymyNPfeAEVglq7lG1V+0IlRKVWGITLjG2VC6ZG7AQXKNBReKqOjLFGvlAWcjuhjRyR29xPQA==
X-Received: by 2002:a17:902:690a:: with SMTP id j10mr4872494plk.155.1598070502310;
        Fri, 21 Aug 2020 21:28:22 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 21:28:21 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 0/9] IOASID extensions for guest SVA
Date:   Fri, 21 Aug 2020 21:35:09 -0700
Message-Id: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOASID was introduced in v5.5 as a generic kernel allocator service for
both PCIe Process Address Space ID (PASID) and ARM SMMU's Sub Stream
ID. In addition to basic ID allocation, ioasid_set was defined as a
token that is shared by a group of IOASIDs. This set token can be used
for permission checking, but lack of some features to address the
following needs by guest Shared Virtual Address (SVA).
- Manage IOASIDs by group, group ownership, quota, etc.
- State synchronization among IOASID users
- Non-identity guest-host IOASID mapping
- Lifecycle management across many users

This patchset introduces the following extensions as solutions to the
problems above.
- Redefine and extend IOASID set such that IOASIDs can be managed by groups.
- Add notifications for IOASID state synchronization
- Add reference counting for life cycle alignment among users
- Support ioasid_set private IDs, which can be used as guest IOASIDs
Please refer to Documentation/ioasid.rst in enclosed patch 1/9 for more
details.

This patchset only included VT-d driver as users of some of the new APIs.
VFIO and KVM patches are coming up to fully utilize the APIs introduced
here.

You can find this series at:
https://github.com/jacobpan/linux.git ioasid_ext_v2
(VFIO and KVM patches will be available at this branch when published.)

This work is a result of collaboration with many people:
Liu, Yi L <yi.l.liu@intel.com>
Wu Hao <hao.wu@intel.com>
Ashok Raj <ashok.raj@intel.com>
Kevin Tian <kevin.tian@intel.com>

Thanks,

Jacob

Changelog

V2:
- Redesigned ioasid_set APIs, removed set ID
- Added set private ID (SPID) for guest PASID usage.
- Add per ioasid_set notification and priority support.
- Back to use spinlocks and atomic notifications.
- Added async work in VT-d driver to perform teardown outside atomic context

Jacob Pan (9):
  docs: Document IO Address Space ID (IOASID) APIs
  iommu/ioasid: Rename ioasid_set_data()
  iommu/ioasid: Introduce ioasid_set APIs
  iommu/ioasid: Add reference couting functions
  iommu/ioasid: Introduce ioasid_set private ID
  iommu/ioasid: Introduce notification APIs
  iommu/vt-d: Listen to IOASID notifications
  iommu/vt-d: Send IOASID bind/unbind notifications
  iommu/vt-d: Store guest PASID during bind

 Documentation/ioasid.rst    | 618 ++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  27 +-
 drivers/iommu/intel/pasid.h |   1 +
 drivers/iommu/intel/svm.c   |  97 ++++-
 drivers/iommu/ioasid.c      | 835 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h |   2 +
 include/linux/ioasid.h      | 166 ++++++++-
 7 files changed, 1699 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/ioasid.rst

-- 
2.7.4

