Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DE3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA420888
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent-com.20150623.gappssmtp.com header.i=@isovalent-com.20150623.gappssmtp.com header.b="QWwvalzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbgFWWPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388062AbgFWWPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:15:45 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4243FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 15:15:44 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h18so173437qvl.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=25Ut+90unfc/17zR5QP1XFu2lQ+gkSVHUM/pNIHUamo=;
        b=QWwvalzBaMOov3jyg7ZlDqMdpGmOXFv+H0bRVWqpuxO7B0uAWJnCyTQiAOI0tgHwB7
         CvT+YGWcpO5uVVcaO8lIaGGXmlyPa+YTDzHlkQWibomUzo/z94EKTGPGF990wWmYtKKa
         XPfG1ZCjhqKgyMxmd/le6unBuqrUqWTRp72ijuUuRmrg4Iv475uwnTxRt+Jly2YYUD3d
         bEoFRQPDvKX9FAocXcGZQMfK00U/g4oZH7X8c/2tPg6YXI70xA9xBknE/HtxDQB8u5VS
         4oB4YAbW1jDws9NuV1lGwZfvyPo/FJnCJL+E/CjMPM/vBAMjXTgcICmjai8BX9kBHhY+
         R07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=25Ut+90unfc/17zR5QP1XFu2lQ+gkSVHUM/pNIHUamo=;
        b=qmtVWVu0avLfB2eHHekV5YzV0/xiGKtgn79VG6PJnjcGHnYk9NuToO5H6bOehKc2v9
         la/nZzS72EuaeW7pOYcE88fPq8NyyEMFAreAX3/o3oC0VQg6+6tvQOdAQWGyNm6E0Ig3
         UszJltcbzIDm4/efPkPAJJYrxEBgmbrxBnW2iWbwK9vYdWooG6LeK6TggSv4FCio1eBK
         IU6x3Ykv2vA1Ns0dD8kUfnDHjNbk8R0tkHVnRq27ftUMuYmLOgKBoXmFbjiycnzJwTP1
         FR0XHv+K3JlH3Zpl9GcvfFg4juU2wJgXJwMY2mgWCTw6ZVN6IiP7BX5qaPZLZzPa/P9c
         CcgA==
X-Gm-Message-State: AOAM533o8UGboLxVwUc6JgQ19KOw6tbLClY2oSPnyElQOoTi88TDncYx
        04oTbbOeaTGL+k19kp8Mfs78WP2UBMRCpigKntP59Q==
X-Google-Smtp-Source: ABdhPJzi0pCJ8bBLbaZzf1GYjs5Vf7FmPHkYOzYRQObkC339lGul3X0AUJf1Bq9uiHeSTWtlbtB0MWcje0NFCpC/vWw=
X-Received: by 2002:a05:6214:964:: with SMTP id do4mr29164894qvb.84.1592950543505;
 Tue, 23 Jun 2020 15:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200623103740.25876-1-quentin@isovalent.com> <895052df95b2fc85b07e5a493fbb1ff415d8f62c.camel@perches.com>
In-Reply-To: <895052df95b2fc85b07e5a493fbb1ff415d8f62c.camel@perches.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 23 Jun 2020 23:15:32 +0100
Message-ID: <CACdoK4KknQMerx0k=bZxyQ35v1geGw99CitpP4hHMZ_o7W2eiA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: fix CONST_STRUCT when const_structs.checkpatch
 is missing
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 17:48, Joe Perches <joe@perches.com> wrote:
>
> Hi again.
>
> On Tue, 2020-06-23 at 11:37 +0100, Quentin Monnet wrote:
> > Checkpatch reports warnings when some specific structs are not declared
> > as const in the code. The list of structs to consider was initially
> > defined in the checkpatch.pl script itself, but it was later moved to a=
n
> > external file (scripts/const_structs.checkpatch), in commit bf1fa1dae68=
e
> > ("checkpatch: externalize the structs that should be const"). This
> > introduced two minor issues:
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -770,7 +770,7 @@ sub read_words {
> >                               next;
> >                       }
> >
> > -                     $$wordsRef .=3D '|' if ($$wordsRef ne "");
> > +                     $$wordsRef .=3D '|' if (defined($$wordsRef) && $$=
wordsRef ne "");
>
> perl is a weird language and the $$wordsRef ne "" test
> isn't required as the append will work even if the
> thing being appended to isn't defined.
>
> You can read the perlsyn docs
> http://perldoc.perl.org/perlsyn.html
> or
> https://stackoverflow.com/questions/2166575/when-is-it-ok-to-use-an-undef=
ined-variable-in-perl-with-warnings-enabled

I didn't want to touch $typeOtherTypedefs in v2, and I thought I
needed that =C2=AB $$wordsRef ne "" =C2=BB for the
"read_words(\$typeOtherTypedefs, $typedefsfile)" where the variable
was defined but possibly empty? Anyway, thanks for the lore and the
links :).

>
> so perhaps remove the test and improve the additional
> $typedefsfile use too

Agreed, your version looks better. I'll resubmit a v3 with your
suggestions, please feel free to comment and add a "Co-authored-by:"
tag if you feel this is appropriate.

Thank you,
Quentin
