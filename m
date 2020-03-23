Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED53C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A7320719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qREfsk+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgCWTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:18:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36097 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgCWTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:18:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id k18so16004650oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZKG7fTNBsJ3BzEdzcdQdFxvXUKeTmJw8ex6iL6EOq4=;
        b=qREfsk+dXDKglyer4a2qeACjwrid7zU0l/gOaRByTH9Ll2wZjiqzwJ6cbpU5YIjJt/
         TD3Na1To9Dp/0jC9Nwn1Z36a41fldefYxufKaHR5nj+haoYtUv/oTgk6/FXVTEF8SSQH
         xlcCupPEeBXWhFTEUDFdXuU1yHTnF3y4mOvUTnYzGp1A99sbPLA8b6lCLmIrV1fxCTWg
         9uOBIHhMe0B0DIJ7AMYdxhnmOrNcIiBk9iTQVgXpNhohhg1nxXrKKoID9jHaM2g9v0/R
         JUdKFHBPydw5lYwSIparAdsWVMpNSPx65T/dtks/uSBjLqIwV5Xc6L6a72AvpbKr92Sb
         gsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZKG7fTNBsJ3BzEdzcdQdFxvXUKeTmJw8ex6iL6EOq4=;
        b=Fzwu4r3bFrpMEQkZYfXFTJC3aYS+f6mwyMWhWWshg2ZYfS63sKkNNYS78E0phPbJku
         HlVDFcIXhKr5pzR3wSArbBLV4W6akDE3UHDAnmvjV1hs5N+y/dJxgW0rBy823TFqp8XD
         Etl17JKGEmagW59cS1eqVnG9VcNvljfbWedjgQ/XOsJlwF+PoM771clPQoDp6x1k7cvJ
         yecplbojCsnpLEWAjFiE/RtyG1ISILDLkLaFv62I8D3+eDhrU4EoBrUYcloCC9P2V6m4
         71UX//8XwzoPPiolk+RC0Rs0tNeVJ7dZobOed69gYMxLaT2mOYokfX9cZjQHSaYP2Pr5
         eWJw==
X-Gm-Message-State: ANhLgQ0KTKF003zt2dRdgOfrQaYxORS3cmd7DT5joGbd6bvviTLxGvWJ
        J+Lx5u9pKIEwqjVUtmg4BIYNEOvV0BFYcqb+PTOojgJh+uE=
X-Google-Smtp-Source: ADFU+vvtp101BmSbeYLakx7Wvp+wzVb723oqWR/Id6j79lBhJDMmBLI8QD1mYj4E7HSrHOtRmJDVPLQ/QzaoSrn5hUI=
X-Received: by 2002:a05:6808:8db:: with SMTP id k27mr675696oij.175.1584991110176;
 Mon, 23 Mar 2020 12:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200318205337.16279-1-sashal@kernel.org> <20200318205337.16279-30-sashal@kernel.org>
In-Reply-To: <20200318205337.16279-30-sashal@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 23 Mar 2020 20:18:04 +0100
Message-ID: <CAG48ez1pzF76DpPWoAwDkXLJ01w8Swe=obBrNoBWr=iGTbH7-g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 30/73] futex: Fix inode life-time issue
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:54 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> [ Upstream commit 8019ad13ef7f64be44d4f892af9c840179009254 ]
>
> As reported by Jann, ihold() does not in fact guarantee inode
> persistence. And instead of making it so, replace the usage of inode
> pointers with a per boot, machine wide, unique inode identifier.
>
> This sequence number is global, but shared (file backed) futexes are
> rare enough that this should not become a performance issue.

Please also take this patch, together with
8d67743653dce5a0e7aa500fcccb237cde7ad88e "futex: Unbreak futex
hashing", into the older stable branches. This has to go all the way
back; as far as I can tell, the bug already existed at the beginning
of git history.
