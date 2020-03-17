Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217FBC0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D092051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584404700;
	bh=ZTTRdPUhzYRD192C0C/2+tFl/CeSMwHpwJKQTJruQ/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1vu0VyyOBHQhCt/Q5/WJ+bhBxkWJvl8aqefnWmqgrGPvHOTiCP2xDdnJy+wkRNg44
	 JMaBTO2wpNwQ+aw7uAt3zEzy+bEO64409G5W+Ed1Ii2s0BDXSMoG6GEppr6M0fbDpO
	 kyR06YEzrmc/+BzAeRG48EJTDUHmKH1rmsXhmxVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbgCQAY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:24:58 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:48711 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733127AbgCQAY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:24:58 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 02H0OpO6017424;
        Tue, 17 Mar 2020 09:24:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 02H0OpO6017424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584404692;
        bh=lYmS7nvHUEJukM5osVioG3Y1rBqHPxYugmPf5H/y+jw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KRfyZlQ4pRnk1FM+CsGrVy+TsNd9MdkEVA4mZXceJKrbqbNUEPZy89JEnknX3pd2P
         IomQTcuwNjz9geeKpzshLYsR+tWbmdZx8r+MGcxEoz2p8pR60ZKv+9lXr45jhKtLs2
         Q/hUdq6UmCiUYBaX5mM8RaJOeK6tzI3ExtP2KvMWtDbkYL6H7GR5WB3riqnbsIcnYF
         LDsUV7rRg9ajKmPJjr8l+GkkNClabz5mus0XYAjlFQ51PLqcRutDpbRoGyMhqE1/ZZ
         qsXo9cDYNoxLeaSawC/W3FlOuNgj+3nCrz69MQ7Vn4yMP8U2M/6RBOb9zAVMuootqp
         R2BWr4gqMzbmw==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id p7so10475770vso.6;
        Mon, 16 Mar 2020 17:24:51 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2Ql2cKK6PdQkYJwN+mVAlGHseF5++xCDhiTyTW+WQAqV/z5juX
        VcfUqny4iTKL1hnU8uwfTVjjY6qQu348UzMjGw0=
X-Google-Smtp-Source: ADFU+vsOPBrOzTgm5VTvZ0d/XdJVuV5L3GL5ekW4Db//LFL0zlu58JXBlPfQeHqzoQjGYpEXKyqpU7hKMHKjxWJQw8o=
X-Received: by 2002:a67:2d55:: with SMTP id t82mr1925939vst.215.1584404690356;
 Mon, 16 Mar 2020 17:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200311170120.12641-1-jeyu@kernel.org> <CAK7LNAT-xdMZbK5UeVvm6S-WNimMMKO3b=jkJsU29z6ULPjs_Q@mail.gmail.com>
In-Reply-To: <CAK7LNAT-xdMZbK5UeVvm6S-WNimMMKO3b=jkJsU29z6ULPjs_Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Mar 2020 09:24:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATV2uUagMRrhe76k=QLxXKFKCPzY_ZXe2s5ze0UJuEXHw@mail.gmail.com>
Message-ID: <CAK7LNATV2uUagMRrhe76k=QLxXKFKCPzY_ZXe2s5ze0UJuEXHw@mail.gmail.com>
Subject: Re: [PATCH v2] modpost: move the namespace field in Module.symvers last
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 11:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Mar 12, 2020 at 2:02 AM Jessica Yu <jeyu@kernel.org> wrote:
> >
> > In order to preserve backwards compatability with kmod tools, we have to
> > move the namespace field in Module.symvers last, as the depmod -e -E
> > option looks at the first three fields in Module.symvers to check symbol
> > versions (and it's expected they stay in the original order of crc,
> > symbol, module).
> >
> > In addition, update an ancient comment above read_dump() in modpost that
> > suggested that the export type field in Module.symvers was optional. I
> > suspect that there were historical reasons behind that comment that are
> > no longer accurate. We have been unconditionally printing the export
> > type since 2.6.18 (commit bd5cbcedf44), which is over a decade ago now.
> >
> > Fix up read_dump() to treat each field as non-optional. I suspect the
> > original read_dump() code treated the export field as optional in order
> > to support pre <= 2.6.18 Module.symvers (which did not have the export
> > type field). Note that although symbol namespaces are optional, the
> > field will not be omitted from Module.symvers if a symbol does not have
> > a namespace. In this case, the field will simply be empty and the next
> > delimiter or end of line will follow.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: cb9b55d21fe0 ("modpost: add support for symbol namespaces")
> > Tested-by: Matthias Maennich <maennich@google.com>
> > Reviewed-by: Matthias Maennich <maennich@google.com>
> > Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > Signed-off-by: Jessica Yu <jeyu@kernel.org>
>
>
> While I am not opposed to this fix,
> I did not even notice Module.symvers was official interface.
>
> Kbuild invokes scripts/depmod.sh to finalize
> the 'make modules_install', but I do not see the -E
> option being used there.
>
> I do not see Module.symvers installed in
> /lib/modules/$(uname -r)/.
>
>
>



Applied to linux-kbuild/fixes.



-- 
Best Regards
Masahiro Yamada
