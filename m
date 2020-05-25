Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13560C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E3E20890
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="jPH55+5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbgEYOMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:12:36 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:37808 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388855AbgEYOMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=e35Z1aZcBpO4FjT4/OfXhJlClEKE3GlteSXg77ztYqc=; b=j
        PH55+5TSZQKrRnRs/Q6BFmo4bAVedI3XsuUqmNPn+LSJw31h84UiM5/J8FEVXMqf
        6LgFoXk15SpIWDz00Fw8zirS4DN5oG6nUFUFAEPeCFsjcl2omNwKkGfSnLFs6Mnk
        ZrijSSneX648u0Oq5LuS57tHUXaFHZkTkUu9heakeo=
Received: from localhost.localdomain (unknown [223.73.184.21])
        by app2 (Coremail) with SMTP id XQUFCgC3v+M90stetAqpAg--.14499S3;
        Mon, 25 May 2020 22:12:15 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] afs: Fix afs_cb_interest refcnt leak in afs_select_fileserver()
Date:   Mon, 25 May 2020 22:11:26 +0800
Message-Id: <1590415886-52353-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgC3v+M90stetAqpAg--.14499S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xuF17tF47XrWrZFy3CFg_yoW8Jw1Dpr
        4rCw1DKr98X348GwsxJa1rXa4rX393Xw42kFZxWw1rZws8CF4avr1vqryvgFW7u395Aw4U
        XF18K34Y9FZ8CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOlksUU
        UUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_select_fileserver() invokes afs_get_cb_interest(), which returns a
reference of the specified afs_cb_interest object to "fc->cbi" with
increased refcnt.

The reference counting issue happens in one exception handling path of
afs_select_fileserver(). When error occurred in
afs_wait_for_fs_probes(), the function forgets to decrease the refcnt
increased by afs_get_cb_interest(), causing a refcnt leak.

Fix this issue by calling afs_put_cb_interest() when error occurred in
afs_wait_for_fs_probes().

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/afs/rotate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 2a3305e42b14..f73af16cdb92 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -357,8 +357,10 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	_debug("pick [%lx]", fc->untried);
 
 	error = afs_wait_for_fs_probes(fc->server_list, fc->untried);
-	if (error < 0)
+	if (error < 0) {
+		afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
 		goto failed_set_error;
+	}
 
 	/* Pick the untried server with the lowest RTT.  If we have outstanding
 	 * callbacks, we stick with the server we're already using if we can.
-- 
2.7.4

