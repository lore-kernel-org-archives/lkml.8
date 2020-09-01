Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F84C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8D82083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aE0f2vH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIAD7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIAD7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:59:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D5C0612FE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:59:38 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 37so7525oto.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=el8iJcmxOaxJOWS4sBxpKnjD++a2+5Ro/otj+ZBjluA=;
        b=aE0f2vH2fWKwM5rp5aSui+5ZTSy2ZWY+LaNJKpegOkwFNDRcOa0Gz219cZHHw3/aJk
         HL7NPqz3LzVs76fcYikrbSSKovBLDWSIL7l+N96GhaggLNGsZ+iOFgNJDXXh7mWsm9Zi
         Wl0jVE9bAdfjlwhBitSpSG9up0K9u4ELiQegaI6e0UkHsTLMwvbHg1tVVmZeqRO1xzLu
         1E/4RyB2Ggv8sPdYtMDchlOJ8IsIoir+Z/7GMKVNGwC4PGwts3M1niHO4+tu2wGwNrt5
         wHLOp85kqLNb3p4IDT0w4ox4Px0opavig4UhBQ7krNMxFDxh6bP+h5BEW8oKhzwR7tjZ
         FYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=el8iJcmxOaxJOWS4sBxpKnjD++a2+5Ro/otj+ZBjluA=;
        b=ZgcPOHPwwjoLfn27cSUbq9LsrVH5VgGTFQnmFTCaERkz1JFGJanoYrFor0kqXd9n86
         USNMDvBD8yFDeaId8uew9cBxg6/ji3VSteS1XrvwDDB6CFPgOZFqWQZ1003iDn6tDAhf
         WnAGl++RN9j5sy5LvJqke3EE/9JP/RnXzdtfSt7ph0PRYQNXLdL8qtSrMvdhWdIeRzpC
         RuciRgHr0oefiloQahmBR4MJ+nXsiWKduCxHIseNIiXOz3Jx5JEu3sIzzW9jhy0hH25x
         MGWF54luezHxTHBB8afwzfdcKGlgzx0DJ8fnIB1W1JZaHG2Q7LidKjH8fzPp+iYcjEgK
         QLlA==
X-Gm-Message-State: AOAM531uOuHCop8TfqaXjOHh0AzLJsALoGDKSQdBfjkVMQARegFlLGv3
        pVbrZYh6jRaY9Y5rwWAyzHkX8w==
X-Google-Smtp-Source: ABdhPJz9PjlDrpfqy0fPfryU+nJtNXlq34EoIGFmVU9GzUCWSI54417v6I4cCggHlKPdb4Offb9fvg==
X-Received: by 2002:a9d:48:: with SMTP id 66mr22439ota.83.1598932777791;
        Mon, 31 Aug 2020 20:59:37 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 10sm2217395otv.48.2020.08.31.20.59.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2020 20:59:36 -0700 (PDT)
Date:   Mon, 31 Aug 2020 20:59:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/5] mm: fix check_move_unevictable_pages() on THP
In-Reply-To: <5875bdbe-c1af-737b-9ec2-4b48b3c2465f@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2008312040530.1019@eggly.anvils>
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils> <alpine.LSU.2.11.2008301405000.5954@eggly.anvils> <5875bdbe-c1af-737b-9ec2-4b48b3c2465f@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1560420255-1598932776=:1019"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1560420255-1598932776=:1019
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Sep 2020, Alex Shi wrote:
> =E5=9C=A8 2020/8/31 =E4=B8=8A=E5=8D=885:08, Hugh Dickins =E5=86=99=E9=81=
=93:
> > --- 5.9-rc2/mm/vmscan.c=092020-08-16 17:32:50.721507348 -0700
> > +++ linux/mm/vmscan.c=092020-08-28 17:47:10.595580876 -0700
> > @@ -4260,8 +4260,14 @@ void check_move_unevictable_pages(struct
> >  =09for (i =3D 0; i < pvec->nr; i++) {
> >  =09=09struct page *page =3D pvec->pages[i];
> >  =09=09struct pglist_data *pagepgdat =3D page_pgdat(page);
> > +=09=09int nr_pages;
> > +
> > +=09=09if (PageTransTail(page))
> > +=09=09=09continue;
> > +
> > +=09=09nr_pages =3D thp_nr_pages(page);
> > +=09=09pgscanned +=3D nr_pages;
> > =20
> > -=09=09pgscanned++;
> >  =09=09if (pagepgdat !=3D pgdat) {
> >  =09=09=09if (pgdat)
> >  =09=09=09=09spin_unlock_irq(&pgdat->lru_lock);
> > @@ -4280,7 +4286,7 @@ void check_move_unevictable_pages(struct
> >  =09=09=09ClearPageUnevictable(page);
> >  =09=09=09del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
> >  =09=09=09add_page_to_lru_list(page, lruvec, lru);
>=20
> So, we might randomly del or add a thp tail page into lru?
> It's interesting to know here. :)

No, it wasn't that interesting, I'd have been more concerned if it was
like that.  Amusing idea though: because the act of adding a thp tail
to lru would clear the very bit that says it's a tail.

=09=09if (!PageLRU(page) || !PageUnevictable(page))
=09=09=09continue;

Let's see: PageLRU and PageUnevictable are both of the PF_HEAD type,
so permitted on tails, but always redirecting to head: so typically
PageLRU(page) would be true, because head on lru; but PageUnevictable(page)
would be false on tail, because head has already been moved to an evictable
lru by this same function.  So it safely went the "continue" way, but
without incrementing pgrescued.

Hugh

>=20
> Thanks
> Alex
>=20
> > -=09=09=09pgrescued++;
> > +=09=09=09pgrescued +=3D nr_pages;
> >  =09=09}
> >  =09}
> > =20
--0-1560420255-1598932776=:1019--
