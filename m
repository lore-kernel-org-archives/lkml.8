Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EBDC54FD1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A73206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585057455;
	bh=1nHoIlvAAtgS9/1HbiXy6FKLACLGKOljzYG5G1rnyUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+vZsHBoJPPBjz56TKLmmXlkLmW1DThtXiS/mawypOjgxtjjvkYiFpZtmD1EqhLSv
	 18goqoPxELb7pldf0vpSBSd4V9+dkmzkcf5Q/MMHHPecodiYgf3XjO0vNT33VJVWc+
	 MM1CgIwR19BWXaKgy/v9vONJ27I3I4UhxW5g3Uyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgCXNoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgCXNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:20 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6F221924;
        Tue, 24 Mar 2020 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057399;
        bh=1nHoIlvAAtgS9/1HbiXy6FKLACLGKOljzYG5G1rnyUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZNu6eQGDwNRn29cvysnV8SePP7I9FZpLgnoZEACXXUbSw1hYXfB9NjJntF4FfnrV
         ONmxMJzDAwNaBUf79a8Hydq+qXgeHm2E5ArFD3uagwv0u9iTn+2UpT2fzZtFrMPWXV
         ZaUmSZf70pJ5IIemRXMg8RQGb9e6exAbJNRjnHXQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjpt-0025sE-8X; Tue, 24 Mar 2020 14:43:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 20/20] media: Kconfig: on !EMBEDDED && !EXPERT, enable driver filtering
Date:   Tue, 24 Mar 2020 14:43:13 +0100
Message-Id: <a308d449c0ca3f808fe9d0e88dbc4e3cbfea2075.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advanced and embedded users know what to do, so, by default,
they will likely want to be able to open the entire set of
Kconfig media options.

Normal "poor" users usually needs more help when setting
stuff, so let's open an more simplified version to them by
default.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 81259287ffa3..ef71cc03c1c5 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -21,6 +21,7 @@ if MEDIA_SUPPORT
 config MEDIA_SUPPORT_FILTER
 	bool "Filter devices by their types"
 	depends on MEDIA_SUPPORT
+	default y if !EMBEDDED && !EXPERT
 	help
 	   Configuring the media subsystem can be complex, as there are
 	   hundreds of drivers and other config options.
-- 
2.24.1

