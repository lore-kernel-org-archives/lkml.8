Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A020D20691
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBfezS03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgFIMPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgFIMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:15:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6927AC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 05:15:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y18so7969087plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0dKW+Kd5iAiFQPX60Bp7aaI38nX4AF0yQ8hLDeb5gc8=;
        b=KBfezS03XZHLwY+2mBULAXoYYfvOAwPXvOpLQ4oldt9JOjJj5BCo87GEH1U634kCDU
         h9+NoNelKMT0YAbAYjhKOTqfTV+tZviVfeDEGQj6Gm3fkm5fN2JBAgMKpZ/C2Fm5T6TJ
         UIWr65WS202gyJv0e/vjq1AwykOBvPJ1XUM6aoJ9xuGBve2+KEqxmBhwS2u1RbGQEevt
         ZEZcpxXjaasTlvOrgOTujW8C+/ygguQ/kb0lqJRDnxdOkl/NGHm31IZZLhtZHYwbO/6h
         UECM4cHEaKe1I5i6V8ua8N/hBFjqvkCFZBeHWY9kaMHeFc2fqYO2A7ahjn632SC8WWeR
         ApOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0dKW+Kd5iAiFQPX60Bp7aaI38nX4AF0yQ8hLDeb5gc8=;
        b=V4sYNxiL8HdQJElrcZsiZ+dVLsbxowTV97SioDGaK/9d+oNTkGkr6jU3kXrQNPxABg
         J21UZwz+i1WgOB1C473ah8U+zx2UBfc5XuUABbyQkcgqbw6i5jqraqLvgcsNST5XqPh5
         fJcglGuRPEARUFgL6U3af1kCg+67/gDUrnLjCk3gvAtX1Ig9GpASEjMgxoTOT5uab/Fy
         1f+RQEnqVaAa+91XZvZFeO9tHiKH4902/1lqvCZiAvYcQsx8R2KHTwc9W0CAC3fxM8iQ
         H+4PovM2SWTI7f9kmLuQVMT5nsIAzdDL9wxcQKC83DX4HoIMsAyZy0dJY6eH6wGCJFdt
         uSEQ==
X-Gm-Message-State: AOAM533LLFQS2fBiRWnijBzxFa1qYjTTzJKYj6lFBj+PHwnPCpJqRmI5
        OYZOkxImgQ2vy6aY+R8zNt8=
X-Google-Smtp-Source: ABdhPJzgMu3yWE9LnAFG9gGAMC7UrErODLlG4QecO4O0nsWOWfTXYEv2cpZuEl1oLyvhscdLH5us0Q==
X-Received: by 2002:a17:902:ea92:: with SMTP id x18mr3046191plb.157.1591704909657;
        Tue, 09 Jun 2020 05:15:09 -0700 (PDT)
Received: from localhost ([49.207.50.180])
        by smtp.gmail.com with ESMTPSA id k7sm7624998pfp.84.2020.06.09.05.15.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jun 2020 05:15:08 -0700 (PDT)
Date:   Tue, 9 Jun 2020 17:45:06 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: vmsplit 4g/4g
Message-ID: <20200609121506.GA7846@afzalpc>
References: <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
 <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc>
 <CAK8P3a2=o6RkONUoHTaR-2jpXg-wa-YnCYi0a4gAknYmvu8X7Q@mail.gmail.com>
 <20200608111834.GB5736@afzalpc>
 <CAK8P3a1q51=_DUS1A8k67c3TyQ+7LTpeo98LmzoFK=qg+8Fktw@mail.gmail.com>
 <20200608151727.GA5017@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608151727.GA5017@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 08, 2020 at 08:47:27PM +0530, afzal mohammed wrote:
> On Mon, Jun 08, 2020 at 04:43:57PM +0200, Arnd Bergmann wrote:

> > There is another difference: get_user_pages_fast() does not return
> > a  vm_area_struct pointer, which is where you would check the access
> > permissions. I suppose those pointers could not be returned to callers
> > that don't already hold the mmap_sem.
> 
> Ok, thanks for the details, i need to familiarize better with mm.

i was & now more confused w.r.t checking access permission using
vm_area_struct to deny write on a read only user page.

i have been using get_user_pages_fast() w/ FOLL_WRITE in copy_to_user.
Isn't that sufficient ?, afaiu, get_user_pages_fast() will ensure that
w/ FOLL_WRITE, pte has write permission, else no struct page * is
handed back to the caller.

One of the simplified path which could be relevant in the majority of
the cases that i figured out as follows,

 get_user_pages_fast
  internal_user_pages_fast
   gup_pgd_range [ no mmap_sem acquire path]
    gup_p4d_range 
     gup_pud_range
      gup_pmd_range
       gup_pte_range
		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
                 [ causes to return NULL page if access violation ]

   __gup_longterm_unlocked [ mmap_sem acquire path]
    get_user_pages_unlocked
     __get_user_pages_locked
      __get_user_pages
       follow_page_mask
        follow_p4d_mask
         follow_pud_mask
          follow_pmd_mask
           follow_page_pte
	        if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags))
                 [ causes to return NULL page if access violation ]

As far as i could see none of the get_user_pages() caller are passing
struct vm_area_struct ** to get it populated.

And Ingo's series eons ago didn't either pass it or check permission
using it (it was passing a 'write' arguement, which i believe
corrresponds to FOLL_WRITE)

Am i missing something or wrong in the analysis ?

Regards
afzal
