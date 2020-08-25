Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC1FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2A52075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g17iV+Lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHYXTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHYXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:19:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C00C061574;
        Tue, 25 Aug 2020 16:19:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 31so64876pgy.13;
        Tue, 25 Aug 2020 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nzT4cIv5aZloZUa85ooGLcuJKku+lTzXEIFwdhhhrM4=;
        b=g17iV+Lc6aSBOLe+PXWahWJW6Y2WovRbdTAFwXkgWGEBHeis8BwaGJ1/CrBTJ6wOxj
         UKRTRHo+JKIkjHdtn9pMcUYhCibnMervY6vIJWwS4RQlE3LSjVqmLUTaL39UbAGj4g6L
         0j0826j4CHEZnT2exq6W7xhcrJUuL+xeGwEr2VpfFjtGbo9lANRsknS4EVWyKfxKl7Il
         /yIG9aDg8s8XYB33HFnAKY/2MhxQ2vY2S/m+geHEPThOE90LQ6W/H7XBdg78bySpsa/G
         t/9acHQaOTqhr0MpHdKlJO7fxd8cXHOELXVJXXUfDBije2GdrgU/aZZQogR8XNVpmWFo
         c4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzT4cIv5aZloZUa85ooGLcuJKku+lTzXEIFwdhhhrM4=;
        b=UH/AJUyQZxDqGfdAJrvy99L/wXSWNJqoMJeRcOnBBVJkiv0FnY3SySyXVH/LTKr60j
         oMvu9nv0sFDYhJGzELcZ3RObUu37x69fdGcXhnuzNpOqe6MNKC7y+Fn7gv64q8XuMMJg
         Fl/eP0aSuFiu5pTmLOrzpLx8br1sQTZlQyXUhzOSibkUz4oxHdSfWryc4Mc3Ow+lQf8E
         kXR5NI9FQOkmvVvLv3n6ToXl9kjbhk8F9gnPIuR0Y24DQJNCdYMdb/zSgrZW+vXqnDjT
         1raRdZuevUW5Y4ua4eq/gaf4K5OnDme1ys2qxDCmhnOMw7tV2rXShWxAGLpeAT/rDtzH
         8pFg==
X-Gm-Message-State: AOAM531RQ2CB+J5qzUPdxAeAslK88XaaXW/rHNA4fX23yd1QFCE7iQE3
        XhNF4EW1mA0cye4p0n3KMpM=
X-Google-Smtp-Source: ABdhPJyK06Dvh5ZLh8ZEvQMG4jqMYYcFE+LKTmieWcScqEbOmexcuH0IBvKor0u/mjocM4FCOCK/kw==
X-Received: by 2002:a63:4545:: with SMTP id u5mr8237031pgk.229.1598397551754;
        Tue, 25 Aug 2020 16:19:11 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v78sm344700pfc.121.2020.08.25.16.19.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 16:19:11 -0700 (PDT)
Date:   Tue, 25 Aug 2020 16:19:00 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, sfr@canb.auug.org.au, hch@lst.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: [RFT][PATCH 0/7] Avoid overflow at boundary_size
Message-ID: <20200825231900.GA4726@Asurada-Nvidia>
References: <20200820231923.23678-1-nicoleotsuka@gmail.com>
 <4321af30-9554-6897-5281-05afd88f2631@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4321af30-9554-6897-5281-05afd88f2631@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Tue, Aug 25, 2020 at 12:16:27PM +0200, Niklas Schnelle wrote:
> On 8/21/20 1:19 AM, Nicolin Chen wrote:
> > We are expending the default DMA segmentation boundary to its
> > possible maximum value (ULONG_MAX) to indicate that a device
> > doesn't specify a boundary limit. So all dma_get_seg_boundary
> > callers should take a precaution with the return values since
> > it would easily get overflowed.
> > 
> > I scanned the entire kernel tree for all the existing callers
> > and found that most of callers may get overflowed in two ways:
> > either "+ 1" or passing it to ALIGN() that does "+ mask".
> > 
> > According to kernel defines:
> >     #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
> >     #define ALIGN(x, a)	ALIGN_MASK(x, (typeof(x))(a) - 1)
> > 
> > We can simplify the logic here:
> >   ALIGN(boundary + 1, 1 << shift) >> shift
> > = ALIGN_MASK(b + 1, (1 << s) - 1) >> s
> > = {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
> > = [b + 1 + (1 << s) - 1] >> s
> > = [b + (1 << s)] >> s
> > = (b >> s) + 1
> > 
> > So this series of patches fix the potential overflow with this
> > overflow-free shortcut.
 
> haven't seen any other feedback from other maintainers,

I am wondering this too...whether I sent correctly or not.

> so I guess you will resend this?

Do I need to? Though I won't mind doing so if it's necessary..

> On first glance it seems to make sense.
> I'm a little confused why it is only a "potential overflow"
> while this part
> 
> "We are expending the default DMA segmentation boundary to its
>  possible maximum value (ULONG_MAX) to indicate that a device
>  doesn't specify a boundary limit"
> 
> sounds to me like ULONG_MAX is actually used, does that
> mean there are currently no devices which do not specify a
> boundary limit?

Sorry for the confusion. We actually applied ULONG_MAX change
last week but reverted it right after, due to a bug report at
one of these "potential" overflows. So at this moment the top
of the tree doesn't set default boundary to ULONG_MAX yet.

Thanks
Nic
