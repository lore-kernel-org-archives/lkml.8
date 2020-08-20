Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFCC20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919478;
	bh=VsjZbyDoFnSpuIJdUWlBT69iwFkVIb5It172DSCdcZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0/0zGY/rbEkL71Bz3PiIsY/yn6UjgnD7V3mql8nsnKVPOAi6IO/nkIf4fswZALqq
	 VHx7JuNiOL/9VALy1EfztvHOKKsmpsCPE0oiVFH8glIHFal75TWp136MLcIwHrQJQZ
	 7KzNvKdDMoFu8AM931oL1PzVEOUSY0+K/NhdMikg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgHTKbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbgHTKUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:20:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288F82076E;
        Thu, 20 Aug 2020 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918848;
        bh=VsjZbyDoFnSpuIJdUWlBT69iwFkVIb5It172DSCdcZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8WRoOwi6ix0rw3eJvsnpnuO2HLcnXK+xOnw2mjFxWkIKS/4fTGDiTb3IRukZzIzm
         grx8woxPTjpWYp1u27SpTc+CNskLY3U6vxHlS0HKShdNkSyW4VNhn+Xlk+cyYxBI3U
         4ku/H7KaIVj6DH4Moo+v1DecK2T1g7Qgsmfvtp0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 088/149] media: firewire: Using uninitialized values in node_probe()
Date:   Thu, 20 Aug 2020 11:22:45 +0200
Message-Id: <20200820092129.989276439@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 2505a210fc126599013aec2be741df20aaacc490 ]

If fw_csr_string() returns -ENOENT, then "name" is uninitialized.  So
then the "strlen(model_names[i]) <= name_len" is true because strlen()
is unsigned and -ENOENT is type promoted to a very high positive value.
Then the "strncmp(name, model_names[i], name_len)" uses uninitialized
data because "name" is uninitialized.

Fixes: 92374e886c75 ("[media] firedtv: drop obsolete backend abstraction")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/firewire/firedtv-fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/firewire/firedtv-fw.c b/drivers/media/firewire/firedtv-fw.c
index 247f0e7cb5f7f..5d634706a7eaa 100644
--- a/drivers/media/firewire/firedtv-fw.c
+++ b/drivers/media/firewire/firedtv-fw.c
@@ -271,6 +271,8 @@ static int node_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	name_len = fw_csr_string(unit->directory, CSR_MODEL,
 				 name, sizeof(name));
+	if (name_len < 0)
+		return name_len;
 	for (i = ARRAY_SIZE(model_names); --i; )
 		if (strlen(model_names[i]) <= name_len &&
 		    strncmp(name, model_names[i], name_len) == 0)
-- 
2.25.1



