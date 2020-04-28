Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E15DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF6E206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iU4A37lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgD1TIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:08:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47397 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728643AbgD1TIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588100930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DmkRvjwC+u8+jIYVrru4c5dbjRS9yf05sZWdTQ7YeX0=;
        b=iU4A37lzPgyn4ckDsU2JB5vV5HWRGagezU77tj58TPmUMc2IhGIykduULzMBpNvicPJfMG
        aH6lTQzQBBI62Z0KOtsWbdOLELIyUWOZ/AsOK50yt9gCvM2ECu0RXD3fTemIAVKob6Zvcq
        JILDWzi+L5+x6A1BAfqLISIh+XiTW98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-fJURyZAzM7mNEkkjzKzvDg-1; Tue, 28 Apr 2020 15:08:44 -0400
X-MC-Unique: fJURyZAzM7mNEkkjzKzvDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18F82107ACCD;
        Tue, 28 Apr 2020 19:08:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.231])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0DA2160CD3;
        Tue, 28 Apr 2020 19:08:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Apr 2020 21:08:42 +0200 (CEST)
Date:   Tue, 28 Apr 2020 21:08:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
Message-ID: <20200428190836.GC29960@redhat.com>
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com>
 <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com>
 <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28, Linus Torvalds wrote:
>
> On Mon, Apr 27, 2020 at 7:56 PM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
> >
> > was this resolved meanwhile?
>
> No. I think the tentative plan is to just apply Oleg's "don't wait for
> zombie threads with cred_guard_mutex held" patch, hopefully with that
> de_thread() moved into install_exec_creds() (right after the dropping
> of the locks).

Oops. I can update that old patch but somehow I thought there is a better
plan which I don't yet understand...

And, IIRC, Jan had some ideas how to rework the new creds calculation in
execve paths to avoid the cred_guard_mutex deadlock?

Oleg.

