Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24B3C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850BD206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3xtt0At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDFVCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:02:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30404 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgDFVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g21Qo7QtPcOJEghRPDvMQfA4S9QNIdU3sAG/Fw2UsOU=;
        b=Z3xtt0AtTAC1iSLmoHZDZ/PvrtWUxfn1t7B62ksxUDAKqE/94hDGJtKnOa44EZ3cmExyk9
        OHVuyKQeWwoOJoapP6m09cwhwUKXdp34tCqAJH0fOjRSOyErnuuh7nm8WCANeeyFMfXBAY
        mUYknG5H6YFvloBjlnOEa/k8c2hf4Ww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-6gVOvJGpOcSlCRKkAB1x5Q-1; Mon, 06 Apr 2020 17:02:18 -0400
X-MC-Unique: 6gVOvJGpOcSlCRKkAB1x5Q-1
Received: by mail-wr1-f69.google.com with SMTP id o10so529674wrj.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g21Qo7QtPcOJEghRPDvMQfA4S9QNIdU3sAG/Fw2UsOU=;
        b=WKQnKrM+w83elrFE9MLER496CDN3H13/rKzOAUwGiBNsBDSXgpW51KrnbhbbvLCh50
         55Rn318mOd+rdgFicf1lbcXHCOzwM1issvYgaqL7mP6NqAwK52F+nCHgUxiwQC7FVdPA
         1y3jsidu5EcUpewFpRpkH3OwvxDTWnWaEAbRnmzYXyOT+uFJDbXaRGynMiKwJhGuZ06w
         AS+pTcMRh758VwHDhqyhVobMYaeNjOVSHZ544GPNHBb37pvym3R8rV9SLyWM/R8+BmoV
         YfhoAGQicBqlEwckagxoQjOgdRKn3ocHNkcxkYVvP91/X9087KDxhL1mNcKLbm6QLeZT
         JsQA==
X-Gm-Message-State: AGi0PuYcKDe1efeaAOnlpTQ7yXHdsOIR0iQgpone/vl+smWpCfLPWslD
        1QUXIV/NJs4n4JMeAQ4JwlqDpamA2/NkbBP6gRUbF9fbUNsTY2t1aed0SBX3j+pF8+cUKcqXebP
        N7VqSe1UtMgmZpVvzpbxWJFCJ
X-Received: by 2002:a1c:6503:: with SMTP id z3mr1333584wmb.92.1586206936903;
        Mon, 06 Apr 2020 14:02:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypI5XZ+o0zl+Xjii6R2ZxpTo8wJSgUW9OoxrS+ssp1PhHsSDSD9x+AsUIKw9dscJ9d5JnCrL9A==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr1333570wmb.92.1586206936739;
        Mon, 06 Apr 2020 14:02:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id u22sm905456wmu.43.2020.04.06.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:02:16 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:02:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 11/12] remoteproc: switch to virtio_legacy_init/size
Message-ID: <20200406210108.148131-12-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs that make this
explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..c350a01e6c4e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -322,7 +322,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	struct rproc_mem_entry *mem;
 
 	/* actual size of vring (in bytes) */
-	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
+	size = PAGE_ALIGN(vring_legacy_size(rvring->len, rvring->align));
 
 	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
 
-- 
MST

