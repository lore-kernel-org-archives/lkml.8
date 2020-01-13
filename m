Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2A8C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF3220678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cho5Xgy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgAMUVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:21:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38401 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAMUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:21:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id f20so4257240plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 12:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bIaxZyK0QJpQTL/WgrEd8VP6JHOxc9uUiVT69OkfGfs=;
        b=Cho5Xgy5zKREtQuKz+/bSZ0g+gIyHdz2p24Yfmsxr7CAccjr5kcYpqbgOvKvI1tvOi
         0Pw3+2nxm7aPkD+pmpl/OIX7moakvPw2GOjM30vb5vz5mSO0dN7irc5zX92k8ZNLh5FZ
         C+9K7yYtuDy4lOut09g3xyF2lbu0OFZDC34OWJr2lBCTa1hJaiygNIy2lV4Jj8HzXOkA
         lE1ma7JDpwMYDBQyQSniSv3xsKGxjIIbQCruULLZa0ItRSSKET5yRX8Vl3N174N8zYr1
         Ixn4VH4adsnqXjKH5qgXYxbPbyK5p0X3/nAOowu2RukAy8WC22V/2K4DHpY87DfNUPGr
         zJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bIaxZyK0QJpQTL/WgrEd8VP6JHOxc9uUiVT69OkfGfs=;
        b=ht0KkTodMxeoUsuAEZiOQDHG9N8VoCR3bCn9q7NtAiti3iYhIA/zV3BkhTPgodkl1k
         H5ZETLMbo1D0ybKXexIFslAirmLW6QIiXzcS27c16WQZ89TvsN6cyVWy1CCkfxPHbFoA
         UdS72U+nbMQ4wSTngFRbcqBlG0Z56XkjC79qfm+W1JSymKVvzDmP29Bl/wURZQM6Exz5
         5+C9qySqQFo0tine+UlMdRObFgBcRMw8PxkCn0Dd7qdztpytxXXK7EB9OwLlN9ubgN3y
         H7EDOSFf7Tr0rjWm134Lmt1ZzuQx4K0Nrj8PSmMlYQdoE1vvsVs24ZhRDLu1pfjU6Sp5
         Dmaw==
X-Gm-Message-State: APjAAAWPjRiEDmqD2PMyC5jipiXLAx7zDuTzP1UH7BokHT4RC12FwdCq
        w1EmflxJ0IbHwW+TCK6sg8dScA==
X-Google-Smtp-Source: APXvYqz63b0w80w/6x4HYHZY8yCvMeX3CjLxshGz0cPA+oMJSNaR8BhdRUhjA82WiAoUwJBS4TcRcg==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr23348884pjs.69.1578946866353;
        Mon, 13 Jan 2020 12:21:06 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id c17sm14862042pfi.104.2020.01.13.12.21.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jan 2020 12:21:05 -0800 (PST)
Date:   Mon, 13 Jan 2020 12:20:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, hannes@cmpxchg.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com
Subject: Re: [PATCH v7 00/10] per lruvec lru_lock for memcg
In-Reply-To: <24d671ac-36ef-8883-ad94-1bd497d46783@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2001131157500.1084@eggly.anvils>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com> <20191231150514.61c2b8c8354320f09b09f377@linux-foundation.org> <944f0f6a-466a-7ce3-524c-f6db86fd0891@linux.alibaba.com> <d2efad94-750b-3298-8859-84bccc6ecf06@linux.alibaba.com>
 <alpine.LSU.2.11.2001130032170.1103@eggly.anvils> <24d671ac-36ef-8883-ad94-1bd497d46783@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1359013247-1578946865=:1084"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1359013247-1578946865=:1084
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 13 Jan 2020, Alex Shi wrote:
> =E5=9C=A8 2020/1/13 =E4=B8=8B=E5=8D=884:48, Hugh Dickins =E5=86=99=E9=81=
=93:
> >=20
> > I (Hugh) tried to test it on v5.5-rc5, but did not get very far at all =
-
> > perhaps because my particular interest tends towards tmpfs and swap,
> > and swap always made trouble for lruvec lock - one of the reasons why
> > our patches were more complicated than you thought necessary.
> >=20
> > Booted a smallish kernel in mem=3D700M with 1.5G of swap, with intentio=
n
> > of running small kernel builds in tmpfs and in ext4-on-loop-on-tmpfs
> > (losetup was the last command started but I doubt it played much part):
> >=20
> > mount -t tmpfs -o size=3D470M tmpfs /tst
> > cp /dev/zero /tst
> > losetup /dev/loop0 /tst/zero
>=20
> Hi Hugh,
>=20
> Many thanks for the testing!
>=20
> I am trying to reproduce your testing, do above 3 steps, then build kerne=
l with 'make -j 8' on my qemu. but cannot reproduce the problem with this v=
7 version or with v8 version, https://github.com/alexshi/linux/tree/lru-nex=
t, which fixed the bug KK mentioned, like the following.=20
> my qemu vmm like this:
>=20
> [root@debug010000002015 ~]# mount -t tmpfs -o size=3D470M tmpfs /tst
> [root@debug010000002015 ~]# cp /dev/zero /tst
> cp: error writing =E2=80=98/tst/zero=E2=80=99: No space left on device
> cp: failed to extend =E2=80=98/tst/zero=E2=80=99: No space left on device
> [root@debug010000002015 ~]# losetup /dev/loop0 /tst/zero
> [root@debug010000002015 ~]# cat /proc/cmdline
> earlyprintk=3DttyS0 root=3D/dev/sda1 console=3DttyS0 debug crashkernel=3D=
128M printk.devkmsg=3Don
>=20
> my kernel configed with MEMCG/MEMCG_SWAP with xfs rootimage, and compilin=
g kernel under ext4. Could you like to share your kernel config and detaile=
d reproduce steps with me? And would you like to try my new version from ab=
ove github link in your convenient?

I tried with the mods you had appended, from [PATCH v7 02/10]
discussion with Konstantion: no, still crashes in a similar way.

Does your github tree have other changes too?  I see it says "Latest
commit e05d0dd 22 days ago", which doesn't seem to fit.  Afraid I
don't have time to test many variations.

It looks like, in my case, systemd was usually jumping in and doing
something with shmem (perhaps via memfd) that read back from swap
and triggered the crash without any further intervention from me.

So please try booting with mem=3D700M and 1.5G swap,
mount -t tmpfs -o size=3D470M tmpfs /tst
cp /dev/zero /tst; cp /tst/zero /dev/null

That's enough to crash it for me, without getting into any losetup or
systemd complications. But you might have to adjust the numbers to be
sure of writing out and reading back from swap.

It's swap to SSD in my case, don't think that matters. I happen to
run with swappiness 100 (precisely to help generate swap problems),
but swappiness 60 is good enough to get these crashes.

Hugh
--0-1359013247-1578946865=:1084--
