Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DFEC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BAA207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cA5hZxgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgAPQFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:05:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39358 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgAPQFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:05:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so19577505qko.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ITaNl5uhW3c9BKNTq8iRAEvkIWnU2UBbLTn/vPzRoLQ=;
        b=cA5hZxgLV8TglORvyg0085ms28N2KFsehz1HccdQ+b8D6gGcE/l9pMVBsfHG2NdpZZ
         BPS5/JgO630LRfOFUn0ueikrsL6qloec0K9nrnfK0AGnXmwt5fxB6+80zoB0NSOBAMj6
         9y+wRs5ATLmhvf9SMIw2j6a3InaRYeN8hsxw8Hr5hGE1tcUhuqQjdKmTYF89pjsUoKIf
         iMUwQtQsOfKekzFlxNodWBCCjqnYhmAlysbytpovNItzcYKQBdXGn5Qgc57La8srw8Cw
         rzOUykEN01a6LSbDjOA9uNlYeaYMWqI1a+ICYuq9YFU3TlMJBRsdcLdNMHL5q/f0dDKa
         e8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ITaNl5uhW3c9BKNTq8iRAEvkIWnU2UBbLTn/vPzRoLQ=;
        b=e1FbN4GRUCBTjq/eRfk0xO7mKfIs1Mdk+NSa31jth9HmL5jtuVsJQrY6rNljHZoAC3
         vEcZRaPWlj6oV4qJzKIMvc4kksVEH6bWqXMAmT7lUaBkHKkyhqHc/oAXwkxq/HhBIMne
         p7avObPFYEEhvxEZZpj6wFN6Q+ezIvKihnpjmMBh0u/NYlY3R0gVQf4By5CZrcQdG9iD
         HUrtieez3BGZ1SnQpI4RudAwtxeaDiHq8IOubIxos0RAbYxf2DUF5CmJbiC4oZzGKnxM
         f3dA3UTLya47Z0Ou4/T35rKbna6hUuzGuG8UOgYiZInOINgpO4r5CapeIOQ4ev2RhiDT
         S6kQ==
X-Gm-Message-State: APjAAAVIwDEk2vdsm9qAsgX8zuUw7MPYUUmGcCPEFdDNjBzdzlKBj8Gh
        UfBkGgieXYwM4emOUVVXVs0Sb9SpIESf/A==
X-Google-Smtp-Source: APXvYqwHrEB389KjskFiGUF8kyhbYBlghm23dwqZDY69ig+dAuXl3+ikQWqlKYjMEOigNodubJr5WQ==
X-Received: by 2002:a37:814:: with SMTP id 20mr32808216qki.314.1579190711795;
        Thu, 16 Jan 2020 08:05:11 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b35sm11465407qtc.9.2020.01.16.08.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:05:10 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next v3] mm/hotplug: silence a lockdep splat with
 printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200116155434.GB19428@dhcp22.suse.cz>
Date:   Thu, 16 Jan 2020 11:05:07 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D469AA91-FF6A-49B8-B894-1FA04C59AA3B@lca.pw>
References: <20200115172916.16277-1-cai@lca.pw>
 <20200116142827.GU19428@dhcp22.suse.cz>
 <162DFB9F-247F-4DCA-9B69-535B9D714FBB@lca.pw>
 <20200116155434.GB19428@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 16, 2020, at 10:54 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> On Thu 16-01-20 09:53:13, Qian Cai wrote:
>>=20
>>=20
>>> On Jan 16, 2020, at 9:28 AM, Michal Hocko <mhocko@kernel.org> wrote:
>>>=20
>>> On Wed 15-01-20 12:29:16, Qian Cai wrote:
>>>> It is guaranteed to trigger a lockdep splat if calling printk() =
with
>>>> zone->lock held because there are many places (tty, console =
drivers,
>>>> debugobjects etc) would allocate some memory with another lock
>>>> held which is proved to be difficult to fix them all.
>>>=20
>>> I am still not happy with the above much. What would say about =
something
>>> like below instead?
>>> "
>>> It is not that hard to trigger lockdep splats by calling printk from
>>> under zone->lock. Most of them are false positives caused by lock =
chains
>>> introduced early in the boot process and they do not cause any real
>>> problems. There are some console drivers which do allocate from the
>>> printk context as well and those should be fixed. In any case false
>>> positives are not that trivial to workaround and it is far from =
optimal
>>> to lose lockdep functionality for something that is a non-issue.
>>> <An example of such a false positive goes here>
>>> "
>>=20
>> I feel like I repeated myself too many times. A call trace for one =
lock dependency
>> is sometimes from early boot process because lockdep will save the =
first one it
>> encountered, but it does not mean the lock dependency will only not =
happen in
>> early boot. I spent some time to study those early boot call traces =
in the given
>> lockdep splats, and it looks to me the lock dependency is also =
possible after
>> the boot.
>=20
> Then state it explicitly with an example of the trace and explanation
> that the deadlock is real. If the deadlock is real then it shouldn't =
be
> really terribly hard to notice even without lockdep splats which get
> disabled after the first false positive, right?

A deadlock could be really hard to trigger though which needs a perfect
timing between multiple threads.=
