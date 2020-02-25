Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E5BC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690452176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgBYILe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:11:34 -0500
Received: from relay.sw.ru ([185.231.240.75]:41992 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbgBYILe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:11:34 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1j6VJF-00055E-Hb; Tue, 25 Feb 2020 11:11:17 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] pstore: pstore_ftrace_seq_next should increase position
 index
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Message-ID: <0b5592a6-6589-b17e-2a33-0c1e9128c32e@virtuozzo.com>
Date:   Tue, 25 Feb 2020 11:11:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: resent to proper subsystem maintainers

In Aug 2018 NeilBrown noticed 
commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
"Some ->next functions do not increment *pos when they return NULL...
Note that such ->next functions are buggy and should be fixed. 
A simple demonstration is
   
dd if=/proc/swaps bs=1000 skip=1
    
Choose any block size larger than the size of /proc/swaps.  This will
always show the whole last line of /proc/swaps"

/proc/swaps output was fixed recently, however there are lot of other
affected files, and one of them is related to pstore subsystem.

If .next function does not change position index, following .show function
will repeat output related to current position index.

There are at least 2 related problems:
- read after lseek beyond end of file, described above by NeilBrown
 "dd if=<AFFECTED_FILE> bs=1000 skip=1" will generate whole last list
- read after lseek on in middle of last line will output expected rest of
 last line but then repeat whole last line once again. 

If .show() function generates multy-line output 
(like pstore_ftrace_seq_show() does ?)
following bash script cycles endlessly

 $ q=;while read -r r;do echo "$((++q)) $r";done < AFFECTED_FILE

Unfortunately I'm not familiar enough to pstore subsystem and was unable to
find affected pstore-related file on my test node.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283

Vasily Averin (1):
   pstore: pstore_ftrace_seq_next should increase position index

 fs/pstore/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3.1
