Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36877206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqWBkcez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgGHSUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGHSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:20:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9819C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:20:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so4095932pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bEkWcEKwBD8xzZaF4VqK8c5iBK1OXZVpxV6HiO0m7tM=;
        b=cqWBkcezVloDchxtCxMaucVR2RWfi/YCXBxLuCxxQqhLPETQ0SvbnDInCrAdSAeRBW
         aoJIUzLqmEy9LyK3/6WsnYwSyQ0QrppcdHhH9Upwgjc7sV7sQwH38gf6zvCkDitS0Akj
         vn9uGFaCis28GxGLkdU+WcjqwWYgXFcU9WpBzrUrt3MHrCPjYKxyPh81q4lQSumrCwec
         b888IdXqcMeb8d1J/uPg0494nJij+oK1fha5o+AVBNjvhu8UC6kR93t9KLCqF30g9/RP
         XpYrTTDFINf1aDYbhP2Wv7L8E3UGe6ss6qUe9RZMwH8sa2b4mNODUUlmwRgepuRBTnz/
         3NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bEkWcEKwBD8xzZaF4VqK8c5iBK1OXZVpxV6HiO0m7tM=;
        b=ggNx1GTwvQElyKGebMM1daYqNEYsR0diaKLN6m99wrDNvz6+MYMsY56SD4HQve2noO
         +NTTBTraCY81uXvZVrtgF7ovS+//HiMUeJ1nt7wSyhDhaNLlIZi6VW0iqSaB1fi1lWCq
         UccgrOb1BGnvoL5wtC829s/HZWtCCSz3c74SUJgGUZu11aKE9fPsQxAXIBSblIgfXvJB
         /7KCuc4/O26jDeE6Y4qsqGLAeNFUwZId0RxjCiDJ1/M19cswjPFzD/LKbmkqJkPNOEzy
         xTUDEzNp59yvEvKcdcgx38ZijOkmCgBI1TqZQPJIdEXMXMMGHIiMiQsRoPg/IT8UBbMW
         EIdg==
X-Gm-Message-State: AOAM531WhBUiObyi6iv3I4Cg83p6+RIqj7lIDhUWWft6zCiavSX+DK6m
        V6MBshaGQAhYvn6V0yHCqC7RwWPEl0gs9laXkrlALw==
X-Google-Smtp-Source: ABdhPJxT1iy5+o6DaILSYYSi5KfZKnWzH1bvRWtS3F9igLDsByWKdJh6R9CseQoIqi2MOm22OWl3T9rHy1HsLtvVuiM=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr10935924pjb.32.1594232437416;
 Wed, 08 Jul 2020 11:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200630021436.43281-1-richard.weiyang@linux.alibaba.com>
 <202007010217.Rut2zTnF%lkp@intel.com> <20200701115816.GB4979@L-31X9LVDL-1304.local>
 <MN2PR11MB4064B0104312A3D22F1698F3E5670@MN2PR11MB4064.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB4064B0104312A3D22F1698F3E5670@MN2PR11MB4064.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Jul 2020 11:20:26 -0700
Message-ID: <CAKwvOdkVqY8WAfdTtHbgnJ2jafvsJCUgx2Rx4PCeNiX7HjLLow@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse: only sub-section aligned range would be populated
To:     "Xia, Hui" <hui.xia@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Philip Li <philip.li@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     lkp <lkp@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:23 AM Xia, Hui <hui.xia@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Wei Yang <richard.weiyang@linux.alibaba.com>
> >Sent: 2020=E5=B9=B47=E6=9C=881=E6=97=A5 19:58
> >To: lkp <lkp@intel.com>
> >Cc: Wei Yang <richard.weiyang@linux.alibaba.com>; Williams, Dan J
> ><dan.j.williams@intel.com>; akpm@linux-foundation.org; kbuild-all@lists.=
01.org;
> >clang-built-linux@googlegroups.com; linux-mm@kvack.org; linux-
> >kernel@vger.kernel.org
> >Subject: Re: [PATCH] mm/sparse: only sub-section aligned range would be
> >populated
> >
> >On Wed, Jul 01, 2020 at 02:11:10AM +0800, kernel test robot wrote:
> >>Hi Wei,
> >>
> >>Thank you for the patch! Perhaps something to improve:
> >>
> >>[auto build test WARNING on mmotm/master]
> >>
> >>url:    https://github.com/0day-ci/linux/commits/Wei-Yang/mm-sparse-onl=
y-
> >sub-section-aligned-range-would-be-populated/20200630-101713
> >>base:   git://git.cmpxchg.org/linux-mmotm.git master
> >>config: x86_64-allnoconfig (attached as .config)

