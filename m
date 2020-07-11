Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80468C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3C02076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iPPbSg9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGKAxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGKAxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:53:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A1C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:53:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so5937663edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Rls/U/lDsLfT4D3DE5n9+9Nu0A90fUMZ5H2LpZadpY=;
        b=iPPbSg9QOhO1/J2AGGABUiWYW1G+aZBlYGBwtZRUeuvTEkRismRqyyYYb/b5HtXFzD
         eT6GM4fHT57mSqaeCJSPWS/lhpqKIIW/IEcSX0sOK4gzky06Dhnp/Ip1OIIpfdUL4I9D
         zaf7XYwr0+dyWUSgZz/fIP6VpjQimltNJozru9KMByXvX/GmYaTxeawAnzBI049LwHqK
         QyTtiHGsXlvVd8xwGIQmR9G52VI1TJAAt9K92hcxV/pbQ4SMotmatFqvGtbVlMbDTsbL
         X0IogtzxzfRftbdheB9eRV8vW+J7XAIlFm6MBfLuy3kRg+Ca6FB45eVJjJ060lXd8Yag
         +wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Rls/U/lDsLfT4D3DE5n9+9Nu0A90fUMZ5H2LpZadpY=;
        b=kgcQjewRc1/IMvMf8HTtlBN262Fxrw3q7k4X8Bnx6qdybvyf8jZc7l+H2kOrWO50Xc
         4UqXVabdmd7N+6JqZhq+UCAbVplCmsdCTNliXMiCfjt/We0kCjlUxcth5Qqu6MlGi3s9
         UEM4+cCaUHhRQAm4D2GFOcTrFpvccPTcNzbHD9Sv8jRsCLZyjKy7FLM7K1MwhgFWuMZk
         gHbKAXPztmJJdkri6ktnc6mD99pKxzHE74/qfBxQAckuMWaOfKHb+Mdk2NBdx98ZME2T
         pP/91MmW8MS/NNPbKW5l5IW5y9SEulj3KX9/hgJfAD0x5sTsjocl/GDIQGn3RFkg4pbY
         9X8Q==
X-Gm-Message-State: AOAM533lNKSHP8Y4rNPQG8of9CqCwWUoXZ+as8XTEu+Upz3H2zpAFzTN
        +IvF6Y3jEJmZBqZVKpbrwaoXQGGsMuee4e3ZnsxMDQ==
X-Google-Smtp-Source: ABdhPJzFhcpJg+WtMu5QLudWk0KLldzkSq/YYsINvRouju8S48SBuHcb7Lqaek9OHZZ2kIe4eSSfayb2v5gUYFCpvG0=
X-Received: by 2002:a50:a1e7:: with SMTP id 94mr77926426edk.165.1594428781622;
 Fri, 10 Jul 2020 17:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <d7043cad-076d-d065-f933-b772b4e9c131@oracle.com>
In-Reply-To: <d7043cad-076d-d065-f933-b772b4e9c131@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jul 2020 17:52:50 -0700
Message-ID: <CAPcyv4ie3pavOzPP68jGdeT1UK2eMjiZwiwvw1Jzy6D-d_pxjg@mail.gmail.com>
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 7:37 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/23/20 11:55 PM, Dan Williams wrote:
> > @@ -561,13 +580,26 @@ static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
> >       if (start == U64_MAX)
> >               return -EINVAL;
> >
> > +     ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
> > +                     * (dev_dax->nr_range + 1), GFP_KERNEL);
> > +     if (!ranges)
> > +             return -ENOMEM;
> > +
> >       alloc = __request_region(res, start, size, dev_name(dev), 0);
> > -     if (!alloc)
> > +     if (!alloc) {
> > +             kfree(ranges);
> >               return -ENOMEM;
> > +     }
>
> Noticed this yesterday while looking at alloc_dev_dax_range().
>
> Is it correct to free @ranges here on __request_region failure?
>
> IIUC krealloc() would free dev_dax->ranges if it succeeds, leaving us without
> any valid ranges if __request_region failure case indeed frees @ranges. These
> @ranges are being used afterwards when we delete the interface and free the
> assigned regions. Perhaps we should remove the kfree() above and set
> dev_dax->ranges instead before __request_region; or alternatively change the
> call order between krealloc and __request_region? FWIW, krealloc checks if the
> object being reallocated already meets the requested size, so perhaps there's no
> harm with going with the former.

Yeah, the kfree is bogus. It can just wait until the device is
destroyed to be freed, but only if there is an existing allocation. If
this is a new allocation then nothing else will do the kfree.
