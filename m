Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266BA207F9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBUS7d5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgFHMxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:53:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26577 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728007AbgFHMxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gjI/Xc/cqqYk/lSVknmdrxtI4JosdROOwhqNKTqv88I=;
        b=MBUS7d5yoet9opOUKh8ZovEy5/KqdTQ0gNCxLRHZHmRTDvn0CM6b845rWYqpZU7fuWtDcL
        GdhaIPJ4H+23q0qPG6ExE6OLxaXIysPZTU4UzrAca8K/l34P30CS7JdoTXEd2ES8Tp+56/
        bqdIAH+M3bYop06PELMqZ42/mCMqeVc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-19zAtKc5MPuK8xFFWmzwPA-1; Mon, 08 Jun 2020 08:52:55 -0400
X-MC-Unique: 19zAtKc5MPuK8xFFWmzwPA-1
Received: by mail-wm1-f70.google.com with SMTP id t145so5220018wmt.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gjI/Xc/cqqYk/lSVknmdrxtI4JosdROOwhqNKTqv88I=;
        b=LN1EJ3VQHf3y+FV4gNUmu3f4jc5bqlJSVNwKg0H9pCP6VwXxUYkynEat6XPLilaP2H
         1F+SqsEEo3lebsqkZTmh4C4gR9qNuY2lwW3KBZ8kXEY+TAXN6O9CifzE7p3dSlkDE5b/
         wek6gweYmeKtfguax+cqOot3C7M8LfAJNB2aKM/JZ/fVeDmHjDgVf+wj3WlIvYgMYjFd
         HsltP3VUy+Scjn3ccUT07nHizRY6KimM1+uOjpd8oOGNIuu+/KMUgMpeWD0yXsU8qJ2T
         Rb7un4W0VkxhZbe7rCKAtXFPG7KWzEiBO2WWCcNpNtMSQ13CvN46aL4iN0dktme57C2y
         uVDQ==
X-Gm-Message-State: AOAM533MklM6CWGclv12gymd+etXhBHrWAlE+1j/lMRsOOYY1zqFdfOx
        GSBLFDdIrhjFOSBiHsV5E4b7nZdylKJl5MLKzNb77P7ML+FzVZxErykb2MAPxZZTQobIjhgB96R
        7poVzbU3BkjaAPvDPloeb3o7Y
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr23504277wrx.300.1591620773839;
        Mon, 08 Jun 2020 05:52:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDSI+/ZbdtAMbTo/u8TmLBd4nOMtF+iSAUbirR2p1aEeZspsKsHQ+oW3THKUaNWxC1PVL/dQ==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr23504259wrx.300.1591620773666;
        Mon, 08 Jun 2020 05:52:53 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id y19sm21769323wmi.6.2020.06.08.05.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:52:52 -0700 (PDT)
Date:   Mon, 8 Jun 2020 08:52:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v6 00/11] vhost: ring format independence
Message-ID: <20200608125238.728563-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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


Michael S. Tsirkin (11):
  vhost: option to fetch descriptors through an independent struct
  vhost: use batched get_vq_desc version
  vhost/net: pass net specific struct pointer
  vhost: reorder functions
  vhost: format-independent API for used buffers
  vhost/net: convert to new API: heads->bufs
  vhost/net: avoid iov length math
  vhost/test: convert to the buf API
  vhost/scsi: switch to buf APIs
  vhost/vsock: switch to the buf API
  vhost: drop head based APIs

 drivers/vhost/net.c   | 174 ++++++++++---------
 drivers/vhost/scsi.c  |  73 ++++----
 drivers/vhost/test.c  |  22 +--
 drivers/vhost/vhost.c | 382 +++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  44 +++--
 drivers/vhost/vsock.c |  30 ++--
 6 files changed, 443 insertions(+), 282 deletions(-)

-- 
MST

