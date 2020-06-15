Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960922067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203735;
	bh=YpsoInZqczjnNenwORS4J/CGQOJkV2n3MqoFDptUmuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LleLFIziYsV61UrxItzIJmH/wvJDq/B75KxMor3WkyT5NijTadqV6Ara4QE6gAZOm
	 ZuLotaE4P/cztk5xbMjtNhA6BEwupsK9HZeEW/Pwyd0hfqYuwnh8bumqYh5zfL5UvG
	 2AG2S/XQItlgbY5A2FA+IcS//GBYCqQFcfXtGDK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgFOGsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219B9208D5;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=YpsoInZqczjnNenwORS4J/CGQOJkV2n3MqoFDptUmuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H23WV4qxLsoMqm3j5HnK+E0LcvztblvcFG2vTEN3YSSJwyi8l8zqcrsKxUsS/Jx8V
         oQhwL995MECtciboau6NJkdOPVMMtFxkxd4oFLG8E0QlAabqA4LkJ3FKEE+e3qanQs
         CDK54KF+QpJhdK5jW0aaFWD5YTBh6EQ0hfQAaaA0=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009nnb-3e; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 22/29] docs: it_IT: add two missing references
Date:   Mon, 15 Jun 2020 08:47:01 +0200
Message-Id: <e6ac17a4065a892e1b64e447106178a86354796e.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there are missing references causing Sphinx warnings:

    Documentation/translations/it_IT/process/submitting-patches.rst:384: WARNING: undefined label: it_email_clients (if the link has no caption the label must precede a section header)
    Documentation/translations/it_IT/process/submitting-patches.rst:384: WARNING: undefined label: it_email_clients (if the link has no caption the label must precede a section header)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/translations/it_IT/process/management-style.rst   | 2 ++
 Documentation/translations/it_IT/process/submitting-patches.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/translations/it_IT/process/management-style.rst b/Documentation/translations/it_IT/process/management-style.rst
index 76ed074082ea..f7acee105c05 100644
--- a/Documentation/translations/it_IT/process/management-style.rst
+++ b/Documentation/translations/it_IT/process/management-style.rst
@@ -1,5 +1,7 @@
 .. include:: ../disclaimer-ita.rst
 
+.. _it_managementstyle:
+
 :Original: :doc:`../../../process/management-style`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 7c23c08e4401..94c816b4e8f8 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -1,3 +1,5 @@
+.. _it_email_clients:
+
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-- 
2.26.2

