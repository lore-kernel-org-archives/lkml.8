Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AABC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06492078E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588412;
	bh=74s5m8HNMKP17ED9i127nA+BSSpQ6KiM7FGWrO3friM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b3pVp8HrRkpfOOyHxxQCaqyKy9FqQ3UE17VQWyHzjJ2lnsCiIFTlA+/vHr0iE1xw+
	 VIGg+6XTMTYaX4BVUhutn9zWiSD4hFeRKf2GohwzxSnLi5LZtA/gE+sSEhtuqifoiw
	 8eQ1gO4zUej+94/zGy6Bu2RTraE62bFIJJGmF0hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgIHSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbgIHQL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:11:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362392474A;
        Tue,  8 Sep 2020 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580247;
        bh=74s5m8HNMKP17ED9i127nA+BSSpQ6KiM7FGWrO3friM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JP60DvFngOv+t/rfSaKitvyPSdZwoWxGODWqEY4JiiTnhYEF73dyDks/Gb70f0tK1
         5QsfrHlczyVuXOPxnprKe8xvy+nxIlw/TQGy8m7TvQsiv2SkQKXapxobHMOgN6HMv8
         IE3pf7hlJEujPCvycisjpUiZ+D0z4yTaXd+uR168=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 77/88] dm cache metadata: Avoid returning cmd->bm wild pointer on error
Date:   Tue,  8 Sep 2020 17:26:18 +0200
Message-Id: <20200908152225.034843176@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

commit d16ff19e69ab57e08bf908faaacbceaf660249de upstream.

Maybe __create_persistent_data_objects() caller will use PTR_ERR as a
pointer, it will lead to some strange things.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-metadata.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -537,12 +537,16 @@ static int __create_persistent_data_obje
 					  CACHE_MAX_CONCURRENT_LOCKS);
 	if (IS_ERR(cmd->bm)) {
 		DMERR("could not create block manager");
-		return PTR_ERR(cmd->bm);
+		r = PTR_ERR(cmd->bm);
+		cmd->bm = NULL;
+		return r;
 	}
 
 	r = __open_or_format_metadata(cmd, may_format_device);
-	if (r)
+	if (r) {
 		dm_block_manager_destroy(cmd->bm);
+		cmd->bm = NULL;
+	}
 
 	return r;
 }


