Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C06EC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081BB20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jul2LE9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgICSkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgICSkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:40:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D1C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=twNne7EcIveImsxJ/Miw6pH23+YkOBeJ0NWRElVb5Rw=; b=jul2LE9HVKVYuXrYUjFG6nOg3x
        dMIBnhRWsQKsMAdRvT+Urniak2pCc5qLp41UJ/a7mPgxP18g8DPQEXUd/jS+7JLzBzBpsbvLoCvUj
        W9fX6g+su6ELqsZUu98o2Ue9pQ4qtiUINDhWT33SJdW7L3F3N0ODcGoSSmwfoGoA37ndMpk6z7Cbn
        GaNp5FGfcOzo89ArjTc6hZTDO/UllsLzaTaG8X2SHtz6UkGoRPqQc1gV2ckZP/2DUeNXSpF130b4j
        Dqs+5Jmpo7qYfOzTbBRNIyGQgAVO5ohB+KQtYzIlKi1+ud40iKXzGz8ah0ktOCWafqLB0OrekjUGr
        nVakNP7w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDu9G-0004SL-TH; Thu, 03 Sep 2020 18:39:50 +0000
Date:   Thu, 3 Sep 2020 19:39:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/gup: don't permit users to call get_user_pages with
 FOLL_LONGTERM
Message-ID: <20200903183950.GF14765@casper.infradead.org>
References: <20200819110100.23504-1-song.bao.hua@hisilicon.com>
 <e4265ac0-793d-053b-81b1-15e57c04b830@nvidia.com>
 <CAFqt6zb2GjO9KOVdKT1P0P-Wn+isnArous5gpw-AJ3va+fi9rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zb2GjO9KOVdKT1P0P-Wn+isnArous5gpw-AJ3va+fi9rw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 12:42:44PM +0530, Souptick Joarder wrote:
> We can use is_valid_gup_flags() inside ->
> get_user_pages_locked(),
> get_user_pages_unlocked(),
> pin_user_pages_locked() as well.
> 
> Are you planning to add it in future patches ?

If you're looking for a new project, adding a foll_t or gup_t or
something for the FOLL flags (like we have for gfp_t or vm_fault_t)
would be helpful.  We're inconsistent with our naming here.
