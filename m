Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E92C2D0E8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E8E206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAATpuWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDEDpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:45:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726300AbgDEDpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586058350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6bjZYbv6VqM+RxwJTZGsFoIqwpjcB99cyO45E1FggI=;
        b=dAATpuWovw9CEzGqnAAymZHxC9aXA/oj69+C+zKJbSW+gNdknzpTOy250sXOhbOZBgQAaR
        i3WQ0q2UQHrhi/7otx7e3DGvHvz7Yq36jsfNXjzn3kOU7nMR5KhcjIIe5kVJ8YxmepECC9
        +s4iBVbaH8wnXE/VCxzirA97m2UGTgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-O11Yts25OACodvfb7RsZbg-1; Sat, 04 Apr 2020 23:45:46 -0400
X-MC-Unique: O11Yts25OACodvfb7RsZbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10C14800D50;
        Sun,  5 Apr 2020 03:45:45 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-153.rdu2.redhat.com [10.10.112.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 146E45C1B2;
        Sun,  5 Apr 2020 03:45:43 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
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
 <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com>
 <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
 <9876d04e-32c9-dcaa-545a-bfecbf07ea74@redhat.com>
 <AM6PR03MB5170E4AA9CBA36BDC87A3F43E4C50@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <59ee9556-6289-8630-f753-f1267d82f737@redhat.com>
Date:   Sat, 4 Apr 2020 23:45:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <AM6PR03MB5170E4AA9CBA36BDC87A3F43E4C50@AM6PR03MB5170.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/20 11:35 PM, Bernd Edlinger wrote:
>> To be symmetric with the existing downgrade_write() function, I will
>> choose the name upgrade_read() for the upgrade function.
>>
>> Will that work for you?
>>
> May I ask, if the proposed rwsem will also work for RT-linux,
> or will it be a normal mutex there?

Good question. RT have their own special code for rwsem. I need to take
a look at that to see if something like that is possible.

Cheers,
Longman

