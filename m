Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646F4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429222245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH1oegfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgGaMvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGaMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:51:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57F8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:13 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so32295295ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B/WYQkneNHHasyBibLNJc39P94On0q0Yf/0dGxBiCnM=;
        b=bH1oegfq4F1BjeNTK0Nmijn8MhoTBmIOgLZoaVfUGo0h2JoRT+aO14I78TeLvdBHYm
         Pt4W0qwPJ4s9jm03v4G0XX/uCdXRfRLPIyYfE7mgknlRuHgczule6rCWmicdbvvZkVR5
         FK1yg1ZEqij2/fftNtqZXSMUYpyr8RLHPKXEKIlnDfhXUcnkj7I+tcnqEu4OLCIdRvwU
         kdCVHuuI5NS6sIq8V5pwcioRFKnchzzF27Gus5xnrUP4lSfxpu9uXYL8eh3rwklF60Hw
         yDmB2W+Hz3BQ8SKUUY/ifYHZeaBqiQgP66TgtLdW15C+Z/XUEQZamtVRWmfGMyn6Brg4
         z6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B/WYQkneNHHasyBibLNJc39P94On0q0Yf/0dGxBiCnM=;
        b=Yzr1sMvHT+0CFh61Ra7c2ejIV663kejVym/Fm62Jg34GD0hOOAhY7+JnUACrRVdVoo
         QnykqK0Qlu2KfdIaPczoDQzCRnT2fYVLnwVh0+UFTYoOxus9dVdu8tsMRhcr15IipbpQ
         Z7ZieOuI7EicZcI9Dy7bsmZtho8qVoRWEhvSnm9F3Xf/SUI2dV/lLkNGpxKOoiPVctrR
         t1+TS6YaZloTxYFXaRTwvx1Utcitz7ToMVvuOOBpRnG6VDjBn6/RwgXT6gTZCEuePzVK
         ogL8MnDUT5Y+XYbJUHfwN5jnONzcGgKBsE3qC0qkw4YVI504Y4f8Jj8mopPXnKcnBpMy
         iuHw==
X-Gm-Message-State: AOAM5325p9YszWEJlMVs3CDgNokMlRAv8KOuTHGdTg0QS4VvLfqmImSW
        QAdHYGODv8DhprdSbkI4ivE=
X-Google-Smtp-Source: ABdhPJwQKJDe178RRgB019PdVZcaJRxYEd+DG5Tp68DUOkwsyOEYd5yGBw9xFWQf08QnB4cwBtO9VA==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr1822750ljc.159.1596199872208;
        Fri, 31 Jul 2020 05:51:12 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id s2sm1923362lfs.4.2020.07.31.05.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:51:11 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 0/6] Fixes and improvements for Xen pvdrm
Date:   Fri, 31 Jul 2020 15:51:03 +0300
Message-Id: <20200731125109.18666-1-andr2000@gmail.com>
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

5. Version 2 of the Xen displif protocol adds XENDISPL_OP_GET_EDID
request which allows frontends to request EDID structure per
connector. This request is optional and if not supported by the
backend then visible area is still defined by the relevant
XenStore's "resolution" property.
If backend provides EDID with XENDISPL_OP_GET_EDID request then
its values must take precedence over the resolutions defined in
XenStore.

Thank you,
Oleksandr Andrushchenko

[1] https://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=c27a184225eab54d20435c8cab5ad0ef384dc2c0

Oleksandr Andrushchenko (6):
  xen/gntdev: Fix dmabuf import with non-zero sgt offset
  drm/xen-front: Fix misused IS_ERR_OR_NULL checks
  drm/xen-front: Add YUYV to supported formats
  xen: Sync up with the canonical protocol definition in Xen
  drm/xen-front: Pass dumb buffer data offset to the backend
  drm/xen-front: Add support for EDID based configuration

 drivers/gpu/drm/xen/xen_drm_front.c         | 72 +++++++++++++++-
 drivers/gpu/drm/xen/xen_drm_front.h         | 11 ++-
 drivers/gpu/drm/xen/xen_drm_front_cfg.c     | 82 +++++++++++++++++++
 drivers/gpu/drm/xen/xen_drm_front_cfg.h     |  7 ++
 drivers/gpu/drm/xen/xen_drm_front_conn.c    | 27 +++++-
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c |  3 +
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.h |  3 +
 drivers/gpu/drm/xen/xen_drm_front_gem.c     | 11 +--
 drivers/gpu/drm/xen/xen_drm_front_kms.c     |  7 +-
 drivers/xen/gntdev-dmabuf.c                 |  8 ++
 include/xen/interface/io/displif.h          | 91 ++++++++++++++++++++-
 11 files changed, 305 insertions(+), 17 deletions(-)

-- 
2.17.1

