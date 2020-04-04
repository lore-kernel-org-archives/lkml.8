Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE98C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7220737
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzUzA4z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDDCCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 22:02:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbgDDCCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 22:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585965738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEySp0igGGDaXwATMDuOfmSBnZ6a+w2LGLwT++JWohM=;
        b=dzUzA4z4/azREAQtCMyj04AVnyqw6hRKWK5HbLySvy7rvPTKO8yn6qFp8YM0k+ErbwJuDW
        jFkeGl1yK8DPxWeZ+V/gBzyjKRYBJPLTUmZFKcZZBeP81cGQcoK1Epp+0HrEqGs7bJ3Q1G
        EfXfYJNJSTXkj9lXwUtulIELDoDidWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-YclbKtIJPh2hNF82t5852Q-1; Fri, 03 Apr 2020 22:02:14 -0400
X-MC-Unique: YclbKtIJPh2hNF82t5852Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 160CC13F6;
        Sat,  4 Apr 2020 02:02:13 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-94.rdu2.redhat.com [10.10.118.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F71999E1D;
        Sat,  4 Apr 2020 02:02:12 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
 <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
 <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
 <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com>
Date:   Fri, 3 Apr 2020 22:02:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 9:30 PM, Linus Torvalds wrote:
> On Fri, Apr 3, 2020 at 4:23 PM Waiman Long <longman@redhat.com> wrote:
>> Alternatively, we could assert that only one reader can do the upgrade
>> and do a WARN_ON_ONCE() if multiple concurrent upgrade attempts is det=
ected.
> Ack, that would be best.
>
> [ And since I'm not on mobile any more, and my html email got thrown
> out by the list, I'll just repeat that by "static choice" I mean "no
> runtime decisions or flags": code that needs the unfair behavior would
> use a special unfair function ]
>
>               Linus
>
Got it.

So in term of priority, my current thinking is

=C2=A0=C2=A0=C2=A0 upgrading unfair reader > unfair reader > reader/write=
r

A higher priority locker will block other lockers from acquiring the lock=
.

Thought?

Cheers,
Longman

