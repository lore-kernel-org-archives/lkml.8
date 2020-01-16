Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33506C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048D12077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197365;
	bh=RA0gC3u+M4VuPADWnkOULAiiEkP0hcTg7uSzVZvtwbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t/OA/Y0znq0j68AfTkwjYJ+q3KNNxd8SVP+CM1zHR3UmrG5d94D0xltJTkS3PP8Yb
	 YvLLRLJ7EpD//XVeJmioe+8hlC0Rg+a0mQ4/87AqYdOmRfoVArngA96ztCb74UBpLE
	 rOik0lFab2m82xYPapO3EclWvWRpCfqG7z9Pyl40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394508AbgAPR4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394068AbgAPRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:44:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F4E42474C;
        Thu, 16 Jan 2020 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196648;
        bh=RA0gC3u+M4VuPADWnkOULAiiEkP0hcTg7uSzVZvtwbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZV+Eqb0bmlM6fnx3v/Ua9ASgRQK+paOmBnmuBZ9n71ix5myYSKhJ4/xgLuOum57o
         TQXXH7luXwMZ0tRvlnWlQnXlW9DirT+TL0TiUz/9t0vHl5oTq2e7vSYSddkvctW2+F
         eJjcHWuCaScZ9E9JyaHOvMTGlVKUBTNflPm3vv1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>, xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 4.4 057/174] xen, cpu_hotplug: Prevent an out of bounds access
Date:   Thu, 16 Jan 2020 12:40:54 -0500
Message-Id: <20200116174251.24326-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 201676095dda7e5b31a5e1d116d10fc22985075e ]

The "cpu" variable comes from the sscanf() so Smatch marks it as
untrusted data.  We can't pass a higher value than "nr_cpu_ids" to
cpu_possible() or it results in an out of bounds access.

Fixes: d68d82afd4c8 ("xen: implement CPU hotplugging")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/cpu_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index f4e59c445964..17054d695411 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -53,7 +53,7 @@ static int vcpu_online(unsigned int cpu)
 }
 static void vcpu_hotplug(unsigned int cpu)
 {
-	if (!cpu_possible(cpu))
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
 		return;
 
 	switch (vcpu_online(cpu)) {
-- 
2.20.1

