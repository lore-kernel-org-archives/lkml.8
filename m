Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CCAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E72A20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590042650;
	bh=/cC5x4W6BS0MOmDGqZzvZ7KCSvL+xawPIr2kMiP/xZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oXKi3DQneaih7DmgJukI7o85dxj9YB5m8imxefJs4SQhL3yVhHEN4RMyvIKujpMgx
	 3nn4sah3DIf09MjtBGbIC8gQAELxcsyrRWXH7Bc+TPJVSq0oNLuPLA+du/t3uCw+OW
	 lzK+A5KlzPN39L4lWBluioK8JO7yeUXZZTiukkRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEUGat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:30:49 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:35888 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEUGat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:30:49 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 04L6UNnM023913
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:30:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 04L6UNnM023913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590042625;
        bh=ZNZchnsPv2Z9/h2IVHZD/AcHEXB3gMAJ+aGdK0lUMJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xvmu9frey4CNjeD2SFCpLzoodafBIF5/bN6R3j0aQ+YKkyTdq/CC4WK7a/9nSadEi
         gALSfefL0wxknFF+DuUgM9tBOwnK/Nt7+BWek1b4A5xzmnL0x0o9lcWoTnVBB36ZAe
         cYSYwIls/R0fzhj1RcRUCMVs9CMN7rYEhEU/mUvJu8JfuQOwtHETj91sKVhEWa0Qjd
         TzalB5RtqPHKLhkuXu4ctDT9Iqa0nINXodsjBbAiitjQUkc4E+3nDsaFMY26xZouSi
         KogmXMp8miI/obVbwUIOzZsOrVG7oVFNgWmL6RkGiXPfmbxmOxeWhjkGLwDVZewo2C
         BH+vIL5B5qLng==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id i5so2229006uaq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:30:23 -0700 (PDT)
X-Gm-Message-State: AOAM5310RFynbhWlrOlAiFcgs2GtSCl9nlNLwON6c9rU0RkUTcvW+h4G
        xwIxSd5X/Q+6raAhqNDaWbQcF6vN7c2swtSEzBY=
X-Google-Smtp-Source: ABdhPJxYLh4OnhKax3w8NrWHceKikpZJcwrRGzppLZ8LRARPwHfCFf57aZzTXUXRooE2btzQaSfEMyvH/stt8qf/Vuc=
X-Received: by 2002:ab0:7298:: with SMTP id w24mr6227920uao.95.1590042622632;
 Wed, 20 May 2020 23:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR-t1ToAGf-4FTa+2=ii+WcTD3aFjyZOADQT9rkagKyBw@mail.gmail.com>
 <20200514170945.24964-1-xujialu@vimux.org>
In-Reply-To: <20200514170945.24964-1-xujialu@vimux.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 21 May 2020 15:29:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxFonn+VWHMZb4wgjMNOe_T=ExU3=bk5uG0v-ZNYVe2w@mail.gmail.com>
Message-ID: <CAK7LNARxFonn+VWHMZb4wgjMNOe_T=ExU3=bk5uG0v-ZNYVe2w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] scripts: Support compiled source, improved precise
To:     xujialu <xujialu@vimux.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 2:10 AM xujialu <xujialu@vimux.org> wrote:
>
> Sorry for replying so late.
>
> <snip>
>
> I usually don't run scripts/tags.sh directly. But one day i checked git
> log of scripts/tags.sh, and found this commit c69ef1c87b8c said we may
> run it directly. Then i must took care of that.
>
> Here are some cases that i should write clearly before:
> (I omit COMPILED_SOURCE=3D1 here just for clear and distinct)
>
> 1) make; make gtags;
> 2) make; ./scripts/tags.sh gtags;
> 3) make O=3D123; make O=3D123 gtags;
> 4) make O=3D123; make gtags;
> 5) make O=3D123; ./scripts/tags.sh gtags;
> 6) make O=3D/path/out/of/kernel/; make O=3D/path/out/of/kernel/ gtags;
> 7) make O=3D/path/out/of/kernel/; SOMETHING ./scripts/tags.sh gtags;
>
> Assume that we just change directory into kernel root directory and vim
> a source file:
>
> case 1): We have GTAGS generated in current directory, no problem;
>                 In this case: tree=3D
> case 2): Same as case 1), no problem;
>                 In this case: tree=3D

