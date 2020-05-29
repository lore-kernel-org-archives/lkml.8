Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C533C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EB22074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgE2UO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:14:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46029 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgE2UO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:14:58 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MS3zP-1jYKQZ31Ux-00TXuO; Fri, 29 May 2020 22:14:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Ajay Joshi <ajay.joshi@wdc.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] block: add 'struct gendisk' declaration
Date:   Fri, 29 May 2020 22:14:28 +0200
Message-Id: <20200529201443.429167-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ivtYp8Py2oTIXg3L4kC1QKwdqXma/ZiysiD2h1BzX0EhHte8T3s
 4lBj6kpZ2X5pszJGBBAAbZVnvgImu+ET7Fx2VejQKMPCJWryVUVUmHwBbJXFyHM3G4O2FVU
 uWacjHiejhrJOzlx7BTZlekoJUksBJOqlEVDGnBK5Mny7D0RwEl4XDTwUI7MN+f9JqE47gI
 kHmM/AzX+AUWQM+2URU1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VD5XYlZyX3Q=:0ZpCXvWgttssF7m7KZYbql
 fne2q7QM9eUg6Y7B9GkkFYaWU6WfpMJnJYddqWPKY6kXjunOG958BY63c2BY96VVVvFTWOOiR
 oS/RcssTnyB3ZeulAkMOQ+RVagpGpC/pmHAbtn81yzPMnedccHrZGSPidcNo7MPD4v+05UA5U
 URGo558YUtXPbkFju1ip0B4eQtqiQ2Ww4lN3klhY/gd63Oo8tK78VY5kYYa/dCNVV9W9Ula80
 sWa9vWmvWEbbnfe/VY4/feh1jkPsTpsNr5TwQMXtatlzsME2b+x8S8sJFvvCgkvLUeenymXau
 kRrydOIb9xJtSt1bn62Nmm0VB2fgAxkYvTTqgE0XWobnn6AAngvfUNXKo2WiCx/0oZ+gj/5nL
 zd1xrJpFGtjeiUNvFDKSv5kWA7jsTjc1cA2YEgqQDFXrW0i5MZZ8NBFXIDgc1aKnUmFyoBgJI
 s53/TztZ7Ub0iVhTiUkYkayXIcX8v2GHSz01NTG5gPRBQ+iQrauBIWRzuP2uOWmTsbyresqpa
 9k+MwEDo7ZaDoLDrraYpPLNlV4WZL1pnS4fWW/wVdA5QOcMQA5klfG61FI1M1Y3N/7sjYEg73
 Rnp8/QyIa5D4D7N1JA2haEyGmggPEwg7xG16MldHzmcEixuvYtQnwzEzIqMrKipGvgpMXA0Ik
 I+KU3/puVGvK58/cs5bBGfPIjRFxqRjR8GkpX7w2GaUljt3/TKcE6F7mDZvXn1p9muxIYiY9f
 X8NIQ+7XLcAyEUEL/aYMvkX0Wj2/Npmmig9EpyCXRej1tGDoZeCpdu434t0CVVh//hCjO/JSK
 Xq9hW0qQUg9lRtDZQ3fdYklzv8G8rds2pzyMfzbPfS+fdG7iDM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The added disk_start_io_acct() function declaration causes a warning
when CONFIG_BLOCK is disabled:

include/linux/blkdev.h:1895:41: error: declaration of 'struct gendisk' will not be visible outside of this function [-Werror,-Wvisibility]

Declare the struct tag before the function to suppress that warning.

Fixes: 956d510ee78c ("block: add disk/bio-based accounting helpers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 36568c9d030a..96cf7af86b73 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1892,6 +1892,7 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
+struct gendisk;
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 		unsigned int op);
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
-- 
2.26.2

