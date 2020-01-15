Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF24C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8143C24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XViZdyFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAOBCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:02:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46108 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgAOBCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:02:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so14142412qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 17:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S+wrvI+6mfU/MlVzRlmU5SwrkGNwyv0/rhxozhw1Flk=;
        b=XViZdyFpsuPl6gsQl8qGHU5fvo2PqYU8dnqVm3WWl8nVITrQ4ycOQnvMZA5o6xf188
         OPZjYUjcgvUxrGHgVuWkVYIDmIxOC4uuYGRxKjZIQmPuh3cu/Zx4hG6pU46HmKkzv4c4
         51BmbW3tRU2EBtmaftivv/cPtkiFeHzmcKoIZCJOAuB3l1EYDA+nSvpNQpGw0W88Jujx
         Cy3FQkXfd9AT6Px0KInE7+5dZm1K2S20USQVk2b3M5uOacA8jSYl1yO7YikLvg5+6Q/B
         V/dkdvKtqGOs0jskpPr+KPT27IuGVZKULqKHgO6Cva9CHUv7O4ofCI1ajMfny1UhVFW8
         BrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S+wrvI+6mfU/MlVzRlmU5SwrkGNwyv0/rhxozhw1Flk=;
        b=nJsU/B28gUu6sIURaBDIxxhICpZjNNPdhNQrEu758m9QMY/4TqN3qePx4cQVEULzK+
         q4XFXTkUvSlI20V67m4QRmO6RVDiluJ9cXFHjVNP4faLi2+Gzco1YkmtP2txBYjYGIN6
         ej/AsT+jLguHDL/+JUHzp+idWTJMS50ySYe8zm9mtz6PDsIcRVuvC5Xn7HxGZvGn1nMj
         tLTeQXiFtN5QkyJ0FX2+UhDTXT7tFonM7rh7ocC25jU7r2bwZeav3vbz+XQpGMQTQo1p
         u6lgktKjA3nK+ITzI7iBoFOB9ohXmEukD8OYpgp1VvCQbsc7Jki38mOYfWQzbRO+xyYB
         qAwA==
X-Gm-Message-State: APjAAAXzTeAwx8fvZNPdURCHicNMeSe8ssSn4sadTx5kQ7iHlycXLuS/
        64Lz7NKUY6buW/8HqZk0Cus0BA==
X-Google-Smtp-Source: APXvYqycer5WLGRHLoNY3uunMgv/2tf5IdqJQ1oE1Oyni6TwBHqgttiCYIbjX9aXr/XdjjYiTBvOUg==
X-Received: by 2002:a37:b402:: with SMTP id d2mr24007105qkf.195.1579050153433;
        Tue, 14 Jan 2020 17:02:33 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z4sm7492487qkz.62.2020.01.14.17.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 17:02:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200114155339.ad5eee63b9ff38b617ee6168@linux-foundation.org>
Date:   Tue, 14 Jan 2020 20:02:31 -0500
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEF43337-68A2-4FDF-9B8C-795E017831DE@lca.pw>
References: <20200114210215.GQ19428@dhcp22.suse.cz>
 <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
 <20200114155339.ad5eee63b9ff38b617ee6168@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2020, at 6:53 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
>> On Jan 14, 2020, at 4:02 PM, Michal Hocko <mhocko@kernel.org> wrote:
>>>=20
>>> Yeah, that was a long discussion with a lot of lockdep false =
positives.
>>> I believe I have made it clear that the console code shouldn't =
depend on
>>> memory allocation because that is just too fragile. If that is not
>>> possible for some reason then it has to be mentioned in the =
changelog.
>>> I really do not want us to add kludges to the MM code just because =
of
>>> printk deficiencies unless that is absolutely inevitable.
>>=20
>> I don't know how to convince you, but both random number generator =
and
>> printk() maintainers agreed to get ride of printk() with zone->lock
>> held as you can see in the approved commit mentioned in this patch
>> description because it is a whac-a-mole to fix other places.  In =
other
>> word, the patch alone fixes quite a few false positives and potential
>> real deadlocks.  Maybe Andrew please has a look at this directly?
>>=20
>=20
> Well, a few things.
>=20
> The changelog is quite poor.  It doesn't describe the problem (console
> drivers allocating memory) not does it describe the solution
> (deferring the dump_page() until after release of zone->lock).
>=20
> So I changed it to this:
>=20
> : Some console drivers can perform memory allocation at inappropriate =
times,
> : which can result in lockdep warnings (and presumably deadlocks) if =
printk
> : is called with zone->lock held.
> :=20
> : By far the best fix is to reeducate those console drivers to not =
perform
> : these allocations, but this is proving difficult.

=E2=80=A6 but this is proving difficult because even if we fixed that =
directly, lockdep
Is still able to find an indirect dependency chain, for example [1]

CPU1: console_owner =E2=80=94> port_lock_key
CPU2: port_lock_key =E2=80=94> (&port->lock)->rlock
CPU3: (&port->lock)->rlock =E2=80=94> zone->lock

which will trigger a splat with

zone->lock =E2=80=94> console_owner

[1] https://lore.kernel.org/linux-mm/1570460350.5576.290.camel@lca.pw/

> :=20
> : Another but poorer approach is to call printk_deferred() when =
holding
> : zone->lock, but memory offline will call dump_page() which needs to =
defer
> : after the lock.
> :=20
> : So change has_unmovable_pages() so that it no longer calls =
dump_page()
> : itself - instead it passes the page's descripton (as a string) back =
to the
> : caller so that in the case of a has_unmovable_pages() failure, the =
caller
> : can call dump_page() after releasing zone->lock.
> :=20
> : While at it, remove a similar but unnecessary debug printk() as =
well.
>=20
> But I see a couple of other issues.
>=20
>> @@ -8290,8 +8290,10 @@ bool has_unmovable_pages(struct zone *zo
>> 	return false;
>> unmovable:
>> 	WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>> -	if (flags & REPORT_FAILURE)
>> -		dump_page(pfn_to_page(pfn + iter), reason);
>> +	if (flags & REPORT_FAILURE) {
>> +		page =3D pfn_to_page(pfn + iter);
>=20
> This statement appears to be unnecessary.

dump_page() in set_migratetype_isolate() needs that =E2=80=9Cpage=E2=80=9D=
.

>=20
>> +		strscpy(dump, reason, 64);
>> +	}
>=20
>=20
> Also, that whole `reason' thing in has_unmovable_pages() is just there
> to tell us whether it was an "unmovable page" or a "CMA page".  This
> doesn't seem terribly useful to me.  Also, I expect that the
> dump_page() output will permit the user to determine that it was a CMA
> page anyway.  If not, we can change dump_page() to add that info.
>=20
> So how about we remove that whole `reason' thing and possibly enhance
> dump_page()?  The patch then becomes much simpler.

Sounds like a good idea. I=E2=80=99ll send a v2.

