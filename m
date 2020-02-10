Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE066C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820542082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rSwTITTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJKfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:35:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45796 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:35:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id f25so6489192ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gBA2mpqc5yNuBwQF0S/7vQMG1htEwiZgSuMMRsfYXAs=;
        b=rSwTITTB+2r28n2Butgc7Bsjdj50BTP4ffGx1My9Imv9wCXcLjgtbxkcwJVYTU95Ef
         XaMMMNinTsqW5qDSvh1u3a16YuEDuFSGP9OzOn8c7yz5ryA7b5UCHRmLQlAKS6mjOUTi
         RN2JoND+a3Oc451cl65w+eSeo3j7CECjTGa70SgqaV2bV1IM4wBNN3h0PJJM28mi66a6
         jSn6txrRpKv72mBZJYUgWIpAJ7mdothPRIiA9ZdgsI2jFewnRyY/ZO1VUiO7A+sYQ7cv
         wo3vIpKcUXJoQ7XNxryqC6kYFRbgPESx8Yx4E8CswvMVNdwnjdVEoy+dPN0srbtCY5Nk
         nXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBA2mpqc5yNuBwQF0S/7vQMG1htEwiZgSuMMRsfYXAs=;
        b=a0ROn2Ze5gV9J9ga5Rd0ZgIXmZTxokkocHQxMBThYehuVZ7WpQlhzJZvXSna6m9ic3
         VivxRyFaHx5Ug7oO5nJ2LL28FZitXgkQZOutRkCG+rD1U+DcDDzPMaYHptKHirid0OIm
         b3d6n+uTk05377ETHyy4Ve2wZuxbmoa6vsklpz1OO/ATDcflNA8ISsZnjeSzTPc2bWS4
         zHyswmOQY1bBBjTbkpZaZJ52YlluYMtK91YWBtsVa1NET6QSOmybXKLS+KWlvPkx8AAZ
         X8Zk/EvpumXHYd1Q/H+ePrht13uoQsaY87l66ibzKIv+B7QY+lkZSBzNW2oStmI3qUCW
         IbTw==
X-Gm-Message-State: APjAAAUSOqPyLQ5rfGeUosDRuicMsVXdE+SjBXRKppO97Lsz3X5XuwUr
        Pg2WG7lcUUdETM3Uu7WdxSC/kg==
X-Google-Smtp-Source: APXvYqxUtuigBVXmjs6cg4R5cddlet9eURMDw2uVtBl3TeBZ31CaHSWoMuD6/oA10TDgIs101r7shg==
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr494979ljj.265.1581330939239;
        Mon, 10 Feb 2020 02:35:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m24sm7474324ljb.81.2020.02.10.02.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 02:35:38 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E79D4100B0A; Mon, 10 Feb 2020 13:35:56 +0300 (+03)
Date:   Mon, 10 Feb 2020 13:35:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200210103556.wz72op4g554qn5jm@box>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box>
 <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box>
 <CADyq12xgnVByYOkL=GcszYYKzDpg254QEOFoW8=e1y=bmOCcFQ@mail.gmail.com>
 <20200203130940.enfvdsbn42hhoaki@box>
 <CADyq12x98QspiWSqNui1OH8+FEUzVyJwxia+ho00S2+Q+PmTjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12x98QspiWSqNui1OH8+FEUzVyJwxia+ho00S2+Q+PmTjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 12:42:15PM -0800, Brian Geffon wrote:
> Hi Kirill,
> I started a new thread https://lkml.org/lkml/2020/2/7/640 for my v4
> patch. But I wanted to quickly address your comments. Regarding the
> concern around the rmap, no changes actually need to be made. If we
> were to unlink_anon_vma(vma) and then set vma->anon_vma = NULL, that
> would be fine but then as soon as there was a fault the same anon_vma
> would be attached since it's a private anonymous mapping. So there is
> really nothing to do regarding the rmap.

Okay.

My worry was that we create a new VMA with the same anon_vma *and*
vm_pgoff, but I just realized we can do the same with the current
mremap(2) plus following mmap(2) in the old place. So it's not regression.

I guess we are fine here.

> I considered the two flag approach but since I could not come up with
> a concrete use case of MREMAP_MUSTMOVE I decided to just leave the
> single MREMAP_DONTUNMAP flag, the two flag approach would be only for
> clarifying the operations so I'm not sure it's worth it. (Still trying
> to come up with a better name). But I've attached a man page diff to
> the latest patch.

At least it doesn't have 'FIXED' semantics forced on user. It's fine with
me.

-- 
 Kirill A. Shutemov
