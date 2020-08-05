Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA081C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6825020842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz3cZWAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHET22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728608AbgHERLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uT4MZK/WmjMO9Hf3gYa75MOY3iZoVd/8WD7Av4sgX3M=;
        b=fz3cZWATFlooZQq0MXjZPzUUlnPn1W/B76XD9gBoyELEwI/A8mfkQPHIE43y3G3dU/tH8y
        o3VEz+J3zcBlxU1fjUNSkt2VHzX+/K/yhlhgAFfpPLVX9H0CRfCCohfFpYSI6wEB+jTl/Y
        aP6+1QNNxyC+54ymBPbvrC2vl/3IMSE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-pVxkJcPEOW-nlrg5iMJx1Q-1; Wed, 05 Aug 2020 09:43:37 -0400
X-MC-Unique: pVxkJcPEOW-nlrg5iMJx1Q-1
Received: by mail-wm1-f69.google.com with SMTP id u144so2739965wmu.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uT4MZK/WmjMO9Hf3gYa75MOY3iZoVd/8WD7Av4sgX3M=;
        b=WZc2EICH8XbdaKrr0eKGPxdKzt4fOJyBYrVw+x712xY8x9t3LTxjSTAMASVYaYqgmO
         Dc5btFMBppKfb1os7EqHnIpHpqXywrDQrR3dY3P0nwZhUyHvBTY9lKNNxNAMpkanUIZJ
         LbPhQYe4b5807OzKG7GWOMKv+AIIxvzIWK49SXl7m4bZRzguFrQpYvUQZUkhqKUjOxD7
         FO3RJGETcID1/rIF6nVV0GJV62j+ZYqv85lQ/WXJUJxwWOGuNYkuT1ijFKkr14JQPno0
         O9YsP3Eim7Gokv/S1o1LSe6uxFq+uGZPoB7UzTe+wNuHxydSPg6m9NG7VYz4SbnfFCZd
         webA==
X-Gm-Message-State: AOAM533ZFaf5yXFsb8kA4EZiEGYpFxCAodp7GMTSNFxNo4MOJhvsoxkP
        //yLQn2JHvoH5CAdgWHsEfFl3dltu5UyYRpA0PeNSmJgtEuGyi9mLicaY7rnsPfT4fSvLSONGfD
        F0ndmzEXOFXYYUkJ3LwquEDkK
X-Received: by 2002:adf:b302:: with SMTP id j2mr2859690wrd.294.1596635016393;
        Wed, 05 Aug 2020 06:43:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzITs/miouKXFVmBFtcFlH4aNnnt5FWqtlGH9JkX5pGWDGOgygL5Olr/ps3r5ZDSsC1a6fhYg==
X-Received: by 2002:adf:b302:: with SMTP id j2mr2859668wrd.294.1596635016220;
        Wed, 05 Aug 2020 06:43:36 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id z15sm2842664wrn.89.2020.08.05.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:35 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>, Amit Shah <amit@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 07/38] virtio_console: correct tags for config space fields
Message-ID: <20200805134226.1106164-8-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_console.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_console.h b/include/uapi/linux/virtio_console.h
index b7fb108c9310..7e6ec2ff0560 100644
--- a/include/uapi/linux/virtio_console.h
+++ b/include/uapi/linux/virtio_console.h
@@ -45,13 +45,13 @@
 
 struct virtio_console_config {
 	/* colums of the screens */
-	__u16 cols;
+	__virtio16 cols;
 	/* rows of the screens */
-	__u16 rows;
+	__virtio16 rows;
 	/* max. number of ports this device can hold */
-	__u32 max_nr_ports;
+	__virtio32 max_nr_ports;
 	/* emergency write register */
-	__u32 emerg_wr;
+	__virtio32 emerg_wr;
 } __attribute__((packed));
 
 /*
-- 
MST

