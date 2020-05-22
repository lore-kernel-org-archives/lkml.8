Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA08C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F00207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eo7lQGKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEVBWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVBWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:22:00 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF0C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 18:21:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d191so7921518oib.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 18:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QyvoWyLbSuP/CE36awIf5BB51IMB409+51eWDRrnj+o=;
        b=Eo7lQGKOHDF30A7GNcKV32v4KA/gw8VRNtfwaqUHbU//l8VFzYd4AL6nlOvXafYo1J
         oGmiOu1nIw4u/UXYm/HIxmDLIT24DDR16SLM0VxYqPNGEkqiwzuWZG7MvXYnrMYxIM5p
         bj2tbLMJlKqusuKH8oIIgEEoZOl7Ku9uDuUtdg6iXHphIOZw12qUfviX9cVVJTFUrx6W
         8ezZYEAbkJVvy9zoCHi5QtkVxwfCJQRgFDJIFFIM5ZGYPuDtXA7fnHPuh6EZ59IC4zhV
         wA9BonHZEeM9/QHiPJh6qE3xG65XMUpTnUJeCMybdL0a8B+Qy+qZ0Y677bR6Q92cr4Bh
         RpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QyvoWyLbSuP/CE36awIf5BB51IMB409+51eWDRrnj+o=;
        b=NzGzDT28os5PWZ9r0teyZ2ucINmByN/36aVqdjFbSp1awTZs9+PdzrilbX+/cuHhOT
         0pjxLcsLHY9uFkdh1CFspj/iloRCbjlDJyTVMBXnk87dLdelzTkCPogx1CA160jDuxfU
         K6CxpsL3iC0xLTK2ei5YKEIEs9Bm2MpY+VO2zBfO7pn2pOax6lUHyw57MsZ+N+jRcA0B
         uhzvyeOueJ2vgjzrES4Hbekao9Thyq5Snvn2pQvcXzDQRFzeKBszt6txVCh5O5fN0s0K
         uZ6cf04zVRJbWWmgTSqINOiUKzgbTSyyPw+Oup2n/aL+sXQG8gejjKIc2pq8disOqn7p
         kElQ==
X-Gm-Message-State: AOAM532JIFMWatKHTNDfqqcciKxTGTMU1jB8ZB8luFBQ/38pFGaH0G5z
        ELBmy1pOe4DCQDE9uAOqv3NDxA==
X-Google-Smtp-Source: ABdhPJzyjC58A+oSo8vkohjD8TJiMy24fhHGzlIv/bIFMwS15PjCYp3lfL/QwYU03q+/SI2A4S/kVQ==
X-Received: by 2002:aca:ad45:: with SMTP id w66mr1001114oie.59.1590110518857;
        Thu, 21 May 2020 18:21:58 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p26sm2103753ood.28.2020.05.21.18.21.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 21 May 2020 18:21:57 -0700 (PDT)
Date:   Thu, 21 May 2020 18:21:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Anshuman Khandual <anshuman.khandual@arm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/vmstat: Add events for PMD based THP migration
 without split fix
In-Reply-To: <f1673e4f-64ca-9cf2-861c-7e8a7deeede1@arm.com>
Message-ID: <alpine.LSU.2.11.2005211812400.1524@eggly.anvils>
References: <alpine.LSU.2.11.2005210643340.482@eggly.anvils> <f1673e4f-64ca-9cf2-861c-7e8a7deeede1@arm.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020, Anshuman Khandual wrote:
> On 05/21/2020 07:19 PM, Hugh Dickins wrote:
> > Fix 5.7-rc6-mm1 page migration crash in unmap_and_move(): when the
> > page to be migrated has been freed from under us, that is considered 
> > a MIGRATEPAGE_SUCCESS, but no newpage has been allocated (and I don't
> > think it would ever need to be counted as a successful THP migration).
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > Fix to mm-vmstat-add-events-for-pmd-based-thp-migration-without-split.patch
> > 
> >  mm/migrate.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- 5.7-rc6-mm1/mm/migrate.c	2020-05-20 12:21:56.117693827 -0700
> > +++ linux/mm/migrate.c	2020-05-20 15:08:12.319476978 -0700
> > @@ -1248,7 +1248,7 @@ out:
> >  	 * we want to retry.
> >  	 */
> >  	if (rc == MIGRATEPAGE_SUCCESS) {
> > -		if (PageTransHuge(newpage))
> > +		if (newpage && PageTransHuge(newpage))
> >  			thp_migration_success(true);
> >  		put_page(page);
> >  		if (reason == MR_MEMORY_FAILURE) {
> > 
> 
> Thanks Hugh. I am preparing to respin the vmstat patch accommodating some
> earlier comments. Wondering if I should also fold these changes here after
> adding your signed-off-by ?

Thanks for asking, but please just fold this one-line fixup into your
respin without my signed-off-by: I'm not heavily invested in these stats,
just want to avoid the crash; and don't know if I would want to sign the
result.  You could add something like [hughd: fixed oops on NULL newpage]
to confirm that the fix is on board, but the fix is what matters.

Hugh
