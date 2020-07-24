Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5222206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVeYJqvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGXGCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:02:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37936 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGXGCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 02:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595570571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5dJ1ko+Hxt904icfu36t9njfjgY/TQOjFzaPPRekjr8=;
        b=XVeYJqvJrgYQvAwI+VmUWgVYRhubGPersn3qElOhIxammyT3Hr9UQidUTRHVjqE/Zhk0g9
        0jOZ4cTLmvW5kvd40+IzPLP4cIQI6FQ1wtDyj9FtmWGLsoWWgHsne0fqT3vWmwPQbBOReq
        Jx9sgOiF/LFMTLAE6csFbtHu/Cb8BwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-2niQJxB9NlWBoJhlOzpP2g-1; Fri, 24 Jul 2020 02:02:49 -0400
X-MC-Unique: 2niQJxB9NlWBoJhlOzpP2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9928B57;
        Fri, 24 Jul 2020 06:02:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.121])
        by smtp.corp.redhat.com (Postfix) with SMTP id EAC3A380;
        Fri, 24 Jul 2020 06:02:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 24 Jul 2020 08:02:47 +0200 (CEST)
Date:   Fri, 24 Jul 2020 08:02:44 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     syzbot <syzbot+e7a125aff38791d8cb65@syzkaller.appspotmail.com>
Cc:     christian@brauner.io, davej@codemonkey.org.uk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        liuzhiqiang26@huawei.com, paul.gortmaker@windriver.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in ptrace_stop
Message-ID: <20200724060243.GA17209@redhat.com>
References: <00000000000069316005ab2306cc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000069316005ab2306cc@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, syzbot wrote:
>
> do not call blocking ops when !TASK_RUNNING; state=8 set at [<00000000076362f5>] ptrace_stop+0x0/0x9e0 kernel/signal.c:2054
> WARNING: CPU: 1 PID: 17054 at kernel/sched/core.c:6883 __might_sleep+0x135/0x190 kernel/sched/core.c:6883

#syz fix: sched: Fix race against ptrace_freeze_trace()