Another issue was that this was an allnoconfig x86_64 build with
Clang.  While ARCH=3Dx86_64 defconfigs set:
CONFIG_64BIT=3Dy
CONFIG_X86_64=3Dy

allnoconfig turns those off, making it a 32b x86 build.  We cannot yet
build an ARCH=3Di386 build yet with Clang, so that means this target is
not green to begin with.

+ Arnd
There might be a way for us to disable maybe CONFIG_X86_32 when
building with Clang?  or make it so that randconfig can't dig this up?

+Philip
I'm not sure if it's easy to disable `allnoconfig` x86 builds with
Clang?  Also, I feel like we're asking for a bunch of special cases
while we work through all the issues.  We would like to revert these
special cases once we're in better shape.  Are you tracking a list of
exceptions, so that we can estimate the work to fix on our side, and
that we know to re-enable test coverage once fixed?

> >>compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project
> >>cf1d04484344be52ada8178e41d18fd15a9b880c)
> >>reproduce (this is a W=3D1 build):
> >>        wget https://raw.githubusercontent.com/intel/lkp-
> >tests/master/sbin/make.cross -O ~/bin/make.cross
> >>        chmod +x ~/bin/make.cross
> >>        # install x86_64 cross compiling tool for clang build
> >>        # apt-get install binutils-x86-64-linux-gnu
> >>        # save the attached .config to linux build tree
> >>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross
> >>ARCH=3Dx86_64
> >>
> >>If you fix the issue, kindly add following tag as appropriate
> >>Reported-by: kernel test robot <lkp@intel.com>
> >>
> >
> >Sorry, I don't follow up with this error report.
> >
> >It looks like a build error, while I just removes some check and the bui=
ld pass from
> >my side. Confused with this error report.
> It is false positive. Please ignore. Sorry for inconvenience.
> The report complains about " warning: no previous prototype for function =
'devkmsg_sysctl_set_loglvl'" which is not caused by commit in this report. =
We will investigate and fix in 0-day side.
>
> >
> >>All warnings (new ones prefixed by >>):
> >>
> >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>   case 1: ^
> >>   include/linux/signal.h:177:1: warning: unannotated fall-through betw=
een
> >switch labels
> >>   _SIG_SET_OP(signotset, _sig_not)
> >>   ^
> >>   include/linux/signal.h:167:2: note: expanded from macro '_SIG_SET_OP=
'
> >>   case 2: =3D ^
> >>   include/linux/signal.h:177:1: warning: unannotated fall-through betw=
een
> >switch labels
> >>   include/linux/signal.h:169:2: note: expanded from macro '_SIG_SET_OP=
'
> >>   case 1: =3D ^
> >>   include/linux/signal.h:190:2: warning: unannotated fall-through betw=
een
> >switch labels
> >>   case 1: =3D 0;
> >>   ^
> >>   include/linux/jhash.h:95:2: note: insert '__attribute__((fallthrough=
));' to silence
> >this warning
> >>   case 6: b +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/jhash.h:95:2: note: insert 'break;' to avoid fall-thro=
ugh
> >>   case 6: b +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   break;
> >>   include/linux/jhash.h:96:2: warning: unannotated fall-through betwee=
n switch
> >labels
> >>   case 5: b +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   15include/linux/signal.h:190:2: note: insert '__attribute__((fallthr=
ough));' to
> >silence this warning
> >>   case 1: =3D 0;
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/signal.h:190:2: note: insert 'break;' to avoid fall-th=
rough
> >>   case 1: =3D 0;
> >>   ^
> >>   break;
> >>   include/linux/signal.h:203:2: warninginclude/linux/jhash.h:96:2: not=
e: insert
> >'__attribute__((fallthrough));' to silence this warning
> >>   case 5: b +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/jhash.h:96:2: note: insert 'break;' to avoid fall-thro=
ugh
> >>   case 5: b +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   break;
> >>   include/linux/jhash.h:97:2: warning: unannotated fall-through betwee=
n switch
> >labels
> >>   case 4: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   : unannotated fall-through between switch labels
> >>   case 1: =3D -1;
> >>   ^
> >>   warnings generated.
> >>   include/linux/signal.h:203:2: note: insert '__attribute__((fallthrou=
gh));' to
> >silence this warning
> >>   case 1: =3D -1;
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/signal.h:15203:2: note: insert 'break;' to avoid fall-=
through
> >>   case 1: =3D -1;
> >>   ^
> >>   break;
> >>   include/linux/jhash.h:97:2: note: insert '__attribute__((fallthrough=
));' to silence
> >this warning
> >>   case 4: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/jhash.h:97:2: note: insert 'break;' to avoid fall-thro=
ugh
> >>   case 4: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   break;
> >>   include/linux/jhash.h:98:2: warning: unannotated fall-through betwee=
n switch
> >labels
> >>   case 3: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   include/linux/signal.h:233:2: warning: unannotated fall-through betw=
een
> >switch labels
> >>   case 1: ;
> >>   ^
> >>   warnings generated.
> >>   In file included from kernel/printk/printk.c:61:
> >>   kernel/printk/internal.h:54:20: warninginclude/linux/jhash.h:98:2: n=
ote: insert
> >'__attribute__((fallthrough));' to silence this warning
> >>   case 3: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/jhash.h:98:2: note: no previous prototype for function
> >'vprintk_func'
> >>   __printf(1, 0) int vprintk_func(const char va_list args) { return 0;=
 }