... if you set SRCARCH.

If SRCARCH is unset, it will get a warning.

$ ./scripts/tags.sh  gtags
find: =E2=80=98arch/*.[chS]/=E2=80=99: No such file or directory




> case 3): GTAGS is generated in directory 123; Here comes the problem,
>          gtags will give error "Segmentation fault" (eg. global-5.7.1)
>          or give warnning "is out of source tree." (eg. global-6.6.3-2)
>          because 'make O=3D123' changed to directory 123 and our cute
>          source files is in ../ and gtags seems do not like this path
>          begin with '../', actually it's not an subdiretories for 123;
>          If above situation is not persuasive, then consider one may
>          want generate gtags.files contains files without '../' in
>          kernel root directory, so that gtags could be useful;
>          And this is why case 4) exist, if case 4) is really bad idea
>          then we must have another way to do this - case 5);
>                 In this case: tree=3D../


This is a problem of GNU Global, not of our build system.


"Warning: ... is out of source tree." is listed in
the known bugs:

https://www.gnu.org/software/global/bugs.html


Do not mess up our script.


> case 4): This is not good when we 'make O=3D123 distclean';
>                 In this case: tree=3D../



Of course, "make O=3D123 distclean" cannot clean up
build artifacts created by "make gtags".

So, what problem are you addressing?



> case 5): Find file '.config' in directory 123, then collect files with
>          path just in current directly; No problem;
>                 In this case: tree=3D../

You are misunderstanding.

See the comment at line 8.

# Uses the following environment variables:
# SUBARCH, SRCARCH, srctree


If you want to run this script directly,
you must set all the mentioned environment variables correctly,
and also run this script in the correct working directory.

It will create tag files in the current working directory.
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^

Do not change the working directory internally.





> case 6): What if KBUILD_OUTPUT is out of kernel directory? Assume that
>          we get a gtags.files in that directly, in the gtags.files, the
>          file path all begin with full path, guess what, gtags will give
>          the error or warnning described above. Why don't we just
>          generate GTAGS with relative path in kernel root directory?
>                 In this case: tree=3D/path/out/of/kernel/

This is the intended behavior for the other TAGS, tags, cscope.

Again, this is a problem of GNU global.


The general rule is like this:

Tag files should be always output to the separate object tree
if O=3D is given, then file paths should point to the source
tree with either relative or absolute paths.

This is because the source tree is not always writable.
The source tree might be delivered in a DVD-ROM, read-only mounted nfs,
or located under /usr/src/ which is installed by distro source package.




>
> >
> > +       SRCTREE=3D$(realpath ${tree}.)
> > +
> > +       cd $(dirname $(find -name .config -print -quit).)
> >
> > Why is this needed?
>
> In case 5), the path of source files collected in .cmd files is some
> begin with '../' and some with full path, eg. /usr/include/stdio.h, we
> must change to directory 123 as 'make O=3D123 gtags' does so that we coul=
d
> use same method (described bellow) in both cases.

No.
scripts/tags.sh must be run in the object tree in this case.

5) make O=3D123; cd 123; ../scripts/tags.sh srctree=3D.. SRCARCH=3Dx86 gtag=
s




> > Why is --relative-to=3D${SRCTREE} needed?
> >
> > You are dropping ${SRCTREE} and adding ${ABSPWD}${tree}.
> > I do not understand what this is doing back-and-forth.
>
> These .cmd files also contain the default include dir (eg.
> /usr/include/stdio.h) and even compiler's header files, try make
> ARCH=3Darm.


I know. Probably, that would not happen
because the following patch is queued up.
https://patchwork.kernel.org/patch/11505807/




> We should first collect files with path relative to SRCTREE (which is
> kernel root directory), then we kick out the files which path begin with
> '../' by using sed, and then add ${tree} back:
>
>         realpath --relative-to=3D${SRCTREE} $(find ...) |
>         sed -e "/\.\./d" -e "s,^,${tree},"
>
> Now following code seems good enough:
>
> SRCTREE=3D$(realpath ${tree}.)
>
> cd $(dirname $(find -name .config -print -quit).)
>
> realpath -e --relative-to=3D${SRCTREE} $(find -name "*.cmd" -exec \
>         grep -Poh '(?(?=3D^source_.* \K).*|(?=3D^  \K\S).*(?=3D \\))' {} =
\+ |
>         awk '!a[$0]++') include/generated/autoconf.h |
> sed -e "/\.\./d" -e "s,^,${tree}," | sort -u
>
> What if one want a gtags.files with fullpath:
>
> 'make COMPILED_SOURCE=3D1 KBUILD_ABS_SRCTREE=3D1 gtags' is good, and for
> running scripts/tags.sh directly, i add this ABSPWD there.
>
>         COMPILED_SOURCE=3D1 ABSPWD=3D$PWD/ ./scripts/tags.sh gtags
>
> <snip>
>
> Let's get back to case 6) and consider case 7), we now should tell
> scripts/tags.sh that where is KBUILD_OUTPUT, then i added another
> OUTPATH for that:
>
>         OUTPATH=3D/path/to/KBUILD_OUTPUT ./scripts/tags.sh gtags;
>
> Now we have this code:
>
> SRCTREE=3D$(realpath ${tree}.)
>
> cd $(dirname $(find ${OUTPATH} -name .config -print -quit).)
>
> realpath -e --relative-to=3D${SRCTREE} $(find -name "*.cmd" -exec \
>         grep -Poh '(?(?=3D^source_.* \K).*|(?=3D^  \K\S).*(?=3D \\))' {} =
\+ |
>         awk '!a[$0]++') ${OUTPATH}include/generated/autoconf.h |
> sed -e "/\.\./d" -e "s,^,${ABSPWD}${tree}," | sort -u
>
> But this is the real rare use-case, we should forget about it.
>
> > Please do not introduce a new variable ABSPWD, which is unneeded.
> > This is a rare use-case, but if you want to run this script directly,
> > you must set the variables described at line 9 properly.
>
> Usages i wrote has been deleted. ABSPWD has been added at line 9.
> Maybe we could make it a secret to kbuild system cause it's just useful
> for running scripts/tags.sh directly.
>
> > > +       # Consider 'git ls-files' features:
> > > +       #   1) sort and uniq target files
> > > +       #   2) limit target files by index
> > > +       # git ls-files $(xtags_juggle_list)
> >
> > How is this related to this ?
>
> This useless comment has been deleted. I just thought maybe it's useful
> for someone who wants to make these codes better. Actually git ls-files
> takes too much time.
>
> <snip>
>
> Following is something about gtags.files.
>
> > And, the reason is described here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D3D1948
> > So, scope.files has a good reason to exist.
> > gtags.files does not.
>
> I did a 'make cscope' test without cscope.files on Monday, same error as
> the reason described.
>
> Before that, I thought cscope.files is just for convenience when someone
> want to check which files were compiled, do 'vim cscope.files' to get an
> overview of these files and it's easy to go into a source file from vim,
> especially now we could get a percise cscope.files as [patch 1/2] said.
>
> The latest release date of cscope is 2012-08-04, then i tried gtags
> which is growing up, even though cscope works better than gtags in some
> case. For convenience described above, i tried to add a gtags.files.
> But now, let's forget it for a while. :)



I see bad engineering overall, and
it is breaking
f81b1be40c44b33b9706d64c117edd29e627ad12

So, this is NACK.



--
Best Regards
Masahiro Yamada
