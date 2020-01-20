Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BCAC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CC822527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579535001;
	bh=k5hulNuhjJN1vpqs8RWygBeDicqghWeZskZmfEGyJyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cTWHRNpwtPfFPycq6NZUI2tW3siUI2v93H8oOMlLjy3V0PLnuMbh3CS8ACCT6H9Pn
	 RRjYC4W4O0di4fl1vvUy3JyV9IzBJ5eDQH8jItrVz+no4TgmOLntlTlCoH8qHLwJff
	 eRJiIDmKFro0psXl/LSwASt9s/Az57x7yENLxQuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgATPnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:43:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43214 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:43:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so30073903wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sj2OJDyUF+Gs3NUJLayq5kxeopk2pOJl5Jx9/Iosi0s=;
        b=JmLZ/NsP/uskmIxQQVn37UOx8ymsmEIwaLKQL4s9CAOzDBq6GPoLfKX0PIp1gsq8JC
         ycftxhlHzNH9AT0S+QT6IhIFQBoARiL50Zj6h4ywUbsknWbwFxZ6h2Pp1zi85Akq+VIP
         nkdL5PWKTO8uXUWiC+suRE4m7YoURKXxllGCQEvWFYWFDODvKz5srBYe+WnhQZ6EEa1C
         Z1qMLBRZy8VP/qapJr0yj9/Zr1vVgIYC3BsiAyUqBaUNBgDOqrtCi0GNHiODxq1PeWWr
         tBp0ShUof5RiwK7SfAMCsQSgLJfRBnMiYLppKjfSs13GszcrG2O8YTca6nhgXjDxxY3s
         vnMw==
X-Gm-Message-State: APjAAAWTrj0sNX14uJ+c6/Ul9TLpI1FemzKmx0fLgvqfFXtZ3KHaQkds
        OPBsy2F3HD8BycKXdB/f82c=
X-Google-Smtp-Source: APXvYqxeiJDkSuTikFlnLFD18uLcUXUfw88VtFEHnGvcvq5ZQ4uskDSiDHvv+NORnSeanVqL3Rpk0g==
X-Received: by 2002:adf:c145:: with SMTP id w5mr98337wre.205.1579534998158;
        Mon, 20 Jan 2020 07:43:18 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s3sm23187912wmh.25.2020.01.20.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 07:43:16 -0800 (PST)
Date:   Mon, 20 Jan 2020 16:43:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm v2] mm/page_isolation: fix potential warning from user
Message-ID: <20200120154315.GK18451@dhcp22.suse.cz>
References: <20200120131909.813-1-cai@lca.pw>
 <8c56268d-9b8a-f62e-eca9-7707852a2aaf@redhat.com>
 <ba3215a2-d616-c636-e70d-99bb8f504292@redhat.com>
 <96675869-3815-4E98-8492-1D84F5B42AED@lca.pw>
 <74aebdfe-e727-acd6-e664-6e63948a68ae@redhat.com>
 <F8997A77-7F52-4C0C-8045-F39C57B4CC74@lca.pw>
 <aa5f235e-6449-1531-1355-6974f3d38740@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa5f235e-6449-1531-1355-6974f3d38740@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 15:13:54, David Hildenbrand wrote:
> On 20.01.20 15:11, Qian Cai wrote:
> >> On Jan 20, 2020, at 9:01 AM, David Hildenbrand <david@redhat.com> wrote:
> >> On 20.01.20 14:56, Qian Cai wrote:
[...]
> >>>> FWIW, I'd prefer this change without any such cleanups (e.g., I don't
> >>>> like returning a bool from this function and the IS_ERR handling, makes
> >>>> the function harder to read than before)
> >>>
> >>> What is Michal or Andrew’s opinion? BTW, a bonus point to return a bool
> >>> is that it helps the code robustness in general, as UBSAN will be able to
> >>> catch any abuse.
> >>>
> >>
> >> A return type of bool on a function that does not test a property
> >> ("has_...", "is"...") is IMHO confusing.
> > 
> > That is fine. It could be renamed to set_migratetype_is_isolate() or
> > is_set_migratetype_isolate() which seems pretty minor because we
> > have no consistency in the naming of this in linux kernel at all, i.e.,
> > many existing bool function names without those test of properties. 
> 
> It does not query a property, so "is_set_migratetype_isolate()" is plain
> wrong.
> 
> Anyhow, Michal does not seem to care.

Well, TBH I have missed this change. My bad. I have mostly checked that
the WARN_ONCE is not gated by the check and didn't expect more changes.
But I have likely missed that change in the previous version already.
You guys are too quick with new version to my standard.

Anyway, I do agree that bool is clumsy here. Returning false on success
is just head scratching. Nobody really consumes the errno value but I
would just leave it that way or if there is a strong need to change then
do it in a separate patch.
-- 
Michal Hocko
SUSE Labs