> >>   ^
> >>   kernel/printk/internal.h: insert 'break;' to avoid fall-through
> >>   case 3: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   break;
> >>   include/linux/jhash.h:99:2: warning: unannotated fall-through betwee=
n switch
> >labels
> >>   case 2: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   :54:16: note: declare 'static' if the function is not intended to be=
 used outside
> >of this translation unit
> >>   __printf(1, 0) int vprintk_func(const char va_list args) { return 0;=
 }
> >>   ^
> >>   static
> >>   kernel/printk/printk.cinclude/linux/signal.h:233:2: note: insert
> >'__attribute__((fallthrough));' to silence this warning
> >>   case 1: ;
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/signal.h:233:2: note: insert 'break;' to avoid fall-th=
rough
> >>   case 1: ;
> >>   ^
> >>   break;
> >>   include/linux/signal.h:245:2: warning: unannotated fall-through betw=
een
> >switch labels
> >>   case 1: ;
> >>   ^
> >>>> :165:5: warning: no previous prototype for function
> >'devkmsg_sysctl_set_loglvl'
> >>   int devkmsg_sysctl_set_loglvl(struct ctl_table int write,
> >>   ^
> >>   kernel/printk/printk.c:165:1: note: declare 'static' if the function=
 is not
> >intended to be used outside of this translation unit
> >>   int devkmsg_sysctl_set_loglvl(struct ctl_table int write,
> >>   ^
> >>   static
> >>   include/linux/jhash.h:99:2: note: insert '__attribute__((fallthrough=
));' to silence
> >this warning
> >>   case 2: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/jhash.h:99:2: note: insert 'break;' to avoid fall-thro=
ugh
> >>   case 2: a +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   break;
> >>   include/linux/jhash.h:100:2: warning: unannotated fall-through betwe=
en
> >switch labels
> >>   case 1: a +=3D
> >>   ^
> >>   include/linux/signal.h:245:2: note: insert '__attribute__((fallthrou=
gh));' to
> >silence this warning
> >>   case 1: ;
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/signal.h:245:2: note: insert 'break;' to avoid fall-th=
rough
> >>   case 1: ;
> >>   ^
> >>   break;
> >>   kernel/printk/printk.cinclude/linux/jhash.h:100:2: note: insert
> >'__attribute__((fallthrough));' to silence this warning
> >>   case 1: a +=3D
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/jhash.h:100:2: note: insert 'break;' to avoid fall-thr=
ough
> >>   case 1: a +=3D
> >>   ^
> >>   break;
> >>   include/linux/jhash.h:102:2: warning: unannotated fall-through betwe=
en
> >switch labels
> >>   case 0: /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /de=
v /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var Nothing left to add arch/ block/ certs/ crypto/ drivers/ fs/ includ=
e/ init/ ipc/
> >kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt=
/
> >>   ^
> >>   include/linux/jhash.h:102:2: note: insert 'break;' to avoid fall-thr=
ough
> >>   case 0: /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cephfs /de=
v /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var Nothing left to add arch/ block/ certs/ crypto/ drivers/ fs/ includ=
e/ init/ ipc/
> >kernel/ lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt=
/
> >>   ^
> >>   break;
> >>   :2406:10: warning: 'sprintf' will always overflow; destination buffe=
r has size 0,
> >but format string expands to at least 33
> >>   len =3D sprintf(text,
> >>   ^
> >>   include/linux/jhash.h:136:2: warning: unannotated fall-through betwe=
en
> >switch labels
> >>   case 2: b +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   include/linux/jhash.h:136:2: note: insert '__attribute__((fallthroug=
h));' to
> >silence this warning
> >>   case 2: b +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   __attribute__((fallthrough));
> >>   include/linux/jhash.h:136:2: note: insert 'break;' to avoid fall-thr=
ough
> >>   case 2: b +=3D /Dockerfile /Gemfile /Gemfile.lock /bin /boot /c /cep=
hfs /dev /etc
> >/home /htmldocs /include /kbuild /lib /lib32 /lib64 /libx32 /lkp-cloud /=
lkp-src
> >/media /mnt /opt /patch /pkg /proc /root /run /sbin /share /srv /sys /tm=
p /usr
> >/var fall through arch/ block/ certs/ crypto/ drivers/ fs/ include/ init=
/ ipc/ kernel/
> >lib/ mm/ net/ scripts/ security/ sound/ source/ tools/ usr/ virt/
> >>   ^
> >>   break;
> >>   include/linux/jhash.h:137:2: warning: unannotated fall-through betwe=
en
> >switch labels
> >>   case 1: a +=3D
> >>   ^
> >>   In file included from kernel/capability.c:13:
> >>   In file included from include/linux/audit.h:13:
> >>   In file included from include/linux/ptrace.h:7:
> >>   In file included from include/linux/sched/signal.h:6:
> >>   include/linux/signal.h:147:1: warning: unannotated fall-through betw=
een
> >switch labels
> >>   _SIG_SET_BINOP(sigorsets, _sig_or)
> >>   ^
> >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>   case 2: ^
> >>   include/linux/signal.h:147:1: warning: unannotated fall-through betw=
een
> >switch labels
> >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>   case 1: ^
> >>   include/linux/signal.h:150:1: warning: unannotated fall-through betw=
een
> >switch labels
> >>   _SIG_SET_BINOP(sigandsets, _sig_and)
> >>   ^
> >>   include/linux/signal.h:133:2:In file included from note: expanded fr=
om macro
> >'_SIG_SET_BINOP'
> >>   case 2: ^
> >>   include/linux/signal.h:150:1: warning: unannotated fall-through betw=
een
> >switch labels
> >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>   case 1: ^
> >>   include/linux/signal.h:153:1: warning: unannotated fall-through betw=
een
> >switch labels
> >>   _SIG_SET_BINOP(sigandnsets, _sig_andn)
> >>   ^
> >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>   case 2: kernel/sysctl_binary.c:15:
> >>   In file included from include/linux/netdevice.h:37:
> >>   In file included from include/linux/ethtool.h:18:
> >>   In file included from include/uapi/linux/ethtool.h:19:
> >>   In file included from include/linux/if_ether.h:19:
> >>   include/linux/skbuff.h:3690:2: warning: unannotated fall-through bet=
ween
> >switch labels
> >>   case 24: diffs |=3D __it_diff(a, b, 64);
> >>   ^
> >>--
> >>           ^
> >>           __attribute__((fallthrough));
> >>   include/linux/mm.h:166:2: note: insert 'break;' to avoid fall-throug=
h
> >>           case 56:
> >>           ^
> >>           break;
> >>   In file included from kernel/printk/printk.c:36:
> >>   In file included from include/linux/syscalls.h:76:
> >>   include/linux/signal.h:147:1: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>   _SIG_SET_BINOP(sigorsets, _sig_or)
> >>   ^
> >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>           case 2:                                                     =
    \
