Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F260C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505162074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtW9lS6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCXSEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:04:37 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52876 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgCXSEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:04:37 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so1937876pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6D1qQMRRPZ5xDrX5sp8lcIjV/Vfj8BIv8e4N9X0r+E=;
        b=CtW9lS6Y4fS4UkKTuPejMOdSIuUWtVumC0y+idku0teJFY0Ons5GmbVuvn/1ynq1VL
         bujXj6rBx1VLLR/5v+d50dIhSkezniXi1jI0xkKoxZY5o839joVw4zaP+kFSPm4B7VNN
         KEX9lBIrCOMHzomGYlOZTgb/stIwB5+Y8Q7WVq+Tb2FTgTckL7/9mhKeufeE/kYiofUZ
         CGC65HSefnN4HVLP91NomsmYmFMHWw+KHG6S3Cn1GqNo3mALkQaVjf5wxHCfnVmLyzMC
         yCAJHzcSeWFSkHfqF3nHehV2uoA46i6WZMXe/KrecQd5hhY36HOk9WMj2Yk/iKAHA9x2
         DKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6D1qQMRRPZ5xDrX5sp8lcIjV/Vfj8BIv8e4N9X0r+E=;
        b=o5B9Ct22O05pqHH73syFF5tDRitDEr0KeCPrieGywYSul2kBjU7KbVfZ0bjkgZwFXp
         dQcVQfAW288JJKNGTUZZZMonpRQjL14JaoFkXvhQ0+ANAsc4aD7eFRmryqL5TEi5nDm/
         MTbAB+Yv2C9Hzaj7NtPCnpTsq4er3rZ3KEb/ldVrpje1DN7L69X6O5WYlG2NNsiwdSbN
         v8iD/ksvyDWrSSoO+qL/nZT8B+eDA1dYi7jGOEUdiJfbOHg8osFGkAz/ekiOeOSndXM5
         J0ykzoiC8oTxvaVu6V26KWWQ3CazjT+1O6X5l32NcOkru2MtK9UVuImF2aOl7pvNhMCG
         y7wQ==
X-Gm-Message-State: ANhLgQ2NngNXpwcc8TjM4RfM3/qIe1ZlYHu7bTXnAF7Zz3PfMQRltbMj
        SWiRo564KNHRc8YpNsP/a60UjZfem5kBdAxL8+e9XQ==
X-Google-Smtp-Source: ADFU+vszYgPhPSWp9GTbcfQOr/YTNugd2UHb1LSPkkmg+AKX4oRyirK+NJxXo2eP+nGfaRn2NqRfie1Evh/HYQbt2bM=
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr6206355pjb.186.1585073074176;
 Tue, 24 Mar 2020 11:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200324104005.11279-1-will@kernel.org> <20200324104005.11279-2-will@kernel.org>
 <CAKwvOd=_v__=b6ijFYkxgDsmxakmkxwDWFG48601Gh9cyhj3PA@mail.gmail.com> <20200324175113.GA16742@willie-the-truck>
In-Reply-To: <20200324175113.GA16742@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Mar 2020 11:04:23 -0700
Message-ID: <CAKwvOdm9q0wPun0zLcFB0Z5NPec08OpHWp3tJV3-ddFiuU2jQA@mail.gmail.com>
Subject: Re: [PATCH 1/4] sparc32: mm: Fix argument checking in __srmmu_get_nocache()
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:51 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Mar 24, 2020 at 10:41:52AM -0700, Nick Desaulniers wrote:
> > On Tue, Mar 24, 2020 at 3:52 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > The 'size' argument to __srmmu_get_nocache() is a number of bytes not
> > > a shift value, so fix up the sanity checking to treat it properly.
> > >
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  arch/sparc/mm/srmmu.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> > > index f56c3c9a9793..a19863cac0c4 100644
> > > --- a/arch/sparc/mm/srmmu.c
> > > +++ b/arch/sparc/mm/srmmu.c
> > > @@ -175,18 +175,18 @@ pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
> > >   */
> > >  static void *__srmmu_get_nocache(int size, int align)
> > >  {
> > > -       int offset;
> > > +       int offset, minsz = 1 << SRMMU_NOCACHE_BITMAP_SHIFT;
> > >         unsigned long addr;
> > >
> > > -       if (size < SRMMU_NOCACHE_BITMAP_SHIFT) {
> > > +       if (size < minsz) {
> > >                 printk(KERN_ERR "Size 0x%x too small for nocache request\n",
> > >                        size);
> > > -               size = SRMMU_NOCACHE_BITMAP_SHIFT;
> > > +               size = minsz;
> > >         }
> > > -       if (size & (SRMMU_NOCACHE_BITMAP_SHIFT - 1)) {
> > > -               printk(KERN_ERR "Size 0x%x unaligned int nocache request\n",
> > > +       if (size & (minsz - 1)) {
> > > +               printk(KERN_ERR "Size 0x%x unaligned in nocache request\n",
> >
> > Was modifying the printk intentional? int vs in ?
>
> Yes, I think "int" is a typo so I just fixed it up while I was here. Do you
> prefer the old way? I couldn't parse it at first, but now you mention it
> I suppose the type of 'size' is int, so *maybe* it makes sense after all!

No preference; the code is validating/updating the `size` which as you
noted is an `int`.

-- 
Thanks,
~Nick Desaulniers
