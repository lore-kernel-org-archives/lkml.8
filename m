Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F17C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8FB2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+PUf4/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDGSOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:14:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33559 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:14:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay1so1557162plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PeiZnJCEZqQc3Rqpk45c1lEucyFQ8/zMMdEk9YtKXts=;
        b=Y+PUf4/ItL0F+5y8tsRBf+kNreItmx9FrKwi5SiANr06qTw66OGN+bynO38NPjRCxF
         dXLfvMaQcQxA4gXWi5uboU6rC8p1zSePp59K/vOjX1o6XWPy+1620KI7YA22wae9JRsX
         KxEoRF8kdPb6y8ddg7dfVOwafjoUKtI0tZLmOaEunAqjoNKTNyRgtD74+rT2t/JwGye+
         siU98mSYL3CG+KWPIzD/1F2vSrkqtl2Vauwv+IdVhin9oCylWjSxWx5bR5TExnuqTSTL
         UIuWTmq6jv0kWnTgqKj/pxd0f/sZZWusq7acyEGXLPMI34hFInfYFj1Kjvj7VbMjVD5j
         O5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PeiZnJCEZqQc3Rqpk45c1lEucyFQ8/zMMdEk9YtKXts=;
        b=aPYQxatBvB0WWatAgVTHGfHVtT7sCbxS2lDkQ688ieoQCFDn+/35Awwk1CbK0YoDjZ
         eYV5r26MN8tRMa+af9K2dI3MyZPDstw7IpPbtqlYX5g38qT8KoJtdBHZcZu6XdWF4KVK
         Y6nDV5WGZP6+D/m573u/GKkzYV21DQnLjRlZBsn9hq5ja1sdkS4ZCNw8XZsZQ2xJ+4+S
         wRORx2nZh8sSeL0P6X91s7ROl4kpdolz7S/oIYoysjRCEyHKGlSH522a0mz01c97EU4j
         sWXdaieP9ccrg4x6cIlAp8/xOmWlQPTmKCQ6Big2oQ4HwMnrfpTDs+OrxPfdkzwYYpTo
         gOwQ==
X-Gm-Message-State: AGi0PuYJq6c/jQC4ZQdb2ShcdL1W5vMU/M4B0T8b3rh/u+GKblElo++m
        WO2DQLiNW7/F0PaOlcnn4KXdCDfqBms9PcLoH7sQ9A==
X-Google-Smtp-Source: APiQypJKouIIKhONDkOghKTAW34SOEQnio5T0ysv+Iu/ELxMBu4fc4dVDMgQPcZZE3yIw33w58OEv/qC/oYsouUrQM0=
X-Received: by 2002:a17:90a:8085:: with SMTP id c5mr568939pjn.186.1586283241410;
 Tue, 07 Apr 2020 11:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <29b5043db9a51ef7a0cb6e3a8c69c91e36045cd6.1585944770.git.mirq-linux@rere.qmqm.pl>
 <202004050928.d6QhVcsQ%lkp@intel.com>
In-Reply-To: <202004050928.d6QhVcsQ%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Apr 2020 11:13:50 -0700
Message-ID: <CAKwvOdm5BhMdAmXR0gCLntkbvF7ajaNoWoHVCCio1CqbGzS6aQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] power: supply: core: tabularize HWMON
 temperature labels
To:     kbuild test robot <lkp@intel.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 6:53 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi "Micha=C5=82,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on power-supply/for-next]
> [also build test WARNING on hwmon/hwmon-next linus/master v5.6 next-20200=
404]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Micha-Miros-aw/extension=
s-and-fixes/20200405-044024
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-s=
upply.git for-next
> config: x86_64-randconfig-b002-20200405 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 62f3=
a9650a9f289a07a5f480764fb655178c2334)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER=3Dclang make.cross ARCH=3Dx86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/power/supply/power_supply_hwmon.o: warning: objtool: power_sup=
ply_hwmon_read_string() falls through to next function power_supply_hwmon_w=
rite()

I'm guessing this is from the unreachable:
https://github.com/0day-ci/linux/commit/b8b2d14ca46ca54257f55c9af58ea25695b=
9ee36
I'll need to play with this some more as I couldn't reproduce with a
simplified test case, but looks like a compiler bug.  Filed
https://github.com/ClangBuiltLinux/linux/issues/978 for me to track.

--=20
Thanks,
~Nick Desaulniers