> >>           ^
> >>   include/linux/signal.h:147:1: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>           case 1:                                                     =
    \
> >>           ^
> >>   include/linux/signal.h:150:1: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>   _SIG_SET_BINOP(sigandsets, _sig_and)
> >>   ^
> >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>           case 2:                                                     =
    \
> >>           ^
> >>   include/linux/signal.h:150:1: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>           case 1:                                                     =
    \
> >>           ^
> >>   include/linux/signal.h:153:1: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>   _SIG_SET_BINOP(sigandnsets, _sig_andn)
> >>   ^
> >>   include/linux/signal.h:133:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>           case 2:                                                     =
    \
> >>           ^
> >>   include/linux/signal.h:153:1: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>   include/linux/signal.h:137:2: note: expanded from macro '_SIG_SET_BI=
NOP'
> >>           case 1:                                                     =
    \
> >>           ^
> >>   include/linux/signal.h:177:1: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>   _SIG_SET_OP(signotset, _sig_not)
> >>   ^
> >>   include/linux/signal.h:167:2: note: expanded from macro '_SIG_SET_OP=
'
> >>           case 2: set->sig[1] =3D op(set->sig[1]);                    =
      \
> >>           ^
> >>   include/linux/signal.h:177:1: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>   include/linux/signal.h:169:2: note: expanded from macro '_SIG_SET_OP=
'
> >>           case 1: set->sig[0] =3D op(set->sig[0]);                    =
      \
