Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE6C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2676122482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260456;
	bh=+zyIxA2wZ+3ko/VQnfkCiZs6xfl7S6167m35bkStRss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qlPH5htVwTAGuHXogzZwi2fAgD6+wbYxwHIBbf3APLitTokCr9nD9avkOT841v3QC
	 5SX42fSJufHcQdtalUgpquNhT8zazZOnDXTRb3TJNxYlBn73Aekum9LPYR65vUPsyc
	 io0RFKhQLDlsheAbbmFFoOUzRddKKZq2XYlqAyME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgGTPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbgGTPyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:54:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1883C2064B;
        Mon, 20 Jul 2020 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260449;
        bh=+zyIxA2wZ+3ko/VQnfkCiZs6xfl7S6167m35bkStRss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgZiCVFqZoliUU/EvQKxmnCyHdx5GgoxJG2mydk3TL+grKjTDxMC73CLRjwMjj3H8
         /ffscylQZGUUHoCIa/coA3jf/AtbwrN85AuJ9lQTylA2hLMgm/DFdZwnDbGqfo+FaU
         qzBsP/t23vRaZsqF7FNeX/4RGKoFgFm/tObRONb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wade Mealing <wmealing@redhat.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 4.19 107/133] Revert "zram: convert remaining CLASS_ATTR() to CLASS_ATTR_RO()"
Date:   Mon, 20 Jul 2020 17:37:34 +0200
Message-Id: <20200720152808.906854489@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wade Mealing <wmealing@redhat.com>

commit 853eab68afc80f59f36bbdeb715e5c88c501e680 upstream.

Turns out that the permissions for 0400 really are what we want here,
otherwise any user can read from this file.

[fixed formatting, added changelog, and made attribute static - gregkh]

Reported-by: Wade Mealing <wmealing@redhat.com>
Cc: stable <stable@vger.kernel.org>
Fixes: f40609d1591f ("zram: convert remaining CLASS_ATTR() to CLASS_ATTR_RO()")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1847832
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Link: https://lore.kernel.org/r/20200617114946.GA2131650@kroah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/zram/zram_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1802,7 +1802,8 @@ static ssize_t hot_add_show(struct class
 		return ret;
 	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
-static CLASS_ATTR_RO(hot_add);
+static struct class_attribute class_attr_hot_add =
+	__ATTR(hot_add, 0400, hot_add_show, NULL);
 
 static ssize_t hot_remove_store(struct class *class,
 			struct class_attribute *attr,


