Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4114120768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZSBfZia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgDGBQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:16:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40891 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726407AbgDGBQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=aZSBfZiaSx0UpBpgRp0p/ht9Fwm0PusPo5WmvDsd7fjbjMOkMIhks1C3PLXFKKOuIaLpgB
        SgJfWUp6JjmbLDvQy6VWC+oUhyhQHxI1uk1dIIc2W5A9F/ILx41paHXjDBqXR1E0qccpA+
        U3FYxKCo7ul0+/R50sc0e2Q3DS8z11w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-EPHvf4w8MMmM-xbITSeHCg-1; Mon, 06 Apr 2020 21:16:34 -0400
X-MC-Unique: EPHvf4w8MMmM-xbITSeHCg-1
Received: by mail-wr1-f72.google.com with SMTP id e10so867257wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=aFdULbj3n/mvLfcMq1+8X/b5sk79TeuFz7qWaFJgXTk/iIVAF27SzK0Od21LseqmKF
         TFLoDWPF71PToP8V1CPc0pEqa8jtLzCylpGW4mFJgie/ku22eGYjW4vOX1MDNjT8Y2W0
         MhOocDsbHff5CDYNq0sW6AQA2sW1Xvaocyy/gyMQz7+YsNTs5+eTcR0smlN4xKnlRDlP
         s/k+iGp/zdJA41zGmWi8ubMNlOXND2wzUvG3h3QPHEss0RMP2c1WI1aaISE7ppD1OA9I
         1TZwY+5l7wIiteaSKCZ4kV580DKfkgTj8utWb/XxArmERyxYemBgoO1cIQv0yBgqR6Tn
         EaEA==
X-Gm-Message-State: AGi0Pub3SdeFX2pmJuAsyaUh2ChQZKhLSadyFBlzZqpPP5vMbtgoDh6I
        Br28Kt1ne8vgub610KSGuxLMVz7nGceq+iinVRkRZInZ7Oel9Hv/eOOACyIT3lAdDrXU9w6LhBo
        4BdTvjRGlL3EnfBO7pxoAVTJw
X-Received: by 2002:adf:82c5:: with SMTP id 63mr2027879wrc.312.1586222192874;
        Mon, 06 Apr 2020 18:16:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypI+JWtf7YPshaBQuWRec595zsX+nH2Kk4ZsLkTya0YF6KR2uoObNvntVD6J8RdRBlhJdc93fg==
X-Received: by 2002:adf:82c5:: with SMTP id 63mr2027870wrc.312.1586222192735;
        Mon, 06 Apr 2020 18:16:32 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id t16sm29828757wra.17.2020.04.06.18.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:32 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 02/19] tools/virtio: make asm/barrier.h self contained
Message-ID: <20200407011612.478226-3-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using abort() so let's include stdlib.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/asm/barrier.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
index d0351f83aebe..04d563fc9b95 100644
--- a/tools/virtio/asm/barrier.h
+++ b/tools/virtio/asm/barrier.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
 #if defined(__i386__) || defined(__x86_64__)
 #define barrier() asm volatile("" ::: "memory")
 #define virt_mb() __sync_synchronize()
-- 
MST

