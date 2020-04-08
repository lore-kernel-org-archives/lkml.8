Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C07C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514D120820
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360939;
	bh=kEy4QClsDKqYpuy6jSsVkkfgbzM9x8NxA08DUYZUD4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hGzdGtnKIoNfS8vS0sdTJaWYtENXpOMkG5U+LoGlo/2WCRigf6CNVmmRnnd3xF2G1
	 cPkYljCsDoVHntILcb2J8VJKIZbcuRcu5t23Ev4MDp4mlctewgme8HyJBClAbu/fn1
	 QTx4/srX/BfNWgdX9Qc45B3X+0/5anel9Oyl/Pck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgDHPs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729620AbgDHPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F34B212CC;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=kEy4QClsDKqYpuy6jSsVkkfgbzM9x8NxA08DUYZUD4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLF4PpVLKQgEDnLiFuvvYM5lBC5QFyyZMVUMwonVPgxMLClLz4EpGaIJ3J85vqcKB
         UXZ96AaqI2utO+Qg8nwHHIOV+uZkusgZycq2y25KeRpptuyhzkytPQIuHnlkB0hNeC
         yTOCYnzfaSVEy3btF5hkKOcCocZP+3opjC2TAWTI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cB1-ES; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH 10/35] firewire: firewire-cdev.hL get rid of a docs warning
Date:   Wed,  8 Apr 2020 17:46:02 +0200
Message-Id: <9953f9ef2982babd4c6128af4566a8bb3e416fba.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning:

	./include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.

is because %FOO doesn't work if there's a parenthesis at the
string (as a parenthesis may indicate a function). So, mark
the literal block using the alternate ``FOO`` syntax.

Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/uapi/linux/firewire-cdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 1acd2b179aef..7e5b5c10a49c 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -308,7 +308,7 @@ struct fw_cdev_event_iso_interrupt_mc {
 /**
  * struct fw_cdev_event_iso_resource - Iso resources were allocated or freed
  * @closure:	See &fw_cdev_event_common;
- *		set by %FW_CDEV_IOC_(DE)ALLOCATE_ISO_RESOURCE(_ONCE) ioctl
+ *		set by``FW_CDEV_IOC_(DE)ALLOCATE_ISO_RESOURCE(_ONCE)`` ioctl
  * @type:	%FW_CDEV_EVENT_ISO_RESOURCE_ALLOCATED or
  *		%FW_CDEV_EVENT_ISO_RESOURCE_DEALLOCATED
  * @handle:	Reference by which an allocated resource can be deallocated
-- 
2.25.2

