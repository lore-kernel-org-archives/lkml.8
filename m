Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA6AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A200020715
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="PS5eO1W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgGZEuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:50:50 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:54133 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbgGZEuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Disposition; bh=Ay0
        qShO16vSSzMPyTIZ2QimJo7mPQjzMgrlyLffZN8o=; b=PS5eO1W8IZG2+S9N5Of
        qi5S9yP8VovPcHL5USEGSNMcUAB2CBEGHCr//XMxd09o1idYNBNqaHNRyLoRD49E
        w1iyYaofAE1FCh9k5n6jM/j0jizo8rX4Apzh+fYs3LhrEx3Aewjy7tFi+tfsf1Vr
        5+O4RLXkCv2AYCy/BTI3cVOo=
Received: from xin-virtual-machine (unknown [114.252.69.253])
        by app2 (Coremail) with SMTP id XQUFCgBnbLh3Cx1f7lljAg--.31863S3;
        Sun, 26 Jul 2020 12:49:59 +0800 (CST)
Date:   Sun, 26 Jul 2020 12:49:59 +0800
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn,
        Xin Xiong <xiongx18@fudan.edu.cn>
Subject: [PATCH] fork: fix pid refcount leaks when destroying file
Message-ID: <20200726044959.GA50544@xin-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: XQUFCgBnbLh3Cx1f7lljAg--.31863S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur17XFyxuryDCF17JrWrXwb_yoWkGwbEk3
        y8ZF4DurWvyrnY9r12ka95Xr92yw1YqrW8uwn3KFWjyF9YvayUG3sxGr9xAry8XwsrWF98
        AFn8Wr9rA34xZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
        M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUkrc-UUUUU=
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clone_flags & CLONE_PIDFD is true,the function creates a new file
object called pidfile,and invokes get_pid(),which increases the refcnt
of pid for pidfile to hold.

The reference counting issues take place in the error handling paths.
When error occurs after the construction of pidfile, the function only
invokes fput() to destroy pidfile, in which the increased refcount
won't be decreased, resulting in a refcount leak.

Fix this issue by adding put_pid() in the error handling path
bad_fork_put_pidfd.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..7cbfb2c4fce3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2319,6 +2319,7 @@ static __latent_entropy struct task_struct *copy_process(
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
 		fput(pidfile);
+		put_pid(pid);
 		put_unused_fd(pidfd);
 	}
 bad_fork_free_pid:
-- 
2.25.1

