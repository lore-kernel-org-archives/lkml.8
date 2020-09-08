Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BD220936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+mn5tT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIHWJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgIHWJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:09:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B63C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 15:09:23 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q21so660908edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCABmvNiwq5ZzfEtzfLCEjA/nFkGi01QovzZcJzwaW4=;
        b=A+mn5tT0iNNPItEfp6i6CyIrTFkG0NTDtOtusAoO6RvzmJ6S7GwZ3JTNz/XEbKNCy8
         R3IdrVuR0TLbgToZtxM9QBvlDNtS/V5zHhf63UnS30JQ1fnWNEr/52hRzIpxztKcs7Gx
         kdUdVheSz3d8PH6bPF1U7x7gh5HRx4MHu2JFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCABmvNiwq5ZzfEtzfLCEjA/nFkGi01QovzZcJzwaW4=;
        b=QyDyxQFIcwRI8OU07/iZJppWrxj6lOf28J7WVDXe2UDoUfz/7sMaMMeYFmRcSb5FZz
         GylBx9SIKch4UruNbjEq8wbgvM0muzl6qNwEIvmEavGQysRO+0I2in8juMVCdJFMrSjZ
         NFwiv8Urtou9mDPtBqRd8Xir3D6CLMKuzeXsW2CSAeh7bAtt6a456pKAtUlqiItqLOfp
         +Xd0UrZZLbKY/BMyjqKG2UjRMjfA7iF5Rrb/qaCzGFvJOyurCv4FlPoxgr20384e/Obe
         av1eyX7BZGgHsnbbjlqnuQrFlUdqPanHk+dJP77WlG0YAYgy9O/n4uWX7q4aB9vezhNN
         WcnQ==
X-Gm-Message-State: AOAM531pRX4AWcFSAfCUJbSzgRwouaxCrI3wODThlUrqeFa7OCKr09Jr
        ctl6rwLdmbd/YY8lZ4fyQZgadWurZi+ty5SA
X-Google-Smtp-Source: ABdhPJwUOqPslho3mhbgYPE34sLEUM7GZem3Ne8zvC4UFUTy7/JaYxsHVsxJYf62PXf0ti/SflGuFg==
X-Received: by 2002:a50:d78e:: with SMTP id w14mr1162865edi.229.1599602961818;
        Tue, 08 Sep 2020 15:09:21 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id j15sm443345eds.33.2020.09.08.15.09.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 15:09:20 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id k15so760599wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 15:09:20 -0700 (PDT)
X-Received: by 2002:adf:ff90:: with SMTP id j16mr611132wrr.105.1599602960207;
 Tue, 08 Sep 2020 15:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de> <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <20200819135454.GA17098@lst.de> <CAAFQd5BuXP7t3d-Rwft85j=KTyXq7y4s24mQxLr=VoY9krEGZw@mail.gmail.com>
 <20200820044347.GA4533@lst.de> <20200820052004.GA5305@lst.de>
 <CAAFQd5CFiA2WBaaPQ9ezvMjYZfNw37c42UEy9Pk7kJyCi1mLzQ@mail.gmail.com>
 <20200820165407.GD12693@lst.de> <CAAFQd5D=NzgjosB51-O_cH27a8V6CPgCfaPSfHHz7nKJPbazgg@mail.gmail.com>
 <20200901110617.GA13232@lst.de> <CAAFQd5CmPVSxmZJVn7HnNUn8srZbAbnfzpNMYw3KcDzn7xD2cg@mail.gmail.com>
 <CAAFQd5BDh05DNPShr54opY2GyY-FcH7g8=V2t4xBwz0OwRu9xQ@mail.gmail.com>
In-Reply-To: <CAAFQd5BDh05DNPShr54opY2GyY-FcH7g8=V2t4xBwz0OwRu9xQ@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 9 Sep 2020 00:09:09 +0200
X-Gmail-Original-Message-ID: <CAAFQd5BiHa2ziZuJPwbzKzqaziJfmNDo6YL1NviuppVSQ6YbVQ@mail.gmail.com>
Message-ID: <CAAFQd5BiHa2ziZuJPwbzKzqaziJfmNDo6YL1NviuppVSQ6YbVQ@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 11:58 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Hans, Mauro,
>
> On Tue, Sep 1, 2020 at 5:02 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Tue, Sep 1, 2020 at 1:06 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, Aug 20, 2020 at 07:33:48PM +0200, Tomasz Figa wrote:
> > > > > It wasn't meant to be too insulting, but I found this out when trying
> > > > > to figure out how to just disable it.  But it also ends up using
> > > > > the actual dma attr flags for it's own consistency checks, so just
> > > > > not setting the flag did not turn out to work that easily.
> > > > >
> > > >
> > > > Yes, sadly the videobuf2 ended up becoming quite counterintuitive
> > > > after growing for the long years and that is reflected in the design
> > > > of this feature as well. I think we need to do something about it.
> > >
> > > So I'm about to respin the series and wonder how we should proceed.
> > > I've failed to come up with a clean patch to keep the flag and make
> > > it a no-op.  Can you or your team give it a spin?
> > >
> >
> > Okay, I'll take a look.
> >
> > > Also I wonder if the flag should be renamed from NON_CONSISTENT
> > > to NON_COHERENT - the consistent thing is a weird wart from the times
> > > the old PCI DMA API that is mostly gone now.
> >
> > It originated from the DMA_ATTR_NON_CONSISTENT flag, but agreed that
> > NON_COHERENT would be more consistent (pun not intended) with the rest
> > of the DMA API given the removal of that flag. Let me see if we can
> > still change it.
>
> Given the above, we would like to make changes that affect the UAPI.
> Would you still be able to revert this series?

Sorry, I just realized that this isn't the original series that
introduced the thing, but rather a patch that does a partial revert. I
think it could be also applied as an alternative for the revert, but
perhaps a full series revert is just safer at this point?

For reference, the series in question is:
https://patchwork.linuxtv.org/project/linux-media/cover/20200514160153.3646-1-sergey.senozhatsky@gmail.com/

Best regards,
tomasz
