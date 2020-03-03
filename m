Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7010DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319122465E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR50jNav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCCCgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:36:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36829 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgCCCgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:36:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id i13so681154pfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 18:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RMQ9gygXU0j/rnN/vo74F76HOdw/OIND39QkStwRaA8=;
        b=fR50jNav/kAWk1v0287lRUj1jc1aa0QdrgtIPfyt87jXJNcjxBEmxtKKul9aVO4P0V
         dXa6SP3xeCChmFyptwM8yhWl8o1PBgXnKPBfEAVfcEqyhltOL+ulZsZyWFx/TxV1i/aZ
         o0q46MY/Gh0w60pQcPMcRlCufqOdjz8Og5ph1CA7OXkU2AogDgyzaK+MUJNmaoDLzwFx
         lyxsWeNg2+LNOadMoz3gOHwTeW60AxgPHw0iLnyz8IXusJcSRIuQCpSp2ABTDNqOtJSe
         qZ2oQVr1bZaG0b500IxSkfLF7nl0QLpONckq/yM19biE5CMwlPqJgWYsXyuaPYuLbss2
         L2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RMQ9gygXU0j/rnN/vo74F76HOdw/OIND39QkStwRaA8=;
        b=BAqCaYpKZJUApQCUNiOc4WPbj6FVl5PsYzHNHlx6x3DmMrlBbsMq9MSxX6J6PpKDTT
         R4x4PeJMIa6c48L6EIUNs0xL9NPVSLgOSITe76rQpP3oTAN/OZLPnzYiZHlDZu1qyEi6
         kaPaDniN+k1PYes3wLegVEN24/7yH1qX2cx0SG34XuqXAsR+uBovYa7UMz3gbPysBGu3
         6UiCQlgkng635s9Erb+8HABG7gwOQWtg7ff11dEyXwkJzSJPQcEFb+LuHvwq7XogZXqq
         BnZKzatwXwlcvNJZ6BjbfPik4VItGF+I8J27mJF77iKO/YUQVWi5JVHp7k+bOyOxM9UW
         zR7w==
X-Gm-Message-State: ANhLgQ2+TIjwAPU/DHPXb95YEdr123DMjwbLj1tU3QALP8y6K1P+5n3O
        3JExl0jXXeHspKuXnnNuNLvlXvt1N68=
X-Google-Smtp-Source: ADFU+vt0FkANtpknOcwjsq6RStbK5ZqMwLKwMhbFQQ2R+JU6veW/0N4bsHoa5vdOKnbdv6RUc9/u4Q==
X-Received: by 2002:a63:f74a:: with SMTP id f10mr1900596pgk.360.1583203013723;
        Mon, 02 Mar 2020 18:36:53 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id q66sm23317925pfq.27.2020.03.02.18.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 18:36:53 -0800 (PST)
From:   Junyong Sun <sunjy516@gmail.com>
X-Google-Original-From: Junyong Sun <sunjunyong@xiaomi.com>
To:     mcgrof@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, sunjunyong@xiaomi.com
Subject: [PATCH v2] firmware: fix a double abort case with fw_load_sysfs_fallback
Date:   Tue,  3 Mar 2020 10:36:08 +0800
Message-Id: <1583202968-28792-1-git-send-email-sunjunyong@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_sysfs_wait_timeout may return err with -ENOENT
at fw_load_sysfs_fallback and firmware is already
in abort status, no need to abort again, so skip it.

This issue is caused by concurrent situation like below:
when thread 1# wait firmware loading, thread 2# may write
-1 to abort loading and wakeup thread 1# before it timeout.
so wait_for_completion_killable_timeout of thread 1# would
return remaining time which is != 0 with fw_st->status
FW_STATUS_ABORTED.And the results would be converted into
err -ENOENT in __fw_state_wait_common and transfered to
fw_load_sysfs_fallback in thread 1#.
The -ENOENT means firmware status is already at ABORTED,
so fw_load_sysfs_fallback no need to get mutex to abort again.
-----------------------------
thread 1#,wait for loading
fw_load_sysfs_fallback
 ->fw_sysfs_wait_timeout
    ->__fw_state_wait_common
       ->wait_for_completion_killable_timeout

in __fw_state_wait_common,
...
93    ret = wait_for_completion_killable_timeout(&fw_st->completion, timeout);
94    if (ret != 0 && fw_st->status == FW_STATUS_ABORTED)
95       return -ENOENT;
96    if (!ret)
97	 return -ETIMEDOUT;
98
99    return ret < 0 ? ret : 0;
-----------------------------
thread 2#, write -1 to abort loading
firmware_loading_store
 ->fw_load_abort
   ->__fw_load_abort
     ->fw_state_aborted
       ->__fw_state_set
         ->complete_all

in __fw_state_set,
...
111    if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED)
112       complete_all(&fw_st->completion);
-------------------------------------------
BTW,the double abort issue would not cause kernel panic or create an issue,
but slow down it sometimes.The change is just a minor optimization.

Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
---
changes in v2:
 - modify the commit log of patch
---
 drivers/base/firmware_loader/fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 8704e1b..1e9c96e 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -525,7 +525,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
 	}
 
 	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
-	if (retval < 0) {
+	if (retval < 0 && retval != -ENOENT) {
 		mutex_lock(&fw_lock);
 		fw_load_abort(fw_sysfs);
 		mutex_unlock(&fw_lock);
-- 
2.7.4

