Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECDEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA05204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF2OTnz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgFJLfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:35:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbgFJLfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=K8pYKea34n4xAOJeaGLf5FVVIvqFNqD4hPeT2vvgXYw=;
        b=QF2OTnz9kxuNasah4u4+KL7oDpaLE1I/forXxt8yF2+vBNNpKWBHG80j0tpIXY1sZpqptQ
        S5i5fLcweNfEER4kl5D0DL8ts+UN+0HWJLc+zsR5TfFnLo33R9HIQdyZ4PMsoaomRfIyTP
        Z640UA6RqpCOJbBxRhC8R3RpymGfVmo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-tC6zBoukNHu__7ULv92ccQ-1; Wed, 10 Jun 2020 07:35:48 -0400
X-MC-Unique: tC6zBoukNHu__7ULv92ccQ-1
Received: by mail-wm1-f72.google.com with SMTP id a18so334613wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K8pYKea34n4xAOJeaGLf5FVVIvqFNqD4hPeT2vvgXYw=;
        b=g1rKuQQITwmkDokbMVEfG+VqhveeQHbpoNdu2rh0pICWbzYYBCPD15u+rV6pAVX70P
         /u9HjgGv4GEpbeRxO3G/goCoj3UBDqFxQPbPLtkChF1dUPI/cGOzwa6lV+hp6eSZ1Je4
         OTQqXDEmHbTOqIZRTWUmG75VBKEhdWkZOmftYBnWPXoiC+tDJwblusvwkoYkJA7P9clv
         YGRBddiXyMdp+kppvfU1vHG/gWz4B/1aOxsz2LuCrWXItEghiekC39JsT2KfxD888N+7
         ixOAUAc2ESxpCmSz5hy2FexsRUbTicodakQmgUNnh0+nad/bcL+VjPVpTCbRYXfLjCnY
         x1iw==
X-Gm-Message-State: AOAM530vNSOYoFXPy95iuxMT5T/6Z0WMy4+7sawcj0sGkGALF+4/uvlm
        qy5EY2GiaVwxmVMrldAc+FiRTbsnW7CNkiG4wQ6ZWO6gjNMenqevHrhlIngRXiMcqt1oX1fhVyV
        Xq6vBgb3pzBOH1zJfEijyjLSU
X-Received: by 2002:adf:f251:: with SMTP id b17mr3051840wrp.289.1591788947564;
        Wed, 10 Jun 2020 04:35:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWnKuMQXjtn3IeBKm108U4YQm44aJFvUiXB9xS8f3b+y8TTFsSksejlRPFLR+mhd/ngiqchQ==
X-Received: by 2002:adf:f251:: with SMTP id b17mr3051819wrp.289.1591788947339;
        Wed, 10 Jun 2020 04:35:47 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id e15sm6864302wme.9.2020.06.10.04.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:35:46 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:35:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v7 00/14] vhost: ring format independence
Message-ID: <20200610113515.1497099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This intentionally leaves "fixup" changes separate - hopefully
that is enough to fix vhost-net crashes reported here,
but it helps me keep track of what changed.
I will naturally squash them later when we are done.


This adds infrastructure required for supporting
multiple ring formats.

The idea is as follows: we convert descriptors to an
independent format first, and process that converting to
iov later.

Used ring is similar: we fetch into an independent struct first,
convert that to IOV later.

The point is that we have a tight loop that fetches
descriptors, which is good for cache utilization.
This will also allow all kind of batching tricks -
e.g. it seems possible to keep SMAP disabled while
we are fetching multiple descriptors.

For used descriptors, this allows keeping track of the buffer length
without need to rescan IOV.

This seems to perform exactly the same as the original
code based on a microbenchmark.
Lightly tested.
More testing would be very much appreciated.

changes from v6:
	- fixes some bugs introduced in v6 and v5

changes from v5:
	- addressed comments by Jason: squashed API changes, fixed up discard

changes from v4:
	- added used descriptor format independence
	- addressed comments by jason
	- fixed a crash detected by the lkp robot.

changes from v3:
        - fixed error handling in case of indirect descriptors
        - add BUG_ON to detect buffer overflow in case of bugs
                in response to comment by Jason Wang
        - minor code tweaks

Changes from v2:
	- fixed indirect descriptor batching
                reported by Jason Wang

Changes from v1:
	- typo fixes


Michael S. Tsirkin (14):
  vhost: option to fetch descriptors through an independent struct
  fixup! vhost: option to fetch descriptors through an independent
    struct
  vhost: use batched get_vq_desc version
  vhost/net: pass net specific struct pointer
  vhost: reorder functions
  vhost: format-independent API for used buffers
  fixup! vhost: format-independent API for used buffers
  fixup! vhost: use batched get_vq_desc version
  vhost/net: convert to new API: heads->bufs
  vhost/net: avoid iov length math
  vhost/test: convert to the buf API
  vhost/scsi: switch to buf APIs
  vhost/vsock: switch to the buf API
  vhost: drop head based APIs

 drivers/vhost/net.c   | 174 +++++++++----------
 drivers/vhost/scsi.c  |  73 ++++----
 drivers/vhost/test.c  |  22 +--
 drivers/vhost/vhost.c | 378 +++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  44 +++--
 drivers/vhost/vsock.c |  30 ++--
 6 files changed, 439 insertions(+), 282 deletions(-)

-- 
MST

