Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BABC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CD520866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583358676;
	bh=XvJqeL9Dkwgz8DG/GvAWCcKvRlJMAOJtbu4NVFvKZTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DwBZJyUpm71TOt4zE4MykbZ9LNyk9OrZBn4yBSYc6CObk7JZb+xOTqwXBnOE2heXg
	 EeXZwyEqf05ktcVw7rRPddOo8Cx9kOM+Hwjjc74XZBQUDnN3WZNbbtShPDsbVAXpSx
	 F3fQU+Odb2z+Ceo4ztCWsEyE5W9/250V2txQe9FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbgCDVvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388338AbgCDVvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:51:14 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED5DC21744
        for <linux-kernel@vger.kernel.org>; Wed,  4 Mar 2020 21:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583358674;
        bh=XvJqeL9Dkwgz8DG/GvAWCcKvRlJMAOJtbu4NVFvKZTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LmWDx1sWG0yVE0/Eh7z7VqCtWsxacrnGIghlxQgHOyPF3CwSZfGTAcXb5DGXys6L3
         xwjnQ1wR1+Uy1B7y3igsW52Du5QuYOYpQQUwPP9RgaVPPcljdfJ+tofOXLfh9UrYlG
         L7Mhu0m/Q69F2D2vyVZS1+zKPtBPRLEM/nWYuSCk=
Received: by mail-wr1-f49.google.com with SMTP id h9so4390221wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 13:51:13 -0800 (PST)
X-Gm-Message-State: ANhLgQ2dEXK+qQwCx0rbAZWg5uQXHI2BLMnSDTG1QJYugQquWSUrPFIs
        HD+Osv6xiNyFyVyYwokQYD7M8z/TadKK1FUxjMM4pA==
X-Google-Smtp-Source: ADFU+vt0nYE3kz2ug9hAB7jm/qu/DZt727mpeG008Vdr3dUP3kbKTQb7M36u9X/u+2LrgWShbhBrNFxZJ1vLMx8JsSo=
X-Received: by 2002:adf:f84a:: with SMTP id d10mr6182793wrq.208.1583358672314;
 Wed, 04 Mar 2020 13:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu> <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan> <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
 <20200304185042.GA281042@rani.riverdale.lan> <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
 <20200304191053.GA291311@rani.riverdale.lan> <CAKv+Gu84Bj4tBz=+FhG6cqpYUjc5czaqiNAVDdKgqGoXbnHKbQ@mail.gmail.com>
 <20200304195447.GA295419@rani.riverdale.lan>
In-Reply-To: <20200304195447.GA295419@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 22:51:01 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8sTuj+Wkk8g2tv+1k9LczXV4yV4KSbaJ6Bs69SQwR2_A@mail.gmail.com>
Message-ID: <CAKv+Gu8sTuj+Wkk8g2tv+1k9LczXV4yV4KSbaJ6Bs69SQwR2_A@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/mm/pat: Handle no-GBPAGES case correctly in populate_pud
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 20:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 04, 2020 at 08:22:36PM +0100, Ard Biesheuvel wrote:
> > The wrong one, obviously :-)
> >
> > With Haswell, I get [before]
> >
> > [    0.368541] 0x0000000000900000-0x0000000000a00000           1M
> > RW                     NX pte
> > [    0.369118] 0x0000000000a00000-0x0000000080000000        2038M
> > RW         PSE         NX pmd
> > [    0.369592] 0x0000000080000000-0x00000000b9800000         920M
> >                          pmd
> > [    0.370177] 0x00000000b9800000-0x00000000b9856000         344K
> >                          pte
> ^^ so this is showing the region that didn't get mapped, so you did
> reproduce the issue.
> > [    0.370649] 0x00000000b9856000-0x00000000b9a00000        1704K
> > RW                     NX pte
> > [    0.371066] 0x00000000b9a00000-0x00000000baa00000          16M
> > ro         PSE         x  pmd
> >
> > and after
> >
> > [    0.349577] 0x0000000000a00000-0x0000000080000000        2038M
> > RW         PSE         NX pmd
> > [    0.350049] 0x0000000080000000-0x00000000b9800000         920M
> >                          pmd
> > [    0.350514] 0x00000000b9800000-0x00000000b9856000         344K
> >                          pte
> ^^ but it didn't get fixed :( This region should now be mapped properly
> with flags RW/NX.
> > [    0.351013] 0x00000000b9856000-0x00000000b9a00000        1704K
> > RW                     NX pte
> >
> > so i'm still doing something wrong, I think?
>
> You're *sure* the after is actually after? There seems to be no change
> at all, the patch should have had some effect.

Duh.

Yes, you are right. It was 'operator error'
