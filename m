Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DE2C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521B82087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592183;
	bh=YZtkJSEijSSoBIAR5gokSABzm8BeI5DjS+qu+jTiRe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yIq2g/NYAGM8gA/yJhM+L/lY9/OGzzda+tWGWEdPdJVO2YfBsUA+2Ar4Bo4NnNKkd
	 NFPqYqj2rTGRMuf3THSRYGV9eGfEmYwnrHFD3J3k9wd4RiYcVSTTP1apbqoakTVU/6
	 Pv9J9dn2+eeL8z9v28VqR7Hf+usRJYSfOnsCBRis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbgIHTJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730532AbgIHQGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:06:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE2523DB3;
        Tue,  8 Sep 2020 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579995;
        bh=YZtkJSEijSSoBIAR5gokSABzm8BeI5DjS+qu+jTiRe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5GzVT1eFw7+AZwMjs8/gFUd6VXGI4/ddZSGpqMvtznQHnNdl82YLgv5HVtYFXVf4
         boqdomP2jYDczZn9WAA6rJLa/VqK/6NgQFqyMFC4DG4cAD4TyaDDZIpfgFHUXizmIE
         Q3bl1S6PQGTMeAZiQt1aJu+nzjv88ZyjAESVsT8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 118/129] dm thin metadata:  Avoid returning cmd->bm wild pointer on error
Date:   Tue,  8 Sep 2020 17:25:59 +0200
Message-Id: <20200908152235.750106059@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
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
@@ -739,12 +739,16 @@ static int __create_persistent_data_obje
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


