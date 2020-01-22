Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE0C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0872F24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579701919;
	bh=esBPi1mGxaJZbmOl+/JaOfT4NBrTR5BE3aYw2P5SxaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KOy9fQfc3q5uU3BL44TQc49C7lWyF6+r0K5KrqPwqr4/0GIugYf+XHvWRjK4/NOWG
	 694R50zj4iabdtLD/XTWvOMRRzbhy9Vv+RxKftEAnvxZ8MheJ+2CI4Y+lp4Fhnw5px
	 rqmw6T2Bo68Lc4uv0hpfZfy+9UWZ3glPBLnqWgRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgAVOFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:05:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34993 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgAVOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:05:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so7423166wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 06:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nTDawKBuPPz3RFrkaA7TRY9Jia2zninb0DeM+/pbQ8U=;
        b=tTNJEUiVNp5/UYXZRpKKGk5pmUcetJfgebRlMhACXOcx/da29zUBSO3zp0UCohbIQp
         +sCPpGjGpVXU1xNyPpiUP6vvMlDPJKXs+7JCNYBuEDM1EL8gDR2wLye2KYFuCxB+lDKZ
         MxzSTiVdHMY19bo9Yoqlarrg9zNwuyXwIG6jHDpsDZZJm1Wg6+iEcirB75WtzwMGzcaw
         mgKktaJygxjshVnaJMUQYVQlBSk0grcWZeAJ2hmUVSrjb1ZLYED9eklLDiTpIXOiNgxW
         0/MJZhqJviHbJeIxgcQ3VDK18pfZ9yl1bcbcM8QPTbkW5PfO85PgDyaK+PhdSewMS0ir
         Iqyg==
X-Gm-Message-State: APjAAAUl9b0RAXZ5poBM9dyhLib/TGFLnEt8T5cqaKl4iJgSpDUc0e+O
        +KS4g8Rj3qqk8CprmhV6+is=
X-Google-Smtp-Source: APXvYqxlAP+/wQo+U5G/hC5nhSUhqcfVX0b3qdlQz+EBZiRxKCsql6s8v1dOdo8DVwgg6iphafdn3g==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr11170497wrx.26.1579701916005;
        Wed, 22 Jan 2020 06:05:16 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id b137sm4417661wme.26.2020.01.22.06.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 06:05:15 -0800 (PST)
Date:   Wed, 22 Jan 2020 14:05:12 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sergey Dyasli <sergey.dyasli@citrix.com>
Cc:     Paul Durrant <pdurrant@gmail.com>, xen-devel@lists.xen.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 4/4] xen/netback: fix grant copy across page boundary
Message-ID: <20200122140512.zxtld5sanohpmgt2@debian>
References: <20200117125834.14552-1-sergey.dyasli@citrix.com>
 <20200117125834.14552-5-sergey.dyasli@citrix.com>
 <CACCGGhApXXnQwfBN_LioAh+8bk-cAAQ2ciua-MnnQoMBUfap6g@mail.gmail.com>
 <85b36733-7f54-fdfd-045d-b8e8a92d84c5@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b36733-7f54-fdfd-045d-b8e8a92d84c5@citrix.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:07:35AM +0000, Sergey Dyasli wrote:
> On 20/01/2020 08:58, Paul Durrant wrote:
> > On Fri, 17 Jan 2020 at 12:59, Sergey Dyasli <sergey.dyasli@citrix.com> wrote:
> >>
> >> From: Ross Lagerwall <ross.lagerwall@citrix.com>
> >>
> >> When KASAN (or SLUB_DEBUG) is turned on, there is a higher chance that
> >> non-power-of-two allocations are not aligned to the next power of 2 of
> >> the size. Therefore, handle grant copies that cross page boundaries.
> >>
> >> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> >> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
> >> ---
> >> v1 --> v2:
> >> - Use sizeof_field(struct sk_buff, cb)) instead of magic number 48
> >> - Slightly update commit message
> >>
> >> RFC --> v1:
> >> - Added BUILD_BUG_ON to the netback patch
> >> - xenvif_idx_release() now located outside the loop
> >>
> >> CC: Wei Liu <wei.liu@kernel.org>
> >> CC: Paul Durrant <paul@xen.org>
> >
> > Acked-by: Paul Durrant <paul@xen.org>
> 
> Thanks! I believe this patch can go in independently from the other
> patches in the series. What else is required for this?

This patch didn't Cc the network development list so David Miller
wouldn't be able to pick it up.

Wei.

> 
> --
> Sergey
