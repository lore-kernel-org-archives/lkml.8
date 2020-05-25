Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67784C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4414A206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="QW63tyJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgEYGHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:07:06 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:43920 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgEYGHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:07:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49Vmp11fg0z9vYkP
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 59B5lYnMKfG3 for <linux-kernel@vger.kernel.org>;
        Mon, 25 May 2020 01:07:05 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49Vmp075MFz9vYxd
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:07:04 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49Vmp075MFz9vYxd
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49Vmp075MFz9vYxd
Received: by mail-il1-f197.google.com with SMTP id f65so14394770ilh.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jjGsOnu1ZjgFIvFRXq2dOPsn0xQlqdEv9AzQSBptdx8=;
        b=QW63tyJNQvRmNDXJUnWBiiF5tgN++NOy/cpqOBTcXh1TNFpVs5Tf/XQ3J7NjZS9Hrv
         o/mizuZLq77AHeEwLrWH5HjwcxB0z1Wj/JsHi8OVMH9lpY3j+PKN1tay6acd8cpa+O9d
         NEY4K4ZjbDd1mlRicS9bJoM5wTWmeVRhnuOYNtRgdLy+LO6h1Dqq9i4XFxuqw8IOrVBT
         nB2ADoLToFRnLNmXGsizWOL3sL/8jcazct7ig5DLopUWyDAKqNofTpxNJq/24m6FAe8b
         TP693U3B6swbcE/e0dPM3NQ/PndjFNMVkm+fMC+Kav3KfXBSdO04Szj7CU3yoPmZYzel
         KaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jjGsOnu1ZjgFIvFRXq2dOPsn0xQlqdEv9AzQSBptdx8=;
        b=fJJShdOnGRKAf79CrCQ505X4F07dpsGEGXF89xpqOzgI34RRc3W1m6T8UZZYladOnM
         dGQUhjDO7uga0UfEMVplfgzISmAdlkm3cEHQ68aTEQgu7cQM3NXoWGqdSCursLk3klKm
         XUAa5+f9xK9zqK0q0Z593PAQDCZEUz5M7I2NNuvr/grdLuM750ZLa8DK0DoqNfNHVKSm
         8ZlSiJ4uoVw1118x1LaTuoyyoVvq3KOyqpQB6LIItwPA59PgWlFhKONROzUcyYUUuds3
         7OMC0IiqNJDuPa08CULw/eSK529/b3Wry1yuvTc1ylhnHuEImkERoruMMAkas2ESWP7a
         6JtA==
X-Gm-Message-State: AOAM5324qYQjM1Mye/V7nV0zNKX92iA+9vLjFJZ1vzQHDxHs/cyWr1pm
        5poHnPEj7r/PajYL8vzxffc/J4OaZZqSuqtMx0+mlZwV6XxkCs9mOu1rjeC9px09sFI7HYvXXfn
        jtMusY5KDA5y4gGBpzdmjNdmIqiCC
X-Received: by 2002:a92:c609:: with SMTP id p9mr23541461ilm.243.1590386824557;
        Sun, 24 May 2020 23:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyecTG+zzDarmVarZgvCIsIzQrqhEsFq+h2Ch+VoSyrxcuTA2gmgrIjR4q3Y2rcA62/pamI/g==
X-Received: by 2002:a92:c609:: with SMTP id p9mr23541447ilm.243.1590386824207;
        Sun, 24 May 2020 23:07:04 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id w70sm9062759ili.78.2020.05.24.23.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 23:07:02 -0700 (PDT)
From:   wu000273@umn.edu
To:     dledford@redhat.com
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] RDMA/core: fix missing release in add_port.
Date:   Mon, 25 May 2020 01:06:56 -0500
Message-Id: <20200525060656.2478-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function add_port(), pointer p is not released in error paths.
Fix this issue by adding a kfree(p) into the end of error path.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/infiniband/core/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 087682e6969e..04a003378dfc 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1202,6 +1202,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 
 err_put:
 	kobject_put(&p->kobj);
+	kfree(p);
 	return ret;
 }
 
-- 
2.17.1

