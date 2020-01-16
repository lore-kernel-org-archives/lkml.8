Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0961C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864AE208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AOx0F/7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgAPQ1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:27:32 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41141 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgAPQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:27:32 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so9320390qvr.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yyLGxa8xjrcwmAMsji0ieBLF97v4pr3rE1pmt/X/PTg=;
        b=AOx0F/7R0HgR5MxRITx82a0sB2US6L5QO6ySGD1arnQk6XkmIj+wx+SMO01LNy4sfe
         rLOTZX8Oq8M1R7jmN/d+YC0K/OsdfJ3E3aiGDUcpzHnwI6Dg1FMrqy4AZgb4ikQDA5Qx
         y1mviK/3d5+wXPz5OIeNy8IZNUMHL/3fZ7ggHz/jY2W1UXrflv5ddMX6RGW3f5yMfk1a
         gO22CP8/LlVofpV+Q+BG5O9rfmQOesI8XgxRb4gFZi/gh/fCb6ig58Z6rf56vKkNIuav
         9zNnpCxP7ivoZKGytOgWqr/EyNS6851uvLReSyg61IAuNk+bRIfnuShW1uOOr/9SH/+t
         UwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yyLGxa8xjrcwmAMsji0ieBLF97v4pr3rE1pmt/X/PTg=;
        b=Todihj1NU6m89LKvnSIYYZTFLOL/v0u7zdgZBH8A5nKwrhG9pnNy08ETa93UYilnYQ
         ToVnDB0vLQDGPqBZIoDIlYTmMjtmSgnUPexYtWJPNge98M1AhtXf9gSP6WvPjVZQpuyO
         QTECTEc8Ga53ZJpmAdkmyFKpGqzEcOodwPD4leUDuYJiWVHQ0qMVRiaJ1MbjHMg+Dg8y
         d6/tpmuWmxgKw52xtU2wu+cRM2LAe21hEtIv93FE3RkBIJ+XYyQH4Xk5feXRHMRX4Amo
         ezhXw7cq/At3ctpnPJS99K6pRAvHs8BvUQm78JJhuHwSyU4Pdu0dUvIxAemzdE9/m1gJ
         TERg==
X-Gm-Message-State: APjAAAXUqLYNNksCoq1LqYtstP8v1Lk6niTXq5FAMDDyxzebbpJNtpIL
        Mt9VVRinu4Ioh98sjKTUdYejBg==
X-Google-Smtp-Source: APXvYqyltScEnH62Ya/5D9xBkldj2EacHt3SFfmhbmSeXu8rUngvmSm1NO3XxQt5YQ/0EsfCNmy7hA==
X-Received: by 2002:a05:6214:1149:: with SMTP id b9mr3328191qvt.227.1579192051307;
        Thu, 16 Jan 2020 08:27:31 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o6sm10122861qkk.53.2020.01.16.08.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:27:30 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next v3] mm/hotplug: silence a lockdep splat with
 printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <2be969af-53c0-803b-e0b1-eb20d1077dd0@redhat.com>
Date:   Thu, 16 Jan 2020 11:27:28 -0500
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7D86B8F-678F-4159-8796-D358B70BCC79@lca.pw>
References: <20200115172916.16277-1-cai@lca.pw>
 <20200116142827.GU19428@dhcp22.suse.cz>
 <162DFB9F-247F-4DCA-9B69-535B9D714FBB@lca.pw>
 <20200116155434.GB19428@dhcp22.suse.cz>
 <2be969af-53c0-803b-e0b1-eb20d1077dd0@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 16, 2020, at 11:04 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 16.01.20 16:54, Michal Hocko wrote:
>> On Thu 16-01-20 09:53:13, Qian Cai wrote:
>>>=20
>>>=20
>>>> On Jan 16, 2020, at 9:28 AM, Michal Hocko <mhocko@kernel.org> =
wrote:
>>>>=20
>>>> On Wed 15-01-20 12:29:16, Qian Cai wrote:
>>>>> It is guaranteed to trigger a lockdep splat if calling printk() =
with
>>>>> zone->lock held because there are many places (tty, console =
drivers,
>>>>> debugobjects etc) would allocate some memory with another lock
>>>>> held which is proved to be difficult to fix them all.
>>>>=20
>>>> I am still not happy with the above much. What would say about =
something
>>>> like below instead?
>>>> "
>>>> It is not that hard to trigger lockdep splats by calling printk =
from
>>>> under zone->lock. Most of them are false positives caused by lock =
chains
>>>> introduced early in the boot process and they do not cause any real
>>>> problems. There are some console drivers which do allocate from the
>>>> printk context as well and those should be fixed. In any case false
>>>> positives are not that trivial to workaround and it is far from =
optimal
>>>> to lose lockdep functionality for something that is a non-issue.
>>>> <An example of such a false positive goes here>
>>>> "
>>>=20
>>> I feel like I repeated myself too many times. A call trace for one =
lock dependency
>>> is sometimes from early boot process because lockdep will save the =
first one it
>>> encountered, but it does not mean the lock dependency will only not =
happen in
>>> early boot. I spent some time to study those early boot call traces =
in the given
>>> lockdep splats, and it looks to me the lock dependency is also =
possible after
>>> the boot.
>>=20
>> Then state it explicitly with an example of the trace and explanation
>> that the deadlock is real. If the deadlock is real then it shouldn't =
be
>> really terribly hard to notice even without lockdep splats which get
>> disabled after the first false positive, right?
>=20
> I was asking myself for a long time: did anybody actually see this
> deadlock in real life?

Nobody knows for sure. I think one reason is that not many people will =
use
memory offiline even if they do, it will mostly not be a continuous =
activity in
the system. debugobjects make it way easier to reproduce because it =
allocates
memory in random places, but then it is not all that popular.=
