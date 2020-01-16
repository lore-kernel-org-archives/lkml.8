Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB3C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030932192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N+6Ssu9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAPOxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:53:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34778 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgAPOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:53:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so19356571qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 06:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VfEq4LxyaHniYun5xfWRDNlMpFsWY8fjVqZ31SjMLhY=;
        b=N+6Ssu9W79KXGjbPaL0NzetFoBgyZodXUH9VTeECWwXXzYr52NDmvvTSDsC7JnP6cI
         O2HU1GiwX1dSEA0V91hrSJG42+6WSdF6kNEQNWo1/LOmw6gZGAIWlkJNty86L/x/GUu0
         y5tOFZP4kH55/9MZjwAdsP/G2j8eII45g0rRzFEAgNkDQDZj2Q+YHDNOeEg38GrpNw1H
         8Gh99JTXc/Vm2vJYFqOcUE8zy15nrnGbr67n/MvunTEJCRq692wBTawneW2CTRn+DZu5
         VFMovvdEW1Bz0hjmGltMW5SQV0FxGpfyavPlRE+Lrw4TtoX1S4lfEHOsH1lLwGec+iBz
         EjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VfEq4LxyaHniYun5xfWRDNlMpFsWY8fjVqZ31SjMLhY=;
        b=pRdzj69khFXUjw35L5pRiyAx382iioCYQEvS41rn2I16QiEz2O3GVWeYJlzZRk/daH
         kCIq1no5JXUvh9/nfaVeRwWUYersv1J+DCU18cwRVdQl3DG4YtLAbqY78lzGrURhdOIK
         d/noaXYgsGdbnwig+ZDeK7jKZXuD8fOvRooAAjJ45ae2+By+jMwVSa9+b6rKxlxTtZy2
         TVotJ3w/jP1IB/WKU4Llb4l7jALS0irNnHEO2ElxUanJs4DFedEI/CjgQDBQuLTA1JlO
         LqGi4KHoIBLYMiRWQBzq5Q/HeltU1ScAbAwOxXgiMfinWkazylUwd1KKx0xzhLaD0cKS
         39jg==
X-Gm-Message-State: APjAAAW9a9zC31PBV2UKLq3+xh4CnWW1VAj34TmaqsHs0n62Om9IjQLT
        k4fPSPyS1QD/u07k/wNTeHeC9Q==
X-Google-Smtp-Source: APXvYqxxA0VH8h7EOVvgoK7xV7e6nhK+tq0bsMYcuFMoTlqmJLe474Tp0F39kg4Kmre2Rsn9B+wYqA==
X-Received: by 2002:a05:620a:22ce:: with SMTP id o14mr30268359qki.424.1579186396157;
        Thu, 16 Jan 2020 06:53:16 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s20sm10148412qkj.100.2020.01.16.06.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 06:53:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next v3] mm/hotplug: silence a lockdep splat with
 printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200116142827.GU19428@dhcp22.suse.cz>
Date:   Thu, 16 Jan 2020 09:53:13 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <162DFB9F-247F-4DCA-9B69-535B9D714FBB@lca.pw>
References: <20200115172916.16277-1-cai@lca.pw>
 <20200116142827.GU19428@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 16, 2020, at 9:28 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> On Wed 15-01-20 12:29:16, Qian Cai wrote:
>> It is guaranteed to trigger a lockdep splat if calling printk() with
>> zone->lock held because there are many places (tty, console drivers,
>> debugobjects etc) would allocate some memory with another lock
>> held which is proved to be difficult to fix them all.
>=20
> I am still not happy with the above much. What would say about =
something
> like below instead?
> "
> It is not that hard to trigger lockdep splats by calling printk from
> under zone->lock. Most of them are false positives caused by lock =
chains
> introduced early in the boot process and they do not cause any real
> problems. There are some console drivers which do allocate from the
> printk context as well and those should be fixed. In any case false
> positives are not that trivial to workaround and it is far from =
optimal
> to lose lockdep functionality for something that is a non-issue.
> <An example of such a false positive goes here>
> "

I feel like I repeated myself too many times. A call trace for one lock =
dependency
is sometimes from early boot process because lockdep will save the first =
one it
encountered, but it does not mean the lock dependency will only not =
happen in
early boot. I spent some time to study those early boot call traces in =
the given
lockdep splats, and it looks to me the lock dependency is also possible =
after
the boot.

>=20
>> A common workaround until the onging effort to make all printk() as
>> deferred happens is to use printk_deferred() in those places similar =
to
>> the recent commit [1] merged into the random and -next trees, but =
memory
>> offline will call dump_page() which needs to be deferred after the =
lock.
>=20
> I would remove this paragraph altogether. The real problem is that we =
do
> not really want to make dump_page deferred.
>=20
>> So change has_unmovable_pages() so that it no longer calls =
dump_page()
>> itself - instead it returns a "struct page *" of the unmovable page =
back
>> to the caller so that in the case of a has_unmovable_pages() failure,
>> the caller can call dump_page() after releasing zone->lock.
>=20
> Again this begs for some more explanation why this is ok. Something =
like
> the following:
> "
> Even though has_unmovable_pages doesn't hold any reference to the
> returned page this should be reasonably safe for the purpose of
> reporting the page (dump_page) because it cannot be hotremoved. The
> state of the page might change but that is the case even with the
> existing code as zone->lock only plays role for free pages.
> "

Looks like a better version. Maybe Andrew could squash that in?

>=20
>> Also, make
>> dump_page() is able to report a CMA page as well, so the reason =
string
>> from has_unmovable_pages() can be removed.
>>=20
>> While at it, remove a similar but unnecessary debug-only printk() as
>> well. A few sample lockdep splats can be founnd here [2].
>>=20
>> [1] =
https://lore.kernel.org/lkml/1573679785-21068-1-git-send-email-cai@lca.pw/=

>> [2] =
https://lore.kernel.org/lkml/7CD27FC6-CFFF-4519-A57D-85179E9815FE@lca.pw/
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>=20
> With improved changelog and after addressing one more thing below, =
feel
> free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
>=20
> Thanks for working on this. I have to say I have disliked the initial
> version because they were really hacky. This one can be reasoned about
> at least. has_unmovable_pages returning an unmovable page actually =
makes
> some conceptual sense to me.
>=20
> [...]
>> @@ -8302,12 +8304,10 @@ bool has_unmovable_pages(struct zone *zone, =
struct page *page, int migratetype,
>> 		 */
>> 		goto unmovable;
>> 	}
>> -	return false;
>> +	return NULL;
>> unmovable:
>> 	WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>=20
> You want to move this WARN_ON as well. Not only because it is using
> printk as well but also because we do not really want to trigger the
> warning from userspace via is_mem_section_removable. Maybe worth a =
patch
> on its own?

Yes, I have never triggered the warning there before, so I don=E2=80=99t =
think that is a problem
belong to here.

