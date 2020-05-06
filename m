Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD4AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A40520708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K27S1ANC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgEFStJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbgEFStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:49:08 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ABCC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:49:08 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id j1so955520vkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoS2IrOuB3k8Gs9GTISOGT+amC7ulD3eOthouormdxY=;
        b=K27S1ANCL0hISWI03vyvhke0iacWwTBF7yU/P582dsLj3daLFJ2SdMdfsFXBM294Ft
         1w5QHE6tmAhpi7Z6BXb7NcZk0ycafNLuXx2wl3a8tCd5PlHhRcHX3zgOBff0AtBi91TS
         tCU0/Y6CnphoZclJXqr9jCiMDj9S0ZrAbHKPlqrWDlhTGD5A6PrFkqmbA7hrlzHsopVa
         utrMTck18XaaSK39Gq8HyFkumjumw0E66UirxHQtYh/82SXwFEF4Iw53lSM4AOdd46Cn
         cMzpKs1mqiAfnpFPs9pzfdjjq+tgrEavwY+gcE1WLzmS1hsAiXWz+xxkA61nkdE9tJhC
         T9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoS2IrOuB3k8Gs9GTISOGT+amC7ulD3eOthouormdxY=;
        b=gA/92BkIkE2lFn1l6J021QBJFgHcBhAu8wC2jovz9DleOOvGXc2MSy6shpUqZ9tv0Z
         T0fqHxBeROLw8WGsLLjVYo4QfGwFEufTXXCD5ihpXtONMLondNOuoSbgtRuBEW7rB2NI
         EULRBrilXYc6rN58aqLoSAjzq4jOUkJzGfX6rbmbikg0qmBanuLmcrI4gP61S8r+jY+N
         E0nNahM36l3CnyVNfTrSTpy5klXyD9yjfb5Pyq0uaHdfqmSO3MHMb8jg/S8RBBwyQlcb
         OeU5r0A3ANFQzuobZZW0HrINykLgbab6DbBL9/uv0YlHaFlnjtMBGcchg0+77FFQQ83G
         /HAQ==
X-Gm-Message-State: AGi0Pubg4ztBNo74DqYSmqkT+sXHpZQU9EyAXE8MCMfSCaC2pT1MgLcZ
        OHGXoRcrKorvEaKK5ONLlyqnkDrM5SMA2keTnF+TYaF4
X-Google-Smtp-Source: APiQypJbK31ADZOcUD7/8kR6cwvtVlvUczpqAOSQacU+9q45s47m8DbJapY7KQpgHwzo1HCg8pM6B7TaJf//UPNpmEw=
X-Received: by 2002:a1f:16d5:: with SMTP id 204mr8348641vkw.20.1588790947678;
 Wed, 06 May 2020 11:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBQ13AEPrV=pUcF1L6iYOaDgN2dsVanXBa8+AqgUh87kEQ@mail.gmail.com>
 <20200506113714.GA5281@hirez.programming.kicks-ass.net>
In-Reply-To: <20200506113714.GA5281@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 6 May 2020 11:48:56 -0700
Message-ID: <CABPqkBR5yoocv=6P_EDbMR64Pdyom6VKHOn7b6XnAi2Lf_z4Mg@mail.gmail.com>
Subject: Re: callchain ABI change with commit 6cbc304f2f360
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>, jpoimboe@redhat.com,
        "Liang, Kan" <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 4:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, May 05, 2020 at 08:37:40PM -0700, Stephane Eranian wrote:
> > Hi,
> >
> > I have received reports from users who have noticed a change of
> > behaviour caused by
> > commit:
> >
> > 6cbc304f2f360 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
> >
> > When using PEBS sampling on Intel processors.
> >
> > Doing simple profiling with:
> > $ perf record -g -e cycles:pp ...
> >
> > Before:
> >
> > 1 1595951041120856 0x7f77f8 [0xe8]: PERF_RECORD_SAMPLE(IP, 0x4002):
> > 795385/690513: 0x558aa66a9607 period: 10000019 addr: 0
> > ... FP chain: nr:22
> > .....  0: fffffffffffffe00
> > .....  1: 0000558aa66a9607
> > .....  2: 0000558aa66a8751
> > .....  3: 0000558a984a3d4f
> >
> > Entry 1: matches sampled IP 0x558aa66a9607.
> >
> > After:
> >
> > 3 487420973381085 0x2f797c0 [0x90]: PERF_RECORD_SAMPLE(IP, 0x4002):
> > 349591/146458: 0x559dcd2ef889 period: 10000019 addr: 0
> > ... FP chain: nr:11
> > .....  0: fffffffffffffe00
> > .....  1: 0000559dcd2ef88b
> > .....  2: 0000559dcd19787d
> > .....  3: 0000559dcd1cf1be
> >
> > entry 1 does not match sampled IP anymore.
> >
> > Before the patch the kernel was stashing the sampled IP from PEBS into
> > the callchain. After the patch it is stashing the interrupted IP, thus
> > with the skid.
> >
> > I am trying to understand whether this is an intentional change or not
> > for the IP.
> >
> > It seems that stashing the interrupted IP would be more consistent across all
> > sampling modes, i.e., with and without PEBS. Entry 1: would always be
> > the interrupted IP.
> > The changelog talks about ORC unwinder being more happy this the
> > interrupted machine
> > state, but not about the ABI expectation here.
> > Could you clarify?
>
> Intentional; fundamentally, we cannot unwind a stack that no longer
> exists.
>
Ok, thanks for clarifying this.

> The PEBS record comes in after the fact, the stack at the time of record
> is irretrievably gone. The only (and best) thing we can do is provide
> the unwind at the interrupt.
>
The PEBS record is always at an IP BEFORE or EQUAL to the interrupted IP.
The stack at PEBS may be gone in case the PEBS sample was captured at the
epilogue of the function where sp/rbp are modified.

> Adding a previous IP on top of a later unwind gives a completely
> insane/broken call-stacks.

I agree that using the interrupted IP is the most reliable thing to do.

You can get the callstack at the PEBS sample with LBR callstack on Icelake
because PEBS can record LBR. I am hoping this works with the existing code.
