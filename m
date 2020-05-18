Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A83CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592442070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP9PXV+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgERFqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERFqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:46:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E3BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:46:03 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h7so98068otr.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHIPtwizuJJ8Ut3MjdysZF5NHI8/optEcfuuIjKQd5I=;
        b=WP9PXV+kr+zcDzjTAYCg1yuLh8csUwd0flQXiXhfhopKRwgBWdvOkZlj7+wMvMgmHX
         X9395CSLd6Ob1X4+uoIwE+ASm1p8Pzice9ArcCWw21oVk1aIQPGmpHTSGC/azH+TWC8s
         eAyDXG0zx7Fx/ahE9DDb8zU46xONiX03i0pYL9yopmTPr2GRLreTlJHoib0bT5KL39eI
         vxeA6Jc506j/inSFcdPonAZlNG/3j2fyFWNavvQ8M9FEwRq6Z2F2WUNN0gNSGbhkJutH
         EICmG6+A+hvgd6liCOUV66z1VldLaGEBjkIcwzF0otrZ054JXJY6IEblUUTtWStIjcrg
         ftYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHIPtwizuJJ8Ut3MjdysZF5NHI8/optEcfuuIjKQd5I=;
        b=R2sSIRjN2gwOzOgWhxEmzrR9HVgGQmei/8dveskVYJO0KmYR24o0LMUqnREmFq4Z6l
         rih8/b82XO1l3Ui2u4UJedQ4Cu0SRyrCn+k9VVVVVMlaD/C0lHk4Bz4HidrJLYZ5/6x0
         BM/PKM+HQAkZ4/Pb5i4m7wBql6FjZdq3wTuUnDR41Hub7xzMyB1Emt+HYsO/RV9+Tu/j
         txptjaDaLh3bevgdDNr3jQZMRIyjx/pkOnBHeOyyLrU8r80kxbahKwREtiPjqVPARtPx
         5Rwi3CApVgFXBMkoUXOoCc45eV6q53uz8RjrYc82PGviK4pZr4PVsrPsaN77veByz12J
         9dVQ==
X-Gm-Message-State: AOAM533gJn99uPOtJrbh7Bb/8FcySrEloxzmpgZ4FFDM6HLl0IlCVSWq
        3xqPFe4CMbq8ffg9U8zH3W7AkcqFe8pw9FAg0f9n5g==
X-Google-Smtp-Source: ABdhPJxVaVfYRfC++bcomKfhV/jH4a1jS72/ADwWqa9UGXzYn8ZEQC68iQYkhLvcYWg18qQwytBT5GF2vee0/dz24/o=
X-Received: by 2002:a05:6830:101a:: with SMTP id a26mr10661305otp.53.1589780762697;
 Sun, 17 May 2020 22:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPY=qRQ6gzN1BWh=ianVDBQ1C9kibWHwxs5Z0+QSwGxKymLDTQ@mail.gmail.com>
 <374485.1589637193@turing-police> <af03bee5-27b2-4e92-359a-b1cc8f500d6d@infradead.org>
 <CAPY=qRRJ6aZbbRnWfvjqojs08Z7H-+-6nzLAcpzjDcQOJ40fOQ@mail.gmail.com> <CAM_iQpXzeMjAUW0LNMpGf+bqykU8fjOJmy=CDdNEPQNpSB4raA@mail.gmail.com>
In-Reply-To: <CAM_iQpXzeMjAUW0LNMpGf+bqykU8fjOJmy=CDdNEPQNpSB4raA@mail.gmail.com>
From:   Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date:   Mon, 18 May 2020 11:15:34 +0530
Message-ID: <CAPY=qRQez4JRLGcwBq_3_AGmtH36FRrKjhCWvkhrnQxvBJEnOw@mail.gmail.com>
Subject: Re: general protection fault vs Oops
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 2:16 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Sat, May 16, 2020 at 9:16 AM Subhashini Rao Beerisetty
> <subhashbeerisetty@gmail.com> wrote:
> > Yes, those are out-of-tree modules. Basically, my question is, in
> > general what is the difference between 'general protection fault' and
> > 'Oops' failure in kernel mode.
>
> For your case, they are likely just different consequences of a same
> memory error. Let's assume it is a use-after-free, the behavior is UAF
> is undefined: If that memory freed by kernel is also unmapped from
> kernel address space, you would get a page fault when using it
> afterward, that is an Oops. Or if that memory freed by kernel gets
> reallocated and remapped as read-only, you would get a general
> protection error when you writing to it afterward.
Cool, thanks for the clarification.
