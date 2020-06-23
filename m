Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD70C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0F3207F9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtyHRS+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbgFWS0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732988AbgFWS0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:26:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AAEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:26:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so1830644pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8qABYGSPVig8hCAyKjYse7vuwI3Jd63P0JUeskAy7k4=;
        b=mtyHRS+p+fYuAT/inlNUmSSU8kg6x0W5VgdM+arPQAUJ2tVoLVdFpfyH6hnYzCBnCj
         YrNZaWRvWoElbH3kVDRwykVlrs9TSSy8AXDmciz7tPpKgg6Et0B4TX9qSeTL8WPxewrV
         +SEgl5XAyrIoxnOal8nOsIOYqMERNxpa6LN300G/GIJWmkAfXkWldESpO0LiNaRktvR+
         EgO88cseSpb6HzrQ2C/cqACuKNaQ91kpGsthiCCQ/PQ1p3zHfpyZ3xD/0Mg7G6LIJ8IE
         UUhYnhy16udtmaHpA5f+M2DJkPLM33mloK+r++3ExUZoaj/62jbE0EzhvDaaffrdYtKf
         0HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8qABYGSPVig8hCAyKjYse7vuwI3Jd63P0JUeskAy7k4=;
        b=LMKi1jNOIcC9AkJlp4q/sqhy7v/3k64DJ9gXCKpUlUMZbUw7LHb8GcOyghQGsgjP8s
         7ZOes4/dVDR6DXZNdXzRMlI0Uegs5OqJt8BZMvZkKbw0v9+G3Yg9h6OjXX9wKSuDbEL6
         ztYMzlrSIadFwWJdO7M2zSq0Id4dDBY/yaSsCQsBgrQho4OBdZHjVv/5uLywpt/PcC6+
         vNg0YGhss16Ni78vi8jRQWTbFdubbBwkfjOKLH2zbJ8BHYmPfQwVyP9TtvWbEb4tuzx2
         XJldgas+8/185deWQFgzp1ArnnoewJOMfQgve7ctuEtGY+IbKwRJy8owNRRrjeiF4Jf5
         0omQ==
X-Gm-Message-State: AOAM5325wDcGCzZlQIAqt1OjYfR4R4SBuZrkItbwI5DhlPnU6RicVA6U
        MuFI4cUUrUdXDgdcWDcfT1mjSPTeTGHiDQ2FZ8IAng==
X-Google-Smtp-Source: ABdhPJxRXBA2xZqf+iC0JI5JF5cqdKKD1EIkCEJ8esXI+yISuuu3m0AzVl0F1O1Rxk2YUTf3mCdcuo2Q3BRqk0M/4zA=
X-Received: by 2002:a17:902:ab8d:: with SMTP id f13mr14923916plr.119.1592936799397;
 Tue, 23 Jun 2020 11:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <202006180904.TVUXCf6H%lkp@intel.com> <150a9a49-8d61-ea34-94d4-fff158aae802@csgroup.eu>
 <CAKwvOd=s53vUELe311VSjxt2_eQd+RGNCf__n+cV+R=PQ_CdXQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=s53vUELe311VSjxt2_eQd+RGNCf__n+cV+R=PQ_CdXQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jun 2020 11:26:28 -0700
Message-ID: <CAKwvOdmmGj4B5NnaNTM=SGchU-Jg4VYCroqOWZu=y+j1MxJnYA@mail.gmail.com>
Subject: Re: ld.lld: warning: drivers/built-in.a(misc/ds1682.o):(.data..compoundliteral)
 is being placed in '.data..compoundliteral'
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Fangrui Song <maskray@google.com>,
        Philip Li <philip.li@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 9:32 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jun 19, 2020 at 6:24 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> >
> >
> > Le 18/06/2020 =C3=A0 03:12, kernel test robot a =C3=A9crit :
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
> > > head:   1b5044021070efa3259f3e9548dc35d1eb6aa844
> > > commit: 74016701fe5f873ae23bf02835407227138d874d powerpc/32s: Fix ano=
ther build failure with CONFIG_PPC_KUAP_DEBUG
> >
> > I'm really having hard time understanding the link between this commit
> > and the issue reported below.
> >
> > Can Clang people help understand what the problem might be ?
>
> For randconfigs, it might be the case that we're not clean in the
> first place. + Philip to provide more info on how the bisection
> pinpoints commits? (Is the same randconfig used repeatedly as part of
> a bisection?)
>
> + Kees, idk if this is the warning from the orphan section placement,
> if any of those patches have landed?

