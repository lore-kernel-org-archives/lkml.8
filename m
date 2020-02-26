Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A1C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D6A24676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cOaiA3P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgBZC0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:26:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39426 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBZC0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:26:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id e16so1249126qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 18:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=McJpuDjiTkQs6nd1tw338N5uVXV9DRMKj1tpOelYxV8=;
        b=cOaiA3P4ZiDbk3H+6VEQ7wAs4sF1Qbm9WnMg7HzTY/sevn6Tm+jt0nZIxG6pKWhbSk
         V5+Txqfh6FbHDM4lct+7cCtzjoxvdwxiSMDpxbc4RW7oGMTiEtEn74jmAXM4f/5wyphd
         5xv6cuP3sz5t6lTikrk+FL2Hz7AQSlyDsFkdZh8ufe0UBT6bGIpVqAlfWEUj61VfVbou
         mwZ1wWfRlVvoQXtOqvFeBpEHzyhB96VuyMYGVYdeuhM1e23e6oFnHEEqbCvTt1WMuEMk
         djOLtKGuRLBHW8Nq5S9x49XmEx9sqS5L5l5Va6Bmq38iqv/1BKuYYNZFo9y0DeyiQlD9
         hJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=McJpuDjiTkQs6nd1tw338N5uVXV9DRMKj1tpOelYxV8=;
        b=pnGa7wwvSd3Dk8/p9XaPWkc9ABbIwRZkxtWwkju2P/ybocqeMIrDu9nZ+tajGY8MzS
         hevT+UZcJCFFoQFpK4tpHKJVPozMbripuobcGnmZ5KBwAgxqu1tck17Q/mhzxeI7Z3d2
         kGVU85lqmbCg6ZAoQwtR3o9mxJ7YkqV/4jGjTnnMTsHCM2RiOfmO8OXHmZPMLlZ2GW1P
         1/wqO9XvJh25zVDsRrXUXIQ07SdUTDFcjSM4OxUlgv/rqFR9P0QvqITIkoJWrjOLHDv8
         35lImvSV4/KBWLBL02yQDnqhAjT3+vtCM4Gw2wshQg2gNMpAoALWaAoFqo2gZkJNVNnj
         CTbA==
X-Gm-Message-State: APjAAAUnA3ZMOVkUc/aLpvUukrlgk70AJLJLm/7h8vjE6t79SyZDF3u4
        jUY6cSJ0Yf6wYk5WDgV1M0ehZw==
X-Google-Smtp-Source: APXvYqxumFoENBT98nqJay637NgG8dnK0sEA2gnW+P5UITAQFX4YViNrX5TUcvpRTjXnGNhBIbuVFw==
X-Received: by 2002:a05:620a:c:: with SMTP id j12mr2638047qki.356.1582683999672;
        Tue, 25 Feb 2020 18:26:39 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n138sm319998qkn.33.2020.02.25.18.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 18:26:39 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mm/vmscan: fix data races at kswapd_classzone_idx
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200225181101.eca053d3201a6ac68e543572@linux-foundation.org>
Date:   Tue, 25 Feb 2020 21:26:35 -0500
Cc:     Marco Elver <elver@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE34F3EE-B992-418E-B2A4-D1FDDCD86906@lca.pw>
References: <1582649726-15474-1-git-send-email-cai@lca.pw>
 <20200225181101.eca053d3201a6ac68e543572@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 25, 2020, at 9:11 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Tue, 25 Feb 2020 11:55:26 -0500 Qian Cai <cai@lca.pw> wrote:
>=20
>> pgdat->kswapd_classzone_idx could be accessed concurrently in
>> wakeup_kswapd(). Plain writes and reads without any lock protection
>> result in data races. Fix them by adding a pair of READ|WRITE_ONCE() =
as
>> well as saving a branch (compilers might well optimize the original =
code
>> in an unintentional way anyway). The data races were reported by =
KCSAN,
>>=20
>> ...
>>=20
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3961,11 +3961,10 @@ void wakeup_kswapd(struct zone *zone, gfp_t =
gfp_flags, int order,
>> 		return;
>> 	pgdat =3D zone->zone_pgdat;
>>=20
>> -	if (pgdat->kswapd_classzone_idx =3D=3D MAX_NR_ZONES)
>> -		pgdat->kswapd_classzone_idx =3D classzone_idx;
>> -	else
>> -		pgdat->kswapd_classzone_idx =3D =
max(pgdat->kswapd_classzone_idx,
>> -						  classzone_idx);
>> +	if (READ_ONCE(pgdat->kswapd_classzone_idx) =3D=3D MAX_NR_ZONES =
||
>> +	    READ_ONCE(pgdat->kswapd_classzone_idx) < classzone_idx)
>> +		WRITE_ONCE(pgdat->kswapd_classzone_idx, classzone_idx);
>> +
>> 	pgdat->kswapd_order =3D max(pgdat->kswapd_order, order);
>> 	if (!waitqueue_active(&pgdat->kswapd_wait))
>> 		return;
>=20
> This is very partial, isn't it?  The above code itself is racy against
> other code which manipulates ->kswapd_classzone_idx and the
> manipulation in allow_direct_reclaim() is performed by threads other
> than kswapd and so need the READ_ONCE treatment and is still racy with
> that?

Right, I suppose allow_direct_reclaim() could use some treatment too.

>=20
> I guess occasional races here don't really matter, but a grossly wrong
> read from load tearing might matter.  In which case shouldn't we be
> defending against them in all cases where non-kswapd threads read this
> field?

