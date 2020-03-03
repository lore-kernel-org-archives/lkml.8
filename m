Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E0CC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0C720866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="tF5yG/AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgCCTBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:01:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37123 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgCCTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:01:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so4537627qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=37vsySpB7Mqr4UTwM/asZE/CIaecAwjFUAkmqD+hVbo=;
        b=tF5yG/AWd+MBMKM3vl2N5PrQwoQ369N9ecF8QhfmfTho88uMe3HwPetZtfRLo0VXX0
         GGE7gUX6ISVew0WD/Dz3HAHu5kGePLzK5IBo5j54NW8rgsHjEu/4jCX5CpUeRfV4ZvVV
         lJiR6/29mC9sbD4/1XS3nHQdSf7CH1A3vgeNNbiS693B1Kp9Lcyy+5urzNj124TpsS6D
         fznxmqkI0Qg+DfAlNbGlWbqBn/oVUOsYjGqR6M3BWIgezg+IGELz3+M//gCmE3afJLsW
         A+0086QT4t5fGHe1iItCfnWAOgMYT06CS+0kGqDYCP/ezN/k1jIvAUPzy3RnKsg1ENF9
         zbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37vsySpB7Mqr4UTwM/asZE/CIaecAwjFUAkmqD+hVbo=;
        b=R2NlToM5JCwZdElrPi7FNceoNix9NNYLcNH4o/CA31sCX9qDiI2rFGhECUbb60GccJ
         IfULQcXOpGmMC4JaF/sdqmTQ86wuSWkfxQvL0jutlTodwEXAy54Nypzijo12k1PtPDr3
         cM5FZUChkXwgqxbXxhj/rqY9JevtAsIk3jcj6vpIwWAbONdCUsNoyUBXvb4QeXlCavK+
         DErxI1VAc4soj92s/E8R2w3PYggQJ6WIDSUxpVpihAOhAHVCS/iUfZexfZnAwnjOMIDg
         M4eGcdCWJ/W17OdaJC3GRfIFzvEQIV+BrIITl377AsqrDGfiBwO7tqk75iHd5wqMmCPM
         RC2Q==
X-Gm-Message-State: ANhLgQ2HOdjeCmSvhzTP2NpQv1+WeXBz2xz5eSoHevQQfVoPbVE1DijM
        HdnG+w5OwInsytI5qZogHoRxpw==
X-Google-Smtp-Source: ADFU+vtODMnJ+4ShJe3Bohbk8f0YR/Zh520g1xmeyo/GdYXZtLKRnrfgx9VgFdCYtn0++2UgUn/2MA==
X-Received: by 2002:a37:6211:: with SMTP id w17mr4945011qkb.324.1583262064910;
        Tue, 03 Mar 2020 11:01:04 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w83sm11981895qkb.83.2020.03.03.11.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 11:01:04 -0800 (PST)
Message-ID: <1583262063.7365.147.camel@lca.pw>
Subject: Re: [PATCH -next] signal: annotate data races in sys_rt_sigaction
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, catalin.marinas@arm.com,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Mar 2020 14:01:03 -0500
In-Reply-To: <CANpmjNOtweO7o7wxM6yX3_XKETWcLVqmKsQq5ZkXybfAY4_H5g@mail.gmail.com>
References: <1583256049-15497-1-git-send-email-cai@lca.pw>
         <CANpmjNPJc_45+h_yJWwmw=YUuWduD6pPX2vdfPVekPvnnHd+_Q@mail.gmail.com>
         <CANpmjNOtweO7o7wxM6yX3_XKETWcLVqmKsQq5ZkXybfAY4_H5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-03 at 19:26 +0100, Marco Elver wrote:
> On Tue, 3 Mar 2020 at 18:53, Marco Elver <elver@google.com> wrote:
> > 
> > On Tue, 3 Mar 2020 at 18:21, Qian Cai <cai@lca.pw> wrote:
> > > 
> > > Kmemleak could scan task stacks while plain writes happens to those
> > > stack variables which could results in data races. For example, in
> > > sys_rt_sigaction and do_sigaction(), it could have plain writes in
> > > a 32-byte size. Since the kmemleak does not care about the actual values
> > > of a non-pointer and all do_sigaction() call sites only copy to stack
> > > variables, annotate them as intentional data races using the
> > > data_race() macro. The data races were reported by KCSAN,
> > > 
> > >  BUG: KCSAN: data-race in _copy_from_user / scan_block
> > > 
> > >  read to 0xffffb3074e61fe58 of 8 bytes by task 356 on cpu 19:
> > >   scan_block+0x6e/0x1a0
> > >   scan_block at mm/kmemleak.c:1251
> > >   kmemleak_scan+0xbea/0xd20
> > >   kmemleak_scan at mm/kmemleak.c:1482
> > >   kmemleak_scan_thread+0xcc/0xfa
> > >   kthread+0x1cd/0x1f0
> > >   ret_from_fork+0x3a/0x50
> > 
> > I think we should move the annotations to kmemleak instead of signal.c.
> > 
> > Because putting a "data_race()" on the accesses in signal.c just
> > because of Kmemleak feels wrong because then we might miss other more
> > serious issues. Kmemleak isn't normally enabled in a non-debug kernel.
> > 
> > I wonder if it'd be a better idea to just disable KCSAN on scan_block
> > with __no_kcsan? If Kmemleak only does reads, then __no_kcsan will do
> > the right thing here, because the reads are hidden completely from
> > KCSAN. With "data_race()" you would still have to mark both accesses
> > in signal.c and kmemleak (this is by design, so that we document all
> > intentionally data-racy accesses).
> > 
> > An alternative would be to just exempt kmemleak from KCSAN with
> > "KCSAN_SANITIZE_kmemleak.o := n". Given Kmemleak is a debugging tool
> > and it's expected to race with all kinds of accesses, maybe that's the
> > best option.
> 
> I saw there are already some data_race() annotations in Kmemleak.
> Given there are probably more things waiting to be found in Kmemleak,
> KCSAN_SANITIZE_kmemleak.o := n might just be the best option. I think
> this is fair, because we really do not want to annotate anything
> outside Kmemleak just because Kmemleak scans everything. The existing
> annotations should probably be reverted in that case.

Good idea. I'll post a new patch for that.
