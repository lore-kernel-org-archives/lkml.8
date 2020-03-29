Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D71C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B24B20784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKXvn45U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgC2V5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:57:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44563 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgC2V5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:57:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so18862304wrw.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdH+2Sp8+LCQmdv9cJRBn8nCYFyRth49aJu0RLYZRyg=;
        b=SKXvn45UOfjWlUjmdFc0n9z3vSowX79jBA3X7UhZI5XH/zK/HEwfMUu/NXfMnDFyxA
         w4tU3AGaTG5epfNu5vCpUzfWHtl5ejAo2Fr9AySqHpzpMBKrIzE9spVaNICgkjLv0wPW
         ql37IRwlmz5m+kZPZ5aYPd1UwDjNQEpNOLt1P+0h+1zLJSpjt8mxtjn83Eq0jqJvwxNb
         alZuo48lb4PEuU/BHSDtkHMWNyyLYCnMItSTpXtntGEyz3XID8qpJ9IyD25An5QLWk/j
         gIN5Xn0Zi3lLoMdEkCW44GCTz6HRXNi0gVvULbWeKY5vLVzDW+gZYbZxJ1qiTfg4qNy2
         vhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdH+2Sp8+LCQmdv9cJRBn8nCYFyRth49aJu0RLYZRyg=;
        b=P52kqSZtJuDOJcj19ZPIM5zPpetzvxjYO1xTrPMG36EGMOMXVViSVHe4oPYnVjsMIT
         HveT+x5qzQoll7V0xVoIrdlSFXAfVqUQhrrLE1CdcYGVNU46A6CH1Z2T1xN2gK6xKkUX
         HO/BJHUjBYXC8OnIGlFC0l19vUN12kgMHGR+Q4Y+EJ1cQhLHpiCLYjiXuFYHZHjV8R9b
         YAPKm8e2OUnDn945EWQBC+lylfkgV2MA6GKtwcmbmZ/BO24GhGoT3QStqxTxztca6pEN
         AZhU0vLa2HBr3fnfDpl2Obz2+OE78dmMYcsadm6tv8uuBR0c3Z2ehXIC24GAW4EaWDd2
         BgNg==
X-Gm-Message-State: ANhLgQ2HMJzghRZzPpw+6PkVXF9WwOX+TEhNrgr1nCoG/nTx4FXyrcfu
        gEy+i2kCh/HJnWNqu7Ob8WWiLLAIuXRPzARozy7g0hqh
X-Google-Smtp-Source: ADFU+vtvOe3EElWdk61gCrkYLK9KKQ5cxVkJkiKNS1Zdj/8ck13QHJe7rUazLAJhN6CPFy4vdlgjJJgZDpWQq9A85zI=
X-Received: by 2002:a5d:4885:: with SMTP id g5mr11055550wrq.93.1585519061682;
 Sun, 29 Mar 2020 14:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200327193626.82329-1-alex.dewar@gmx.co.uk>
In-Reply-To: <20200327193626.82329-1-alex.dewar@gmx.co.uk>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 29 Mar 2020 23:57:30 +0200
Message-ID: <CAFLxGvxy8Bc_rb_UKFhxRQ2ttVA1Rk-WqJ=_NYpCUXz2kaq3-A@mail.gmail.com>
Subject: Re: [PATCH] um: Remove some unnecessary NULL checks in vector_user.c
To:     Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 8:38 PM Alex Dewar <alex.dewar@gmx.co.uk> wrote:
>
> kfree() already checks for null pointers, so additional checking is
> unnecessary.
>
> Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>

Applied, thanks!

-- 
Thanks,
//richard
