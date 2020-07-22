Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971E0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698EF2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA3IStd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgGVVWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:22:54 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B3C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:22:54 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so4137201ion.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VohS4iMaP473sH0+x5FyiODZ6sIL4ZWEBPGGaUIXXx4=;
        b=rA3IStd8NrWCnDj/2tajAB8j+bvWNfjiDDH4mkJreUzL/RSlnMlyiQf8e/hBx8dX2Z
         0xlWTKiGdmNYQ/BXFGXFRn4xFGGcr8IdzV05Hc9ea1cR4afkNw3uMXXRLdVPHikRb3db
         NaIFpRSsEdHrj14jCONXz63zna3P3FTVc2of+l2zo1R+RWyAWarOCtbkbcb7y3YjSwwe
         rE1SVU8i/4U4cGSiT5Y6bK7kv29EA8Jpcop7PR1mLEw0FeGOzJW4AvPuMqlGywWkjUU6
         9LOOR3v6hsPKsNZMmsUPAbntChjlVeq3BGsumXCNMpeNk71F32mkSlkiRr8UiqoSgUmC
         TkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VohS4iMaP473sH0+x5FyiODZ6sIL4ZWEBPGGaUIXXx4=;
        b=ZOcBHVcO/q42GW7ANBmhry7LAJQvwKVi04zcCqi9Qdekr/B2MCTpdNScJCWfEdOMsv
         wA1PE0sckjdeCR7V4hs/S95aiWAcOapySxy3aJKmACWaOz7F94S62ynLFK4phsTjOpXt
         YEImAnRe117+Co2Ec5XIshhPJJ0PzJ6Gw5g7kUwLWTQtuAsBJBoRqdogQGCpKYoAa/93
         jsu27bTli1elNHKngOM1w9P0CF/mPAX2WvnSSrKebA3wNZYXfM5EKmGcoUjUxlf0gqaG
         hUjllHr9vgqFpjAIWzBfZ/QA15bjoTIMXNUtNOcCjWShEqhcuaTCFUZvgpBqDAnBjwAe
         Z1UQ==
X-Gm-Message-State: AOAM532lzFD3akWPz7pvyoPtjHg5m+K+KhTFiLT3pJQdNxP+yqwAixB1
        IZ75RSt45a6Rk8wOORppOgKFK5BVBDb+Hl1Q3u+kJh7d
X-Google-Smtp-Source: ABdhPJxvz/UKpGXKZkslafZ+NS4SOqiTqUgKMnVzXq89fLrzhVEbFE+deISxS9T4xeB+Hih/BodSlgxKuYvsKhcU5Kg=
X-Received: by 2002:a02:7419:: with SMTP id o25mr1313549jac.4.1595452973220;
 Wed, 22 Jul 2020 14:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <bug-208655-6666@https.bugzilla.kernel.org/> <87h7tz306w.fsf@nanos.tec.linutronix.de>
 <CAMe9rOrER7Mg_YvzuqguS-GCyP-bD2hogWeo+OMXm7F6JXQUDQ@mail.gmail.com> <87r1t3z612.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87r1t3z612.fsf@nanos.tec.linutronix.de>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 22 Jul 2020 14:22:17 -0700
Message-ID: <CAMe9rOoXQK5GgveVem2fSJWeAYUDjoKOo6ESpkU+29NfytNC7A@mail.gmail.com>
Subject: Re: [PATCH] x86/dumpstack: Dump user space code correctly again
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 12:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> "H.J. Lu" <hjl.tools@gmail.com> writes:
> > On Wed, Jul 22, 2020 at 10:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> +       if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
> >>                 printk("%sCode: Bad RIP value.\n", loglvl);
> >>         } else {
> >>                 printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
> >
> > Add a kerel self test?
>
> Care to whip one up?
>

Can we count "dmesg" to always dump opcode?

-- 
H.J.
