Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C201C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F414F21548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577361;
	bh=nA+tw0V4TWF0+wj9sSPi7MxhSTizICQy93g26Qer/uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FnXT+iYhOeTOJRiQ7tUINqNSn8X6pCSTuTlcGUJw+qNe2wNe5qOMGBAZ60kxgR7qd
	 J29Lt4NbmviNkksGKNc/iJvI3kqC2oc3P3oPVwwc6gyynjZzA792iXscD6ccAI/gtr
	 QLLyOlYn3YO9MVOkTbx6HjLEbeOsoXk+jU0agj4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgFSOgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733281AbgFSOfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:35:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23EFC20CC7;
        Fri, 19 Jun 2020 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577342;
        bh=nA+tw0V4TWF0+wj9sSPi7MxhSTizICQy93g26Qer/uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKCGgsMQ3UhHZ/pq/y6rQkzgYMzsg2q9rnGE+Ml3Sl8lqQZZ2Wplb9XXri7nkAzsP
         17e/HaFjUHyr3dNb2LASTEGkAPWUQ8h2vysFmkU6PzDsjtoJm3CrBpeiCeSHDBofWW
         kPBxtWqhXwaPXkrrTh55EY9YqVvTQenbSn/ZCz/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=E4=BA=BF=E4=B8=80?= <teroincn@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 4.4 013/101] efi/efivars: Add missing kobject_put() in sysfs entry creation error path
Date:   Fri, 19 Jun 2020 16:32:02 +0200
Message-Id: <20200619141614.696225908@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit d8bd8c6e2cfab8b78b537715255be8d7557791c0 upstream.

The documentation provided by kobject_init_and_add() clearly spells out
the need to call kobject_put() on the kobject if an error is returned.
Add this missing call to the error path.

Cc: <stable@vger.kernel.org>
Reported-by: 亿一 <teroincn@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/efivars.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -585,8 +585,10 @@ efivar_create_sysfs_entry(struct efivar_
 	ret = kobject_init_and_add(&new_var->kobj, &efivar_ktype,
 				   NULL, "%s", short_name);
 	kfree(short_name);
-	if (ret)
+	if (ret) {
+		kobject_put(&new_var->kobj);
 		return ret;
+	}
 
 	kobject_uevent(&new_var->kobj, KOBJ_ADD);
 	efivar_entry_add(new_var, &efivar_sysfs_list);


