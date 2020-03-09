Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56916C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2F422525
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw4d6e76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCITXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:23:50 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44066 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgCITXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:23:50 -0400
Received: by mail-qv1-f66.google.com with SMTP id bp19so2573358qvb.11;
        Mon, 09 Mar 2020 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pSIEyt4pe+WfrawaMNkeNrr+5fcB3XjzVwsYTOF2ju0=;
        b=Kw4d6e76TcK3JPkEWaPk5CH0RHqCb0npbnQP0OMms1q6K3WtZdJ5sTdCjIBrFJcJee
         0Xt8PENpizYXH8ulqH72kXFIBx82e320O1Owcs4BxPRe3LT70eWZeLkJq6geQoDsQ3zA
         IC2oyC6nuC8KHshLaS7Xl6d3sjxDW6jdkmkdAsM/74dl/dXUa9aMNzY/m46M0gTxmqCw
         Sym9deDJwsRfWjZJ4BBhy4x/6IDpwebWGW8lVGn6P3II22SC8Bw1RlONEr15QRdgcOxG
         UASMkDlZvVOuEnwjnLzRuM8na+nhDfk5lLTo2RIDyvamCM3EK0YUpyU+0pYR6TC8gWnL
         eX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pSIEyt4pe+WfrawaMNkeNrr+5fcB3XjzVwsYTOF2ju0=;
        b=iyHjUpdMi3p5Jw+ljMfPxsvv4v6h2sMmJTUUcr5QwbAVD0OAWSh1A3rDbsnxx08Cgt
         MCdgOKGcucOT/8BCmXo4ZvSqVL09ektmAW66naRYaVXFQTcX+P499fK4+bBR5eRsg8PT
         +8uD4fb57QlE/NVY+HC+urflMMkyqwa+GiRG4JvWw9Rk81/MxN2iTVNTkn8ocE8dWLJ8
         cqMIUM9Ea9oR54f2Yx7BskzSoz+8kHdtCRsA/4adkNSUCCM/wYcljkbUYe0sIjXa3akQ
         lWEP0IBZN7970xYAuN3CSnAe9igHDHF57pKBaI1/A6qBy8c20yXh6BnJ3WCvmoJHNDyY
         hgFw==
X-Gm-Message-State: ANhLgQ3g6DGfcvPz5it5KwqDTyZ9tFBrnQHwv2uaRrKz1bQ99YB3SfgG
        5m07NkfWNB61YkNuLXlupTg=
X-Google-Smtp-Source: ADFU+vtJWZ9FBeVdxfHMjWWlyGr88juN3wkE8igF9ZxYyJlm0+WtXnJbThPeZrghk9eEUe4IyrgjZQ==
X-Received: by 2002:ad4:4a6e:: with SMTP id cn14mr15960454qvb.21.1583781827648;
        Mon, 09 Mar 2020 12:23:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c12sm1540995qtb.49.2020.03.09.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 12:23:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E9A740009; Mon,  9 Mar 2020 16:23:43 -0300 (-03)
Date:   Mon, 9 Mar 2020 16:23:43 -0300
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Ilie Halip <ilie.halip@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 3/6] perf python: Fix clang detection when using
 CC=clang-version
Message-ID: <20200309192343.GG477@kernel.org>
References: <20200309185323.22583-1-acme@kernel.org>
 <20200309185323.22583-4-acme@kernel.org>
 <CAKwvOdm5RrdpOCMgRezLeHJ9GuocVoKqSUQGHjaCEcZdSr4AwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKwvOdm5RrdpOCMgRezLeHJ9GuocVoKqSUQGHjaCEcZdSr4AwA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 09, 2020 at 11:58:33AM -0700, Nick Desaulniers escreveu:
