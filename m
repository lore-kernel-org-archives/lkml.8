Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E67C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E18E206F9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6shKcOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgEPXMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 19:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbgEPXMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 19:12:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28EEC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 16:12:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 190so6606605qki.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/FA08ie9Q9raMBDAvUVW1EsIFcuMMqEv2UfWS7IrUiU=;
        b=k6shKcOPsbBc4xyf8foNzLKYLQ5MSGfEucWlwiBn/c50HNAicIZCJcHPORCaUjj8PO
         yfpmzsGaoFxzh1nU5Ny6R+7jTYSHlOBk6pMCfsSBSkjLGooKfZms4a618ur8d1mIWRXM
         Y7nzhgC9YyhbOQc+1T90dg6QLONfEOO5m5c9jNBlio1cXzNv1l0golOU7i1GnMWPOJbK
         Huqq3/PD6G9aeXchdHrJrHKx4rzq/flziJFGZow3EKF3eb1erjs1mCREexZE3qcg/NBo
         fTiAOV9tO/TEWP6HXJXg1nFLAHl8TwkgsuS/phHx+LqdXzv+OwfagKXG19Qvvf/K5ngd
         XHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/FA08ie9Q9raMBDAvUVW1EsIFcuMMqEv2UfWS7IrUiU=;
        b=Ut/pgeF+miIIFMah3cWqNm2ogpPIub0nkZ6uCqHdWaXA9l/8OL7BqR5YFksiwPKHnb
         KT+4QTnvvW5uWQPONgz/rVgt9O3XpYvPSrRO4V09zHMlX8Tm4BoR87Isz1IO4/QEnd3k
         43E34sLx1DjxusOvkK5mHpd7FblsD4BeMeH89a4OXjPKmeicCKAAC5IxoxvWZHRj5w99
         HbTyXhUsroWNXQwntcU6lWsTSNGbDOcUXIT1n/PvzplrtpM+HhDTCrkpo3m4D4Z0BbL9
         iQmSckopnQI1Ao1oj7OE2J9m5uomCpaf5TkwXd27yyuYsrLdS+J3Bu2Aqu+bE4NsszJ/
         wUnQ==
X-Gm-Message-State: AOAM532dzX0OnCeKkiymBiZSiXDi5bW4cea4bbESBc7jciVBdEPKC7v2
        TSlVy0+hCxN2wXpXN5rXWO8=
X-Google-Smtp-Source: ABdhPJyiM3dLsgTH98851rg9lWzY83YCpfTp7GUozsuZAuW/V+tMoA+76Acp8GmA15K9uljLsD0D7Q==
X-Received: by 2002:a37:38e:: with SMTP id 136mr9689173qkd.247.1589670772641;
        Sat, 16 May 2020 16:12:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v78sm4845494qkb.62.2020.05.16.16.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 16:12:52 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 16 May 2020 19:12:50 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH v2] x86/boot: Correct relocation destination on old
 linkers
Message-ID: <20200516231250.GA630703@rani.riverdale.lan>
References: <20200111190015.3257863-1-nivedita@alum.mit.edu>
 <20200207214926.3564079-1-nivedita@alum.mit.edu>
 <20200313183349.GA1544820@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200313183349.GA1544820@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 02:33:50PM -0400, Arvind Sankar wrote:
> On Fri, Feb 07, 2020 at 04:49:26PM -0500, Arvind Sankar wrote:
> > For the 32-bit kernel, as described in commit 6d92bc9d483a ("x86/build:
> > Build compressed x86 kernels as PIE"), pre-2.26 binutils generates
> > R_386_32 relocations in PIE mode.  Since the startup code does not
> > perform relocation, any reloc entry with R_386_32 will remain as 0 in
> > the executing code.
> > 
> > Commit 974f221c84b0 ("x86/boot: Move compressed kernel to the end of the
> > decompression buffer") added a new symbol _end but did not mark it
> > hidden, which doesn't give the correct offset on older linkers. This
> > causes the compressed kernel to be copied beyond the end of the
> > decompression buffer, rather than flush against it. This region of
> > memory may be reserved or already allocated for other purposes by the
> > bootloader.
> > 
> > Mark _end as hidden to fix. This changes the relocation from R_386_32 to
> > R_386_RELATIVE even on the pre-2.26 binutils.
> > 
> > For 64-bit, this is not strictly necessary, as the 64-bit kernel is only
> > built as PIE if the linker supports -z noreloc-overflow, which implies
> > binutils-2.27+, but for consistency, mark _end as hidden here too.
> > 
> 
> Gentle reminder.
> 
> https://lore.kernel.org/lkml/20200207214926.3564079-1-nivedita@alum.mit.edu/

Ping.
