Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E20C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164C420661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580707208;
	bh=IUhUu8eqhrnDJ2ahrjLF959JcujUqILexYQ+EWoPMgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0hdoNN87jcnBF5FNn5/aZDRND1xHC6vDoD+4UIqykllw0M3+HoDtNHQpHTrvuXTg8
	 M8vatfG6ElYOLG8k93HeV8/XH6Fn7txJrKnFLOWkvWcxQjBTvL6oM2lyiY0DyXOe00
	 s/oUvly0SAF01I6O7pJLjJfNUPXLvDJSMKbAvw24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgBCFUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 00:20:06 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:46625 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgBCFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 00:20:06 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 0135JhAi023689;
        Mon, 3 Feb 2020 14:19:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 0135JhAi023689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580707184;
        bh=R8kzJf9J/bk6QzTc3zwFEeBvlSpMMeb6GRnS58I25Hc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GQSkoqUT7cplJ/wXPyA1d1u+d8wPOImQFu0SZBMf0OynqlkJLXNsaTinPjzQcHKeD
         vXTz7NAZVqSPn/cY3elZG5pe26Moi/Qo71+eLGDmSWykFNDWn4j30SocFci0PemWPZ
         FS0eYKEMomYmsLmDRIPANfcEe4Rpvb1sOfCXWrLqd1U3Qutpuuf0yUYgCRHMH1wsfZ
         fbqOQ6um91roMnfKiHb6MM4wI8W/izSQBtt5KGZNcsTdIU3Z+M8zMGO6Cb7W154T+X
         nRAE3Yxerh6Ct6L8ABvwbDS14VYeW16BnxbKL/kHInW5p9w6Y1umex8JZ9ObGulA2f
         JiYU7mZonNhVQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id g15so8166693vsf.1;
        Sun, 02 Feb 2020 21:19:44 -0800 (PST)
X-Gm-Message-State: APjAAAUTWFS5Y1xQN7PI5SUkshEms2/Cu4jzZDEq7zTrZ6TpQ0DedguV
        Ky1OgKWlZrw6/LUuVphRAVO03mvG3KDLvQ6saiE=
X-Google-Smtp-Source: APXvYqxcQM6p6tR0N8S+zmXJx/zC8ZCy5mVhBsqvx8kWMeB6kjuvHyZcIQDRKcnuAjcZLZYdO62sUG9u8fNw/IYfhmI=
X-Received: by 2002:a67:6485:: with SMTP id y127mr13978433vsb.54.1580707182954;
 Sun, 02 Feb 2020 21:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20200202050922.12402-1-masahiroy@kernel.org> <20200202050922.12402-3-masahiroy@kernel.org>
 <CAMrEMU9ZBAwOPsqeKw0sUF0EWnfO1-UtOKROD6T1AjYX_tWLXA@mail.gmail.com>
In-Reply-To: <CAMrEMU9ZBAwOPsqeKw0sUF0EWnfO1-UtOKROD6T1AjYX_tWLXA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 3 Feb 2020 14:19:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqGiYHJTsRFdanfxCXe7JYB7+qf=GmvnO3UcJ-uDsatw@mail.gmail.com>
Message-ID: <CAK7LNASqGiYHJTsRFdanfxCXe7JYB7+qf=GmvnO3UcJ-uDsatw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kallsyms: fix type of kallsyms_token_table[]
To:     Justin Capella <justincapella@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 12:26 PM Justin Capella <justincapella@gmail.com> wrote:
>
> unsigned char maybe? I understand printable chars unlikely to cause
> any trouble and probably a non issue, but the domain is different for
> char, and while I don't know of supported implementations where sizeof
> char isn't a byte, I think it's a possibility and perhaps why u8 was
> in use?


As I said in the commit description,
this only contains ASCII, which is 7-bit code.

We do not care the signed-ness of char.


kallsyms_names[] has been u8 since the
following old commit:


commit e10392112d315c45f054c22c862e3a7ae27d17d4
Author: Paulo Marques <pmarques@grupopie.com>
Date:   Mon Oct 18 17:59:03 2004 -0700

    [PATCH] kallsyms data size reduction / lookup speedup



Probably, this is just coding mistake.



-- 
Best Regards
Masahiro Yamada
