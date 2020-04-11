Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B4FC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1D32075E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiutHU0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDKSVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 14:21:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23796 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbgDKSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 14:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586629270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CV+A9KFgGyBleHpbccnyLWR3WWFAZszcweg/siBgpWI=;
        b=KiutHU0kr3MiGHXbMdI1XA5Z6KUTR/TBjHBpjw2LvwPr0dUxROLR/65GMtt/9ikdOzJMU+
        rSi4ad1juLxOxBe8bsVC33+f8U5oZa8YfxkFfllZ/e88xGbD3b2p5TVVr7sUVfhH/KmR87
        3VGppwd6glGPce0rr+l5gpWd2JSpDpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-M3PtyYiiMo-H7Mwh--TO9Q-1; Sat, 11 Apr 2020 14:21:04 -0400
X-MC-Unique: M3PtyYiiMo-H7Mwh--TO9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB278107ACC4;
        Sat, 11 Apr 2020 18:20:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with SMTP id F0F1D5D9C9;
        Sat, 11 Apr 2020 18:20:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 11 Apr 2020 20:20:49 +0200 (CEST)
Date:   Sat, 11 Apr 2020 20:20:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
Message-ID: <20200411182043.GA3136@redhat.com>
References: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, Linus, et al,

by various reasons I have not been reading emails for last weeks,
I'll try to read this thread tomorrow, currently I am a bit lost.

On 04/09, Linus Torvalds wrote:
>
>  (1) have execve() not wait for dead threads while holding the cred
> mutex

This is what I tried to do 3 years ago, see

	[PATCH 1/2] exec: don't wait for zombie threads with cred_guard_mutex held
	https://lore.kernel.org/lkml/20170213141516.GA30233@redhat.com/

yes, yes, yes, the patch is not pretty.

From your another email:

>	/* if the parent is going through a execve(), it's not listening */
>	if (parent->signal->group_exit_task)
		return false;

Heh ;) see

	[PATCH 2/2] ptrace: ensure PTRACE_EVENT_EXIT won't stop if the tracee is killed by exec
	https://lore.kernel.org/lkml/20170213141519.GA30239@redhat.com/

from the same thread.

But this change is more problematic. 

Oleg.

