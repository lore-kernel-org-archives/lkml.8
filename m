Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4D32078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbgFWV5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:57:10 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57152 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:57:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqui-0004Gk-3i; Tue, 23 Jun 2020 15:57:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnquh-000355-0k; Tue, 23 Jun 2020 15:57:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:52:43 -0500
In-Reply-To: <87pn9u6h8c.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 19 Jun 2020 13:30:27 -0500")
Message-ID: <87r1u5laac.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnquh-000355-0k;;;mid=<87r1u5laac.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+sR5+PifQoLRkh+IWaUoEkbEI1rJTseHo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 0/6] exec: s/group_exit_task/group_exec_task/ for clarity
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is a variable tsk->signal->group_exit_task that is only truly used
in de_thread.  These changes modify the coredump code and the
signal_group_exit() function to stop using group_exit_task, and rename
the group_exit_task variable to group_exec_task.

In addition as I think Linus was asking an additional signal flag is
added called SIGNAL_GROUP_DETHREAD, and that flag is used in the
function signal_group_exit() so that only signal->flags needs to be
tested.

Eric W. Biederman (6):
      signal: Pretty up the SIGNAL_GROUP_FLAGS
      exec: Lock more defensively in exec
      signal: Implement SIGNAL_GROUP_DETHREAD
      signal: In signal_group_exit remove the group_exit_task test
      coredump: Stop using group_exit_task
      exec: Rename group_exit_task group_exec_task and correct the Documentation

 fs/coredump.c                |  2 --
 fs/exec.c                    | 22 ++++++++++++++++------
 include/linux/sched/signal.h | 33 +++++++++++++++++----------------
 kernel/exit.c                |  4 ++--
 4 files changed, 35 insertions(+), 26 deletions(-)
