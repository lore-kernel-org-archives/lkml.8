Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0A8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120EA2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599587465;
	bh=MfLFAZl9T5p6DZ86QSrGRTRInrhDWe4wQ8OUWmnQi9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fUnAp+bZpRhwf8feI1Z1DQUUNQj6I8tnDIqhRT5XDL1d/gd8B40bovmBiW4rrRFI1
	 Xn2QbBoA9DhuuSaM4Rm4nFF2oHeVBiUSI/1UOZslxs5SGncVJAUN3fxygOKVycTrU6
	 2bAjKUI8B1Zd2G9btyJoGYeszcxJNxVo/JEiNgfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbgIHRvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbgIHQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85AEC248EB;
        Tue,  8 Sep 2020 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580384;
        bh=MfLFAZl9T5p6DZ86QSrGRTRInrhDWe4wQ8OUWmnQi9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fvgpq6EG3a8l76ipDi52JJBU/8q6SEfijfhO/S9/0N4F+KQf4S+cT4tfkczUoNgxs
         ZRcysw1k6d0k/1Nv1v6RWZJ86l3VXOAm3lLJuXYefLVfWxBWMJbipCFkvk12b9dIAm
         RO2WtzSp8L5jqg2bICJkeSRVvwPGazrRM5kr5UBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 55/65] dm cache metadata: Avoid returning cmd->bm wild pointer on error
Date:   Tue,  8 Sep 2020 17:26:40 +0200
Message-Id: <20200908152219.922371187@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
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
@@ -536,12 +536,16 @@ static int __create_persistent_data_obje
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


