Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0273C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DA224649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od8Ik/Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCJCCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:02:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41573 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgCJCCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:02:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id z65so5706332pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J7pCBtBDSjcVtEqS1SMqVaavriUKG9Gcw86QjHCE7is=;
        b=od8Ik/Ke9KrtA9c/iHuIQuTCQ4UUl9WD9SzJlxBa0aaRNAas2uFuzo6bHEfdOUpWGm
         WeUdb/iJ7YvGs4FVnzeE3n/MncwQcj9DyktXeEC+gNykkoQkBGT6NDSyM59/wmD91jHP
         J7MugXKmAov+76/+0Kd3UjFBamWcWzVmFMy21HGRegnvWAJEziGuFvSt/YETxzmQCEcG
         Nf8fkbMpKGksMaRpqWgBWAzPt6gY+4XqZKkWEgluS0U9VLe3zlffZVr1AxjfY39HYelJ
         UHbdZVbmytWTt3fXxV3Ls781j0S6f2qR4VRLqYKFV6h0jz965t+gu7MmGKAE+USEBHOJ
         2s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7pCBtBDSjcVtEqS1SMqVaavriUKG9Gcw86QjHCE7is=;
        b=cyuqi5+LBcXMD0zoNtvhzolZA4w2vc0j+KyF9aLDRIKbHgWiPjBnmCiRzuTq/8xvI0
         2PJziIVGTK5csJlZxo0z53UOL3RRTZ1nmbB6iKWcxykC4X2jxtlhINbXgCldXP7B4Rgz
         PZvu20MzO0HyYqOszT5SDyt0XlvYejYRJ3Gd0LeRldbZBwjYxNsNT+NxshAkDe3UGxy8
         eWlIOsY4fmrDpZIBM9YBOxrpiZ+WToSPfbPBpmINYm5y8GTCy5ilazSElHj5yMucZaG6
         grOIGkhQO0eYsQfGtqOhKpryDbgJEdBG2XRmiYH6o6JRkeKwFaZSdH/Bn5sDI1Fu1p5F
         qzog==
X-Gm-Message-State: ANhLgQ3jU8M5wD0iLkAi2hgWKiZgWwqb9MeHjrDd7p0w6xiDQ34dtCWc
        SQlTPDgMgqYvbqLti3mYlHM=
X-Google-Smtp-Source: ADFU+vvHEV0JAO6ggNIK/yWlbU/Cwdn68CUMZ0ZoGJtaGZo6g7fDAvZKfEvDMy/2199NVxKR/8Il2A==
X-Received: by 2002:a63:a069:: with SMTP id u41mr3283610pgn.3.1583805730150;
        Mon, 09 Mar 2020 19:02:10 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d6sm740081pjv.38.2020.03.09.19.02.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 19:02:09 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:02:07 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, walken@google.com, rfontana@redhat.com,
        dbueso@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] rbtree: introduce three helpers about sort-order
 iteration
Message-ID: <20200310020206.GA8961@cqw-OptiPlex-7050>
References: <1583769734-1311-1-git-send-email-qiwuchen55@gmail.com>
 <20200309165511.GK12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309165511.GK12561@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 05:55:11PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 10, 2020 at 12:02:14AM +0800, qiwuchen55@gmail.com wrote:
> > +/**
> > + * rbtree_for_each_entry_safe - iterate in sort-order over of given type
> > + * allowing the backing memory of @pos to be invalidated.
> > + * @pos:	the 'type *' to use as a loop cursor.
> > + * @n:		another 'type *' to use as temporary storage.
> > + * @root:	'rb_root *' of the rbtree.
> > + * @field:	the name of the rb_node field within 'type'.
> > + *
> > + * rbtree_order_for_each_entry_safe() provides a similar guarantee as
> > + * list_for_each_entry_safe() and allows the sort-order iteration to
> > + * continue independent of changes to @pos by the body of the loop.
> > + *
> > + * Note, however, that it cannot handle other modifications that re-order the
> > + * rbtree it is iterating over. This includes calling rb_erase() on @pos, as
> > + * rb_erase() may rebalance the tree, causing us to miss some nodes.
> > + */
> > +#define rbtree_for_each_entry_safe(pos, n, root, field) \
> > +	for (pos = rb_entry_safe(rb_first(root), typeof(*pos), field); \
> > +	     pos && ({ n = rb_entry_safe(rb_next(&pos->field), \
> > +			typeof(*pos), field); 1; }); \
> > +	     pos = n)
> 
> Since this cannot deal with rb_erase(), what exactly is the purpose of
> this thing?

It's just a copy of rbtree_postorder_for_each_entry_safe() for
the usage scenario of sort-order iteration. It can be used for
walking the tree and free all entries of the given type.
