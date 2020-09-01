Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0657C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7082087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980932;
	bh=vf8P7knMKxAd8czp29JUejgGx8ytmQ5ofKwx9f36CKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DMkwEWwH42hCs/lrTcLdjnfDlXUtV6R9lMazhh6j94l7HWm49Q3GLbk++sifB3eFs
	 4CDHafyd2V+pXu+7gBknYnkbG5mONnKE2Oeo6uFR3LS3KzyRPoezySAAHsnS1ZQy7+
	 1mUO8tzAuY9AVqvRG6NKLc7BR+10CyvWB25Z64Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgIAPMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbgIAPMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:12:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC74620BED;
        Tue,  1 Sep 2020 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973130;
        bh=vf8P7knMKxAd8czp29JUejgGx8ytmQ5ofKwx9f36CKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPzdBGxv6p7yghBldCS90f5hIgai74pXWO0L0wIzUzmhhSY+TasXgoxPaY7tF1iTs
         Xzt09RXK/R6P2ecbh4YSW8q1hmbjdu9hEnw0FQj8xwmibaOahTJyvjVjursCOh6Elr
         7MWVcN6Txyy+1oLfTvcU/Eq0OhgpAIrADcyfWlFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 19/62] PCI: Fix pci_create_slot() reference count leak
Date:   Tue,  1 Sep 2020 17:10:02 +0200
Message-Id: <20200901150921.706666833@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 8a94644b440eef5a7b9c104ac8aa7a7f413e35e5 ]

kobject_init_and_add() takes a reference even when it fails.  If it returns
an error, kobject_put() must be called to clean up the memory associated
with the object.

When kobject_init_and_add() fails, call kobject_put() instead of kfree().

b8eb718348b8 ("net-sysfs: Fix reference count leak in
rx|netdev_queue_add_kobject") fixed a similar problem.

Link: https://lore.kernel.org/r/20200528021322.1984-1-wu000273@umn.edu
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/slot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 429d34c348b9f..01a343ad7155c 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -303,13 +303,16 @@ placeholder:
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
+		kfree(slot);
 		goto err;
 	}
 
 	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
 				   "%s", slot_name);
-	if (err)
+	if (err) {
+		kobject_put(&slot->kobj);
 		goto err;
+	}
 
 	INIT_LIST_HEAD(&slot->list);
 	list_add(&slot->list, &parent->slots);
@@ -328,7 +331,6 @@ out:
 	mutex_unlock(&pci_slot_mutex);
 	return slot;
 err:
-	kfree(slot);
 	slot = ERR_PTR(err);
 	goto out;
 }
-- 
2.25.1