> On Mon, Mar 9, 2020 at 11:53 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Ilie Halip <ilie.halip@gmail.com>
> >
> > Currently, the setup.py script detects the clang compiler only when inv=
oked
> > with CC=3Dclang. But when using a specific version (e.g. CC=3Dclang-11)=
, this
> > doesn't work correctly and wrong compiler flags are set, leading to bui=
ld
> > errors.
> >
> > To properly detect clang, invoke the compiler with -v and check the out=
put.
> > The first line should start with "clang version ...".
> >
> > Committer testing:
> >
> >   $ make CC=3Dclang-9 O=3D/tmp/build/perf -C tools/perf install-bin
> >   <SNIP>
> >   $ readelf -wi /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gn=
u.so | grep DW_AT_producer | head -1
> >     <c>   DW_AT_producer    : (indirect string, offset: 0x0): clang ver=
sion 9.0.1 (Fedora 9.0.1-2.fc31) /usr/bin/clang-9 -Wno-unused-result -Wsign=
-compare -D DYNAMIC_ANNOTATIONS_ENABLED=3D1 -D NDEBUG -O2 -g -pipe -Wall -W=
error=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS=
 -fexceptions -fstack-protector-strong -grecord-command-line -m64 -mtune=3D=
generic -fasynchronous-unwind-tables -fcf-protection=3Dfull -D _GNU_SOURCE =
-fPIC -fwrapv -Wbad-function-cast -Wdeclaration-after-statement -Wformat-se=
curity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes=
 -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wred=
undant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Ww=
rite-strings -Wformat -Wshadow -D HAVE_ARCH_X86_64_SUPPORT -I /tmp/build/pe=
rf/arch/x86/include/generated -D HAVE_SYSCALL_TABLE_SUPPORT -D HAVE_PERF_RE=
GS_SUPPORT -D HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror -O3 -fno-omit-fr=
ame-pointer -ggdb3 -funwind-tables -Wall -Wextra -std=3Dgnu99 -fstack-prote=
ctor-all -D _FORTIFY_SOURCE=3D2 -D _LARGEFILE64_SOURCE -D _FILE_OFFSET_BITS=
=3D64 -D _GNU_SOURCE -I /home/acme/git/perf/tools/lib/perf/include -I /home=
/acme/git/perf/tools/perf/util/include -I /home/acme/git/perf/tools/perf/ar=
ch/x86/include -I /home/acme/git/perf/tools/include/ -I /home/acme/git/perf=
/tools/arch/x86/include/uapi -I /home/acme/git/perf/tools/include/uapi -I /=
home/acme/git/perf/tools/arch/x86/include/ -I /home/acme/git/perf/tools/arc=
h/x86/ -I /tmp/build/perf//util -I /tmp/build/perf/ -I /home/acme/git/perf/=
tools/perf/util -I /home/acme/git/perf/tools/perf -I /home/acme/git/perf/to=
ols/lib/ -D HAVE_PTHREAD_ATTR_SETAFFINITY_NP -D HAVE_PTHREAD_BARRIER -D HAV=
E_EVENTFD -D HAVE_GET_CURRENT_DIR_NAME -D HAVE_GETTID -D HAVE_DWARF_GETLOCA=
TIONS_SUPPORT -D HAVE_GLIBC_SUPPORT -D HAVE_AIO_SUPPORT -D HAVE_SCHED_GETCP=
U_SUPPORT -D HAVE_SETNS_SUPPORT -D HAVE_LIBELF_SUPPORT -D HAVE_LIBELF_MMAP_=
SUPPORT -D HAVE_ELF_GETPHDRNUM_SUPPORT -D HAVE_GELF_GETNOTE_SUPPORT -D HAVE=
_ELF_GETSHDRSTRNDX_SUPPORT -D HAVE_DWARF_SUPPORT -D HAVE_LIBBPF_SUPPORT -D =
HAVE_BPF_PROLOGUE -D HAVE_SDT_EVENT -D HAVE_JITDUMP -D HAVE_DWARF_UNWIND_SU=
PPORT -D NO_LIBUNWIND_DEBUG_FRAME -D HAVE_LIBUNWIND_SUPPORT -D HAVE_LIBCRYP=
TO_SUPPORT -D HAVE_SLANG_SUPPORT -D HAVE_GTK2_SUPPORT -D NO_LIBPERL -D HAVE=
_TIMERFD_SUPPORT -D HAVE_LIBPYTHON_SUPPORT -D HAVE_CPLUS_DEMANGLE_SUPPORT -=
D HAVE_LIBBFD_SUPPORT -D HAVE_ZLIB_SUPPORT -D HAVE_LZMA_SUPPORT -D HAVE_ZST=
D_SUPPORT -D HAVE_LIBCAP_SUPPORT -D HAVE_BACKTRACE_SUPPORT -D HAVE_LIBNUMA_=
SUPPORT -D HAVE_KVM_STAT_SUPPORT -D DISASM_FOUR_ARGS_SIGNATURE -D HAVE_LIBB=
ABELTRACE_SUPPORT -D HAVE_AUXTRACE_SUPPORT -D HAVE_JVMTI_CMLR -I /tmp/build=
/perf/ -fPIC -I util/include -I /usr/include/python3.7m -c /home/acme/git/p=
erf/tools/perf/util/python.c -o /tmp/build/perf/python_ext_build/tmp/home/a=
cme/git/perf/tools/perf/util/python.o -Wbad-function-cast -Wdeclaration-aft=
er-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarati=
ons -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-d=
efinition -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -=
Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wshadow -D HAVE_ARCH_X86_64_=
SUPPORT -I /tmp/build/perf/arch/x86/include/generated -D HAVE_SYSCALL_TABLE=
_SUPPORT -D HAVE_PERF_REGS_SUPPORT -D HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET =
-Werror -O3 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall -Wextra -s=
td=3Dgnu99 -fstack-protector-all -D _FORTIFY_SOURCE=3D2 -D _LARGEFILE64_SOU=
RCE -D _FILE_OFFSET_BITS=3D64 -D _GNU_SOURCE -I /home/acme/git/perf/tools/l=
ib/perf/include -I /home/acme/git/perf/tools/perf/util/include -I /home/acm=
e/git/perf/tools/perf/arch/x86/include -I /home/acme/git/perf/tools/include=
/ -I /home/acme/git/perf/tools/arch/x86/include/uapi -I /home/acme/git/perf=
/tools/include/uapi -I /home/acme/git/perf/tools/arch/x86/include/ -I /home=
/acme/git/perf/tools/arch/x86/ -I /tmp/build/perf//util -I /tmp/build/perf/=
 -I /home/acme/git/perf/tools/perf/util -I /home/acme/git/perf/tools/perf -=