> >>           ^
> >>   include/linux/signal.h:190:2: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>           case 1: set->sig[0] =3D 0;
> >>           ^
> >>   include/linux/signal.h:190:2: note: insert '__attribute__((fallthrou=
gh));' to
> >silence this warning
> >>           case 1: set->sig[0] =3D 0;
> >>           ^
> >>           __attribute__((fallthrough));
> >>   include/linux/signal.h:190:2: note: insert 'break;' to avoid fall-th=
rough
> >>           case 1: set->sig[0] =3D 0;
> >>           ^
> >>           break;
> >>   include/linux/signal.h:203:2: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>           case 1: set->sig[0] =3D -1;
> >>           ^
> >>   include/linux/signal.h:203:2: note: insert '__attribute__((fallthrou=
gh));' to
> >silence this warning
> >>           case 1: set->sig[0] =3D -1;
> >>           ^
> >>           __attribute__((fallthrough));
> >>   include/linux/signal.h:203:2: note: insert 'break;' to avoid fall-th=
rough
> >>           case 1: set->sig[0] =3D -1;
> >>           ^
> >>           break;
> >>   include/linux/signal.h:233:2: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>           case 1: ;
> >>           ^
> >>   include/linux/signal.h:233:2: note: insert '__attribute__((fallthrou=
gh));' to
> >silence this warning
> >>           case 1: ;
> >>           ^
> >>           __attribute__((fallthrough));
> >>   include/linux/signal.h:233:2: note: insert 'break;' to avoid fall-th=
rough
> >>           case 1: ;
> >>           ^
> >>           break;
> >>   include/linux/signal.h:245:2: warning: unannotated fall-through betw=
een
> >switch labels [-Wimplicit-fallthrough]
> >>           case 1: ;
> >>           ^
> >>   include/linux/signal.h:245:2: note: insert '__attribute__((fallthrou=
gh));' to
> >silence this warning
> >>           case 1: ;
> >>           ^
> >>           __attribute__((fallthrough));
> >>   include/linux/signal.h:245:2: note: insert 'break;' to avoid fall-th=
rough
> >>           case 1: ;
> >>           ^
> >>           break;
> >>   In file included from kernel/printk/printk.c:61:
> >>   kernel/printk/internal.h:54:20: warning: no previous prototype for f=
unction
> >'vprintk_func' [-Wmissing-prototypes]
> >>   __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { ret=
urn 0; }
> >>                      ^
> >>   kernel/printk/internal.h:54:16: note: declare 'static' if the functi=
on is not
> >intended to be used outside of this translation unit
> >>   __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { ret=
urn 0; }
> >>                  ^
> >>                  static
> >>>> kernel/printk/printk.c:165:5: warning: no previous prototype for
> >>>> function 'devkmsg_sysctl_set_loglvl' [-Wmissing-prototypes]
> >>   int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
> >>       ^
> >>   kernel/printk/printk.c:165:1: note: declare 'static' if the function=
 is not
> >intended to be used outside of this translation unit
> >>   int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
> >>   ^
> >>   static
> >>   kernel/printk/printk.c:2406:10: warning: 'sprintf' will always overf=
low;
> >destination buffer has size 0, but format string expands to at least 33 =
[-Wfortify-
> >source]
> >>                           len =3D sprintf(text,
> >>                                 ^
> >>   18 warnings generated.
> >>
> >>---
> >>0-DAY CI Kernel Test Service, Intel Corporation
> >>https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> >
> >
> >--
> >Wei Yang
> >Help you, Help me
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/MN2PR11MB4064B0104312A3D22F1698F3E5670%40MN2PR11MB4064.=
namprd11.prod.outlook.com.



--=20
Thanks,
~Nick Desaulniers
