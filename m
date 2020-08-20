Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9816C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BA42054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923512;
	bh=Kghp6kOUj9uobfpiLg3R2F8nDFSVdCw2OfZGAZeYL6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LOSM6MFl9zl5rtYMeGOWVO/Ee/bh8lQFhLOkEofVj97DUrE0Fdx9VJt83KVy+16AM
	 IIVrlvoSgkmS7d40Zqtb9M27TKOdXhVJOXh+JmXL22V6ym48LurnWwM1FlJnHXJ1us
	 7wvjZ1fSM9b+RNAtFncMoU2UJPvVPuAp5poNldRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgHTLib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:38:31 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:62854 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbgHTLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:34:26 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 07KBXm51011709
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 20:33:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 07KBXm51011709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597923229;
        bh=XGgv3Ngm5kbFZf0GD1E5nkmPdpn4darLmhe2GL+7nuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PW31YXnIxPELMsxjO/YhYZ5bd4+t4Rm5AwFQZe8bmeZBvBBQ7BvTh7cjUevJqrdlC
         gzNcqfHQ+E4ih1UEvONPCMZx/yBOXVIloW5ha/zKFL95ftQulz0HtUG8WxR/LU+rLN
         nvQqC5nBLYu+jzoEUlVnTkfd3yqOX/pCyUhXhuGt1Qlok32u4PK01/NFj8hQz64qqz
         W2ee2DPtWiIkzc+pZBA/C9Z66FUPpLVP+RYuh7srLvzlCKiAa73liFVEe01rWqlJel
         VUCHNpmFMAGYkNyvXb5g5bYPWgDt8dROddMWVosqPoKzxMikuw3oO+BbUKUEKQamlR
         UWc8GGtcTv6+g==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id g20so459133uap.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:33:49 -0700 (PDT)
X-Gm-Message-State: AOAM530l9Z+ElsBHoRUY0vE3eND1672PVNskV3Qu2FesNncbo6SA5cT3
        ZHKKQsDvfMHsH8Deps2/5r7XLw5a5yIR63jetn8=
X-Google-Smtp-Source: ABdhPJxNLBGf4ixlYGFomMDjKzFzffmoM3zK913g/lYzq4mGJBRmpedvIZCUnmeEdeI0pigKfT+itnJWLRfotpKWBcM=
X-Received: by 2002:ab0:623:: with SMTP id f32mr1267638uaf.121.1597923228200;
 Thu, 20 Aug 2020 04:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <ab0cfaed-50bb-5b29-cb93-a2987c384af1@gmx.de>
In-Reply-To: <ab0cfaed-50bb-5b29-cb93-a2987c384af1@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 20 Aug 2020 20:33:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZ_sHPjDLd7+LTc0Sj9K+W51zoRq-=r-0_5AJC06jaEg@mail.gmail.com>
Message-ID: <CAK7LNASZ_sHPjDLd7+LTc0Sj9K+W51zoRq-=r-0_5AJC06jaEg@mail.gmail.com>
Subject: Re: BUG with 5.8.x and make xconfig
To:     Ronald Warsow <rwarsow@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 4:19 AM Ronald Warsow <rwarsow@gmx.de> wrote:
>
> Hallo
>
> configuring kernel 5.8.x on Fedora 32 via "make xconfig" gives me this:
>
>
>   HOSTCXX scripts/kconfig/qconf.o
> scripts/kconfig/qconf.cc: In member function =E2=80=98void
> ConfigInfoView::clicked(const QUrl&)=E2=80=99:
> scripts/kconfig/qconf.cc:1231:3: error: =E2=80=98qInfo=E2=80=99 was not d=
eclared in this
> scope; did you mean =E2=80=98setInfo=E2=80=99?
>   1231 |   qInfo() << "Clicked link is empty";
>        |   ^~~~~
>        |   setInfo
> scripts/kconfig/qconf.cc:1244:3: error: =E2=80=98qInfo=E2=80=99 was not d=
eclared in this
> scope; did you mean =E2=80=98setInfo=E2=80=99?
>   1244 |   qInfo() << "Clicked symbol is invalid:" << data;
>        |   ^~~~~
>        |   setInfo
> make[1]: *** [scripts/Makefile.host:137: scripts/kconfig/qconf.o] Error 1
> make: *** [Makefile:606: xconfig] Error 2
>
>
>
> I have never seen this with kernel 5.7.x.
>
> I haven't found a solution to the above, yet.
> - apart from the workaround: "make menuconfig", etc.-
>
>
> pointers/hints/ideas ?


I think you are using Qt4
(dnf install qt4-devel).

If you install Qt5
(dnf install qt5-devel),
you will be able to do "make xconfig".

I will consider what to do about this.


--=20
Best Regards
Masahiro Yamada
