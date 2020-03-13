Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D9DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58092074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1Vej5By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgCMXS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:18:59 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36483 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:18:59 -0400
Received: by mail-il1-f195.google.com with SMTP id h3so10763286ils.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+ochZsnjp+nULBUUFjbPYvrQxl/WHyAk9Sli/WeJEM=;
        b=R1Vej5Byynd7VIHn9payGZbkP7KlEoNC8RVbdP7UJ8P8/MOGUV5nzqojxlZPbx32gd
         oPF+5rO9mZv0rVmMwy1K8x2mRSj2Y8OO6HZbk0D7EXBve+ssA0aLjZOspgcOZU/4SBRB
         WlPBghJN2+P53C/cibvOCl6/8G0AZ99SD8nqnKmIrX9M2jJBy6zm2fR+e+rJT2GrZDb6
         BvTkbT9wOxkQqS5Sc/Sbf29KPRR+9PcMR3lZZggm9R/OFtIU2BEA5Q0LbQ8X5xGK819J
         +fzSXpYDeTf2bnFTVx5WvbRorppn0X5/zDP4v1G44I3ODBru5oCejcYfRJGj2dmqf+S4
         CPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+ochZsnjp+nULBUUFjbPYvrQxl/WHyAk9Sli/WeJEM=;
        b=CmgRZ2OJlebSP76ktBjIsybSivr3vCeniK0AgvdSZPnzRMukNVyiAstBoOKW+JHUXU
         X+r9ewXjZr7MK7xya2KnwfKcLEZhtT94UWegka/tKM9MIjyrkWIcfCzMNGanj4BWa6Dh
         IstDp7NuX3hUUfPLwhklOE86kxfK8gqwS33Yhu0AFfaKnXY05RthRmSGrSUP3JQbvFB8
         tN99zVwUeZQgRfwB2bgMvkjc61JXwIh87/lHOY2CZjfS6mo4f+seNR77UZ5UDTUhWza8
         FD47aG3F/uMYEAH2Gpb7lhiOToIkKSrHlt0MpUEmDBV5gpF0HjfwC35yN8vvhrM+AdKy
         Zh1A==
X-Gm-Message-State: ANhLgQ2E9wXjytndB303UblbEjshBNe1pkGtbyUEY+C3u5+GkZYrFZgf
        Wm5JSIbYJq4hkAkDkl691P/RPcnVeR/iuCjalYM=
X-Google-Smtp-Source: ADFU+vuvMkFrSIvt1cIgCp/9ZXcNxJMYgLzoQ88Ta4HMOygBLKBzooMHryYn4YYBZg6/ozPzqUj3T7nTIjHZ/lF5tno=
X-Received: by 2002:a92:860f:: with SMTP id g15mr15699025ild.297.1584141538349;
 Fri, 13 Mar 2020 16:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200313184909.4560-1-hqjagain@gmail.com> <20200313184909.4560-2-hqjagain@gmail.com>
 <20200313191426.GO22433@bombadil.infradead.org>
In-Reply-To: <20200313191426.GO22433@bombadil.infradead.org>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sat, 14 Mar 2020 07:18:47 +0800
Message-ID: <CAJRQjodgLgZShiA4twc6FyNspyoL5h7kGtfeOC9UA=4nD_8Qxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] radix-tree: fix kernel-doc for radix_tree_find_next_bit
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought it's better to update the function description as it could
be more readable from source code.

On Sat, Mar 14, 2020 at 3:14 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Mar 14, 2020 at 02:49:08AM +0800, Qiujun Huang wrote:
> >   * radix_tree_find_next_bit - find the next set bit in a memory region
> >   *
> >   * @addr: The address to base the search on
> > - * @size: The bitmap size in bits
> > + * @tag: The tag index (< RADIX_TREE_MAX_TAGS)
> >   * @offset: The bitnumber to start searching at
> >   *
> >   * Unrollable variant of find_next_bit() for constant size arrays.
> > - * Tail bits starting from size to roundup(size, BITS_PER_LONG) must be zero.
> > - * Returns next bit offset, or size if nothing found.
> > + * Returns next bit offset, or RADIX_TREE_MAP_SIZE if nothing found.
> >   */
> >  static __always_inline unsigned long
> >  radix_tree_find_next_bit(struct radix_tree_node *node, unsigned int tag,
>
> Ugh, this is a static function with kernel-doc.  What a waste of time ;-(
