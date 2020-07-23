Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A69C2BA4D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEA122D00
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhLX/Ze7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGWGOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:14:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42834 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726742AbgGWGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595484889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgqIrKX/7BhVPFFnXVO8mJiVW0XzfuDmFwHKiV//tOE=;
        b=MhLX/Ze7Up7iZ8RIe+C3pu0xSI4lQkbq2vz9h4op7phbmjUHd6jWKRS9C01gWA2adRHoso
        F9ZvHFf8pDxhWJKru9A6lrew2gEUAIIMG7UmUOiNYcy/PPBLTT04Oii/W4ltVJvk+D281U
        C9wjIcq5eB0lTQTFDke8KOOpn27TtaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-aO4f4vUrNrCMwr-5pVeFBw-1; Thu, 23 Jul 2020 02:14:45 -0400
X-MC-Unique: aO4f4vUrNrCMwr-5pVeFBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55BFE80183C;
        Thu, 23 Jul 2020 06:14:44 +0000 (UTC)
Received: from localhost (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAD345FC3B;
        Thu, 23 Jul 2020 06:14:40 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:14:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/4] mm/hugetlb.c: Remove the unnecessary
 non_swap_entry()
Message-ID: <20200723061437.GQ32539@MiWiFi-R3L-srv>
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-3-bhe@redhat.com>
 <f66035ea-abfa-2523-8df5-ceb3599c9395@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66035ea-abfa-2523-8df5-ceb3599c9395@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/20 at 10:36am, Anshuman Khandual wrote:
> 
> 
> On 07/23/2020 08:52 AM, Baoquan He wrote:
> > The checking is_migration_entry() and is_hwpoison_entry() are stricter
> > than non_swap_entry(), means they have covered the conditional check
> > which non_swap_entry() is doing.
> 
> They are no stricter as such but implicitly contains non_swap_entry() in itself.
> If a swap entry tests positive for either is_[migration|hwpoison]_entry(), then
> its swap_type() is among SWP_MIGRATION_READ, SWP_MIGRATION_WRITE and SWP_HWPOISON.
> All these types >= MAX_SWAPFILES, exactly what is asserted with non_swap_entry().
> 
> > 
> > Hence remove the unnecessary non_swap_entry() in is_hugetlb_entry_migration()
> > and is_hugetlb_entry_hwpoisoned() to simplify code.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/hugetlb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 3569e731e66b..c14837854392 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3748,7 +3748,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
> >  	if (huge_pte_none(pte) || pte_present(pte))
> >  		return false;
> >  	swp = pte_to_swp_entry(pte);
> > -	if (non_swap_entry(swp) && is_migration_entry(swp))
> > +	if (is_migration_entry(swp))
> >  		return true;
> >  	else
> >  		return false;
> > @@ -3761,7 +3761,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
> >  	if (huge_pte_none(pte) || pte_present(pte))
> >  		return false;
> >  	swp = pte_to_swp_entry(pte);
> > -	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
> > +	if (is_hwpoison_entry(swp))
> >  		return true;
> >  	else
> >  		return false;
> > 
> 
> It would be better if the commit message contains details about
> the existing redundant check. But either way.

Thanks for your advice. Do you think updating the log as below is OK?

~~~~~~~~
If a swap entry tests positive for either is_[migration|hwpoison]_entry(), then
its swap_type() is among SWP_MIGRATION_READ, SWP_MIGRATION_WRITE and SWP_HWPOISON.
All these types >= MAX_SWAPFILES, exactly what is asserted with non_swap_entry().

So the checking non_swap_entry() in is_hugetlb_entry_migration() and
is_hugetlb_entry_hwpoisoned() is redundant.

Let's remove it to optimize code.
~~~~~~~~

Thanks
Baoquan

