Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C2EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF65E20781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595443235;
	bh=ua56k+QiDl3hEXvZulxthJk83c5vFSZv1asxciZo+f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x8wSMag7AvDNnj37KZD/BQ/XJzH9flB59H9o4LAelwYNTQpujkTm4NGS/wF0Gp5uv
	 RwO5TzYKwbUhq6nWfMSrdfc8eMvOYIB/VqbkaWT/lCpzXF6UCR0+sqmhmbvukXBZjJ
	 j72L2L6OTdlRxmBTehnzQg7GlxsGAijPLGUd1K7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbgGVSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:40:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E511CC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:40:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so3574705lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h2gq7xP9nhpEthRDphO7jteDWvEaRR5+QWoFW/1s9IY=;
        b=P3Mq/fGGM16uFmgmYT7T+DUItes5Vbbx04PzkAb/JajUxo10z8ES2tgLzNzyUcggI+
         MP2RNiH/2M3b4Fie+pe5wXh+J340PnGLndIkO7gmfPQB8RYb0dI13jydAh9qX3QM9l2l
         XOniGgQjwC0RLkURggsbtizs5IfBWhyM4oH08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h2gq7xP9nhpEthRDphO7jteDWvEaRR5+QWoFW/1s9IY=;
        b=DCVSPHMxXXtHrFxazwU188Gsrq+C9BkVfIIRMPN2XW+Wykn9h/euqa2YEcKCtznpAw
         WUEtyPqFIWIxzqU96GEZNlccFfRKCpi1L4iFMLo94pvEBoWqGbHRg/yPFvIkSg9T2wwL
         Ueuhl2urVEyNP4Q8BcL4RgGwuidi6cmSAGkrRwVJ05gRUYqD9mA0pHTeWTq2RGnbzkBE
         x+beR1G9R/CJ2ZkpR+5VPwE4EP7BJ/COTEKOv/DiroVLhEZvdrWvf8jqhPU/kM78VkCH
         519do9sh25fRpvCoL4+EWPySC518C0TeXNRezRdjGJHiPe+w6GBLGL1QblHkcfvE58tG
         VpzQ==
X-Gm-Message-State: AOAM533PTuDKzwdtORuSkW/EgOhIIs99sMg/4zKPO/9jphhk04H7oVSD
        xySgJLUuKQ6vPk028J1gRlGs5jyi2o4=
X-Google-Smtp-Source: ABdhPJyF6WzIauHc67aTBaCFPa89Dj95PHx8j4YJry0RXvEeCVQFfjW+8nEd2hNEuLJQSRnQaxzalA==
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr276256ljo.62.1595443231096;
        Wed, 22 Jul 2020 11:40:31 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w7sm437307lfe.41.2020.07.22.11.40.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 11:40:30 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id q4so3616025lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:40:29 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr247885ljj.102.1595443229558;
 Wed, 22 Jul 2020 11:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200722141151.GO15516@casper.infradead.org>
In-Reply-To: <20200722141151.GO15516@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jul 2020 11:40:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC-GKFoBGRSnTnD6VxL_J+5xs4BzEhEfyhGMcT8Mga7g@mail.gmail.com>
Message-ID: <CAHk-=whC-GKFoBGRSnTnD6VxL_J+5xs4BzEhEfyhGMcT8Mga7g@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 5.8
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 7:11 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> XArray updates for 5.8
>
>  - Fix the test suite after introduction of the local_lock

What? No.

Now you broke the actual kernel build:

  In file included from ./include/linux/local_lock.h:5,
                   from ./include/linux/radix-tree.h:14,
                   from ./include/linux/idr.h:15,
                   from lib/idr.c:5:
  ./include/linux/local_lock_internal.h: In function =E2=80=98local_lock_ac=
quire=E2=80=99:
  ./include/linux/local_lock_internal.h:41:13: error: =E2=80=98current=E2=
=80=99
undeclared (first use in this function)
     41 |  l->owner =3D current;
        |             ^~~~~~~
  ./include/linux/local_lock_internal.h:41:13: note: each undeclared
identifier is reported only once for each function it appears in

How the hell did you not see this, and why did you think it was a good
idea to mess with kernel headers and make them alphabetically ordered?

Headers need to be ordered by _contents_, not by some "sort alphabetically"=
.

Do you sort your bookcases by color and size of the book too?

                  Linus
