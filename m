Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C052DC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C0624670
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Rh73nB0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBRTQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:16:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45151 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:16:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id d9so15320646qte.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+HikanyDseXk6iSGhRmx2HuVl8693gA9nI6I0GJFyc=;
        b=Rh73nB0G8fWeZNlkBZdjrCndHlRKqMyPf1GnmJEFzyHhwg6ClOQUpxV0IKgK4q/mZM
         19e3zijgpHqJvgb7fw+EZ+ODuLh75FC7sByLWxwfoJJAP8+RCACW9Mb67QViMspv5UcY
         q4d68KAXHLEAPiBB6bD9+LZ4gilK6hqew74YRA1sRhhqJj1eiH5zpCedCvGKricprPmA
         hq/ZuIupwO7HWjFDZlqyWBWX23zXORg3qgdJZ4ru6A+ELULAc/fbyzNFkzv3QrTXE/mV
         niFwlXhnQ6lG65+gMvNGRRtckdPZCqFLEJ5lYfj08kWh5aUKCqe/61WPrz0qC4B1dKrt
         xf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+HikanyDseXk6iSGhRmx2HuVl8693gA9nI6I0GJFyc=;
        b=jcZZdHtz3fw6mr2LdC2lydnzZwOYI86hfGzHDjoXgD/COsGz5GfCXH8v9C4Mu3nyHS
         c6L+qMIL0seyBBdoBNVHBeAQPHUNoBPqkXIk6MOw5sk/5aq4i+QSnFU+ODLftF1tHrfw
         B7nnI/Nm66qF+Ynkwv0n+7KRDXm6v8r3KxgrurK4w93nI8o4MqrxeTWmY3ti6IQ4zCOk
         6YJyR8S2+oRLPeo+aI1iVxyk0RcTeG34gG+kSad6aSTgPYeo+cDVmTkxTZGUhiRxul6H
         nxdlVvKSm8BD8C2wh4ToSSEqBFW3Ccm02J2nZxFzv7CRFDO5XZknr/XRtimMB98o6Hey
         Qb/A==
X-Gm-Message-State: APjAAAVbICt8flYPywxCljZDtOGcQM4zO/mhF+FFY9PV53JH18x5d7ei
        nDaY847jo7QCXmZKXG1xb0hc9g==
X-Google-Smtp-Source: APXvYqzL6lsVLk1ljw92TPV8cdpIz9faUmoClLnf3276JvpcBJONGjdmkLk3PEFrRhOS3eOwML226Q==
X-Received: by 2002:ac8:6607:: with SMTP id c7mr18616033qtp.51.1582053372940;
        Tue, 18 Feb 2020 11:16:12 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a192sm2406482qkb.53.2020.02.18.11.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 11:16:12 -0800 (PST)
Message-ID: <1582053371.7365.98.camel@lca.pw>
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: fix a -Wunused-but-set-variable
From:   Qian Cai <cai@lca.pw>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Feb 2020 14:16:11 -0500
In-Reply-To: <CAHS8izMrJ3CNB_6W7VJ8+8TXZw0bnUsA5et7jF4iFn8T4QH=4A@mail.gmail.com>
References: <1581953454-10671-1-git-send-email-cai@lca.pw>
         <CAHS8izMrJ3CNB_6W7VJ8+8TXZw0bnUsA5et7jF4iFn8T4QH=4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 10:58 -0800, Mina Almasry wrote:
> On Mon, Feb 17, 2020 at 7:31 AM Qian Cai <cai@lca.pw> wrote:
> > 
> > The commit c32300516047 ("hugetlb_cgroup: add interface for
> > charge/uncharge hugetlb reservations") forgot to remove an unused
> > variable,
> > 
> > mm/hugetlb_cgroup.c: In function 'hugetlb_cgroup_migrate':
> > mm/hugetlb_cgroup.c:777:25: warning: variable 'h_cg' set but not used
> > [-Wunused-but-set-variable]
> >   struct hugetlb_cgroup *h_cg;
> >                          ^~~~
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  mm/hugetlb_cgroup.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> > index ad777fecad28..8a86a2b62bef 100644
> > --- a/mm/hugetlb_cgroup.c
> > +++ b/mm/hugetlb_cgroup.c
> > @@ -774,7 +774,6 @@ void __init hugetlb_cgroup_file_init(void)
> >   */
> >  void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
> >  {
> > -       struct hugetlb_cgroup *h_cg;
> >         struct hugetlb_cgroup *h_cg_rsvd;
> >         struct hstate *h = page_hstate(oldhpage);
> > 
> > @@ -783,7 +782,6 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
> > 
> >         VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
> >         spin_lock(&hugetlb_lock);
> > -       h_cg = hugetlb_cgroup_from_page(oldhpage);
> >         h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
> >         set_hugetlb_cgroup(oldhpage, NULL);
> > 
> > --
> > 1.8.3.1
> > 
> 
> Hi Qian,
> 
> Thank you very much for the fix to remove the warning, but actually
> the real fix is I'm missing a 'set_hugetlb_cgroup(newhpage, h_cg);'
> which will use the variable and set the cgroup on newhpage which is
> needed. I'll submit the proper fix.
> 
> What bothers me though is that locally when I checkout the broken
> patch and try to build I don't see the warning:
> 
> make -j80 mm/hugetlb_cgroup.o
> no warning.
> make -j80 mm/hugetlb_cgroup.o CFLAGS_KERNEL="-Wall"
> no warning
> make -j80 mm/hugetlb_cgroup.o CFLAGS_KERNEL="-Wunused-but-set-variable"
> I see the warning.
> 
> So it seems there is a bunch of warnings I need to explicitly turn on
> otherwise I will continually submit patches that introduce warnings in
> your build. Any idea why I'm running into this? Do you also have to
> turn on these warnings manually on your make line? Is it related to
> gcc version? My gcc version is:
> gcc version 9.2.1 20190909 (Debian 9.2.1-8)

I am doing "make W=1" which will turn on those warnings. Quite noisy but you can
"grep" what you are interested in.
