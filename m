Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E637C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 04:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238AA20838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 04:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MWY3cjEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgCDEd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 23:33:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgCDEd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 23:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+kkuNh//UhpJs53ENwLyQaRMl45p4tqP31oNQE1YBVw=; b=MWY3cjEVPVHDc1C/QBRFwu1Z7g
        MhL6vOk+0OOqLoVxGEjoGD5KE+OMQz0chu6NkhUZlUXvcN3Ah302k4B6rnwc3XyMd8oMv+GjzScRs
        Hk1pw8c4gPXN8ngebT3Rfx+w8HDT3dMnitrFCrD6kx3t17LqR/JZoVXY7z55Wp4f0lJoR2XG9rMoG
        Q/4zQKpoSzHInhFgJbm72Aqmgf9DtsZIDLV0H1Q3/+4oIdFFyuEhDA+KUwLjGOK4VtR4B2e+SExyl
        /z9Wt8tAlFxtb0Om3ecJC36WzrUtnIZWFwfWx7DRJ8322hJD4aJAwm3UftDZuCpb7ZmWLPIBLwz2m
        VIzgo+FA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9LjI-0007Wz-9J; Wed, 04 Mar 2020 04:33:56 +0000
Date:   Tue, 3 Mar 2020 20:33:56 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200304043356.GC29971@bombadil.infradead.org>
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304040515.GX2935@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 08:05:15PM -0800, Paul E. McKenney wrote:
> On Tue, Mar 03, 2020 at 07:33:29PM -0800, Matthew Wilcox wrote:
> > On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> > > Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> > > could happen concurrently result in data races, but those operate only
> > > on a single bit that are pretty much harmless. For example,
> > 
> > Those aren't data races.  The writes are protected by a spinlock and the
> > reads by the RCU read lock.  If the tool can't handle RCU protection,
> > it's not going to be much use.
> 
> Would KCSAN's ASSERT_EXCLUSIVE_BITS() help here?

I'm quite lost in the sea of new macros that have been added to help
with KCSAN.  It doesn't help that they're in -next somewhere that I
can't find, and not in mainline yet.  Is there documentation somewhere?

> RCU readers -do- exclude pre-insertion initialization on the one hand,
> and those post-removal accesses that follow a grace period, but only
> if that grace period starts after the removal.  In addition, the
> accesses due to rcu_dereference(), rcu_assign_pointer(), and similar
> are guaranteed to work even if they are concurrent.
> 
> Or am I missing something subtle here?

I probably am.  An XArray is composed of a tree of xa_nodes:

struct xa_node {
        unsigned char   shift;          /* Bits remaining in each slot */
        unsigned char   offset;         /* Slot offset in parent */
        unsigned char   count;          /* Total entry count */
        unsigned char   nr_values;      /* Value entry count */
        struct xa_node __rcu *parent;   /* NULL at top of tree */
        struct xarray   *array;         /* The array we belong to */
        union {
                struct list_head private_list;  /* For tree user */
                struct rcu_head rcu_head;       /* Used when freeing node */
        };
        void __rcu      *slots[XA_CHUNK_SIZE];
        union {
                unsigned long   tags[XA_MAX_MARKS][XA_MARK_LONGS];
                unsigned long   marks[XA_MAX_MARKS][XA_MARK_LONGS];
        };
};

'shift' is initialised before the node is inserted into the tree.
Ditto 'offset'.  'count' and 'nr_values' should only be touched with the
xa_lock held.  'parent' might be modified with the lock held and an RCU
reader expecting to see either the previous or new value.  'array' should
not change once the node is inserted.  private_list is, I believe, only
modified with the lock held.  'slots' may be modified with the xa_lock
held, and simultaneously read by an RCU reader.  Ditto 'tags'/'marks'.

The RCU readers are prepared for what they see to be inconsistent --
a fact of life when dealing with RCU!  So in a sense, yes, there is a
race there.  But it's a known, accepted race, and that acceptance is
indicated by the fact that the RCU lock is held.  Does there need to be
more annotation here?  Or is there an un-noticed bug that the tool is
legitimately pointing out?
