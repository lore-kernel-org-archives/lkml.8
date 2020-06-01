Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26764C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55A5206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4l5nIFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFAHAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgFAHAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:00:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:00:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so10387740wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7hLIyI91hWF2dAJTHAMrnXKmXiGK0r6i2OQ8DBBjsk8=;
        b=d4l5nIFs8UG2hwMXp+3CywGwO3/fwb8KmMP2bdP9TxzvSbQoXbKaiqLocEgx3NcsAJ
         rcEzL0+DtjwigY1tkJdWvsbs2P7L6XNm9I+bqm0/U4PK8DAm8RvmubEdUBHXzOMN5ci6
         ECMqLtSS+UavujWmeE73JCHXGhbZ5gfkWtrMi6rEiAkM0vQ3rJqCjzdLzScZXiBYsn4i
         e/tXNn0NDk0qJhzAiy0pa9PsQYO3IeI6f3Da+qPsvfR6mRBxnElNEx5bXUu5OJ8KzRaz
         kV4hqk2qGJDNqG0Vvbk/B2fkvimwtzQIAbIoym9cDK/bYg9CKrd6NlXi2fOT2PSBXIgG
         WsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7hLIyI91hWF2dAJTHAMrnXKmXiGK0r6i2OQ8DBBjsk8=;
        b=b8DumBAMT/GX4gGTZh2AxPOG8CTaNtilp4XmNlWgJ6MkV5ZlGgActN6cCKZLqfoA4p
         x1HxURpkOrVCGZ2VAyIJp0YQsdxirPkKhXZtKEIVTlSUx2oaGEgj4/sa7+hz7kBUS/wv
         aW+Q3lnfM0J+3xNjZb3uWAJvf9267H02dpHvZXF67Qr6ODc7qqykbE7lHH+bhDyOEAP/
         Ugc5NPrtnqc5FoE3KWNsdVzblhRcLg39p1POwKcGd48MdBOlrSgM/Cyt1lb6VBr5ccZQ
         GZsLEsCOrseaANTOULb/uonWWzqYfn2HD8Noaeqdlz5hPqKU8GRl9fSfW4U06lTmic5p
         ylMA==
X-Gm-Message-State: AOAM532G0kES6ROdW+InMRH3/6BwATpmbKnohAvl/hzS0HeU1ilvsuJj
        IFTvv1hywhmd1Gz7h9KHpw0M9+Ki
X-Google-Smtp-Source: ABdhPJwwXghL1y55/gTg8CA3fS1qJZCsodusG3LRvCsIo9FSnq2z67ZvVOal5qWvad03DOZn201uOA==
X-Received: by 2002:a5d:5744:: with SMTP id q4mr19609050wrw.137.1590994838549;
        Mon, 01 Jun 2020 00:00:38 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b8sm20629261wrs.36.2020.06.01.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 00:00:37 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/2] habanalabs: initialize variable to default value
Date:   Mon,  1 Jun 2020 09:56:47 +0300
Message-Id: <20200601065648.8775-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Fix the following smatch error in unmap_device_va():
error: uninitialized symbol 'rc'.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 4b8eed1ca513..47da84a17719 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1023,7 +1023,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
 	struct hl_va_range *va_range;
 	enum vm_type_t *vm_type;
 	bool is_userptr;
-	int rc;
+	int rc = 0;
 
 	/* protect from double entrance */
 	mutex_lock(&ctx->mem_hash_lock);
-- 
2.17.1

