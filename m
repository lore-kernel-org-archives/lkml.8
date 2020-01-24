Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACCBC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB27E2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgAXHDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 02:03:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:53158 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730310AbgAXHDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:03:18 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuszK-00085h-Oi; Fri, 24 Jan 2020 10:02:42 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/7] pstore_ftrace_seq_next should increase position index
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <51376af5-e0f2-0ff2-d664-e932153b0665@virtuozzo.com>
Date:   Fri, 24 Jan 2020 10:02:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/pstore/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 7fbe8f0..ea8799b 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -87,11 +87,11 @@ static void *pstore_ftrace_seq_next(struct seq_file *s, void *v, loff_t *pos)
 	struct pstore_private *ps = s->private;
 	struct pstore_ftrace_seq_data *data = v;
 
+	(*pos)++;
 	data->off += REC_SIZE;
 	if (data->off + REC_SIZE > ps->total_size)
 		return NULL;
 
-	(*pos)++;
 	return data;
 }
 
-- 
1.8.3.1

