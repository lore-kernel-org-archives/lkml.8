Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF2EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB85F2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670766;
	bh=DbbVi8JHa1eEPXHrLwj3ICxCD+h+VHi3eWubC5Fj7jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+ggpFuKZdlvHgKHzZYb4refM/+3BKSJq8ZUQogCuBDBLCv7ZNJ0QgptoybeiIMaS
	 CC8oC278Bi1jAAOrwOS0IXUHUiqdth3pdz7stZBEijwAFDhkF+Tk6WaDvXYkBJxBDu
	 uVlCPXvV07we1cyhe5mrn/EuAjatYE40LC0w6aT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgIIQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F59722228;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=DbbVi8JHa1eEPXHrLwj3ICxCD+h+VHi3eWubC5Fj7jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhJPN8Jtk0NBCWNDKBLJ5O9Ph3gfVoSBT71xUwASOVB9GqvAbBjd7Q54s570o5S5S
         gfwjFDuDQpIMfjTOO6buzD/PV3WGtz2qKakFwBO5NGWwAZw42Fwz3HKioNOJOj+LBL
         TFtn4Z6y0qTTQAmRqaZfmA2KgjeGbVef/6aaR26A=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXa-MR; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] docs: submitting-patches: use :doc: for references
Date:   Wed,  9 Sep 2020 16:10:54 +0200
Message-Id: <3ba405f579cf35ef2b39dd210d8ad46adc79f0ad.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two broken references at submitting-patches.rst:

	Documentation/process/submitting-patches.rst:240: WARNING: undefined label: security-bugs (if the link has no caption the label must precede a section header)
	Documentation/process/submitting-patches.rst:336: WARNING: undefined label: documentation/process/email-clients.rst (if the link has no caption the label must precede a section header)

Those are due to some recent renames and file moves.

It turns that maintaining :ref: is currently harder than using
:doc:, as we now have a script to help checking such references.

So, replace :ref: to :doc: there, making them to point to the
current file name.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/submitting-patches.rst | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 04cd41567186..58586ffe2808 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -10,13 +10,10 @@ can greatly increase the chances of your change being accepted.
 
 This document contains a large number of suggestions in a relatively terse
 format.  For detailed information on how the kernel development process
-works, see :ref:`Documentation/process <development_process_main>`.
-Also, read :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
-for a list of items to check before
-submitting code.  If you are submitting a driver, also read
-:ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`;
-for device tree binding patches, read
-Documentation/devicetree/bindings/submitting-patches.rst.
+works, see :doc:`development-process`. Also, read :doc:`submit-checklist`
+for a list of items to check before submitting code.  If you are submitting
+a driver, also read :doc:`submitting-drivers`; for device tree binding patches,
+read :doc:`submitting-patches`.
 
 This documentation assumes that you're using ``git`` to prepare your patches.
 If you're unfamiliar with ``git``, you would be well-advised to learn how to
@@ -241,7 +238,7 @@ If you have a patch that fixes an exploitable security bug, send that patch
 to security@kernel.org.  For severe bugs, a short embargo may be considered
 to allow distributors to get the patch out to users; in such cases,
 obviously, the patch should not be sent to any public lists. See also
-:ref:`Documentation/admin-guide/security-bugs.rst <security-bugs>`.
+:doc:`/admin-guide/security-bugs`.
 
 Patches that fix a severe bug in a released kernel should be directed
 toward the stable maintainers by putting a line like this::
@@ -313,9 +310,8 @@ decreasing the likelihood of your MIME-attached change being accepted.
 Exception:  If your mailer is mangling patches then someone may ask
 you to re-send them using MIME.
 
-See :ref:`Documentation/process/email-clients.rst <email_clients>`
-for hints about configuring your e-mail client so that it sends your patches
-untouched.
+See :doc:`/process/email-clients` for hints about configuring your e-mail
+client so that it sends your patches untouched.
 
 Respond to review comments
 --------------------------
@@ -333,7 +329,7 @@ for their time.  Code review is a tiring and time-consuming process, and
 reviewers sometimes get grumpy.  Even in that case, though, respond
 politely and address the problems they have pointed out.
 
-See :ref:`Documentation/process/email-clients.rst` for recommendations on email
+See :doc:`email-clients` for recommendations on email
 clients and mailing list etiquette.
 
 
-- 
2.26.2

