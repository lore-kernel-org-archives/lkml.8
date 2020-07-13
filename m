Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFEEC433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAB92067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VWDGXW/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgGMTEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:04:00 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:04:00 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i18so12149274ilk.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XA1EpHrdmYjsC6ofF2H7iz3RZthRfSSjC9rfBgRGN6M=;
        b=VWDGXW/NXw25gdZJAvtRUIvPTZDkBqrgY3CT2vzlzhRjMcRQIxRLBAnCJ3lpKSJpFE
         xT0tyMQ0kws9PblSt76PpMPaVVDnfI0c8WDxS8ltFpz/oNNfxz9BkUOdx2EQgjyR+YY/
         YlkbxjOna4FFyv5rCJXy94vXpvS1KnQJY4K0lKyVZm9AlDkywFjXCRoGsnMlp1XaLDK4
         +2wyPVNbDhyGrwQlxKnFaRcbj6BKXFsVhmyjq1XvZOE4nnuFLOfi0oyhx/ODt8ces/LL
         ati5yeNujl4IhJvCI6cN+Dbau+wRoRKvlWhK3sOJ2J4f5tkaCxtF/q/LXuZjOapBQPD3
         zrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XA1EpHrdmYjsC6ofF2H7iz3RZthRfSSjC9rfBgRGN6M=;
        b=eS2aimE7U/LYLkSiQN6kG4co2sQ6f/iMAjPF7PmYMTRjDFC9WAMYixa2D+Nn62jO1Z
         rg7rk0zWv2BTOaiMn5lWssQoTzfEhdBSIgZlTaI+x0C8yr9XuXM9oNVkLO2BkQtMu9rw
         5OIFB3qQzYR3XehFdMV/fW6KqVHT0IJyCKhvhXRGoKEHIeBC2wxy3Rgt/8WFMwlC8VXk
         uwnzn1mkAVK5A7H/n+iY96dTmZiw+53aKrw0VLHj7Jkx8SpZp9V2zxzM7UQooXhfZVC4
         u3DxeF9fYoFdoHzDTA63kSRYDJWJOTYrqTOlJm4vC2OzO85DY1MnOHE8x9/jHrlOaHRg
         5N0A==
X-Gm-Message-State: AOAM530Vgb/xdWgseSpGmJkgqF9PprvmAL/XK2aQ1v3GTFyBad820Xpz
        yXjG0W6wmKxthN6FF5UcAG0Xtg==
X-Google-Smtp-Source: ABdhPJyRHfvJDQGCnEFTKbipmxwJmFZaEpNpmIxk+hQ+Xky9CJ5Yi9Ms8cMrdsBETw747p3cb8+W7w==
X-Received: by 2002:a92:c7c3:: with SMTP id g3mr1271721ilk.164.1594667039054;
        Mon, 13 Jul 2020 12:03:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y6sm8676368ila.74.2020.07.13.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:03:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jv3k5-009wVE-3L; Mon, 13 Jul 2020 16:03:57 -0300
Date:   Mon, 13 Jul 2020 16:03:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: Re: [PATCH 1/3] habanalabs: implement dma-fence mechanism
Message-ID: <20200713190357.GC25301@ziepe.ca>
References: <20200713155424.24721-1-oded.gabbay@gmail.com>
 <20200713155752.GC267581@kroah.com>
 <CAKMK7uH=Ch4ce-9D5e-RvVwq_oK6Doqtq5QbvpmQ8uPWkMCi2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uH=Ch4ce-9D5e-RvVwq_oK6Doqtq5QbvpmQ8uPWkMCi2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 08:34:12PM +0200, Daniel Vetter wrote:
> On Mon, Jul 13, 2020 at 5:57 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 13, 2020 at 06:54:22PM +0300, Oded Gabbay wrote:
> > > From: Ofir Bitton <obitton@habana.ai>
> > >
> > > Instead of using standard dma-fence mechanism designed for GPU's, we
> > > introduce our own implementation based on the former one. This
> > > implementation is much more sparse than the original, contains only
> > > mandatory functionality required by the driver.
> >
> > Sad you can't use the in-kernel code for this, I really don't understand
> > what's wrong with using it as-is.
> >
> > Daniel, why do we need/want duplicate code floating around in the tree
> > like this?
> 
> The rules around dma-fence are ridiculously strict, and it only makes
> sense to inflict that upon you if you actually want to participate in
> the cross driver uapi built up around dma-buf and dma-fence.
> 
> I've recently started some lockdep annotations to better enforce these
> rules (and document them), and it's finding tons of subtle bugs even
> in drivers/gpu (and I only just started with annotating drivers:
> 
> https://lore.kernel.org/dri-devel/20200707201229.472834-1-daniel.vetter@ffwll.ch/
> 
> You really don't want to deal with this if you don't have to. If
> drivers/gpu folks (who created this) aren't good enough to understand
> it, maybe it's not a good idea to sprinkle this all over the tree. And
> fundamentally all this is is a slightly fancier struct completion. Use
> that one instead, or a wait_queue.
> 
> I discussed this a bit with Oded, and he thinks it's easier to
> copypaste and simplify, but given that all other drivers seem to get
> by perfectly well with completion or wait_queue, I'm not sure that's a
> solid case.
> 
> Also adding Jason Gunthorpe, who very much suggested this should be
> limited to dma-buf/gpu related usage only.

Without all the cross-driver stuff dma_fence is just a
completion. Using dma_fence to get a completion is big abuse of what
it is intended for.

I think the only problem with this patch is that it keeps too much of
the dma_fence stuff around. From what I could tell it really just
wants to add a kref and completion to struct hl_cs_compl and delete
everything to do with dma_fence.

Not even sure the kref is needed ;)

Jason
