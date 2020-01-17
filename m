Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA2C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1782087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="T/YKvKzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAQSt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:49:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45210 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:49:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so23632941qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6zf6EUsnzoIFH8F/2Csfpg9qeASx8BfPLWtgpgM5e18=;
        b=T/YKvKzXDojfWpYDzivY7tCKgOF5Zy+3O774FxFwAAfINGHOO9/tyfMxOL/8qJYBQH
         D53UC7QEgREt2UgsAwquUt6IlJN66SYSyIDO1tem0vWvJz+zMeAC7nZD1NhWaabWatqC
         37tbpXkgjFDInuVsoo882bmAsx4AelhB+JzKIE3t6knbcrfD9UPm9iRoj2XLGu71wJxH
         dUAPBJ25W12fCMoyefGRPIibkDTwS+9mtoJ4PTNwqgsVWZh76rMdbw+4B9IUdrGVpVQJ
         2diyw/woaKzXFOS6Glt3Bhjevmljvw9xLifxBJy9GCyJeXwqJxSu2duqtkEUToNmI7Mx
         dY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6zf6EUsnzoIFH8F/2Csfpg9qeASx8BfPLWtgpgM5e18=;
        b=VTYH8TGTal2w/q0jhcZ8T11ugWgDh+sADPgzzK3L3tzIuB6A2/mw8Jc2vTve/tXFhM
         xzMb+xIVg5CwfRhN3HNN13JbRHwOfUF6wRid6YNZp/v40Ses+SEEeMWt49s/tWVfrC6c
         kby15ABCglVcVE69xNK7UBHjcF9DRBSguLMtL6ZnENmD5sL6XWiTytHrzirKyT+TSumc
         4NZmAHmS8XsmkyW7OftB4Eji/0H3mpuHqO26xSI4ChP8okI6yeuNqBUcgzCt1Bd7AS2f
         axnTcdYrbdLO/mjTqEjcv2W06WtcZxZmhE5TKNlynXKwrcRc9/vOYlBiaYwHRsDmDnNb
         fTEg==
X-Gm-Message-State: APjAAAV+l1h7CUSIoRGB0KA1LtwBZobvTxox/GYpPv11jqU0AYRnhvCn
        yvG47wRfhLkx7KLX7+rWDPvvLA==
X-Google-Smtp-Source: APXvYqxGBrQG8jkJsN86gXo6MN6oTisVSXFMYBBziwyhbcK0HZHvGl2FLr6LspZeTvSZN6Wm2yokFQ==
X-Received: by 2002:a37:644:: with SMTP id 65mr39957548qkg.309.1579286995335;
        Fri, 17 Jan 2020 10:49:55 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m27sm13585570qta.21.2020.01.17.10.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 10:49:54 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200117154657.GL19428@dhcp22.suse.cz>
Date:   Fri, 17 Jan 2020 13:49:53 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <00155F33-17C6-4051-A8F9-CCD9414F400D@lca.pw>
References: <20200117143905.GZ19428@dhcp22.suse.cz>
 <3B7490FB-E915-4DC7-8739-01EDC023E22E@lca.pw>
 <20200117154657.GL19428@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 10:46 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> On Fri 17-01-20 10:05:12, Qian Cai wrote:
>>=20
>>=20
>>> On Jan 17, 2020, at 9:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
>>>=20
>>> Thanks a lot. Having it in a separate patch would be great.
>>=20
>> I was thinking about removing that WARN together in this v5 patch,
>> so there is less churn to touch the same function again. However, I
>> am fine either way, so just shout out if you feel strongly towards a
>> separate patch.
>=20
> I hope you meant moving rather than removing ;). The warning is useful
> because we shouldn't see unmovable pages in the movable zone. And a
> separate patch makes more sense because the justification is slightly
> different. We do not want to have a way for userspace to trigger the
> warning from userspace - even though it shouldn't be possible, but
> still. Only the offlining path should complain.

Something like this?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 621716a25639..32c854851e1f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8307,7 +8307,6 @@ struct page *has_unmovable_pages(struct zone =
*zone, struct page *page,
        }
        return NULL;
 unmovable:
-       WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
        return pfn_to_page(pfn + iter);
 }
=20
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e70586523ca3..08571b515d9f 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -54,9 +54,11 @@ static int set_migratetype_isolate(struct page *page, =
int migratetype, int isol_
=20
 out:
        spin_unlock_irqrestore(&zone->lock, flags);
+
        if (!ret)
                drain_all_pages(zone);
        else if ((isol_flags & REPORT_FAILURE) && unmovable)
+               WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
                /*
                 * printk() with zone->lock held will guarantee to =
trigger a
                 * lockdep splat, so defer it here.=