Yes, Kees it looks like orphan section warning; sounds like this is
enabled for ppc on mainline.  We'll need to add this section to the
linker scripts.

>
> + Fangrui, who might know more about this warning from LLD.
>
> >
> > Christophe
> >
> > > date:   2 weeks ago
> > > config: powerpc-randconfig-r032-20200617 (attached as .config)
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project =
487ca07fcc75d52755c9fe2ee05bcb3b6eeeec44)
> > > reproduce (this is a W=3D1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/maste=
r/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # install powerpc cross compiling tool for clang build
> > >          # apt-get install binutils-powerpc-linux-gnu
> > >          git checkout 74016701fe5f873ae23bf02835407227138d874d
> > >          # save the attached .config to linux build tree
> > >          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cro=
ss ARCH=3Dpowerpc
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > >
> > >>> ld.lld: warning: drivers/built-in.a(misc/ds1682.o):(.data..compound=
literal) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.29) is being placed in '.data..compoundliteral.29'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.31) is being placed in '.data..compoundliteral.31'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.33) is being placed in '.data..compoundliteral.33'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.bss..compou=
ndliteral.35) is being placed in '.bss..compoundliteral.35'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.37) is being placed in '.data..compoundliteral.37'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.39) is being placed in '.data..compoundliteral.39'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.41) is being placed in '.data..compoundliteral.41'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.43) is being placed in '.data..compoundliteral.43'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.45) is being placed in '.data..compoundliteral.45'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.47) is being placed in '.data..compoundliteral.47'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.49) is being placed in '.data..compoundliteral.49'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.51) is being placed in '.data..compoundliteral.51'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.53) is being placed in '.data..compoundliteral.53'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.55) is being placed in '.data..compoundliteral.55'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.57) is being placed in '.data..compoundliteral.57'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.59) is being placed in '.data..compoundliteral.59'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.61) is being placed in '.data..compoundliteral.61'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.63) is being placed in '.data..compoundliteral.63'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.65) is being placed in '.data..compoundliteral.65'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.67) is being placed in '.data..compoundliteral.67'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.69) is being placed in '.data..compoundliteral.69'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.71) is being placed in '.data..compoundliteral.71'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.73) is being placed in '.data..compoundliteral.73'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.75) is being placed in '.data..compoundliteral.75'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.77) is being placed in '.data..compoundliteral.77'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.79) is being placed in '.data..compoundliteral.79'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.81) is being placed in '.data..compoundliteral.81'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.83) is being placed in '.data..compoundliteral.83'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.85) is being placed in '.data..compoundliteral.85'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.87) is being placed in '.data..compoundliteral.87'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.89) is being placed in '.data..compoundliteral.89'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.91) is being placed in '.data..compoundliteral.91'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.93) is being placed in '.data..compoundliteral.93'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.95) is being placed in '.data..compoundliteral.95'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.97) is being placed in '.data..compoundliteral.97'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.99) is being placed in '.data..compoundliteral.99'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.101) is being placed in '.data..compoundliteral.101'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.103) is being placed in '.data..compoundliteral.103'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.105) is being placed in '.data..compoundliteral.105'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.107) is being placed in '.data..compoundliteral.107'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.109) is being placed in '.data..compoundliteral.109'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.111) is being placed in '.data..compoundliteral.111'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.113) is being placed in '.data..compoundliteral.113'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.115) is being placed in '.data..compoundliteral.115'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.117) is being placed in '.data..compoundliteral.117'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.119) is being placed in '.data..compoundliteral.119'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.121) is being placed in '.data..compoundliteral.121'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.123) is being placed in '.data..compoundliteral.123'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.125) is being placed in '.data..compoundliteral.125'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.127) is being placed in '.data..compoundliteral.127'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.129) is being placed in '.data..compoundliteral.129'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.131) is being placed in '.data..compoundliteral.131'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.133) is being placed in '.data..compoundliteral.133'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.135) is being placed in '.data..compoundliteral.135'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.137) is being placed in '.data..compoundliteral.137'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.139) is being placed in '.data..compoundliteral.139'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.141) is being placed in '.data..compoundliteral.141'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.143) is being placed in '.data..compoundliteral.143'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.145) is being placed in '.data..compoundliteral.145'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.147) is being placed in '.data..compoundliteral.147'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.149) is being placed in '.data..compoundliteral.149'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.151) is being placed in '.data..compoundliteral.151'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.153) is being placed in '.data..compoundliteral.153'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.155) is being placed in '.data..compoundliteral.155'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.157) is being placed in '.data..compoundliteral.157'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.159) is being placed in '.data..compoundliteral.159'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.161) is being placed in '.data..compoundliteral.161'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.163) is being placed in '.data..compoundliteral.163'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.165) is being placed in '.data..compoundliteral.165'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.167) is being placed in '.data..compoundliteral.167'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.169) is being placed in '.data..compoundliteral.169'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.171) is being placed in '.data..compoundliteral.171'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.173) is being placed in '.data..compoundliteral.173'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.175) is being placed in '.data..compoundliteral.175'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.177) is being placed in '.data..compoundliteral.177'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.179) is being placed in '.data..compoundliteral.179'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.181) is being placed in '.data..compoundliteral.181'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.183) is being placed in '.data..compoundliteral.183'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.185) is being placed in '.data..compoundliteral.185'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.187) is being placed in '.data..compoundliteral.187'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.189) is being placed in '.data..compoundliteral.189'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.191) is being placed in '.data..compoundliteral.191'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.193) is being placed in '.data..compoundliteral.193'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.195) is being placed in '.data..compoundliteral.195'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.197) is being placed in '.data..compoundliteral.197'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.199) is being placed in '.data..compoundliteral.199'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.201) is being placed in '.data..compoundliteral.201'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.203) is being placed in '.data..compoundliteral.203'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.205) is being placed in '.data..compoundliteral.205'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.207) is being placed in '.data..compoundliteral.207'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.209) is being placed in '.data..compoundliteral.209'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.211) is being placed in '.data..compoundliteral.211'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.213) is being placed in '.data..compoundliteral.213'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.215) is being placed in '.data..compoundliteral.215'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.217) is being placed in '.data..compoundliteral.217'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.219) is being placed in '.data..compoundliteral.219'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.221) is being placed in '.data..compoundliteral.221'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.223) is being placed in '.data..compoundliteral.223'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.225) is being placed in '.data..compoundliteral.225'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.227) is being placed in '.data..compoundliteral.227'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.229) is being placed in '.data..compoundliteral.229'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.231) is being placed in '.data..compoundliteral.231'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.233) is being placed in '.data..compoundliteral.233'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.235) is being placed in '.data..compoundliteral.235'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.237) is being placed in '.data..compoundliteral.237'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.239) is being placed in '.data..compoundliteral.239'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.241) is being placed in '.data..compoundliteral.241'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.243) is being placed in '.data..compoundliteral.243'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.245) is being placed in '.data..compoundliteral.245'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.247) is being placed in '.data..compoundliteral.247'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.249) is being placed in '.data..compoundliteral.249'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.251) is being placed in '.data..compoundliteral.251'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.253) is being placed in '.data..compoundliteral.253'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.255) is being placed in '.data..compoundliteral.255'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.257) is being placed in '.data..compoundliteral.257'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.259) is being placed in '.data..compoundliteral.259'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.261) is being placed in '.data..compoundliteral.261'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.263) is being placed in '.data..compoundliteral.263'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.265) is being placed in '.data..compoundliteral.265'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.267) is being placed in '.data..compoundliteral.267'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.269) is being placed in '.data..compoundliteral.269'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.271) is being placed in '.data..compoundliteral.271'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.273) is being placed in '.data..compoundliteral.273'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.275) is being placed in '.data..compoundliteral.275'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.277) is being placed in '.data..compoundliteral.277'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.279) is being placed in '.data..compoundliteral.279'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.281) is being placed in '.data..compoundliteral.281'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.283) is being placed in '.data..compoundliteral.283'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.285) is being placed in '.data..compoundliteral.285'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.287) is being placed in '.data..compoundliteral.287'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.289) is being placed in '.data..compoundliteral.289'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.294) is being placed in '.data..compoundliteral.294'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.295) is being placed in '.data..compoundliteral.295'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.296) is being placed in '.data..compoundliteral.296'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.297) is being placed in '.data..compoundliteral.297'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compou=
ndliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compou=
ndliteral.18) is being placed in '.data..compoundliteral.18'
> > > ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compound=
literal.19) is being placed in '.data..compoundliteral.19'
> > > ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compound=
literal.20) is being placed in '.data..compoundliteral.20'
> > > ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compound=
literal.21) is being placed in '.data..compoundliteral.21'
> > > ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compound=
literal.22) is being placed in '.data..compoundliteral.22'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compou=
ndliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compou=
ndliteral.15) is being placed in '.data..compoundliteral.15'
> > > ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compound=
literal.16) is being placed in '.data..compoundliteral.16'
> > > ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compound=
literal.17) is being placed in '.data..compoundliteral.17'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compo=
undliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compo=
undliteral.2) is being placed in '.data..compoundliteral.2'
> > > ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoun=
dliteral.3) is being placed in '.data..compoundliteral.3'
> > > ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoun=
dliteral.4) is being placed in '.data..compoundliteral.4'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoun=
dliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoun=
dliteral.10) is being placed in '.data..compoundliteral.10'
> > > ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundl=
iteral.11) is being placed in '.data..compoundliteral.11'
> > > ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundl=
iteral.12) is being placed in '.data..compoundliteral.12'
> > >>> ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq-dt-platdev.o):(=
.data..compoundliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: drivers/built-in.a(hid/hid-cp2112.o):(.data..compo=
undliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundl=
iteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundl=
iteral.2) is being placed in '.data..compoundliteral.2'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.3) is being placed in '.data..compoundliteral.3'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.4) is being placed in '.data..compoundliteral.4'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.5) is being placed in '.data..compoundliteral.5'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.6) is being placed in '.data..compoundliteral.6'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.7) is being placed in '.data..compoundliteral.7'
> > > ld.lld: warning: net/built-in.a(ipv6/addrconf_core.o):(.data..compoun=
dliteral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> > > ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab=
'
> > > ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> > >>> ld.lld: warning: drivers/built-in.a(misc/ds1682.o):(.data..compound=
literal) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.29) is being placed in '.data..compoundliteral.29'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.31) is being placed in '.data..compoundliteral.31'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.33) is being placed in '.data..compoundliteral.33'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.bss..compou=
ndliteral.35) is being placed in '.bss..compoundliteral.35'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.37) is being placed in '.data..compoundliteral.37'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.39) is being placed in '.data..compoundliteral.39'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.41) is being placed in '.data..compoundliteral.41'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.43) is being placed in '.data..compoundliteral.43'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.45) is being placed in '.data..compoundliteral.45'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.47) is being placed in '.data..compoundliteral.47'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.49) is being placed in '.data..compoundliteral.49'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.51) is being placed in '.data..compoundliteral.51'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.53) is being placed in '.data..compoundliteral.53'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.55) is being placed in '.data..compoundliteral.55'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.57) is being placed in '.data..compoundliteral.57'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.59) is being placed in '.data..compoundliteral.59'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.61) is being placed in '.data..compoundliteral.61'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.63) is being placed in '.data..compoundliteral.63'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.65) is being placed in '.data..compoundliteral.65'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.67) is being placed in '.data..compoundliteral.67'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.69) is being placed in '.data..compoundliteral.69'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.71) is being placed in '.data..compoundliteral.71'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.73) is being placed in '.data..compoundliteral.73'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.75) is being placed in '.data..compoundliteral.75'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.77) is being placed in '.data..compoundliteral.77'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.79) is being placed in '.data..compoundliteral.79'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.81) is being placed in '.data..compoundliteral.81'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.83) is being placed in '.data..compoundliteral.83'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.85) is being placed in '.data..compoundliteral.85'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.87) is being placed in '.data..compoundliteral.87'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.89) is being placed in '.data..compoundliteral.89'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.91) is being placed in '.data..compoundliteral.91'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.93) is being placed in '.data..compoundliteral.93'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.95) is being placed in '.data..compoundliteral.95'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.97) is being placed in '.data..compoundliteral.97'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.99) is being placed in '.data..compoundliteral.99'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.101) is being placed in '.data..compoundliteral.101'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.103) is being placed in '.data..compoundliteral.103'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.105) is being placed in '.data..compoundliteral.105'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.107) is being placed in '.data..compoundliteral.107'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.109) is being placed in '.data..compoundliteral.109'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.111) is being placed in '.data..compoundliteral.111'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.113) is being placed in '.data..compoundliteral.113'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.115) is being placed in '.data..compoundliteral.115'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.117) is being placed in '.data..compoundliteral.117'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.119) is being placed in '.data..compoundliteral.119'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.121) is being placed in '.data..compoundliteral.121'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.123) is being placed in '.data..compoundliteral.123'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.125) is being placed in '.data..compoundliteral.125'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.127) is being placed in '.data..compoundliteral.127'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.129) is being placed in '.data..compoundliteral.129'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.131) is being placed in '.data..compoundliteral.131'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.133) is being placed in '.data..compoundliteral.133'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.135) is being placed in '.data..compoundliteral.135'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.137) is being placed in '.data..compoundliteral.137'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.139) is being placed in '.data..compoundliteral.139'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.141) is being placed in '.data..compoundliteral.141'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.143) is being placed in '.data..compoundliteral.143'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.145) is being placed in '.data..compoundliteral.145'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.147) is being placed in '.data..compoundliteral.147'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.149) is being placed in '.data..compoundliteral.149'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.151) is being placed in '.data..compoundliteral.151'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.153) is being placed in '.data..compoundliteral.153'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.155) is being placed in '.data..compoundliteral.155'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.157) is being placed in '.data..compoundliteral.157'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.159) is being placed in '.data..compoundliteral.159'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.161) is being placed in '.data..compoundliteral.161'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.163) is being placed in '.data..compoundliteral.163'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.165) is being placed in '.data..compoundliteral.165'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.167) is being placed in '.data..compoundliteral.167'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.169) is being placed in '.data..compoundliteral.169'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.171) is being placed in '.data..compoundliteral.171'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.173) is being placed in '.data..compoundliteral.173'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.175) is being placed in '.data..compoundliteral.175'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.177) is being placed in '.data..compoundliteral.177'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.179) is being placed in '.data..compoundliteral.179'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.181) is being placed in '.data..compoundliteral.181'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.183) is being placed in '.data..compoundliteral.183'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.185) is being placed in '.data..compoundliteral.185'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.187) is being placed in '.data..compoundliteral.187'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.189) is being placed in '.data..compoundliteral.189'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.191) is being placed in '.data..compoundliteral.191'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.193) is being placed in '.data..compoundliteral.193'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.195) is being placed in '.data..compoundliteral.195'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.197) is being placed in '.data..compoundliteral.197'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.199) is being placed in '.data..compoundliteral.199'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.201) is being placed in '.data..compoundliteral.201'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.203) is being placed in '.data..compoundliteral.203'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.205) is being placed in '.data..compoundliteral.205'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.207) is being placed in '.data..compoundliteral.207'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.209) is being placed in '.data..compoundliteral.209'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.211) is being placed in '.data..compoundliteral.211'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.213) is being placed in '.data..compoundliteral.213'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.215) is being placed in '.data..compoundliteral.215'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.217) is being placed in '.data..compoundliteral.217'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.219) is being placed in '.data..compoundliteral.219'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.221) is being placed in '.data..compoundliteral.221'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.223) is being placed in '.data..compoundliteral.223'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.225) is being placed in '.data..compoundliteral.225'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.227) is being placed in '.data..compoundliteral.227'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.229) is being placed in '.data..compoundliteral.229'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.231) is being placed in '.data..compoundliteral.231'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.233) is being placed in '.data..compoundliteral.233'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.235) is being placed in '.data..compoundliteral.235'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.237) is being placed in '.data..compoundliteral.237'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.239) is being placed in '.data..compoundliteral.239'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.241) is being placed in '.data..compoundliteral.241'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.243) is being placed in '.data..compoundliteral.243'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.245) is being placed in '.data..compoundliteral.245'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.247) is being placed in '.data..compoundliteral.247'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.249) is being placed in '.data..compoundliteral.249'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.251) is being placed in '.data..compoundliteral.251'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.253) is being placed in '.data..compoundliteral.253'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.255) is being placed in '.data..compoundliteral.255'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.257) is being placed in '.data..compoundliteral.257'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.259) is being placed in '.data..compoundliteral.259'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.261) is being placed in '.data..compoundliteral.261'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.263) is being placed in '.data..compoundliteral.263'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.265) is being placed in '.data..compoundliteral.265'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.267) is being placed in '.data..compoundliteral.267'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.269) is being placed in '.data..compoundliteral.269'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.271) is being placed in '.data..compoundliteral.271'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.273) is being placed in '.data..compoundliteral.273'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.275) is being placed in '.data..compoundliteral.275'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.277) is being placed in '.data..compoundliteral.277'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.279) is being placed in '.data..compoundliteral.279'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.281) is being placed in '.data..compoundliteral.281'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.283) is being placed in '.data..compoundliteral.283'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.285) is being placed in '.data..compoundliteral.285'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.287) is being placed in '.data..compoundliteral.287'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.289) is being placed in '.data..compoundliteral.289'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.294) is being placed in '.data..compoundliteral.294'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.295) is being placed in '.data..compoundliteral.295'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.296) is being placed in '.data..compoundliteral.296'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.297) is being placed in '.data..compoundliteral.297'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compou=
ndliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compou=
ndliteral.18) is being placed in '.data..compoundliteral.18'
> > > ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compound=
literal.19) is being placed in '.data..compoundliteral.19'
> > > ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compound=
literal.20) is being placed in '.data..compoundliteral.20'
> > > ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compound=
literal.21) is being placed in '.data..compoundliteral.21'
> > > ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compound=
literal.22) is being placed in '.data..compoundliteral.22'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compou=
ndliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compou=
ndliteral.15) is being placed in '.data..compoundliteral.15'
> > > ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compound=
literal.16) is being placed in '.data..compoundliteral.16'
> > > ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compound=
literal.17) is being placed in '.data..compoundliteral.17'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compo=
undliteral) is being placed in '.data..compoundliteral'
> > >>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compo=
undliteral.2) is being placed in '.data..compoundliteral.2'
> > > ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoun=
dliteral.3) is being placed in '.data..compoundliteral.3'
> > > ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoun=
dliteral.4) is being placed in '.data..compoundliteral.4'
> > > ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundl=
iteral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundl=
iteral.10) is being placed in '.data..compoundliteral.10'
> > > ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundl=
iteral.11) is being placed in '.data..compoundliteral.11'
> > > ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundl=
iteral.12) is being placed in '.data..compoundliteral.12'
> > > ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq-dt-platdev.o):(.d=
ata..compoundliteral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: drivers/built-in.a(hid/hid-cp2112.o):(.data..compoun=
dliteral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.2) is being placed in '.data..compoundliteral.2'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.3) is being placed in '.data..compoundliteral.3'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.4) is being placed in '.data..compoundliteral.4'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.5) is being placed in '.data..compoundliteral.5'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.6) is being placed in '.data..compoundliteral.6'
> > > ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundlit=
eral.7) is being placed in '.data..compoundliteral.7'
> > > ld.lld: warning: net/built-in.a(ipv6/addrconf_core.o):(.data..compoun=
dliteral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> > > ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab=
'
> > > ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> > > ld.lld: warning: drivers/built-in.a(misc/ds1682.o):(.data..compoundli=
teral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral) is being placed in '.data..compoundliteral'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.29) is being placed in '.data..compoundliteral.29'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.31) is being placed in '.data..compoundliteral.31'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.33) is being placed in '.data..compoundliteral.33'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.bss..compou=
ndliteral.35) is being placed in '.bss..compoundliteral.35'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.37) is being placed in '.data..compoundliteral.37'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.39) is being placed in '.data..compoundliteral.39'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.41) is being placed in '.data..compoundliteral.41'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.43) is being placed in '.data..compoundliteral.43'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.45) is being placed in '.data..compoundliteral.45'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.47) is being placed in '.data..compoundliteral.47'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.49) is being placed in '.data..compoundliteral.49'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.51) is being placed in '.data..compoundliteral.51'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.53) is being placed in '.data..compoundliteral.53'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.55) is being placed in '.data..compoundliteral.55'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.57) is being placed in '.data..compoundliteral.57'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.59) is being placed in '.data..compoundliteral.59'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.61) is being placed in '.data..compoundliteral.61'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.63) is being placed in '.data..compoundliteral.63'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.65) is being placed in '.data..compoundliteral.65'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.67) is being placed in '.data..compoundliteral.67'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.69) is being placed in '.data..compoundliteral.69'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.71) is being placed in '.data..compoundliteral.71'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.73) is being placed in '.data..compoundliteral.73'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.75) is being placed in '.data..compoundliteral.75'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.77) is being placed in '.data..compoundliteral.77'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.79) is being placed in '.data..compoundliteral.79'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.81) is being placed in '.data..compoundliteral.81'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.83) is being placed in '.data..compoundliteral.83'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.85) is being placed in '.data..compoundliteral.85'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.87) is being placed in '.data..compoundliteral.87'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.89) is being placed in '.data..compoundliteral.89'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.91) is being placed in '.data..compoundliteral.91'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.93) is being placed in '.data..compoundliteral.93'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.95) is being placed in '.data..compoundliteral.95'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.97) is being placed in '.data..compoundliteral.97'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.99) is being placed in '.data..compoundliteral.99'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.101) is being placed in '.data..compoundliteral.101'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.103) is being placed in '.data..compoundliteral.103'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.105) is being placed in '.data..compoundliteral.105'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.107) is being placed in '.data..compoundliteral.107'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.109) is being placed in '.data..compoundliteral.109'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.111) is being placed in '.data..compoundliteral.111'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.113) is being placed in '.data..compoundliteral.113'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.115) is being placed in '.data..compoundliteral.115'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.117) is being placed in '.data..compoundliteral.117'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.119) is being placed in '.data..compoundliteral.119'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.121) is being placed in '.data..compoundliteral.121'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.123) is being placed in '.data..compoundliteral.123'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.125) is being placed in '.data..compoundliteral.125'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.127) is being placed in '.data..compoundliteral.127'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.129) is being placed in '.data..compoundliteral.129'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.131) is being placed in '.data..compoundliteral.131'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.133) is being placed in '.data..compoundliteral.133'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.135) is being placed in '.data..compoundliteral.135'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.137) is being placed in '.data..compoundliteral.137'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.139) is being placed in '.data..compoundliteral.139'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.141) is being placed in '.data..compoundliteral.141'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.143) is being placed in '.data..compoundliteral.143'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.145) is being placed in '.data..compoundliteral.145'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.147) is being placed in '.data..compoundliteral.147'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.149) is being placed in '.data..compoundliteral.149'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.151) is being placed in '.data..compoundliteral.151'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.153) is being placed in '.data..compoundliteral.153'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.155) is being placed in '.data..compoundliteral.155'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.157) is being placed in '.data..compoundliteral.157'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.159) is being placed in '.data..compoundliteral.159'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.161) is being placed in '.data..compoundliteral.161'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.163) is being placed in '.data..compoundliteral.163'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.165) is being placed in '.data..compoundliteral.165'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.167) is being placed in '.data..compoundliteral.167'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.169) is being placed in '.data..compoundliteral.169'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.171) is being placed in '.data..compoundliteral.171'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.173) is being placed in '.data..compoundliteral.173'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.175) is being placed in '.data..compoundliteral.175'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.177) is being placed in '.data..compoundliteral.177'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.179) is being placed in '.data..compoundliteral.179'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.181) is being placed in '.data..compoundliteral.181'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.183) is being placed in '.data..compoundliteral.183'
> > > ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compo=
undliteral.185) is being placed in '.data..compoundliteral.185'
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
