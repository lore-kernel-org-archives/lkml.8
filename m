Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA1C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A65F207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="irDldOUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIADci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIADch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:32:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E183FC0612FF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:32:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so8301934qkn.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D9LQOOZMhk5sGMfOr4O9KkwDsvLVRqelWrWxaR7xfSg=;
        b=irDldOUhcTG9Ln66BCPoHZ18lasJTXAdXl52OIMakYvfZpSLWJQm9CCRGkw38gYvxE
         62WNrZV6h4mmiNOB6XKFu47+hPBQA2ImO7Gl5/J00RvHAkdGgbNiUEQqkwZkhsj32dIp
         XMqpePtNDW4eef/RawyKIyyVGeRUs+uwCL2mRvfvZT/TmqURCqkofPKXA0PazKWdZZEl
         aNBNlZOThqQiugYG1oRgKUqgGUitI0amnMBRwzpPaoM1u1mj1lZ4SIxhRKg2IqWqhvhf
         hHdYdayvBPc1W/vy23fOxuyYrWDv4XHba61kAonvTEYLl4AOEqXIzxQywRLnrfK+3z3s
         nV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D9LQOOZMhk5sGMfOr4O9KkwDsvLVRqelWrWxaR7xfSg=;
        b=VYNO+bCkg8vkT6EgF7dNOKny1/IQ0ZHGF3ihGXIEEncgWtfTxnM7p/ZupCHI4uXYcM
         0H2CJQMItXf9jvYIdgvZ/MufkXNQJ8NNBNCa9YywBg7EZA24XsYq3PKmMW2L7zNnvV8t
         rnSkMwGagpyT1UhYN/S+sTFHlJsewgDjuf/lldhqrB6iD0+WRvOYpdnad7WBopQYtrq5
         mv4ZchGAmU+TkEF08Ph5zdwUiBgtFMguAhPPGAOwQk24SJ9rb12+lr3GmofcOtsDF/Bo
         5ioFIFNUafrZ6602oiMS1GOLrFJqkgChIsulliAvZCbi04QTS3t3/OgnkrWGSqMTxkqF
         qw3Q==
X-Gm-Message-State: AOAM533wzGh7WvgG4QgceD8OtpKGpQc0o5KQY31QbbGJ0h5jZMe9Erai
        YwWT8Wj1AORsKltubl3mxvnVOg==
X-Google-Smtp-Source: ABdhPJyZ12jz6sA34cLdjam+P+4nzb9LIvuDeGEB9QepX1ckrsKMkPcSSG9jKEFMisESG6z1f12SNw==
X-Received: by 2002:a05:620a:b1a:: with SMTP id t26mr4627615qkg.353.1598931155876;
        Mon, 31 Aug 2020 20:32:35 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z10sm12294219qtf.24.2020.08.31.20.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 20:32:35 -0700 (PDT)
Date:   Mon, 31 Aug 2020 23:32:28 -0400
From:   Qian Cai <cai@lca.pw>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tom.leiming@gmail.com, paulmck@kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200901033227.GA10262@lca.pw>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <d96b0b3f-51f3-be3d-0a94-16471d6bf892@i-love.sakura.ne.jp>
 <20200901005131.GA3300@lca.pw>
 <20200901010928.GC1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901010928.GC1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:09:28AM +0100, Al Viro wrote:
