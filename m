Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D696C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFA92245F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599836525;
	bh=QE17evv1Y7ctaurvyQ7i62yO2vJYXzF22gW2hz51gUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=scIOiJrUcoqYRdFypz15qbCMGG/eCciKO/tXjZhHyZkiEtQ/2rjbp+w1xUJZtBoZE
	 nK+4ZGGrHzJAWfQh8VNIefr4r9le2N/aORcCYKpixWE3YIo6nykqidNYMTyAJfctq5
	 cRVEB0HSan+wgbWVgRS5X3xRLp4v7zGjYACtmooE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgIKPBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgIKNCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:02:20 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E43422242;
        Fri, 11 Sep 2020 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829050;
        bh=QE17evv1Y7ctaurvyQ7i62yO2vJYXzF22gW2hz51gUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isTATd3BebxFqIwpN21cHbVMb8srW7cKBBC1TLYHzgktuIRAeNl2cjdYa8o3RXTfk
         WjAF8wNTfvCn7PqdvBObJMYxwMzqBQIy/ZK2icN1/4HqDHDdJenlwdQfO0rdFKuEdI
         H7XfPHYbI3sJzLlXKduQrh828xi0+cHvGt7M+Mlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.9 47/71] dm thin metadata:  Avoid returning cmd->bm wild pointer on error
Date:   Fri, 11 Sep 2020 14:46:31 +0200
Message-Id: <20200911122507.265553927@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911122504.928931589@linuxfoundation.org>
References: <20200911122504.928931589@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

commit 219403d7e56f9b716ad80ab87db85d29547ee73e upstream.

Maybe __create_persistent_data_objects() caller will use PTR_ERR as a
pointer, it will lead to some strange things.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin-metadata.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -700,12 +700,16 @@ static int __create_persistent_data_obje
 					  THIN_MAX_CONCURRENT_LOCKS);
 	if (IS_ERR(pmd->bm)) {
 		DMERR("could not create block manager");
-		return PTR_ERR(pmd->bm);
+		r = PTR_ERR(pmd->bm);
+		pmd->bm = NULL;
+		return r;
 	}
 
 	r = __open_or_format_metadata(pmd, format_device);
-	if (r)
+	if (r) {
 		dm_block_manager_destroy(pmd->bm);
+		pmd->bm = NULL;
+	}
 
 	return r;
 }


