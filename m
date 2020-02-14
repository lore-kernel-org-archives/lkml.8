Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA86C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D71024696
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697887;
	bh=SONkKqbwf5JAh6hTaH2JVn6iDfa5NTZtilJALl4Cgsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXFF7dGCtLNV/BKOW2p1rjko7wzi/qIylT0mHEj3YU+SlkAcU/9hbvORLHweZLQID
	 yn0SrH3fYFZN0duDnuripmIjxPsageskJ3RTmTAb8v2nx9NvPbwKOsKIzzr3KACh6W
	 TriNAePTFFtqC/ythJWJCUWIMTmwYeennkK+/AwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406304AbgBNQ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405790AbgBNQYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:24:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF7524787;
        Fri, 14 Feb 2020 16:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697442;
        bh=SONkKqbwf5JAh6hTaH2JVn6iDfa5NTZtilJALl4Cgsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjoANu1nmTwJhOYrn5Jk9eVa+2z17D2to7I7ZfqPyZ8gh2daM/qRRCSP/h3egjkvN
         9lj3WJwdPH501CqxdOB3b0HuxZFSM+o1BlZGoDF6hj0344F8sIDSSVWtxUXJoHv4aA
         fOH4B5Z06GPPVjbGsreFpN2dG1kucwlKNqqSQ+/Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 128/141] docs: i2c: writing-clients: properly name the stop condition
Date:   Fri, 14 Feb 2020 11:21:08 -0500
Message-Id: <20200214162122.19794-128-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

[ Upstream commit 4fcb445ec688a62da9c864ab05a4bd39b0307cdc ]

In I2C there is no such thing as a "stop bit". Use the proper naming: "stop
condition".

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reported-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/i2c/writing-clients | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index a755b141fa4a8..8b0de4334ae90 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -339,9 +339,9 @@ read/written.
 
 This sends a series of messages. Each message can be a read or write,
 and they can be mixed in any way. The transactions are combined: no
-stop bit is sent between transaction. The i2c_msg structure contains
-for each message the client address, the number of bytes of the message
-and the message data itself.
+stop condition is issued between transaction. The i2c_msg structure
+contains for each message the client address, the number of bytes of the
+message and the message data itself.
 
 You can read the file `i2c-protocol' for more information about the
 actual I2C protocol.
-- 
2.20.1

