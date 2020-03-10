Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE0C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B1D24691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844392;
	bh=A//OTV3+t80o4DfPxG+5T9Nazx04EEHsGGsu+omI/XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wLUKZMpev16ljVD1iGgtbEXvb3BxmYJ7Ej+MbRylYDN+U4WUhDw4VzVI6HjxxD5pe
	 wkOco1Ca/4D4dcxxxSxbFnhTnFf1cJrjiJxeJdDqIyh1SvN8Omn/FVlxZVTK5bvyP3
	 wKHWWmqIbKbhFbeEXS14STMHGYYPbXZB8gtksCe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCJMqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgCJMq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:46:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E46DD2468D;
        Tue, 10 Mar 2020 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844386;
        bh=A//OTV3+t80o4DfPxG+5T9Nazx04EEHsGGsu+omI/XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGRsfUXlizfVjX6q4EdMlMUkgJeTRCDOvzjEdIQ91tTVNf9/hZf/KpbXHD3V1awT7
         2Cs+JIASsxwCFBhU2uLHw8euzqNStoH5rs9xAfaeAANkXkwsOWQMz3Et+B5tixTllS
         IVN/HNxhd92jhBtG/OoYrXJyksbn01FVrNyhggzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 61/88] s390/cio: cio_ignore_proc_seq_next should increase position index
Date:   Tue, 10 Mar 2020 13:39:09 +0100
Message-Id: <20200310123621.642063499@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 8b101a5e14f2161869636ff9cb4907b7749dc0c2 ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
Link: https://lore.kernel.org/r/d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/blacklist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 9082476b51db9..4e9f794176d35 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -302,8 +302,10 @@ static void *
 cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
 {
 	struct ccwdev_iter *iter;
+	loff_t p = *offset;
 
-	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
+	(*offset)++;
+	if (p >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
 		return NULL;
 	iter = it;
 	if (iter->devno == __MAX_SUBCHANNEL) {
@@ -313,7 +315,6 @@ cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
 			return NULL;
 	} else
 		iter->devno++;
-	(*offset)++;
 	return iter;
 }
 
-- 
2.20.1



