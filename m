Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08185C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C467F20772
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh0cIo/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgGDXmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 19:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgGDXl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 19:41:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F349C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 16:41:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so38601830ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWyN/3WNtV7VRIdJ8FuzrwB0Ews8dbEmWLEqUU8aH3Y=;
        b=Kh0cIo/ZsIAxjW9Q//BSRJhntuBYewSUFD5usVcoOci+eW1UJqiUpT7+DYj5/t0dXU
         ptxDt8Kobg2fPoYCw8FZdCueMA9WI4np9bQslZPwKDlSJvdeOaoTsEcj+yzhc+Zj2teo
         tIhalQL4RV7zge44nchGuWcrdhEQ0vc5cOeyv3NBK7utaVLrwWbwHBEJDlNos/YyI2tX
         IypEXDqHEmHZFbz/Bk+8Qkszk5f+onYfU90ufaYONfD3/I9RjlBeLhr+j+KdLLo3jqd8
         fzFzttljI+WklUAHUyJZrP9vwN061KoXidBWAcVAzOcGeG1/IMULDziOIjTOK7idgyeR
         A5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWyN/3WNtV7VRIdJ8FuzrwB0Ews8dbEmWLEqUU8aH3Y=;
        b=rfTFdzYirIa/4Jzh3ML01nH6cjm3NqZh3TG7171hF3HM1BDxz+MKtOKl5NogqcXL6f
         nH+EMOJAmbPS1da0jE1d47zm1ydOakgb/0gpOEOBTjF2BkyIi0zxD0O9qmhlf7viWxUm
         ITRC96hfYxD+FHqpwkCB6KJk52SzmR1u7xtRfyjq9P7254csKStaRCkl0/w8NxWLQQdq
         TE3cj2/uphGBWblLEByiwhyE7H9ruCeP26zXVQ3KObNUbqpPZ958B1iPfVHVRECRXqtB
         cqoe1mbHE6eqPzhJPezIF1R14Sa8TrSxidLUPDmTmksKCdOw6RgofQYQ8y0+4GrNAdnJ
         ccGw==
X-Gm-Message-State: AOAM533ST33ASotlACEcIwOodOX6St5zZn8/b96QjuNVvVurCXY4aVbG
        9bKyoENEnl4f048L9KFh/qpMQFEO8yajcKDahVw=
X-Google-Smtp-Source: ABdhPJwWS0Ma5bRs5z3IeTaszufOAuFwKp2kgb8VjlRm/RwxTJR6CiDakIznepbcBwH7i8b/fobZciNMZO2mDh57nT8=
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr37142718ejb.317.1593906118215;
 Sat, 04 Jul 2020 16:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <920e6dc0-628b-9bad-926a-d1238a373cda@infradead.org>
In-Reply-To: <920e6dc0-628b-9bad-926a-d1238a373cda@infradead.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 5 Jul 2020 09:41:47 +1000
Message-ID: <CAPM=9ty0tiL_qM_UFv0S0VtARKz_f-Anngc+amDM5LjGAHazhA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'. Colors to represent a policy requires an indirection. The
>
> how about:
>               Using colors to represent a policy requires an indirection.

I'd totally submit that red/black trees while in no way racist, are a
horrible indirection, as it means nothing if you've never interacted
with gambling culture, (and maybe James Bond movies).

left/right trees make naturally more sense and translate into more
languages, so yes I think removal of color naming is a good thing even
for non-racist reasonings.

Dave.
