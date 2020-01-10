Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9A0C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4F520838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578688738;
	bh=8Hnf4WFZdFRdcDaOEb0WO/34pdUFLVSRBvx/iAwo7qA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qVTdrScYiCJd7Vu7wz1ryt7yhkJwh4jd40iPB41OVYRFw7mD9PPPExs1vQz9OZUkn
	 UbeG0HH8tG61OdHdRyoKJ14Qt1A48SgxC9ZtuuJYa/mjz8tg9+Mz7B0NP5cX14AFEw
	 OhrqEwZIMX/BX/Y+hEEwIo64e/qM0WdIovm2uL/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgAJUi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:38:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40950 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgAJUi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:38:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so3458016ljk.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwolBsIgDGCVUkuSZAXRmkjdEmEEA4cQUilISYO+J6g=;
        b=KMWtE7+YPwle9SL0j+y71fRurG4RTvYhGihBiblvXCB/Ffgesfl67Jf9uO2iN6Zowv
         V+httb+uJNwFOpVTmASjdnvw4XkNlnc15na/eSuYdTWfmU/csZGjKyNqoozQGm/sOVkq
         DI9KVcBBLukvUyMHO9zoVyU0CY//JZepI+q/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwolBsIgDGCVUkuSZAXRmkjdEmEEA4cQUilISYO+J6g=;
        b=S7TOCYg2Jh7Knf27AOC4rKckT4NneGs+X1iYUE/v71y3tenL3eHSONyF/DC5kQjqQY
         jDMltOAO8Cz2TRrF68vcBiz4Z7rW6DcmM95mTD2UGFNAAnuZnjpcA1A3+PJbr06C9x1S
         1fmUKMLD4isoDAUzYi/l5tXSWGmiqG0IkuaUpnmP1ER0kGQ2A5mk8k+C2Wb0P8nj9jLM
         oXodn4pHZupopUttGC1dhLW79zbdsQY3eEUOZMo6PpX7UZ4c2ouIv3Ua2XE5p/0jS7sU
         XWE10YZWPHn9hV/dmG84fgDodULAdfG6zBWb5v6tJHw0OqrBuOk1m1KzBCZOc8vSyC+P
         05JA==
X-Gm-Message-State: APjAAAUUcaIZ16jILQ0AWVwBYKA6ncOefI9lbqqhVyx8lNFuGrxo1tbk
        mD/tM2ikF+71XB++2xVWWYFOfIRhTuA=
X-Google-Smtp-Source: APXvYqzFfuskcsOfCzprAM7daevrNG9cvw1OFSknES31PSNMHxCwJJ3WImode4XaKxK0szUnrve8vw==
X-Received: by 2002:a2e:2c04:: with SMTP id s4mr3924378ljs.35.1578688734745;
        Fri, 10 Jan 2020 12:38:54 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d20sm1573185lfm.32.2020.01.10.12.38.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 12:38:53 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id a13so3437389ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 12:38:53 -0800 (PST)
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr3902573ljh.50.1578688733508;
 Fri, 10 Jan 2020 12:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20200110154218.0b28309f@xps13> <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
In-Reply-To: <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jan 2020 12:38:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdsFSX0gTOiNkTANONgHHVY+8jUd1DmY2SJpdNOq5xJw@mail.gmail.com>
Message-ID: <CAHk-=whdsFSX0gTOiNkTANONgHHVY+8jUd1DmY2SJpdNOq5xJw@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Fixes for v5.5-rc6
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Konstantin, can you see what's wrong?

It's not just Miquel's. The sound, thermal, and power management fixes
pulls seem to also be lacking pr-tracker-bot responses.

But Jens got one for block - but that went to the block mailing list,
not lkml. So maybe it's specific to lkml itself.

Maybe things are just slow, and I have gotten used to the
almost-instant responses when I do a "git push" to publish my pulls.

               Linus
