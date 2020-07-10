Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F2C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543C52078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doF2Dk/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGJLe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:34:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40170 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbgGJLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594380894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=EzC4+3Uio0btE/eT99wb28DjwFQm8PNAr1hwJ0RyCaw=;
        b=doF2Dk/zaBKv80zygCsH7ZBrni8Xt5LeQkfdf/33PlU7BuSxFOHjJyoUFHZM2ohfWMjwkK
        PwzmXZz/KTLFjBGktD9PCd+nKeWfnoVX75kayXxjSeBn28ThyxNuzZxYD1BmlJOB8955G8
        Gfzwb3GF1sT/pH4YZrqbsjPTyose+Ks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-RMmTb912MzertXFcu_Sr4A-1; Fri, 10 Jul 2020 07:34:53 -0400
X-MC-Unique: RMmTb912MzertXFcu_Sr4A-1
Received: by mail-wr1-f72.google.com with SMTP id v3so5797077wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 04:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EzC4+3Uio0btE/eT99wb28DjwFQm8PNAr1hwJ0RyCaw=;
        b=ERsUiYS3rpkfFxR/PsO5aaIME5IsDdKFTxnumCDmtZbEdgWcetybaGy5CHeKV9hBDE
         M3VyGhNV6HMcqAgIYnV6/AwsbEihXHLIFIOaAZaRdKOr0hyNseWVAY+WvkQiYaZxo6SO
         Mau1bDTztENJ0GszCGEGySFYlwWw9Uz//AWx9bx7EO/Wo5oVjDH3XhS4RIDEIEUC1ACY
         5JxFrf76eWHfic1kPMfIyRBK7cVdGB6uN8WMgkAwl5GUKwdVZOuE4ro1zpOr+L6XpzZw
         HqqajYEyhHP4jASRK/kboK5+ewsbwUmS4rylrAtwvGErMXT/ecTsIG/K3OfqBgctwABA
         Eihg==
X-Gm-Message-State: AOAM532tLahPa/XDCFSK2ANxs9QbLNvP1zizERQdZHL69G8vt7I+JuhJ
        hD3f+1gXJGBczEGKcrD0K/wrCG/m3g/rpbDmp+RAt/ojSmVwtI+ITVgPQacB8X0j8WcpKYvLNDt
        crh85M8UKMJ9qOAz6LJ24hZVX
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr4470532wmh.166.1594380891721;
        Fri, 10 Jul 2020 04:34:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx90BpB4I7EqEP/O5J2f309s9HJt8HSPK6EszINTBtjxI/xy0htX3AuOl6odIkAErop9ZzsVA==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr4470520wmh.166.1594380891509;
        Fri, 10 Jul 2020 04:34:51 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id c194sm8970921wme.8.2020.07.10.04.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:34:50 -0700 (PDT)
Date:   Fri, 10 Jul 2020 07:34:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] vop: sparse warning fixup
Message-ID: <20200710113447.427927-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vop_dc_to_vdev dropped an __iomem tag on its argument,
causing a sparse warning. Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/misc/mic/vop/vop_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 85942f6717c5..25ed7d731701 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -546,7 +546,7 @@ static int vop_match_desc(struct device *dev, void *data)
 	return vdev->desc == (void __iomem *)data;
 }
 
-static struct _vop_vdev *vop_dc_to_vdev(struct mic_device_ctrl *dc)
+static struct _vop_vdev *vop_dc_to_vdev(struct mic_device_ctrl __iomem *dc)
 {
 	return (struct _vop_vdev *)(unsigned long)readq(&dc->vdev);
 }
-- 
MST

