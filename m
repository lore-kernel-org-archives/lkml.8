Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768EA2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYtFxTDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgHQLAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgHQK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:59:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383E5C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:59:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 77so14073729ilc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRFKMn469rvJhbWPmwRlBDaHdkmhCPJ0BZ8j32mtJZ8=;
        b=nYtFxTDlguMrPy84wfm448P60GlInQ7IF6vj7mfgT+/kHB8EL9ZE3BIajxXy6O+CnG
         oiOVOML039xpDFQXS9P0FqmUspW3JExsgLjasj8rZSfKaY/zPKzRjcaexFXPwd6oj9/9
         UgahkMybxjI7uz6FwlLOLZQd/Gxjm8txa1PhkFigBFT07tviMtLt5GupPjt8ubs8hSmI
         gXFWrIAXriIiUl9Ork9197tmvAOpzwIyfxMEzk/l+PdqgSJlp+CeCYEspyUQkczU14fh
         RTLo4a5KTluMp+5wiqvuF1T2afYhnr+fGdLqg6ykzSNMWmR+jJ89cwiOlt42bs2429Id
         ZKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRFKMn469rvJhbWPmwRlBDaHdkmhCPJ0BZ8j32mtJZ8=;
        b=S8BgF7bec/02xoAm0CLdqRJCsHJ+GcEZ0hKg+k7iGJ+Bg0qaawK+gkbWJFmP67Mqn5
         tkrEojjWGIAk2UPIGhtovFMI8xmgV+VlFbOUPjvdGe/OirgpWLSC0ISF+fNtdTi2CmQR
         AEgWX0tOWw8br6Lj2PrY/6SxxpA4xuyxnuwnKlw2BuZc3S1L6/gLc3gnZqj0/RPS4cVt
         RRlsWL4OlJmEXFUtFrxebgutYbgagU9/pFBD6quys+2rWTFJumLeBSsaIcxStHNJUSwy
         A7ULm3ZO+0w4RCGbMs9AOYjd9QfR432ZbJzBmw17it2UcaaNkcnE7wMruH53JY1LrQLo
         j2Yg==
X-Gm-Message-State: AOAM532edQDpNkkEaLOPk8E4N28WsEmAeDo5VF4t9tUpSTVJyncmNZFt
        WONcOYwWFCBE3zBEpbWhtap71ORXKcdzQbKZTgdM4EDIeg8=
X-Google-Smtp-Source: ABdhPJz/QfASkB2AoUF3H9HAnFJU6XXHvJ/U1MYXBfXZTb/tYWN+NSY2WoyFrL+ntJxqIizgsyeEfbprGLbH/1tYPAM=
X-Received: by 2002:a92:c7ae:: with SMTP id f14mr13948607ilk.39.1597661978616;
 Mon, 17 Aug 2020 03:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <1597395824-3325-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20200814131034.f71a91c6827904e12a629e04@linux-foundation.org> <20200814211459.65f6db0211872e30684a630a@linux-foundation.org>
In-Reply-To: <20200814211459.65f6db0211872e30684a630a@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 17 Aug 2020 18:59:27 +0800
Message-ID: <CAGWkznFYaMLUf3cazP9x9eA-SYTu6GkXR=m3q20WowGsCZLWHw@mail.gmail.com>
Subject: Re: [PATCH] mm : sync ra->ra_pages with bdi->ra_pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <klamm@yandex-team.ru>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 12:15 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 14 Aug 2020 13:10:34 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > On Fri, 14 Aug 2020 17:03:44 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > > Some system(like android) will turbo read during startup via expanding the
> > > readahead window and then set it back to normal(128kb as usual). However, some
> > > files in the system process context will keep to be opened since it is opened
> > > up and has no chance to sync with the updated value as it is almost impossible
> > > to change the files attached to the inode(processes are unaware of these things)
> >
> > How about making VM_READAHEAD_PAGES a variable?
>
> Or make it settable in Kconfig?
I don't think so. The scenario I gave before is a dynamic process,
can't be solved via menuconfig thing.
