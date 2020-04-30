Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3DDC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44482076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pyVQXCzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgD3OU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgD3OU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:20:57 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775C9C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:20:57 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t199so5349537oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vU7NNDB88N8b7luDUTJQIrpl7937xKbm7PdW+jOV5J4=;
        b=pyVQXCzRdeYFN35dxvsghsrXzIdcIbEYwc3EaNswiigQ56cZTaQdOFWpaTh0LfCcdm
         2KjNZxbDLoiOShbqWhjVC9o5qbxrY7BWh0w5c+wVG3zivALqYuf86KUZjg5MdLb8W9j5
         pICF3wLWqrM0bo3kIYJMJJyW8jKzWQXR9OH5A5rzn2vBpKJwwOImwWTVnzVH08xSth+I
         9+4KH1ak29J3udYms0FoW4bD0Oh3Y2xYPy++zsxjMAbWXZc59UIOz4nbUiYnTT3lvxzn
         mR2DQiqizyIRFsjO3i3lIyN/yI1wkbOWVcjCADgROSvUQboVCrBkRfFoDvvfSHp3Hy19
         ZvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vU7NNDB88N8b7luDUTJQIrpl7937xKbm7PdW+jOV5J4=;
        b=CUkTdL0ldkdXkz12DYbZbdCS/nDZf2S9PZm2bR0fH14ZxkquBDKq4zv7FuV2TSi0MQ
         OOVa125uDhJFLOwV6IXngFOIlc1OkOqqfR2SfNDibAUPJSbEROLY4+wwI18l7rPQTyfB
         ah/mvQsfPPRzNxXBCkczGw79zP08f1UnR4NQd/FsfVFJcH+e8GGIQU1rc3T4egZhjGN7
         CQrJZa/hmKf5HOF4/E+FzlMx+eWl+zjjEpKvb4Knt3juhdaTnvawX2cijh/FqPb6fxBE
         OgIKqMOP/TLBncS5hP9P+3bdvHEadMMiggLuSlgY7YZwJW+Acvq1gCBVEpVt7rpWaBDz
         eWrg==
X-Gm-Message-State: AGi0PubctpF/G/XdmhGuOL+wu2iRFmJHN8QPss4nBbtBr6yj/deq+j04
        cwmrXozOhK3wUtoSObdb3w6O03oR1oAsSxnH1Fmpxw==
X-Google-Smtp-Source: APiQypKi11+B07gGR75YnzeMGeraH6AVLTAvNHkxcGX7oFLvFp4wW4F3hi8wb9UT3WC71m1+ov8vwd6qa2wRA4NbCjo=
X-Received: by 2002:aca:d485:: with SMTP id l127mr1766826oig.119.1588256456666;
 Thu, 30 Apr 2020 07:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200430015930.32224-1-vitor@massaru.org> <cb4d93a0-b967-f37d-ea01-0368c91b896e@infradead.org>
 <0463c90cfbe2036235010c5f8b92af6a96c20f74.camel@massaru.org> <20200430043723.GA27272@ravnborg.org>
In-Reply-To: <20200430043723.GA27272@ravnborg.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 30 Apr 2020 19:50:45 +0530
Message-ID: <CAO_48GGgeJ9cFeAfKB7GjLTwOzXxk_goKsi42ocRswwXkWh11g@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Documentation: fix: `make htmldocs` warnings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        brendanhiggins@google.com, LKML <linux-kernel@vger.kernel.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

On Thu, 30 Apr 2020 at 10:07, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Wed, Apr 29, 2020 at 11:27:22PM -0300, Vitor Massaru Iha wrote:
> > On Wed, 2020-04-29 at 19:06 -0700, Randy Dunlap wrote:
> > > On 4/29/20 6:59 PM, Vitor Massaru Iha wrote:
> > > > Add missed ":" on kernel-doc function parameter.
> > > >
> > > > This patch fixes this warnings from `make htmldocs`:
> > > > ./drivers/dma-buf/dma-buf.c:678: warning: Function parameter or
> > > > member 'importer_ops' not described in 'dma_buf_dynamic_attach'
> > > > ./drivers/dma-buf/dma-buf.c:678: warning: Function parameter or
> > > > member 'importer_priv' not described in 'dma_buf_dynamic_attach'
> > > >
> > > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > > ---
> > > >  drivers/dma-buf/dma-buf.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > > index ccc9eda1bc28..0756d2155745 100644
> > > > --- a/drivers/dma-buf/dma-buf.c
> > > > +++ b/drivers/dma-buf/dma-buf.c
> > > > @@ -655,8 +655,8 @@ EXPORT_SYMBOL_GPL(dma_buf_put);
> > > >   * calls attach() of dma_buf_ops to allow device-specific attach
> > > > functionality
> > > >   * @dmabuf:              [in]    buffer to attach device to.
> > > >   * @dev:         [in]    device to be attached.
> > > > - * @importer_ops [in]    importer operations for the
> > > > attachment
> > > > - * @importer_priv        [in]    importer private pointer for the
> > > > attachment
> > > > + * @importer_ops:        [in]    importer operations for the
> > > > attachment
> > > > + * @importer_priv:       [in]    importer private pointer for the
> > > > attachment
> > > >   *
> > > >   * Returns struct dma_buf_attachment pointer for this attachment.
> > > > Attachments
> > > >   * must be cleaned up by calling dma_buf_detach().
> > > >
> > >
> > > Sumit said that he would be applying my patch from April 7:
> > > https://lore.kernel.org/linux-media/7bcbe6fe-0b4b-87da-d003-b68a26eb4cf0@infradead.org/
> > >
> > > thanks.
> >
> > Sorry. I didn't check if the patch has already been sent.
>
> Sumit - patch from Randy is neither applied to drm-misc-next nor
> drm-misc-fixes.
> A reminder in case it was lost somewhere.

My bad: I have now applied it to drm-misc-fixes, so should be seen in
-next soon.

>
>         Sam

Best,
Sumit.