I /home/acme/git/perf/tools/lib/ -D HAVE_PTHREAD_ATTR_SETAFFINITY_NP -D HAV=
E_PTHREAD_BARRIER -D HAVE_EVENTFD -D HAVE_GET_CURRENT_DIR_NAME -D HAVE_GETT=
ID -D HAVE_DWARF_GETLOCATIONS_SUPPORT -D HAVE_GLIBC_SUPPORT -D HAVE_AIO_SUP=
PORT -D HAVE_SCHED_GETCPU_SUPPORT -D HAVE_SETNS_SUPPORT -D HAVE_LIBELF_SUPP=
ORT -D HAVE_LIBELF_MMAP_SUPPORT -D HAVE_ELF_GETPHDRNUM_SUPPORT -D HAVE_GELF=
_GETNOTE_SUPPORT -D HAVE_ELF_GETSHDRSTRNDX_SUPPORT -D HAVE_DWARF_SUPPORT -D=
 HAVE_LIBBPF_SUPPORT -D HAVE_BPF_PROLOGUE -D HAVE_SDT_EVENT -D HAVE_JITDUMP=
 -D HAVE_DWARF_UNWIND_SUPPORT -D NO_LIBUNWIND_DEBUG_FRAME -D HAVE_LIBUNWIND=
_SUPPORT -D HAVE_LIBCRYPTO_SUPPORT -D HAVE_SLANG_SUPPORT -D HAVE_GTK2_SUPPO=
RT -D NO_LIBPERL -D HAVE_TIMERFD_SUPPORT -D HAVE_LIBPYTHON_SUPPORT -D HAVE_=
CPLUS_DEMANGLE_SUPPORT -D HAVE_LIBBFD_SUPPORT -D HAVE_ZLIB_SUPPORT -D HAVE_=
LZMA_SUPPORT -D HAVE_ZSTD_SUPPORT -D HAVE_LIBCAP_SUPPORT -D HAVE_BACKTRACE_=
SUPPORT -D HAVE_LIBNUMA_SUPPORT -D HAVE_KVM_STAT_SUPPORT -D DISASM_FOUR_ARG=
S_SIGNATURE -D HAVE_LIBBABELTRACE_SUPPORT -D HAVE_AUXTRACE_SUPPORT -D HAVE_=
JVMTI_CMLR -I /tmp/build/perf/ -fno-strict-aliasing -Wno-write-strings -Wno=
-unused-parameter -Wno-redundant-decls
>=20
> Sorry for not speaking up sooner, but if you don't want to include
> that mass of command line options above, I generally check which
> toolchain has been used to produce a binary via:
> $ readelf --string-dump=3D.comment <foo>
> which may be more concise, but sometimes we strip out the `.comment`
> section from binaries.

