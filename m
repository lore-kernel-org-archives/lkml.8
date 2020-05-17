Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515FFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2975A20758
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJQu5C9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgEQUqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgEQUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:46:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C945C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:46:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l6so1453382oic.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOGW5X0TGnwvfdKrZMYAVQyL8pOL2pG3Yh6nQN7pc+k=;
        b=LJQu5C9+BvFHQQ5nC51OFsHjqNeamH4oP3ywmBTTvspp8YNzR+qxuFO376WYn5hDg/
         Q15X4+hHrcdVeLSIN1izTyXWrlua5s1tY87NTS+1G0THJc2krCFs5IRnoKyAAZESninv
         4+Y//hPl8/FNRDSGa4VRiUEu+yokLxksiC2N4cXDb93kBD0ECkGRmrKLfrfe9JelwyQE
         2OtIk4Eurk75RnnhyijTNr8veIFjB8ApCR5og16NtuZqI65BnHdXmtQHTZX+572cMEe7
         BUL5vB36laCsy/blvdz9qmIRhIopkbD8Lk2HMoz5cani+SuME8drs+9sUGsPUCM/f4PE
         UHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOGW5X0TGnwvfdKrZMYAVQyL8pOL2pG3Yh6nQN7pc+k=;
        b=QV5eAB993oN9v+sWSyXImeK/pKGwkiVJVcBxLVNJoKBTrT9MHuUVpRVOueS4j2cRv/
         d9NjNMOb3s2xh5MwMaUAfy9LpHNk0FduwCZC0COOv1/z1JFlah3k3RUkqL+LoFOkVVMZ
         la2X4Zvpa8TK+cBfc4IujksTUUD4YOMXsTE35n90D/A8aIFX1ErR92NYgePvGoKmnoYS
         LuCfV/okBZ4RyhdgTEvBsCa1tdepA/ug6fVCRcV+CmkVGy0lpK8iRB1ndSzY4Kcfz/JL
         Yy9PS5JAWLa7xNItV9MLIstWmUA1SIizNG6BtTCc4mChQYN+YT1YDvnFTZHWapse4Gji
         62Bg==
X-Gm-Message-State: AOAM530OdA974oQiqN/TeLn58h9fNMKtahdIRbZBXvrK2fXfYZkVqlhn
        DECX4IViK7tkjS+cKljXmIVB7LhQtUHh3mmloRU=
X-Google-Smtp-Source: ABdhPJx9X7595DuhkP5qNYkqWJnw/kAliBoUDVWpj+5aW/c3otJ6HH3qda5gpv8JPsLo1WgncR8cI644/2Dp5g4s6dw=
X-Received: by 2002:aca:e1d6:: with SMTP id y205mr164891oig.142.1589748410745;
 Sun, 17 May 2020 13:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAPY=qRQ6gzN1BWh=ianVDBQ1C9kibWHwxs5Z0+QSwGxKymLDTQ@mail.gmail.com>
 <374485.1589637193@turing-police> <af03bee5-27b2-4e92-359a-b1cc8f500d6d@infradead.org>
 <CAPY=qRRJ6aZbbRnWfvjqojs08Z7H-+-6nzLAcpzjDcQOJ40fOQ@mail.gmail.com>
In-Reply-To: <CAPY=qRRJ6aZbbRnWfvjqojs08Z7H-+-6nzLAcpzjDcQOJ40fOQ@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun, 17 May 2020 13:46:39 -0700
Message-ID: <CAM_iQpXzeMjAUW0LNMpGf+bqykU8fjOJmy=CDdNEPQNpSB4raA@mail.gmail.com>
Subject: Re: general protection fault vs Oops
To:     Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 9:16 AM Subhashini Rao Beerisetty
<subhashbeerisetty@gmail.com> wrote:
> Yes, those are out-of-tree modules. Basically, my question is, in
> general what is the difference between 'general protection fault' and
> 'Oops' failure in kernel mode.

For your case, they are likely just different consequences of a same
memory error. Let's assume it is a use-after-free, the behavior is UAF
is undefined: If that memory freed by kernel is also unmapped from
kernel address space, you would get a page fault when using it
afterward, that is an Oops. Or if that memory freed by kernel gets
reallocated and remapped as read-only, you would get a general
protection error when you writing to it afterward.