> On Mon, Aug 31, 2020 at 08:51:32PM -0400, Qian Cai wrote:
> > On Fri, Aug 07, 2020 at 09:34:08PM +0900, Tetsuo Handa wrote:
> > > On 2020/08/07 21:27, Al Viro wrote:
> > > > On Fri, Aug 07, 2020 at 07:35:08PM +0900, Tetsuo Handa wrote:
> > > >> syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
> > > >> iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
> > > >> ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
> > > >> call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> > > >> vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
> > > >> with pipe->mutex held.
> > > >>
> > > >> The reason of falling into infinite busy loop is that iter_file_splice_write()
> > > >> for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
> > > >> while for_each_bvec() cannot handle .bv_len == 0.
> > > > 
> > > > broken in 1bdc76aea115 "iov_iter: use bvec iterator to implement iterate_bvec()",
> > > > unless I'm misreading it...
> > 
> > I have been chasing something similar for a while as in,
> > 
> > https://lore.kernel.org/linux-fsdevel/89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw/
> > 
> > In my case, it seems the endless loop happens in iterate_iovec() instead where
> > I put a debug patch here,
> > 
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -33,6 +33,7 @@
> >                 if (unlikely(!__v.iov_len))             \
> >                         continue;                       \
> >                 __v.iov_base = __p->iov_base;           \
> > +               printk_ratelimited("ITER_IOVEC left = %zu, n = %zu\n", left, n); \
> >                 left = (STEP);                          \
> >                 __v.iov_len -= left;                    \
> >                 skip = __v.iov_len;                     \
> > 
> > and end up seeing overflows ("n" supposes to be less than PAGE_SIZE) before the
> > soft-lockups and a dead system,
> > 
> > [ 4300.249180][T470195] ITER_IOVEC left = 0, n = 48566423
> > 
> > Thoughts?
> 
> Er...  Where does that size come from?  If that's generic_perform_write(),
> I'd like to see pos, offset and bytes at the time of call...  ->iov_offset would
> also be interesting to see (along with the entire iovec array, really).

I used a new debug patch but not sure how to capture without
printk_ratelimited() because the call sites are large,

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d812eef23a32..214b93c3d8a8 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -33,6 +33,7 @@
                if (unlikely(!__v.iov_len))             \
                        continue;                       \
                __v.iov_base = __p->iov_base;           \
+               printk_ratelimited("ITER_IOVEC left = %zu, n = %zu, iov_offset = %zu, iov_base = %px, iov_len = %lu\n", left, n, i->iov_offset, __p->iov_base, __p->iov_len); \
                left = (STEP);                          \
                __v.iov_len -= left;                    \
                skip = __v.iov_len;                     \
diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..202b0ab28adf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3408,6 +3408,7 @@ ssize_t generic_perform_write(struct file *file,
                if (mapping_writably_mapped(mapping))
                        flush_dcache_page(page);
 
+               printk_ratelimited("pos = %lld, offset = %ld, bytes = %ld\n", pos, offset, bytes);
                copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
                flush_dcache_page(page);

Al, does it help? If not, can you cook a debug patch instead?

[  587.765400][T21348] pos = 468152746240, offset = 256, bytes = 3840
[  587.765424][T21348] pos = 468152750080, offset = 0, bytes = 4096
[  587.765439][T21348] pos = 468152754176, offset = 0, bytes = 4096
[  587.765455][T21348] pos = 468152758272, offset = 0, bytes = 4096
[  591.235409][T22038] ITER_IOVEC left = 0, n = 22476968, iov_offset = 0, iov_base = 00007ff12570c000, iov_len = 20
[  591.313456][T22038] ITER_IOVEC left = 0, n = 22476948, iov_offset = 0, iov_base = 00007ff123250000, iov_len = 20
[  591.363679][T22038] ITER_IOVEC left = 0, n = 22476928, iov_offset = 0, iov_base = 00007ff123650000, iov_len = 6370
[  591.413217][T22038] ITER_IOVEC left = 0, n = 22470558, iov_offset = 0, iov_base = 00007ff123850000, iov_len = 20
[  591.459754][T22038] ITER_IOVEC left = 0, n = 22470538, iov_offset = 0, iov_base = 00007ff12570c000, iov_len = 376
[  591.507748][T22038] ITER_IOVEC left = 0, n = 22470162, iov_offset = 0, iov_base = 00007ff12570c000, iov_len = 3473
[  591.557395][T22038] ITER_IOVEC left = 0, n = 22466689, iov_offset = 0, iov_base = 00007ff123250000, iov_len = 20
[  591.605295][T22038] ITER_IOVEC left = 0, n = 22466669, iov_offset = 0, iov_base = 00007ff12570a000, iov_len = 3392
[  591.653045][T22038] ITER_IOVEC left = 0, n = 22463277, iov_offset = 0, iov_base = 00007ff123250000, iov_len = 1329038
[  591.705324][T22038] ITER_IOVEC left = 0, n = 21134239, iov_offset = 0, iov_base = 00007ff123850000, iov_len = 20
