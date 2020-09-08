Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9661C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7900E20708
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592254;
	bh=NqMaoRw+5/BsIKvTRlZSxaEi2PjZWGU9pYqi2JqcjVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J6p6MvSY2bCkKrZ9uYyHcHdOnc4euMV5e/Gds1RNYB+MBQ+o+/zmaUMROnPJK8DUn
	 tzM3wYVdmi72eQ2hGml2lePGKKkhz1iP+4wPvnUL4sbel7MVrTxF6dZ4hZfeOSNfTa
	 Wni57so7fYD6EQVcTKykrB+7G2VdA7xyLCba2eqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgIHTKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731228AbgIHQFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:05:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2770F229C4;
        Tue,  8 Sep 2020 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579966;
        bh=NqMaoRw+5/BsIKvTRlZSxaEi2PjZWGU9pYqi2JqcjVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCQyvzSZTngePZrtJTSrJ2+si+OXoi76GMDb8jr0h4uCQ3nkLtoVAOgv7N09Ve6u9
         mZUdlhWVbXIVb9I3cA9NhI1lCDoSwZAqW198mFpo9Qw2faXqUhwZOeVbgOM1HAJKke
         1lPawg0ohyn42hZirYD0f/b6XJzR9G57DteqtOSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 104/129] media: rc: do not access device via sysfs after rc_unregister_device()
Date:   Tue,  8 Sep 2020 17:25:45 +0200
Message-Id: <20200908152235.032347423@linuxfoundation.org>
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

From: Sean Young <sean@mess.org>

commit a2e2d73fa28136598e84db9d021091f1b98cbb1a upstream.

Device drivers do not expect to have change_protocol or wakeup
re-programming to be accesed after rc_unregister_device(). This can
cause the device driver to access deallocated resources.

Cc: <stable@vger.kernel.org> # 4.16+
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/rc/rc-main.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1256,6 +1256,10 @@ static ssize_t store_protocols(struct de
 	}
 
 	mutex_lock(&dev->lock);
+	if (!dev->registered) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
 
 	old_protocols = *current_protocols;
 	new_protocols = old_protocols;
@@ -1394,6 +1398,10 @@ static ssize_t store_filter(struct devic
 		return -EINVAL;
 
 	mutex_lock(&dev->lock);
+	if (!dev->registered) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
 
 	new_filter = *filter;
 	if (fattr->mask)
@@ -1508,6 +1516,10 @@ static ssize_t store_wakeup_protocols(st
 	int i;
 
 	mutex_lock(&dev->lock);
+	if (!dev->registered) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
 
 	allowed = dev->allowed_wakeup_protocols;
 


