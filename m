Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D5E22CAD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2LVuNPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgHCU7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34515 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728605AbgHCU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8eHz/lbxCSjMlZVNH/34TV/YIRF5gbPoZs5VubwoF5c=;
        b=F2LVuNPQ5BYggz7boPIHdq8LdgZohx0J8M5343BqV2N00FndJ9efLHkmrvCSBtMw8mpJm3
        yTsKMN9isMZgu3qt1OUDKj9qXPz7lJJntiuIvdK8UE+1kEn0OXDJ3Lv56Ox805Z4I55DAM
        c0K+YHTSZbTmRpnmRao3sRilc21DDaE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-t5z2mZ2iMZaH-s3Y0nVKLw-1; Mon, 03 Aug 2020 16:59:00 -0400
X-MC-Unique: t5z2mZ2iMZaH-s3Y0nVKLw-1
Received: by mail-qk1-f197.google.com with SMTP id z1so21353929qkg.23
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eHz/lbxCSjMlZVNH/34TV/YIRF5gbPoZs5VubwoF5c=;
        b=X38r5Z0ybkfMRW00UQfPunkSq6PwEkcUugjM7h26gQj3xuYRgjyb+CBrN4nz9SBu28
         QWlwoXHG3ZM83vS1eSJ0hlQClrfisBos+2VTXV9u0Q9LPM2+jLVnU84PqRP6fBV1S+uT
         a7mh2OwrvF0xhYc/qzB/EN5+oZR4kr9JNDSP5khkDt4hNWqZvx2McvZ8x49nVwQDGeJy
         2RBRnaJ4ps6xBLKFHxEBLmPS2sE7Y5+1JAL6tnD37TzzgyzcV9bi+iBaju6soUgEhg3x
         vlg+X+MFAJ5/ydCunhvmRZy+sE9vlrMtyUHIJ+tCFZSMowqfZYEpL3fz4UKgyoa3VLLw
         6AhA==
X-Gm-Message-State: AOAM533QWtTtv/Qb37dpDhWtT52Nxaxu+UpLEP+LueE/d7Z+fmbM7yw3
        FaM07EBDX0se/lOFw1S34mbZvYd02nB+z37pRaCT/OvUJiSVn8HnZ22MTWr6z87IR2U5+clQq8A
        ERP+dwQv2qqW4Jwf8mQV7osoq
X-Received: by 2002:a37:b647:: with SMTP id g68mr16691695qkf.70.1596488339530;
        Mon, 03 Aug 2020 13:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpr04+Pwki0AMTvbbWBex2pXR+QEGXSXfwWpj28UnW+RCxiaQMgdRzpparB0ZmbKWaDfeieA==
X-Received: by 2002:a37:b647:: with SMTP id g68mr16691684qkf.70.1596488339330;
        Mon, 03 Aug 2020 13:58:59 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id o37sm24587956qte.9.2020.08.03.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:58:58 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:58:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 05/24] virtio_balloon: correct tags for config space fields
Message-ID: <20200803205814.540410-6-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag config space fields as having little endian-ness.
Note that balloon is special: LE even when using
the legacy interface.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_balloon.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index dc3e656470dd..ddaa45e723c4 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -45,20 +45,20 @@
 #define VIRTIO_BALLOON_CMD_ID_DONE	1
 struct virtio_balloon_config {
 	/* Number of pages host wants Guest to give up. */
-	__u32 num_pages;
+	__le32 num_pages;
 	/* Number of pages we've actually got in balloon. */
-	__u32 actual;
+	__le32 actual;
 	/*
 	 * Free page hint command id, readonly by guest.
 	 * Was previously named free_page_report_cmd_id so we
 	 * need to carry that name for legacy support.
 	 */
 	union {
-		__u32 free_page_hint_cmd_id;
-		__u32 free_page_report_cmd_id;	/* deprecated */
+		__le32 free_page_hint_cmd_id;
+		__le32 free_page_report_cmd_id;	/* deprecated */
 	};
 	/* Stores PAGE_POISON if page poisoning is in use */
-	__u32 poison_val;
+	__le32 poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
MST

