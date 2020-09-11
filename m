Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B606EC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642C52076D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="jHItxRDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgIKFSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:18:05 -0400
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:42373 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbgIKFSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1599801481; bh=mLmfO9KHGTwVzdxvKCaMc7ab60/ASrOKOwWiogdgsXo=;
        h=From:To:Subject:Date:Message-Id;
        b=jHItxRDsLdS/D8TW2AajPPWmgurAgPVcIx6H41NtqL1C0PUMhbCzxaxrzD9DdRpAV
         ZqgpMfv15J9BCdgHknZuUa68IxBOQFfKckiHfMryELadeGqieT6J1LEbjAGdnQQNP0
         G3ifRpJN9IGK8uyTNQzHvW+d9eGJok77o9I7jinbRCVrmXa0SSY6ZAf/cOWwHL56fv
         ZAXvPfCj+yHn0de6L0rm3t9BvwF4DtqI1V7TJ6L9Fh9sHEL9OIh6b0FwNNkVNEfBX0
         y1jdYmgON3G5o+MG85VQSBR6HZOYwS7b4JfWggl9jilzMmN0crOitiHqAX1Yq80v25
         ZR5hNpi0SPl/A==
Received: from localhost (unknown [80.214.155.133])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id DF853540358;
        Fri, 11 Sep 2020 05:18:00 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@st.com>, avolmat@me.com
Subject: [PATCH] mailbox: sti: fix struct description warnings
Date:   Fri, 11 Sep 2020 07:17:58 +0200
Message-Id: <20200911051758.31800-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_01:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=592 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2009110044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix formating of struct description to avoid warning highlighted
by W=1 compilation.

warning: cannot understand function prototype: 'struct sti_mbox_device '
warning: cannot understand function prototype: 'struct sti_mbox_pdata '
warning: cannot understand function prototype: 'struct sti_channel '

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox-sti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index 2baf69a0b81c..0f2bc09c364d 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -36,7 +36,7 @@
 #define MBOX_BASE(mdev, inst)   ((mdev)->base + ((inst) * 4))
 
 /**
- * STi Mailbox device data
+ * struct sti_mbox_device - STi Mailbox device data
  *
  * An IP Mailbox is currently composed of 4 instances
  * Each instance is currently composed of 32 channels
@@ -60,7 +60,7 @@ struct sti_mbox_device {
 };
 
 /**
- * STi Mailbox platform specific configuration
+ * struct sti_mbox_pdata - STi Mailbox platform specific configuration
  *
  * @num_inst:	Maximum number of instances in one HW Mailbox
  * @num_chan:	Maximum number of channel per instance
@@ -71,7 +71,7 @@ struct sti_mbox_pdata {
 };
 
 /**
- * STi Mailbox allocated channel information
+ * struct sti_channel - STi Mailbox allocated channel information
  *
  * @mdev:	Pointer to parent Mailbox device
  * @instance:	Instance number channel resides in
-- 
2.17.1

