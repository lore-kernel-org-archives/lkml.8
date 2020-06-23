Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5199AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2011D20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943990;
	bh=xlGFGp69053SdoDQvg0jjtckRZObmKizq7MUoMM0yy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=srAeUMXUeK7QFmtCaiULfRm6GKDdze9aCuURq7RIq4yM+7DzNX9tWi9Ha3FsO68oK
	 JB+MOn+oZBRim7dhcWBHbEiL03AwCXN+JdOjXCfHs8d69jO2Qo1HhXPJwXznnMgVrg
	 Ui0omBjDOjKSKjZh7JBJaLHpdmX8C318KOTjPDTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbgFWU02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390633AbgFWU0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:26:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A1720702;
        Tue, 23 Jun 2020 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943976;
        bh=xlGFGp69053SdoDQvg0jjtckRZObmKizq7MUoMM0yy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRz5+ED2FEe6hjo/UE0lJMXFumvyer58MksQMoFuvX0BUtSihUbV9skQqF+bTCrfB
         /liLoBH/jpP91tUFffEjzCzLRyELD4sbci69iqe9fAIKdQMH9Ks6VVZndfAuuSj6VG
         gZ15mNfizGar32fiQzx7pY9nBkVLkSQsPRYH7I+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 097/314] staging: gasket: Fix mapping refcnt leak when put attribute fails
Date:   Tue, 23 Jun 2020 21:54:52 +0200
Message-Id: <20200623195343.485555282@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 57a66838e1494cd881b7f4e110ec685736e8e3ca ]

gasket_sysfs_put_attr() invokes get_mapping(), which returns a reference
of the specified gasket_sysfs_mapping object to "mapping" with increased
refcnt.

When gasket_sysfs_put_attr() returns, local variable "mapping" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one path of
gasket_sysfs_put_attr(). When mapping attribute is unknown, the function
forgets to decrease the refcnt increased by get_mapping(), causing a
refcnt leak.

Fix this issue by calling put_mapping() when put attribute fails due to
unknown attribute.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Link: https://lore.kernel.org/r/1587618895-13660-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/gasket/gasket_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index 5f0e089573a29..ad852ea1d4a92 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -339,6 +339,7 @@ void gasket_sysfs_put_attr(struct device *device,
 
 	dev_err(device, "Unable to put unknown attribute: %s\n",
 		attr->attr.attr.name);
+	put_mapping(mapping);
 }
 EXPORT_SYMBOL(gasket_sysfs_put_attr);
 
-- 
2.25.1



