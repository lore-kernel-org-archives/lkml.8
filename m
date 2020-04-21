Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E9C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3582206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yYEhL7H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgDUOek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgDUOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:34:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD870C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:34:38 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j4so14621438qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W/B7BqjKBM4LZhb4muvBIRGp0mx98vy+3KswtAICBb4=;
        b=yYEhL7H/J2T6a6KKsWtsnbqwV2cWxzG4KCkGuvV+HGGqMt695cfXAFayLf634O0D8N
         z82YE/+6dzOh9T+J54Go3udpMsHkfEiyEfpQQEFz+ni8Z3fO6HNe/+OEWnKNZGvCrQFv
         7MyV/oxIsGW5GZYEwaAvXlBxuvKYFNlzgnnPsGfdVhqH4efEsitrvCJ56KEkW1B6EH7w
         odftt7b2/bH6woOvOhVei6k0Joeaku1g3SZ20UgwSTx5fB7+fyYrg6uvz74nLee6+ml6
         5mnXx36doD8smCo0G5RTwTbK3elxGEOatUHv/n1//Z4svtrHZLE23Us6aYYi73MYJ3Ey
         vEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W/B7BqjKBM4LZhb4muvBIRGp0mx98vy+3KswtAICBb4=;
        b=Ce1Pukp3WjoA6o732kZWS+TxdGTA8MNequYix142e+e1ZSXSS1AwwFCUpyTNCnTI4H
         uE8ZcF1ci7QI796CzWiMb0FxoGL8PQppfO4r4NmUzjw4ClpkwFaXy9VO17Qi5Vl/So6o
         H0hYiqrCWf+Douu5+zpiRRYkZBIRVVCDyjXKxxRM0TaLJACsVWIwK8J+KWa1wQebonKy
         AZtOLIHLfVw+GiNJ9vJVWvcFPBSGmfFADrWoxiSVrClcOebUJq1eqAEBJVrSyjszynKp
         Z9EtJyOrRQ/UbJiIPQ+YaOA1+RZJmNIHZcCBvT7dd9dKx9LC3ZJ6pZtL4lvI8G/dieuB
         SZAQ==
X-Gm-Message-State: AGi0PuarlfoUkN8mYwuNp5h08Ruvu9MS7IOEIiqlx/s/DM1lpIi5Czc9
        CLp0ySzmcpIwrzK9A5wIpQeXGg==
X-Google-Smtp-Source: APiQypJDgokxNuDXaXcXJrXUlJsXPY/rZTc78iXB1zdm3cuK8LKoUspcWCkYeXie16EUDE3J1THnEA==
X-Received: by 2002:a37:48a:: with SMTP id 132mr22236543qke.390.1587479678044;
        Tue, 21 Apr 2020 07:34:38 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id u35sm1753086qtd.88.2020.04.21.07.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:34:37 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:34:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 18/18] mm: memcontrol: update page->mem_cgroup stability
 rules
Message-ID: <20200421143435.GB341682@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200421091014.2180-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421091014.2180-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:10:14PM +0800, Hillf Danton wrote:
> 
> On Mon, 20 Apr 2020 18:11:26 -0400 Johannes Weiner wrote:
> > 
> > The previous patches have simplified the access rules around
> > page->mem_cgroup somewhat:
> > 
> > 1. We never change page->mem_cgroup while the page is isolated by
> >    somebody else. This was by far the biggest exception to our rules
> >    and it didn't stop at lock_page() or lock_page_memcg().
> > 
> > 2. We charge pages before they get put into page tables now, so the
> >    somewhat fishy rule about "can be in page table as long as it's
> >    still locked" is now gone and boiled down to having an exclusive
> >    reference to the page.
> > 
> > Document the new rules. Any of the following will stabilize the
> > page->mem_cgroup association:
> > 
> > - the page lock
> > - LRU isolation
> > - lock_page_memcg()
> > - exclusive access to the page
> 
> Then rule-1 makes rule-3 no longer needed in mem_cgroup_move_account()?

Well, mem_cgroup_move_account() is the write side. It's the function
that changes page->mem_cgroup. So it needs to take all these locks in
order for the readside / fastpath to be okay with any one of them.
