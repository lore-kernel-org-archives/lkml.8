Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54227C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7D420838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Pa7Yy+L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBJU2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:28:53 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39044 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJU2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:28:53 -0500
Received: by mail-qv1-f68.google.com with SMTP id y8so3852570qvk.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cH1NZdrBoIjAY1XAC9d75vxrcvobYxggMgU+/9QfuUs=;
        b=Pa7Yy+L0thH8M5xaedZm9QMAkv3kj9blTWqJ1OMzSYrYHivdRyjtS89INBNzgRFNN2
         Sm/sFzeV13gZnmTl5E4GYJNG6jj+dMo5KlGzMBQZByY7moeZDQbB4pSiBdG7qXYPKqdH
         X674SLKU3UIPzFy976hLebggwS//zTuOPDf9Ko6HnwwZk7Zw7OiX//I1za5VrF103lRj
         GqfLzZNvx9mx/m7aqqzoB98UlLrUGn/K7XZSugGhteXh1Rs36e2SrpIturrK5rR9xdpW
         MKe7q/4m617FydaIEUGemkorv9Pmgqbm70XpsbvGmcLUXTelV9wMO7UZlNIDAsfoSln1
         ZV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cH1NZdrBoIjAY1XAC9d75vxrcvobYxggMgU+/9QfuUs=;
        b=pRoh6YbUSAdLB0+wa/Yg4MaRRol/oJ5R1eJAn+ZqAA5iyMUa4OqrD+b5cuAzZpx/nd
         D7Xne0GEJq/Xtn9wW8yymROw6V5k2I3aygvq8UdwH4PAUAzUwGzdkMAMMAX7XQxO3dfg
         ug1O8pJKp1ymcAjkLdawAY7D7YBqlzHI544sT+a+2BPCHVc8gam+UgFzrc0Myy/pb7M7
         IceUtJFjpSk0Z5R8clJYV/9l2bV3MeT/AoE/Pyg05uO8JNsXQDNzVyhaUTUN3vPVbDTE
         xR7/iPeR3SGMijAJ/QPKmD5JjbB87yZdyja+yJKgUXx1jRkDo/QPj96ZC/tlgVPy+Zrk
         d8PQ==
X-Gm-Message-State: APjAAAXMn9Ew6higIMmjLOFT1FhhtwILig408NQlya36wAZxFQZLfPGj
        iTb054mSzApqzL3K2KcuMlIrbg==
X-Google-Smtp-Source: APXvYqywW+k/JZMKyfuID4VcPgq29DGzOE4AGMgy8OusuES1E5cDZl4CuoQgAGe/WJ7DEqTbd3/gVg==
X-Received: by 2002:ad4:446b:: with SMTP id s11mr11575471qvt.148.1581366531833;
        Mon, 10 Feb 2020 12:28:51 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x41sm790275qtj.52.2020.02.10.12.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 12:28:51 -0800 (PST)
Message-ID: <1581366529.7365.49.camel@lca.pw>
Subject: Re: [PATCH -next] mm/filemap: fix a data race in filemap_fault()
From:   Qian Cai <cai@lca.pw>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 15:28:49 -0500
In-Reply-To: <20200210192155.GM8731@bombadil.infradead.org>
References: <1581354029-20154-1-git-send-email-cai@lca.pw>
         <20200210172511.GL8731@bombadil.infradead.org>
         <1581362448.7365.38.camel@lca.pw>
         <20200210192155.GM8731@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 11:21 -0800, Matthew Wilcox wrote:
> On Mon, Feb 10, 2020 at 02:20:48PM -0500, Qian Cai wrote:
> > On Mon, 2020-02-10 at 09:25 -0800, Matthew Wilcox wrote:
> > > On Mon, Feb 10, 2020 at 12:00:29PM -0500, Qian Cai wrote:
> > > > @@ -2622,7 +2622,7 @@ void filemap_map_pages(struct vm_fault *vmf,
> > > >  		if (page->index >= max_idx)
> > > >  			goto unlock;
> > > >  
> > > > -		if (file->f_ra.mmap_miss > 0)
> > > > +		if (data_race(file->f_ra.mmap_miss > 0))
> > > >  			file->f_ra.mmap_miss--;
> > > 
> > > How is this safe?  Two threads can each see 1, and then both decrement the
> > > in-memory copy, causing it to end up at -1.
> > 
> > Well, I meant to say it is safe from *data* races rather than all other races,
> > but it is a good catch for the underflow cases and makes some sense to fix them
> > together (so we don't need to touch the same lines over and over again).
> 
> My point is that this is a legitimate warning from the sanitiser.
> The point of your patches should not be to remove all the warnings!

The KCSAN will assume the write is "atomic" if it is aligned and within word-
size which is the case for "ra->mmap_miss", so I somehow skip auditing the
locking around the concurrent writers, but I got your point. Next time, I'll
spend a bit more time looking.
