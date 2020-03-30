Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37218C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C2920774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585606485;
	bh=7KpBR/W7+bPHCJpJEKwkHUbR4WHKWBABl2xYyvNQYNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LLsLuYQGO3NHKxj+gdu0TFx84bb9g7+LFCKcqdrXCXMl0WAD9LzafY9aTgq3bx/bY
	 ZaxVEkJ9W8UZZogUCkjq/oOKFUzaMopN9KuYZ2sct27017NC+54Mxp7Q9Po0eI69bO
	 38VDnyEnLJyuRoVhgTjd5b7KyARsPa78NwSchJho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgC3WOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbgC3WOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:14:43 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75535205ED;
        Mon, 30 Mar 2020 22:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585606482;
        bh=7KpBR/W7+bPHCJpJEKwkHUbR4WHKWBABl2xYyvNQYNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w0GY9JXgQUWqVWDe39zbN8b7c0l67cXTyBYBV3PuOdhxn/GqPZe6ZzSTdYz4kx/a6
         kkusRcdIDy0himtZvlpGoYzpgWqN2Z61BWNENKEGPvIZiv3awjsqWSyLYqi9VJTkqV
         dVw39RHlbzGwDsviHWSDQsIPm5cYVPlNGSzoruiE=
Date:   Mon, 30 Mar 2020 15:14:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of
 number of pages in __remove_pages()
Message-Id: <20200330151441.e3a704f7c98dc70cdce95d0e@linux-foundation.org>
In-Reply-To: <F45052AF-D619-4993-AFF4-1E417C3BF424@redhat.com>
References: <CAHk-=wj1K5rsyoPps3H5QW_KOxtDQ8zPJ-bc-BmYjT4jXU_7Og@mail.gmail.com>
        <F45052AF-D619-4993-AFF4-1E417C3BF424@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Mar 2020 22:41:18 +0200 David Hildenbrand <david@redhat.com> wrote:

> >   https://lore.kernel.org/linux-mm/20200128093542.6908-1-david@redhat.com/raw
> > 
> > and that one *does* have the "Withou=\nt" pattern in it. But it still
> > has the proper
> > 
> >   Content-Transfer-Encoding: quoted-printable
> > 
> > in it, so the recipient should decode it just fine (and again, you can
> > see that in the non-raw email - it looks just fine).
> > 
> > So your emails on lore look fine. I'm not seeing how that got corrupted.
> 
> *maybe* Andrew updated only the patch description, copying the raw content. Eventually he converts MIME only when importing, so the description got corrupted.
> 
> ... or the mail he received via cc got messed up by my mailing infrastructure.

Something like that.  It's sylpheed being weird.  In some situations
(save as...) it will perform the mime conversion but in others (%f in
an action menu) it does not.  So for David's patches I do save-as for
the patch and manually edit the mime out of changelog.  It's basically
"only David" so I haven't got around to doing anything smarter.

My nightly check-all-the-patches-for-various-cruft script emails me
about =3D but I didn't' have a test for "o=$m".  I just added one.




