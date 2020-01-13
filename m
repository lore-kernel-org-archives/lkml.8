Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8149C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03122082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgAMIC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:02:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45244 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgAMIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:02:56 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so8104827otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 00:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8Id6XgPA2ap+aeggUNQ70885pghkWz/XEq4dAjRKOU=;
        b=U5PflLDUu++zCw1ql6MXSoNFy/Nbi95sp7pTOdZdEvbOWLD3p63Vx/tayOUC/QMbzZ
         a1KMkjNWE9G2Mud+nUYZorLANfnSMR/SGrb/XaPWBedA9eubTau3sSgiST1itLfy6Qo6
         tylvtWDLMvYYC+fV7oJF06dW+CrewqirVfrGRcKBY48ETtidOeA1LW5wx/93x4wzoa7b
         k+u1Z3moQ3ym3mRT5GufVf/qfnDcPK/iOc2gNtyayzjYxXOtfWnG+YuPCaRLY6I9wqO+
         KykRocIYL8rGm2A19KVvz3b1DlL0iGm/RypvcERQuPufoHI9BKD4/zDKG7mRoXHv5mkL
         wJww==
X-Gm-Message-State: APjAAAW/XwsKUQQz1owrVn7ie+rPmF8fIEUxw3qhCcLlmGy1fc7oUTKo
        ALKS75nyR+XFRx0C+TkmApMW1+BCaoaySs4wIls=
X-Google-Smtp-Source: APXvYqxrTQxdCcBjcuZNb4i1DplR5hz8sBr2nJFdWUQiqpijAC8f2J0N8OKIXCudxmSmWTD9cr7n8tPRxo6bdGVvTh0=
X-Received: by 2002:a05:6830:18c6:: with SMTP id v6mr7330803ote.145.1578902575501;
 Mon, 13 Jan 2020 00:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20200110154218.0b28309f@xps13> <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
 <CAHk-=whdsFSX0gTOiNkTANONgHHVY+8jUd1DmY2SJpdNOq5xJw@mail.gmail.com> <20200111145004.htnpdf6oaiksryxz@chatter.i7.local>
In-Reply-To: <20200111145004.htnpdf6oaiksryxz@chatter.i7.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jan 2020 09:02:44 +0100
Message-ID: <CAMuHMdUtk9m+BNrH1BuqGxWXR5h1DZmUasHMVKNYFxsd5wa5YA@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Fixes for v5.5-rc6
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

On Sat, Jan 11, 2020 at 3:50 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> Things should be unstuck now, and at least this particular bug is fixed
> -- hopefully it'll be smooth and automatic the next time the epoch rolls
> over to 9.git.

Are you prepared for multi-digit epochs? ;-)
They not only contain more than one digit, but compare incorrectly
when using lexical sorting...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
