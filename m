Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C34C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD568206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgEEQNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbgEEQNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:13:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 380E5ABF4;
        Tue,  5 May 2020 16:13:12 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 7/7] sysvipc_find_ipc should increase position index
References: <b7a20945-e315-8bb0-21e6-3875c14a8494@virtuozzo.com>
X-Yow:  C'MON, everybody!!  I've flown in LESLIE GORE and two dozen KOSHER
 BUTCHERS!  They'll be doing intricate MILITARY MANEUVERS to the
 soundtrack from "OKLAHOMA"!!
Date:   Tue, 05 May 2020 18:13:08 +0200
In-Reply-To: <b7a20945-e315-8bb0-21e6-3875c14a8494@virtuozzo.com> (Vasily
        Averin's message of "Fri, 24 Jan 2020 10:03:12 +0300")
Message-ID: <mvm4ksupdgr.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is causing this bug (seen on 5.6.8):

# ipcs -q

------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages    

# ipcmk -Q
Message queue id: 0
# ipcs -q

------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages    
0x82db8127 0          root       644        0            0           

# ipcmk -Q
Message queue id: 1
# ipcs -q

------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages    
0x82db8127 0          root       644        0            0           
0x76d1fb2a 1          root       644        0            0           

# ipcrm -q 0
# ipcs -q

------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages    
0x76d1fb2a 1          root       644        0            0           
0x76d1fb2a 1          root       644        0            0           

# ipcmk -Q
Message queue id: 2
# ipcrm -q 2
# ipcs -q

------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages    
0x76d1fb2a 1          root       644        0            0           
0x76d1fb2a 1          root       644        0            0           

# ipcmk -Q
Message queue id: 3
# ipcrm -q 1
# ipcs -q

------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages    
0x7c982867 3          root       644        0            0           
0x7c982867 3          root       644        0            0           
0x7c982867 3          root       644        0            0           
0x7c982867 3          root       644        0            0           


As you can see, whenever an IPC item with a low id is deleted, the items
with higher ids are duplicated, as if filling a hole.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
