Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF1AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9BC20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IfIObDJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGMTJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:09:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:09:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h13so10421230otr.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Csf/7rx4gaZR2B7YhjrBbyppyMnO+n7zmvX5ufPGpCo=;
        b=IfIObDJQskKnHqAruRqptjka9NXRlz+z1M5/eujPB310PpBqdu4COPAIN/Cr0RgkZe
         csL9JdoKQYyrRvJt6w2L//Zdtbri5Wn/D/1NrGUm7XvQLvUaf7dbdQZ2gYaCigz73Kd9
         8ZuqNIO57QJGtRy75QjfDNaXsZytH4slodRVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Csf/7rx4gaZR2B7YhjrBbyppyMnO+n7zmvX5ufPGpCo=;
        b=Ebmwy7H19uGxxM5FJKBzvhxmNEHKzETGnreRPIciC+KWwMMrSf4ethqEwceQj0sH9K
         HNGfHWOdeIdtnEnO6gfMjeHqs3fCrSCxSdfNXp74c0ufaeWndD29GR0ikOvBW5x7RFMO
         pwg+AAZqR0X45ou00PPqasHIkoYFx/ZWrrO9TQwJu7B+xlPUJx1/wtZymL9bYUry8+QX
         RjD1FNtVs1sgV0H9Gw31J4u6UraZfgjcgzdAwU3VXopkxXik6rHlAL0RnpLk/A6c4HbW
         SgFwo9YM4u0SFISLF92zhpy+2DUsmc0CbTRp0edZ1UorVtKGU+UElMSTdg6c7gF8Hesu
         Oufg==
X-Gm-Message-State: AOAM531xw7I8enCXHYdRmzyuFVrLrGdxaKM8SGu2uLqoh8/smLf89wvJ
        i7q6sBD9Hj4g1Z8ex/bP//liVpJXRRMKW1UX4DXrSg==
X-Google-Smtp-Source: ABdhPJyUfjDCoS33Guu3UGdJfWIASBtZ5qzt0D41zU5mOfrQiEfUP0Rwo7HwfanvcEVn/gWsmUZcNMm1enh6woEinEg=
X-Received: by 2002:a9d:d55:: with SMTP id 79mr1005030oti.281.1594667346774;
 Mon, 13 Jul 2020 12:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200713155424.24721-1-oded.gabbay@gmail.com> <20200713155752.GC267581@kroah.com>
 <CAKMK7uH=Ch4ce-9D5e-RvVwq_oK6Doqtq5QbvpmQ8uPWkMCi2w@mail.gmail.com> <20200713190357.GC25301@ziepe.ca>
In-Reply-To: <20200713190357.GC25301@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 13 Jul 2020 21:08:55 +0200
Message-ID: <CAKMK7uEvehX2CV3Q5FJrF49-_Xe9gXJ11wDo7xyVsipyuZm23Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] habanalabs: implement dma-fence mechanism
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 9:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Jul 13, 2020 at 08:34:12PM +0200, Daniel Vetter wrote:
> > On Mon, Jul 13, 2020 at 5:57 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jul 13, 2020 at 06:54:22PM +0300, Oded Gabbay wrote:
> > > > From: Ofir Bitton <obitton@habana.ai>
> > > >
> > > > Instead of using standard dma-fence mechanism designed for GPU's, we
> > > > introduce our own implementation based on the former one. This
> > > > implementation is much more sparse than the original, contains only
> > > > mandatory functionality required by the driver.
> > >
> > > Sad you can't use the in-kernel code for this, I really don't understand
> > > what's wrong with using it as-is.
> > >
> > > Daniel, why do we need/want duplicate code floating around in the tree
> > > like this?
> >
> > The rules around dma-fence are ridiculously strict, and it only makes
> > sense to inflict that upon you if you actually want to participate in
> > the cross driver uapi built up around dma-buf and dma-fence.
> >
> > I've recently started some lockdep annotations to better enforce these
> > rules (and document them), and it's finding tons of subtle bugs even
> > in drivers/gpu (and I only just started with annotating drivers:
> >
> > https://lore.kernel.org/dri-devel/20200707201229.472834-1-daniel.vetter@ffwll.ch/
> >
> > You really don't want to deal with this if you don't have to. If
> > drivers/gpu folks (who created this) aren't good enough to understand
> > it, maybe it's not a good idea to sprinkle this all over the tree. And
> > fundamentally all this is is a slightly fancier struct completion. Use
> > that one instead, or a wait_queue.
> >
> > I discussed this a bit with Oded, and he thinks it's easier to
> > copypaste and simplify, but given that all other drivers seem to get
> > by perfectly well with completion or wait_queue, I'm not sure that's a
> > solid case.
> >
> > Also adding Jason Gunthorpe, who very much suggested this should be
> > limited to dma-buf/gpu related usage only.
>
> Without all the cross-driver stuff dma_fence is just a
> completion. Using dma_fence to get a completion is big abuse of what
> it is intended for.
>
> I think the only problem with this patch is that it keeps too much of
> the dma_fence stuff around. From what I could tell it really just
> wants to add a kref and completion to struct hl_cs_compl and delete
> everything to do with dma_fence.

Yeah, that's what I recommended doing too. error flag might be needed
too I think, but that's it.
-Daniel

> Not even sure the kref is needed ;)
>
> Jason



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
