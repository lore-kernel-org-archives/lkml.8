Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A166BC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6911320724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io7cCr2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgCRAto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:49:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45662 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRAto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:49:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id 2so12890656pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 17:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEZjMRu2hEVHCCshJE6Ur56JVGlCCroTKLH+YSFAD7w=;
        b=Io7cCr2Ux3LNSgzS/WNfg+3Nv6rjTYHZTgDS03ZRcXDj93Q+S5moUxm0sRGywBHEbx
         JVTRcyB58gDjfIZLSTC5eRL68oDPalq2F4KGkMgRXJKpmpNMnpomfkDzjGIQoOL74DSv
         4ltNeOcpmHVfK6YMpE0JXoawQKT3dKELvrI6yVpSydusg7FHIkVDwtc6QakVETnsgZe2
         GHezEWSDwKV2FLtll34AUtPmJhL2/YhvSmjRit+ui4U61ypowKhtxzUXMVU3zFXkbT2S
         xqlz3lnuZnHbI7715ufXM/amo9ubX4Ro4NYNUbzlqZgWpC4ix0pwiaml58soZIeI9mfi
         QT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEZjMRu2hEVHCCshJE6Ur56JVGlCCroTKLH+YSFAD7w=;
        b=ODbgDWdpMQvk3UAOPyRg8bEyWfwXiGbO5qBQ3o8KDEnY8izkcIp462ucK/k1VZdBOM
         zIXjTuzcu55OQ1IPT93fB58as/rWWVaZ2O/u5e05czU81vzLQDfTNmoF7lR4SWDnO/Mz
         VFCBSUcm49TqUs6LW/HczM/XIhsYra9UkZ6m0xOuZIYFywCiSF8pHtF02zHZZBrD4i4W
         V7hsRBzZHE1Fs3/jS0N1e5HfJDIO0abgN0dd2qD7S1LO9HabgF3Z+buUYKnRoDbR3XVy
         KwSyKRwBs5n9Kn3bmsl7kRRw45H2Mx3V62M3cFTMLgoN+94Bzk4i7T84c3SHmLrMUcZA
         siyg==
X-Gm-Message-State: ANhLgQ1PrfkJzWekLEqHd30KgRhi07QFayh+GauTq3DCzegQpVSm48Uw
        XIZMpKuOPfW1Ticv+bSZ1nTLMGMdq19m+77BgTM=
X-Google-Smtp-Source: ADFU+vulDfQJe56I6PtipWkmVU80PG2acfuR+y5k+u68pckhTDj9tsFiLPV2dZecfSsyzei9Czac70YRpukrXrlNl+Q=
X-Received: by 2002:aa7:8dcc:: with SMTP id j12mr1528707pfr.57.1584492581383;
 Tue, 17 Mar 2020 17:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHOvCC7ZLpOkdWPjY3art8LYOh2SJWwgqYRHRMVm-E4-kD06mA@mail.gmail.com>
 <20200317134043.GA22433@bombadil.infradead.org>
In-Reply-To: <20200317134043.GA22433@bombadil.infradead.org>
From:   JaeJoon Jung <rgbi3307@gmail.com>
Date:   Wed, 18 Mar 2020 09:49:30 +0900
Message-ID: <CAHOvCC4WSiCD93A=DyfY8_3uqZAGXrdj4=GA4cyQx6ZqdakUtg@mail.gmail.com>
Subject: Re: [PATCH] Add next, prev pointer in xa_node at the lib/xarray.c
To:     Matthew Wilcox <willy@infradead.org>
Cc:     maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>, koct9i@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,
Thank you for your deep response.

I think XArray is a very well-made structure that requires no further
improvement if the indexes are dense in a 64-bit system.

Since xa_node is 576 bytes and is set to fit 7 per 4kB page,
adding a data type to xa_node is rather a memory waste problem.

#define XA_CHUNK_SHIFT          (CONFIG_BASE_SMALL ? 4 : 6)
XA_CHUNK_SIZE is 32 or 64

XA_CHUNK_SIZE is 32 or 64, and currently XAarray is 64 optimized,
so modifying it may have a counterproductive effect.

There is a downside to the well-designed XArray, but if the indexes
are not dense or deleted a lot, the memory of the slots in the xa_node
is increased and the search cost for logn increases at f (n) = O
(nlogn)

My worries are here and I hope you understand my efforts to solve it.

My attempts described below are meaningful when XA_CHUNK_SHIFT is 4 or
2, and can solve the slowdown in search speed when indexes are deleted
and not concentrated.

When XA_CHUNK_SHIFT is 2(XA_CHUNK_SIZE is 4), the XArray configuration
is as follows.
(It is difficult to express the picture in text.)

xarray->head : xa_node : index: 0  16  32  48
                +---+---+---+
                                |   |   |   |
        +-----------------------+   |   |   +------------+
        |              +------------+   |                |
        |              |                |                |
    0  4  8  12    16  20  24  28   32  36  40  44   48  52  56  60
    +--+--+---+    +---+---+---+    +---+---+---+    +---+---+---+
        |              |                |                |
  +-----+              |                +-------+        +---------------+
  |                    |                        |                        |
  0 1 2 3 <==>... <==> 16 17 18 19 <==>... <==> 32 33 34 35 <==>...
<==> 48 49 ..

In the above, if xa_node is connected to next and prev, it does not
search the parent node, so the logn disappears from f (n) = O (nlogn),
which improves search efficiency with f (n) = O (n). In fact, this is
already well-known in traditional algorithms, but I hope you can
understand it with the effort applied to XArray.

Best Regards,
JaeJoon Jung.

On Tue, 17 Mar 2020 at 22:40, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Mar 17, 2020 at 04:32:34PM +0900, JaeJoon Jung wrote:
> > Hi Matthew,
> > I add next, prev pointer in the xa_node to improve search performance.
> > XArray currently has the following search capabilities:
> >
> > Search algorithm performance is O(n) = n x log(n)
>
> That's not how "big-O" notation is used.
> https://en.wikipedia.org/wiki/Big_O_notation
>
> What you mean to say here is O(n.log(n)).
>
> > For example,
> > XA_CHUNK_SHIFT 2
> > XA_CHUNK_SIZE 4
>
> I'm not really interested in the performance of a cut-down radix tree.
> You can re-run the numbers with a SHIFT of 6 and SIZE of 64 to get a
> more useful set of performance numbers.
>
> > If you connect the leaf node with the next and prev pointers as follows,
> > the search performance is improved to O (n) = n.
>
> But that's not free.  Right now, the xa_node is finely tuned in
> size to 576 bytes on 64-bit systems (32-bit systems are a secondary
> consideration).  That gets us 7 nodes per page.  Increasing the size any
> further reduces the number per page to 6, which is a pretty meaningful
> increase in memory usage.
>
> > @@ -1125,6 +1125,8 @@ struct xa_node {
> >         unsigned char   count;          /* Total entry count */
> >         unsigned char   nr_values;      /* Value entry count */
> >         struct xa_node __rcu *parent;   /* NULL at top of tree */
> > +        struct xa_node __rcu *prev;     /* previous node pointer */
> > +        struct xa_node __rcu *next;     /* next node pointer */
>
> You should be indenting with tabs, not spaces.  Or your mail system is
> messing with your patches.
>
