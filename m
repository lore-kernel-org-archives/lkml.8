Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86754C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD172084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJtMhqlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgGBSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:23:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728148AbgGBSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593714198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N4n2qeDClQPShAlOepg3+xUXJF0gLP+gI9YS4+e3wWo=;
        b=UJtMhqlQ9GgiUVGjEoKEI6yxDOQMBua1vYQv8Z895+zWEc9/oCd7XnDjOQA1KvVY1ShgaB
        iplx0W6PPwqfvhtGEew6NNRN+ce76yIdIU8AXdeI6t5ndDyo3SqwCcU9UMxUfSzjy8jm57
        y3hEK5iUneQrzOOVqTrYul9o2u+e6O0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-SvaBzjqvNkWb_BXtGgUtWQ-1; Thu, 02 Jul 2020 14:23:15 -0400
X-MC-Unique: SvaBzjqvNkWb_BXtGgUtWQ-1
Received: by mail-ot1-f72.google.com with SMTP id j37so6407362ota.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4n2qeDClQPShAlOepg3+xUXJF0gLP+gI9YS4+e3wWo=;
        b=jn1oU4xEKN+KCSk/4FwkDELnq4i3w77pvUQx3kKCOQ/jILlLFtnBpo5huMEc9hDs1c
         FoiXAXJpIlfZxvWo9cRxZ0wwgPv1BMP5D857IkMTX8Tw1newC3kfKwEcjx6m528n/Tl6
         +sOp+Cucdie1t2i4JBEzoOi3kEXnuhS9vSNK4SJPWWcoW5Ce5WTHd+RUJfokWYvzMRcg
         4r8QzwXahfjqbJHgw9CosR4Hyj7PB9ZkxXtETmn28eBIr+abbtphcRbkiRmyxYJKv1ET
         pFBfaUMCOc9o2hssC9zcYdgHiqGlfjFyPfS0rQD9Xa9WdWzJnBJTy362O9naW866amJV
         bXrA==
X-Gm-Message-State: AOAM531MafEXuxXgoSRc6sEItXGVZPwVQkBDiGxtADrDRu38HUHxvLKA
        MOaOVAogX0FG5G+FVvmXQVy4xut29YOuQ+/GSCTxAlHyo6JFZtiMsi1uR9AFNhWg83anDukvo2a
        +OMUHaiXruEd1vpET4WmJOWMC2EMVSIvS1WH03aOr
X-Received: by 2002:a9d:5f92:: with SMTP id g18mr12102135oti.95.1593714194841;
        Thu, 02 Jul 2020 11:23:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvm7EcRvsfCto8/PgbdopuIxxPcMOqqa27XvyoeidGOQ9Dab1I7ij1VwHb4T6hC4Paewj6S+oUpsnH5rz8W5I=
X-Received: by 2002:a9d:5f92:: with SMTP id g18mr12102114oti.95.1593714194564;
 Thu, 02 Jul 2020 11:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <CAHk-=whb4H3ywKcwGxgjFSTEap_WuFj5SW7CYw0J2j=WGUs4nQ@mail.gmail.com>
In-Reply-To: <CAHk-=whb4H3ywKcwGxgjFSTEap_WuFj5SW7CYw0J2j=WGUs4nQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Jul 2020 20:23:03 +0200
Message-ID: <CAHc6FU7ZWJb308yfMaskFeSwNxgxqn89pxT4F7Ud4HthhrC5CA@mail.gmail.com>
Subject: Re: [RFC 0/4] Fix gfs2 readahead deadlocks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Of this patch queue, either only the first patch or all four patches can
> > be applied to fix gfs2's current issues in 5.8.  Please let me know what
> > you think.
>
> I think the IOCB_NOIO flag looks fine (apart from the nit I pointed
> out), and we could do that.

Ok, that's a step forward.

> However, is the "revert and reinstate" looks odd. Is the reinstate so
> different from the original that it makes sense to do that way?
>
> Or was it done that way only to give the choice of just doing the revert?
>
> Because if so, I think I'd rather just see a "fix" rather than
> "revert+reinstate".

I only did the "revert and reinstate" so that the revert alone will
give us a working gfs2 in 5.8. If there's agreement to add the
IOCB_NOIO flag, then we can just fix gfs2 (basically
https://lore.kernel.org/linux-fsdevel/20200619093916.1081129-3-agruenba@redhat.com/
with IOCB_CACHED renamed to IOCB_NOIO).

Thanks,
Andreas

