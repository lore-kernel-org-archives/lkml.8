Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F54C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06772076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um/nxUAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHCNsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:48:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30176 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726785AbgHCNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596462521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=SMxVmqh9+IpJqntX4TYmN4Y+TTmVHJNY5eblJs9DUyI=;
        b=Um/nxUAC1qB4cQfQL5bK5OEqDTuEpy/BmMl/5LKCPgISS75heJhk+3aQJIygDm+6Ao6nt9
        iKyNSp+ExCi1QiRJUzG7ttgID9ZRAXys4cXNaxt55YOxhRh3HjIJRkLKhvyHCQjgbCIGqr
        xA96mNggB5/kMX0nCD1voEdARP6foms=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-Mr_LVldAOhaDOQCZ2AR_Aw-1; Mon, 03 Aug 2020 09:48:39 -0400
X-MC-Unique: Mr_LVldAOhaDOQCZ2AR_Aw-1
Received: by mail-qv1-f71.google.com with SMTP id j13so17036286qvi.17
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 06:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SMxVmqh9+IpJqntX4TYmN4Y+TTmVHJNY5eblJs9DUyI=;
        b=bDp/En0Szv83SzvTIdvvfe6hxLhf30XMdjBrBCmSWTsdLGM/8AQx+SomZfZR8V3Mac
         AYav0OkZFpRXB1HDCUMm74iJYvNzssHBC3Jn5KaPV7VFCVqC+xo73lBkUR+AiNOiOZgJ
         31jUbCihRpNvhiDVszLFP/aE5K+ChHmr8fWqfk4JyrzoAbe/V33fYUaRQJ73Yi+B7k5X
         hBrGPpdmGOBrzOKX3uTK9EenbxceV3oaR5p20utLy3+riEuc/q+ORJpyd7xju/cKVCnJ
         1c9DfumJBEg+LABswkKisE2j3bkUJaukopv29mopnYAcs9UlKJgbr9V+//ekwa1e8vuF
         1t2A==
X-Gm-Message-State: AOAM533+nQ9JthnMI3gwwxi4Tz+2OOVtdGr15gZWy10h4HHA25BIR8sJ
        5MxMYzEiT9VCACeZetFXLaNvDYgx8kfb0Fay4SUdgeop4xtMtGEh2gWi+wbEDpGBDwJQR3vLsc9
        XwOTOMytJAaPEYeM0YwQHRHxl
X-Received: by 2002:a37:90e:: with SMTP id 14mr16647332qkj.102.1596462519487;
        Mon, 03 Aug 2020 06:48:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Q9H9YNB/cgP7w/wWSAvOIBiIgVexrNtMfORoaMNYcUfqssZruqZR5pgv924elJAriQdwDA==
X-Received: by 2002:a37:90e:: with SMTP id 14mr16647309qkj.102.1596462519240;
        Mon, 03 Aug 2020 06:48:39 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d46sm22820662qtk.37.2020.08.03.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 06:48:38 -0700 (PDT)
From:   trix@redhat.com
To:     nick@shmanahar.org, dmitry.torokhov@gmail.com,
        ezequiel@collabora.com, bleung@chromium.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] input: atmel_mxt_ts: fix double free
Date:   Mon,  3 Aug 2020 06:48:32 -0700
Message-Id: <20200803134832.6290-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

atmel_mxt_ts.c:1850:2: warning: Attempt to free released memory
        kfree(id_buf);
        ^~~~~~~~~~~~~

The problem is with this code block

data->raw_info_block = id_buf;
...
error = mxt_parse_object_table(data, id_buf + MXT_OBJECT_START);
if (error) {
	dev_err(&client->dev, "Error %d parsing object table\n", error);
	mxt_free_object_table(data);
	goto err_free_mem;
}

mxt_free_object_table() frees id_buf

kfree(data->raw_info_block);

So skip over the second free

Fixes: 068bdb67ef74 ("Input: atmel_mxt_ts - fix the firmware update")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 6b71b0aff115..1cc0f492f4f4 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1839,7 +1839,7 @@ static int mxt_read_info_block(struct mxt_data *data)
 	if (error) {
 		dev_err(&client->dev, "Error %d parsing object table\n", error);
 		mxt_free_object_table(data);
-		goto err_free_mem;
+		goto err_free_mem1;
 	}
 
 	data->object_table = (struct mxt_object *)(id_buf + MXT_OBJECT_START);
@@ -1848,6 +1848,7 @@ static int mxt_read_info_block(struct mxt_data *data)
 
 err_free_mem:
 	kfree(id_buf);
+err_free_mem1:
 	return error;
 }
 
-- 
2.18.1

