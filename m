Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F59820848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iGTGKK10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbgCCVGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:06:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgCCVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:06:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id f5so2099253pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ILFaru9VkZkMm/uyrzqiQJ9WG3dQIfoo+O/VJBbEFZM=;
        b=iGTGKK10+oxxGN/v1WRzlg2M7NJw6f+qRsLtaBqc7c4Ps8N8OV1wA0nsn8Qi0vXheX
         2I7VybJAPo/CSFrdzqO8O7NJ4eZf42BLLr1BvTvx0qahY/5511jVg9WApd8aKL87j7Wo
         JwGHVbPh6NYNAW7PSci6bP5TQNZ8U1XfDSCSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ILFaru9VkZkMm/uyrzqiQJ9WG3dQIfoo+O/VJBbEFZM=;
        b=Bo9JyuBuQojmvZAvzDGkHZZ+rPtFrza3kr1yGgypYUPERT22ZM/noPeClOi09m88o+
         lE0qFgXevx+7bRt3x15wK9JKhfAPJYytGmm8RUmnBpczpiX5MAAY96IuFDEnFDnnNlCf
         ejq5b5cuMQXtlqX2GjI+O6D0YFxbPJZMWz/gchMKzxuMt+UhbfPyJunX3y2H5BcBmPdh
         aKKW1fz+KSuNxgbVQLTzdXXIchg1yvT95OoG+gi6vpQJMW0lNkaLirir6ENJBeaadBB1
         FJjAoXKzQbDzCobd2xrFcfeVM4cRqRJSq1NuurK2UnTDMJFSU9ZJWisz4VZ683yGEFwo
         Y15g==
X-Gm-Message-State: ANhLgQ01/rIpFBMMHw2ARMe6PPbIbUUgb//gTUWel/1pSHKFRJTT+Gf0
        0NzpFfFdAruetzA9ToWpgexd1Q==
X-Google-Smtp-Source: ADFU+vsX24TqvZducoROKbsVvZI+6EDVj0It78BA7xOOgTAPjpEniKQ6+IXDdCbfi0Jq0Yosvyx13Q==
X-Received: by 2002:a63:385e:: with SMTP id h30mr5587070pgn.230.1583269605143;
        Tue, 03 Mar 2020 13:06:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gx18sm135662pjb.8.2020.03.03.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 13:06:44 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:06:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Remove debug info from kallsyms linking
Message-ID: <202003031301.083CF048C2@keescook>
References: <202002242114.CBED7F1@keescook>
 <CAEf4BzYrBoQJ1tPMRMQ_-G6e76=zj4zyC=HrY-mxH_9QK65oqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYrBoQJ1tPMRMQ_-G6e76=zj4zyC=HrY-mxH_9QK65oqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 10:55:04PM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 24, 2020 at 9:17 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > When CONFIG_DEBUG_INFO is enabled, the two kallsyms linking steps spend
> > time collecting and writing the dwarf sections to the temporary output
> > files. kallsyms does not need this information, and leaving it off
> > halves their linking time. This is especially noticeable without
> > CONFIG_DEBUG_INFO_REDUCED. The BTF linking stage, however, does still
> > need those details.
> >
> > Refactor the BTF and kallsyms generation stages slightly for more
> > regularized temporary names. Skip debug during kallsyms links.
> >
> > For a full debug info build with BTF, my link time goes from 1m06s to
> > 0m54s, saving about 12 seconds, or 18%.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> I've tested locally, seems to be generating BTF properly (I haven't
> timed anything, though). See nit below, but otherwise:
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Thanks!

> 
> >  scripts/link-vmlinux.sh | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >
> 
> [...]
> 
> > @@ -106,6 +114,8 @@ gen_btf()
> >  {
> >         local pahole_ver
> >         local bin_arch
> > +       local bin_format
> > +       local bin_file
> >
> >         if ! [ -x "$(command -v ${PAHOLE})" ]; then
> >                 echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
> > @@ -118,8 +128,9 @@ gen_btf()
> >                 return 1
> >         fi
> >
> > -       info "BTF" ${2}
> >         vmlinux_link ${1}
> > +
> > +       info "BTF" ${2}
> 
> Any reason to exclude linking from "BTF" step? It's still a part of
> BTF generation, so seems fair to have BTF encompass both vmlinux
> linking and BTF generation/deduplication?

I'm not sure I'm following what you're saying here. If you're asking why
BTF linking is separate from the final vmlinux link, it's because of how
kallsyms is generated. Currently it's using a rather brute-force
approach to figure out exactly where everything is going to be in the
final link, and for that it need to have both the BTF symbols present
and the kallysms symbols present. So, unfortunately, each needs to be a
separate step. I spent some time trying to merge BTF and kallsyms phase
1, but I didn't find a viable solution. I'm *sure* there is a better way
to handle kallsyms, but I haven't had the time to really investigate it.
I think it would require some close coordination with linker behavior
changes...

> 
> >         LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> >
> >         # dump .BTF section into raw binary file to link with final vmlinux

BTW, in looking at BTF generation, why is this cut up into three steps:
pahole, objcopy, objcopy... shouldn't pahole just gross an output method
to dump the final .o file? That would be MUCH nicer. Especially since
the first step ends up rewriting (?!) the original ELF. This is a lot of
needless IO...

-- 
Kees Cook
