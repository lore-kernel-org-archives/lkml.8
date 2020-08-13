Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E109020768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDpTVC3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHMGVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgHMGVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:21:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8639C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:21:16 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c15so2451325lfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wDWU02+wCKok8nwDMeBlH97/pQcKgRkp+JF5JymdpUo=;
        b=jDpTVC3sIm7gufDjf0d+/+hJrzDRXPB5ir1t8eW5KL1T4aQ4sPLBnwenLQJBq8qKIT
         jbWxj5JszQNrbU7t/NghozcTj8mbbQlIm6qR389+tdkpQMibep+6sVKx04ZpKchRa7LV
         GNarSi2rJdVEBIeItxbNSzQqwt1BU78frDE9wbp2rvt/2v1RWsrdGtn4StePHqGj+jOs
         0hkOuKOaNcoKsUQjwgop4MRJCWhnqOQS/C5bdq1bBa5QlE+tS3/4sQxnvthYHBWU4xY8
         HfUDYiAqSdSuj7GT21GU5fs5apPoGqXCDyMaqNXkiNYk+hF3l+HR3QJrDN2l/Qih7nVD
         R67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wDWU02+wCKok8nwDMeBlH97/pQcKgRkp+JF5JymdpUo=;
        b=NpQ09HFDlmXHCLP1kW0BO+cCEbkWryTYg6T/mOW2Pn2tZbz3ytd0slY63DqMpKjPmP
         Xn9uiVleISYJVExr8X+3dCqv5+l3QCjbsmqB0EJDmBxW3uKwokcsU96fzoeFFS/f+et5
         hpCAbo8e5VQ9pvYPhc8dJyFSy9myfF7goVMMtC7nK9Bt8J3wwO5BlG49/fukDNlC4IYb
         d8PU2ccic1mhOTGjPMIKEOIGiQtKYo31bflwpa1WSnG/wxrQkFOeApmARy2W2Tw7NCaI
         KXtccNu0PT2EI2lmOIsGmcu3Q73Oib9zAG9BZkGnZ2LUuBeF2qhNsR6SDCg1WgsK2dE6
         UoGg==
X-Gm-Message-State: AOAM531HMDnKtvcR1HMmd5CsMHks07wYDRtL2CQaWRmpUyHBa66Z+5RP
        HiVdU6soB/z/sAnJCl5c6i8=
X-Google-Smtp-Source: ABdhPJyM6kqvqKmDAxBHlLEed6fda0trrJcviieTKINPyset90Po5kDy6xXF6opl++WeilsLdmCx8A==
X-Received: by 2002:ac2:5ec8:: with SMTP id d8mr1391609lfq.169.1597299675256;
        Wed, 12 Aug 2020 23:21:15 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id f14sm964060lfd.2.2020.08.12.23.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 23:21:14 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2 0/5] Fixes and improvements for Xen pvdrm
Date:   Thu, 13 Aug 2020 09:21:08 +0300
Message-Id: <20200813062113.11030-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hello,

This series contains an assorted set of fixes and improvements for
the Xen para-virtualized display driver and grant device driver which
I have collected over the last couple of months:

1. Minor fixes to grant device driver and drm/xen-front.

2. New format (YUYV) added to the list of the PV DRM supported formats
which allows the driver to be used in zero-copying use-cases when
a camera device is the source of the dma-bufs.

3. Synchronization with the latest para-virtualized protocol definition
in Xen [1].

4. SGT offset is now propagated to the backend: while importing a dmabuf
it is possible that the data of the buffer is put with offset which is
indicated by the SGT offset. This is needed for some GPUs which have
non-zero offset.

Thank you,
Oleksandr Andrushchenko

[1] https://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=c27a184225eab54d20435c8cab5ad0ef384dc2c0

Changes since v1:
=================

1. Removed patch which adds EDID to PV DRM as it needs more time for review:
"5. Version 2 of the Xen displif protocol adds XENDISPL_OP_GET_EDID
request which allows frontends to request EDID structure per
connector. This request is optional and if not supported by the
backend then visible area is still defined by the relevant
XenStore's "resolution" property.
If backend provides EDID with XENDISPL_OP_GET_EDID request then
its values must take precedence over the resolutions defined in
XenStore."
I will send this as a dedicated patch.

2. Added missing CC stable for the patches with fixes

Oleksandr Andrushchenko (5):
  xen/gntdev: Fix dmabuf import with non-zero sgt offset
  drm/xen-front: Fix misused IS_ERR_OR_NULL checks
  drm/xen-front: Add YUYV to supported formats
  xen: Sync up with the canonical protocol definition in Xen
  drm/xen-front: Pass dumb buffer data offset to the backend

 drivers/gpu/drm/xen/xen_drm_front.c      | 10 +--
 drivers/gpu/drm/xen/xen_drm_front.h      |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c |  1 +
 drivers/gpu/drm/xen/xen_drm_front_gem.c  | 11 +--
 drivers/gpu/drm/xen/xen_drm_front_kms.c  |  2 +-
 drivers/xen/gntdev-dmabuf.c              |  8 +++
 include/xen/interface/io/displif.h       | 91 +++++++++++++++++++++++-
 7 files changed, 111 insertions(+), 14 deletions(-)

-- 
2.17.1