Well, this doesn't produce what I needed, see:

[root@five ~]# readelf --string-dump=3D.comment /tmp/build/perf/python/perf=
=2Ecpython-37m-x86_64-linux-gnu.so

String dump of section '.comment':
  [     0]  GCC: (GNU) 9.2.1 20190827 (Red Hat 9.2.1-1)

[root@five ~]#

See the part below, where I need to look at what compiler flags were
used to build the python build, like -fcf-protection.

- Arnaldo

=20
> >   $
> >
> > And here is how tools/perf/util/setup.py checks if the used clang has
> > options that the distro specific python extension building compiler
> > defaults:
> >
> >   if cc_is_clang:
> >       from distutils.sysconfig import get_config_vars
> >       vars =3D get_config_vars()
> >       for var in ('CFLAGS', 'OPT'):
> >           vars[var] =3D sub("-specs=3D[^ ]+", "", vars[var])
> >           if not clang_has_option("-mcet"):
> >               vars[var] =3D sub("-mcet", "", vars[var])
> >           if not clang_has_option("-fcf-protection"):
> >               vars[var] =3D sub("-fcf-protection", "", vars[var])
> >           if not clang_has_option("-fstack-clash-protection"):
> >               vars[var] =3D sub("-fstack-clash-protection", "", vars[va=
r])
> >           if not clang_has_option("-fstack-protector-strong"):
> >               vars[var] =3D sub("-fstack-protector-strong", "", vars[va=
r])
> >
> > So "-fcf-protection=3Dfull" is used, clang-9 has this option and thus it
> > was kept, the perf python extension was built with it and the build
> > completed successfully.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/903
> > Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Igor Lubashev <ilubashe@akamai.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: clang-built-linux@googlegroups.com
> > Link: http://lore.kernel.org/lkml/20200309085618.14307-1-ilie.halip@gma=
il.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/setup.py | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > index aa344a163eaf..8a065a6f9713 100644
> > --- a/tools/perf/util/setup.py
> > +++ b/tools/perf/util/setup.py
> > @@ -2,11 +2,13 @@ from os import getenv
> >  from subprocess import Popen, PIPE
> >  from re import sub
> >
> > +cc =3D getenv("CC")
> > +cc_is_clang =3D b"clang version" in Popen([cc, "-v"], stderr=3DPIPE).s=
tderr.readline()
> > +
> >  def clang_has_option(option):
> > -    return [o for o in Popen(['clang', option], stderr=3DPIPE).stderr.=
readlines() if b"unknown argument" in o] =3D=3D [ ]
> > +    return [o for o in Popen([cc, option], stderr=3DPIPE).stderr.readl=
ines() if b"unknown argument" in o] =3D=3D [ ]
> >
> > -cc =3D getenv("CC")
> > -if cc =3D=3D "clang":
> > +if cc_is_clang:
> >      from distutils.sysconfig import get_config_vars
> >      vars =3D get_config_vars()
> >      for var in ('CFLAGS', 'OPT'):
> > @@ -40,7 +42,7 @@ class install_lib(_install_lib):
> >  cflags =3D getenv('CFLAGS', '').split()
> >  # switch off several checks (need to be at the end of cflags list)
> >  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unuse=
d-parameter', '-Wno-redundant-decls' ]
> > -if cc !=3D "clang":
> > +if not cc_is_clang:
> >      cflags +=3D ['-Wno-cast-function-type' ]
> >
> >  src_perf  =3D getenv('srctree') + '/tools/perf'
> > --
> > 2.21.1
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/clang-built-linux/20200309185323.22583-4-acme%40kernel.org.
>=20
>=20
>=20
> --=20
> Thanks,
> ~Nick Desaulniers

--=20

- Arnaldo
