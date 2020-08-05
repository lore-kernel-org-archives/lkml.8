Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7225BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F162075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsRniJBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgHETaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:30:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36952 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728557AbgHERKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rITNW/NU1Wv42UK2hT0FegE7HEoaDEjHqXI0VXDNUgg=;
        b=LsRniJBSuAAAsFzo6sGVwQymK6Jm37AtaXO6QAyXiOuVUoKMbiD6lTQotZePoBfV61aDj0
        HUemDBTsGG4flYU3rwe++x7sb1m0MONlyb89V0ZW4az3iTnlwDcGbZX5D/BVHVAhXlFQyB
        yIX9+B5UEDLPrlAnXaZIZDmCZ2nZAbI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-TnxXk2naPrSSD7nj03hm0w-1; Wed, 05 Aug 2020 09:44:32 -0400
X-MC-Unique: TnxXk2naPrSSD7nj03hm0w-1
Received: by mail-wr1-f71.google.com with SMTP id s23so13430322wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rITNW/NU1Wv42UK2hT0FegE7HEoaDEjHqXI0VXDNUgg=;
        b=douW860ND1DAfJZ+qne1xFvfvHL7cH/r2FEqChapJmm+mIZun18EFG4stIMxv/rywN
         PRu416IDTcodMnbsngna7XXrUlIrLI512Evl5Ev+afH+Nb5GYvB/plX+muMXPvU1glmQ
         BTh2pbJFa1h8dpf5/yn50uk0u03Rklz3M886E3HjzIn2AeC9IVbQDvUF0E78Mw72vD+j
         j7L+liexY+FIM5M3KQ97YZsGrT6fF41Tri+zYH++ncSE188budnGpqnrdOTzUN7uVj9w
         3UhDtY2AkTQEkxz/Deo/QQMKDflMipR3lFUDWGONk9sUE0dx8dhQryLBD3zbYoeo3nqQ
         37dQ==
X-Gm-Message-State: AOAM530h3JP68DNENlB+TbTcjZxvWErl2GWdFmKtTH5KeSZJXFo4tA5J
        UEsk+/EyBmrMKsmphxULEzH1AIphjkbXWys7ZcmCNP3FpW8q1t3LFuxrgwn9zpZDQYtBYkZM63n
        U6fWVWNHrmXhQZ8UL0i0NWFmp
X-Received: by 2002:a1c:28c1:: with SMTP id o184mr3561059wmo.91.1596635070886;
        Wed, 05 Aug 2020 06:44:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcZLOj081T5kxFNjl1P5IaJV7iDG1ay5q9gWzjOmdLhKok8j4JZTnYScNBYJMMxfhLX53FGQ==
X-Received: by 2002:a1c:28c1:: with SMTP id o184mr3561042wmo.91.1596635070706;
        Wed, 05 Aug 2020 06:44:30 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id g8sm2732859wme.13.2020.08.05.06.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:30 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 27/38] virtio_caif: correct tags for config space fields
Message-ID: <20200805134226.1106164-28-mst@redhat.com>
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
---
 include/linux/virtio_caif.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_caif.h b/include/linux/virtio_caif.h
index 5d2d3124ca3d..ea722479510c 100644
--- a/include/linux/virtio_caif.h
+++ b/include/linux/virtio_caif.h
@@ -11,9 +11,9 @@
 
 #include <linux/types.h>
 struct virtio_caif_transf_config {
-	u16 headroom;
-	u16 tailroom;
-	u32 mtu;
+	__virtio16 headroom;
+	__virtio16 tailroom;
+	__virtio32 mtu;
 	u8 reserved[4];
 };
 
-- 
MST

