Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9BFC47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490F92070B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589251943;
	bh=a61Umy7M6kHj5wgaBbb2sAVsz4OJ7Y948cNr917SORw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xJ3v3T6b8fByryY7NpeA1iQ3feGrBii8orEvceZ6EbmWLui5rIsUo16WkSqi4Q7FS
	 9m/tkpEfZnbhaVhXDsHfuXkvunfV+sM6LAMU/jk4BckGh155Y9aPf3JW7KX1YqWh6K
	 /835RZ0LTx39wC49UTU2rXhrnzrOfQfbOctpdMXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgELCwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:52:22 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49524 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgELCwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:52:22 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 04C2q4VB018851
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:52:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 04C2q4VB018851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589251925;
        bh=/dP1/+gVU934yq2ykxBJRp/L7Knp7DBZvFbITFJXeug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H4eCgm9aPnNCyO/lE2noclXrw6/4Wc8eIb02C0d4UwQx8uV86rIrciTJ8v9KC/NWZ
         h0z7KMbivSt008b4gmLyVTWEBW4u3F8npc3yIVFNTBxcJOOT9GRoxqAvuMLKnWZv8f
         xA/q6cUF9P8KGUKZ4zAJ82Kdj5yh6pbGjYq5bm3XLXvwo3G8t5VidSXApKO3+1JlAe
         CnZUFBHDB4eYzZf7TP6ELGSgXSJ/tNfgxrDI9svG4d0Cr5+HpWBZ5WVjgoPvJ1YFqF
         xFGtz0lIj8dSN5eRJ/xlS9Z0G274zjVlLuEJYnl/U0zCULYgZM1l1Uz3gIyiDAjg7T
         D2SBCa75Xf28w==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id z1so6959759vsn.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 19:52:04 -0700 (PDT)
X-Gm-Message-State: AOAM532zxtxJO0VNA60h7dN2J2OjTqAp2clCMH9lVVYjNSdHr+81kB7N
        dmHV8dwRlVpc3ffX7SqzHGd27lgy4aBB9cDkQ30=
X-Google-Smtp-Source: ABdhPJwOHvmc3TCk/eY55ytF1r9uMVxx5MgfvfLKamD3C4LDNNmyYuubhdGMLE2xOuvBW/i6rbPFgAN+TGVhadUX+GA=
X-Received: by 2002:a67:d00e:: with SMTP id r14mr3160729vsi.215.1589251923295;
 Mon, 11 May 2020 19:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200428070614.GB992660@kroah.com> <20200502052619.26457-1-xujialu@vimux.org>
 <20200502052619.26457-2-xujialu@vimux.org>
In-Reply-To: <20200502052619.26457-2-xujialu@vimux.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 May 2020 11:51:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-t1ToAGf-4FTa+2=ii+WcTD3aFjyZOADQT9rkagKyBw@mail.gmail.com>
Message-ID: <CAK7LNAR-t1ToAGf-4FTa+2=ii+WcTD3aFjyZOADQT9rkagKyBw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] scripts: Support compiled source, improved precise
To:     xujialu <xujialu@vimux.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 2:27 PM xujialu <xujialu@vimux.org> wrote:
>
> Original 'COMPILED_SOURCE=1 make cscope' collects nearly 30000 files
> include too many unused files, this patch precisely collects source
> files from *.cmd, in this case just 3000 files include dts and dtsi.
>
> Usage:
>   1) COMPILED_SOURCE=1                           make {cscope,gtags}
>   2) COMPILED_SOURCE=1 KBUILD_ABS_SRCTREE=1      make {cscope,gtags}
>   3) COMPILED_SOURCE=1              ./scripts/tags.sh {cscope,gtags}
>   4) COMPILED_SOURCE=1 ABSPWD=$PWD/ ./scripts/tags.sh {cscope,gtags}
>
> Signed-off-by: xujialu <xujialu@vimux.org>
> ---
>  scripts/tags.sh | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 4e18ae5282a6..941a5c61d343 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -89,22 +89,30 @@ all_sources()
>         find_other_sources '*.[chS]'
>  }
>
> +# COMPILED_SOURCE=1                           make {cscope,gtags}
> +# COMPILED_SOURCE=1 KBUILD_ABS_SRCTREE=1      make {cscope,gtags}
> +# COMPILED_SOURCE=1              ./scripts/tags.sh {cscope,gtags}
> +# COMPILED_SOURCE=1 ABSPWD=$PWD/ ./scripts/tags.sh {cscope,gtags}


These comment are misleading since this sounds like
is is only usef for cscope, gtags.


Please do not introduce a new variable ABSPWD, which is unneeded.
This is a rare use-case, but if you want to run this script directly,
you must set the variables described at line 9 properly.




> +xtags_juggle_list()
> +{
> +       SRCTREE=$(realpath ${tree}.)
> +
> +       cd $(dirname $(find -name .config -print -quit).)


Why is this needed?

You are already in objtree
when this script is being run.

If you handle the objects built with O= option,
you need to do 'make O=... gtags'.

> +
> +       realpath -e --relative-to=${SRCTREE} $(find -name "*.cmd" -exec \
> +               grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
> +               awk '!a[$0]++') include/generated/autoconf.h |
> +       sed -e "/\.\./d" -e "s,^,${ABSPWD}${tree},"
> +}

Why is --relative-to=${SRCTREE} needed?

You are dropping ${SRCTREE} and adding ${ABSPWD}${tree}.
I do not understand what this is doing back-and-forth.



Lastly, the file order is currently carefully crafted
but this patch would make it random-ordered.

I am afraid the following commit would be broken.




commit f81b1be40c44b33b9706d64c117edd29e627ad12 (HEAD)
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Mon Feb 8 00:25:59 2010 +0100

    tags: include headers before source files

    Currently looking up a structure definition in TAGS / tags takes one to
    one of multiple "static struct X" definitions in arch sources, which makes
    it for many structs practically impossible to get to the required header.
    This patch changes the order of sources being tagged to first scan
    architecture includes, then the top-level include/ directory, and only
    then the rest. It also takes into account, that many architectures have
    more than one include directory, i.e., not only arch/$ARCH/include, but
    also arch/$ARCH/mach-X/include etc.

    Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
    Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>
    [mmarek@suse.cz: fix 'var+=text' bashism]
    Signed-off-by: Michal Marek <mmarek@suse.cz>

> +
>  all_compiled_sources()
>  {
> -       for i in $(all_sources); do
> -               case "$i" in
> -                       *.[cS])
> -                               j=${i/\.[cS]/\.o}
> -                               j="${j#$tree}"
> -                               if [ -e $j ]; then
> -                                       echo $i
> -                               fi
> -                               ;;
> -                       *)
> -                               echo $i
> -                               ;;
> -               esac
> -       done
> +       # Consider 'git ls-files' features:
> +       #   1) sort and uniq target files
> +       #   2) limit target files by index
> +       # git ls-files $(xtags_juggle_list)


How is this related to this ?






> +
> +       xtags_juggle_list | sort -u
>  }
>
>  all_target_sources()
> --
> 2.20.1
>


--
Best Regards
Masahiro Yamada
