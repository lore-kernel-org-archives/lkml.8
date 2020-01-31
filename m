Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567A7C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2110F20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580440597;
	bh=+P4Q8vL/zkYVTL0+cGeW7SHzjvTfCjmEe8DI+bOOliI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aekYO746T0kwGr3mOwS3++Do++GwhMt3v+y6xYHtNOrDZ70SjUNHGsRnHaLbz8Ntx
	 krtZXLGwDi3lRvyDHXrG9PQucJd4RcmjGb8+cqaDt3CHIdamMm5ew1Wi9rQqyfDJbu
	 K5rOOKFN9XHs9Xg7qZItjYe2iRD90vaE7yeeK7u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgAaDQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:16:36 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:19289 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgAaDQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:16:36 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 00V3GRaf027939;
        Fri, 31 Jan 2020 12:16:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 00V3GRaf027939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580440588;
        bh=zUagY7zkaT5fHUquSXsnCtBmp3feRvS5rxxXqEGW+bs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GgUuosGpQ8zy1B4VqtQuotif5JGWV0XFzLVWPzZBrSRDSvyRqLs7QvOvkrvVQvrBz
         I+hWZTGIJm13pZYFm2jFvLd8lAjG51/3aTX1zf+88H2bhBFEGsk28k+dgONLLfEpl5
         eahTO+XpBTYcJehTL69ILIeVjyA+wxdMICvnrcxRRvtEun96x6+DrZvGyWk8ySLrHt
         IhWaGEHCQCnHP6xhIvvemqkO30riWK+bbp1Ak0wJtnJVz+QAsnk4pdNpSetR2Rp6f4
         rl+WRYYatnXRYmgMggTnft8v+hpfWZTQYlFwupiUi1/WdNVPwH+3MpRcyezjK9GI3h
         NI+nLga3/GcXQ==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id g15so3543582vsf.1;
        Thu, 30 Jan 2020 19:16:27 -0800 (PST)
X-Gm-Message-State: APjAAAXJyzibTYZ1EEYQUA/Z7XJEgTqPgeoAC65WObGrYy1ND8IQ7Itg
        HCluSn+du/drwQtygSVtSBRIxBeX+W0+JnSBM2c=
X-Google-Smtp-Source: APXvYqzYIMt8w3M1BG9hsElPnnvs7pUlXxMEa6yuo7U3dDHxmNV8RIuJPu4veWuyX4j//fDyzJjvQkrdLKu3BCO8xHo=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr5401332vsh.179.1580440585640;
 Thu, 30 Jan 2020 19:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20200130122221.30029e32@gandalf.local.home> <CAK7LNAR1AJFDahD6cB_MryBd-79N_T5O9WV3CMEA+HOCDXZEig@mail.gmail.com>
 <20200130143941.23a0e217@gandalf.local.home> <CAK7LNATryPUSTm8wPTFHO=E5f=sVPM4T0UxT=BF2qeyVehsH6Q@mail.gmail.com>
 <20200130214100.57b8239b@rorschach.local.home>
In-Reply-To: <20200130214100.57b8239b@rorschach.local.home>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 31 Jan 2020 12:15:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQGpyK=06qU9EZCeDkjUHC0+TUE-L=PkbMwUCrZqwvWkA@mail.gmail.com>
Message-ID: <CAK7LNAQGpyK=06qU9EZCeDkjUHC0+TUE-L=PkbMwUCrZqwvWkA@mail.gmail.com>
Subject: Re: [GIT PULL] kconfig: localmodconfig: Minor clean ups to streamline_config.pl
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Fri, Jan 31, 2020 at 11:41 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 31 Jan 2020 11:08:59 +0900
> Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > OK, I see.  I will also try my best to send a notice email.
> > I want to avoid a situation where two people
> > are picking up the same patches without noticing each other.
>
> BTW, I'm fine with changes to the localmodconfig code going through
> your tree. Just let me give them acks. And if I end up having changes,
> I'll send them to you.

Yes, that will make things clearer.
I will ask you to give acks as needed,
and apply patches to my tree.

This file is seldom updated, so this will be not
burden any way.



> Thanks!
>
> -- Steve




--
Best Regards
Masahiro Yamada
