Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED53C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C408C204EA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="TL3US7AT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGZF2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 01:28:08 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:59497 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgGZF2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 01:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Disposition; bh=i7I
        WTuXbIMWv0hCwBne9xxyRCcOriPNlgAzJOpZpCEo=; b=TL3US7ATed3gM8HMymo
        xL69dRRmyExiSXlTpMboHW1+GtUzi8iJxS6vBBf6Z9gWz6mxd8C7opbnqYCnXq3U
        wt5e7mPPGgCLrtfzs7xMmi4c8o6jnFhsIVIEp8iqJmQ6jGQ5BSgBE7Lvgzn1vZ0b
        L0pxyiEGCOe8KvNFqkGt0Tk8=
Received: from xin-virtual-machine (unknown [114.252.69.253])
        by app1 (Coremail) with SMTP id XAUFCgAnL_9kFB1fypU4Ag--.34557S3;
        Sun, 26 Jul 2020 13:28:04 +0800 (CST)
Date:   Sun, 26 Jul 2020 13:28:04 +0800
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn,
        Xin Xiong <xiongx18@fudan.edu.cn>
Subject: [PATCH] tty: fix pid refcount leak in tty_signal_session_leader
Message-ID: <20200726052804.GA51199@xin-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: XAUFCgAnL_9kFB1fypU4Ag--.34557S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fCry8tryfXFy5Zr4xJFb_yoW8Xw45pa
        15J3yjyF98GF4UGrnrJ34FgFWFga4ftF97Gryqy34UAwsxAFyfKFy3Ka4jvF1qyrs5Zr1r
        uFW2vw13AF43ZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUJb18UUUUU=
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the loop, every time when p->signal->leader is true, the function
tty_signal_session_leader() will invoke get_pid() and return a
reference of tty->pgrp with increased refcount to the local variable
tty_pgrp or return NULL if it fails. After finishing the loop, the
function invokes put_pid() for only once, decreasing the refcount that
tty_pgrp keeps.

Refcount leaks may occur when the scenario that p->signal->leader is
true happens more than once. In this assumption, if the above scenario
happens n times in the loop, the function forgets to decrease the
refcount for n-1 times, which causes refcount leaks.

Fix the issue by decreasing the current refcount of the local variable
tty_pgrp before assigning new objects to it.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
---
 drivers/tty/tty_jobctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index f8ed50a16848..9e6bf693ade1 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -212,6 +212,8 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
 			__group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
 			put_pid(p->signal->tty_old_pgrp);  /* A noop */
 			spin_lock(&tty->ctrl_lock);
+			if (tty_pgrp)
+				put_pid(tty_pgrp);
 			tty_pgrp = get_pid(tty->pgrp);
 			if (tty->pgrp)
 				p->signal->tty_old_pgrp = get_pid(tty->pgrp);
-- 
2.25.1

