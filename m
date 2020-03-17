Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2DBC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FCB20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443503;
	bh=S5G1KHBEaEL4NDBxq8BafkUPfEetq4PzQnKJ/q0Y/ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j/ov57klXNvq3kUgMnxhEKYArSKYEZFrZCCCL+/loarnxEHGvVqBBTQ9GFCz3wAAq
	 IuaQ6gosFsFzzhXh8I3vO3v632mJzPOvGxzlnFqoXJrFUrR2juFRR4qdNDEDvbViLW
	 NEbBfSZyV/8PG3JakJL/+1wKLHyS0ZJfdGINhsyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgCQLLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgCQLLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:11:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E14402073C;
        Tue, 17 Mar 2020 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443497;
        bh=S5G1KHBEaEL4NDBxq8BafkUPfEetq4PzQnKJ/q0Y/ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMR7IKxQEEDKkNPZDvojNHx03hPlZOyDGujaxrL0IEYYY2kvUqWZp1kTkyWjdnd0H
         1pLT5ua44r+ujgUhcFPcqDUwZKLH6TsnaPqBW5P1swNmLCB2uwjBH9A3LunG4PCSHz
         3/nXfA99O8VUezMRjGJt6wmAkzzxM1fe9gg9vjcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.5 094/151] ktest: Add timeout for ssh sync testing
Date:   Tue, 17 Mar 2020 11:55:04 +0100
Message-Id: <20200317103333.132377255@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 4d00fc477a2ce8b6d2b09fb34ef9fe9918e7d434 upstream.

Before rebooting the box, a "ssh sync" is called to the test machine to see
if it is alive or not. But if the test machine is in a partial state, that
ssh may never actually finish, and the ktest test hangs.

Add a 10 second timeout to the sync test, which will fail after 10 seconds
and then cause the test to reboot the test machine.

Cc: stable@vger.kernel.org
Fixes: 6474ace999edd ("ktest.pl: Powercycle the box on reboot if no connection can be made")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/ktest/ktest.pl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1383,7 +1383,7 @@ sub reboot {
 
     } else {
 	# Make sure everything has been written to disk
-	run_ssh("sync");
+	run_ssh("sync", 10);
 
 	if (defined($time)) {
 	    start_monitor;


