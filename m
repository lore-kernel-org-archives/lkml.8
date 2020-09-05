Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E057C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F8920797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxH98ftS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgIEBL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIEBLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:11:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84FC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 18:11:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a15so10059785ljk.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 18:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVcjVt4eRCCqDmBRs4CW6qVJs8qz0idz0moivADsBgI=;
        b=kxH98ftSFWAPsaHJTwX+WhvhUjCZUTPhHBinBNAIzR04z6fSpI1zS5DJZFMagawr0J
         YoQ3fUF+RlxxgduK7z1/GRhYa9Dygtd8Oc0WJJXK/Xq8aEk3HNbFpqsLPPM8BqcM9FLb
         hipXojb9Wzw77e5JIyXAOcsSzdZyPgGToQ2Ta7V8Z/sEFyXvS8pbjuiaROFpyTBn4JZf
         pCGdHmZqi/ao32ZRiHDJp/AeZTrbdv+9C0u/bApzFSMxVS0aSf2akzJL6yh6PaCREqx1
         LgnVy+lwHmuAW9DM0z76gckFx9g1xmf+baJsP2LRzXT1j1AiHohOmvj7oSziChZq5gk9
         lQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVcjVt4eRCCqDmBRs4CW6qVJs8qz0idz0moivADsBgI=;
        b=UjUpPsAjeJLrnBYpKG//skx+6+stl5zPLqnrq3ETFA+bUhm2zvl2bfGB2pEo8B4G0c
         mBumFC22snn+mnA8Q2FGgUTX3zUCAJCqY7zR1eBlyuOX+l/h2McfAybOXoZEkSo43GrK
         n0PGdH4/Wdd4156+p7EKADm4wg1T8BvC+VnGrjSAok1SZdW1U+pF0FbwOeXh3T4i/g2K
         F+DqkV+Jpzx3moSzEr9uM3Bt3xxxeQl1seS4VNXOtM0UKl5SS6DZmufogLtgY+XUlLjr
         oNxlrCHiamRSsU8+DZW8adVehXkkqdNfEsiVGwoAjqYyVKeCcK1b7yInx6iy5aJS7yp8
         +dJg==
X-Gm-Message-State: AOAM532nBu78ut7nzrSzZDLAebXsT3L0MQf9SYK5YjeXY7gys6O6amXT
        cQur+r5BV60SPcuJPbMjWLCKtmIOyZ1fhbSpuRw=
X-Google-Smtp-Source: ABdhPJzp6Hqvot9y7mTd2pN3V6/9sHFQaaXXammREKjLP1Pkf8aJMWhwhQ2SctDwvxrRX0w733PFGIGKk0ZmpypD0BQ=
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr4199950ljh.70.1599268282585;
 Fri, 04 Sep 2020 18:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200819110100.23504-1-song.bao.hua@hisilicon.com>
 <e4265ac0-793d-053b-81b1-15e57c04b830@nvidia.com> <CAFqt6zb2GjO9KOVdKT1P0P-Wn+isnArous5gpw-AJ3va+fi9rw@mail.gmail.com>
 <20200903183950.GF14765@casper.infradead.org>
In-Reply-To: <20200903183950.GF14765@casper.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 5 Sep 2020 06:41:11 +0530
Message-ID: <CAFqt6zYBDEsHqdQtgh+eZUAf+ODet=+LS7gqSkX5JO9eqS=_TA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: don't permit users to call get_user_pages with FOLL_LONGTERM
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 12:09 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 03, 2020 at 12:42:44PM +0530, Souptick Joarder wrote:
> > We can use is_valid_gup_flags() inside ->
> > get_user_pages_locked(),
> > get_user_pages_unlocked(),
> > pin_user_pages_locked() as well.
> >
> > Are you planning to add it in future patches ?
>
> If you're looking for a new project, adding a foll_t or gup_t or
> something for the FOLL flags (like we have for gfp_t or vm_fault_t)
> would be helpful.  We're inconsistent with our naming here.

Sure. I will start looking into this and come up with a RFC version.
