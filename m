Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D827DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C17207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgEVNlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:41:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42479 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:41:09 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MA7Ss-1jmcIw0XRS-00Bdz4 for <linux-kernel@vger.kernel.org>; Fri, 22 May
 2020 15:41:08 +0200
Received: by mail-qk1-f177.google.com with SMTP id s1so10670499qkf.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 06:41:07 -0700 (PDT)
X-Gm-Message-State: AOAM532GCYngrtTRPkRC2imhzbm5/J+DT/P4MMRO4FHGN8WUTlzl0JTb
        QB4bKo6sEDxgvVyOJd4z1cJwVr4Qq+ttnHdRrkg=
X-Google-Smtp-Source: ABdhPJw72qhJPEgqVT822Ql1yOjxUpdjhgdyA43vHIIc+PFmMM5PlNa1cswOMyKH99k/7OpAjlei5e3PHIhIIS38+EM=
X-Received: by 2002:a37:4c48:: with SMTP id z69mr14161951qka.138.1590154867026;
 Fri, 22 May 2020 06:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <202005222050.mkKQBFyc%lkp@intel.com>
In-Reply-To: <202005222050.mkKQBFyc%lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 May 2020 15:40:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3AvVuf6ADizEg6twExf_QwJarJ-1E7BUWUb7=Sw1e0Dw@mail.gmail.com>
Message-ID: <CAK8P3a3AvVuf6ADizEg6twExf_QwJarJ-1E7BUWUb7=Sw1e0Dw@mail.gmail.com>
Subject: Re: drivers/ide/ide-ioctls.c:15:24: sparse: sparse: incorrect type in
 initializer (different address spaces)
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Hutchings <bwh@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0WAKCR2FNzlPGK3NxlGiYUv9t51jhtzaoSm70Fg5NY+60PozpLY
 oRHoUdb0AD2nBmeJiitUVNllVe33SsNG4fp3UQdOqFbozLqvg6xDuXqWsjx8TMPHxAkQsER
 P6WmFMcwTyuAzxLOhNNFhkdiEIwycZpOBuuKsJuZW2LXKglkzkyf5dbVtp+CHVE4RRurdAs
 /nDGlPriyAtjD9endVvzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rRoahcFYX3g=:VcglX4I/ZbiSAInO2pFXVa
 0yHrM1pQcTFbSN9eqPFhYoJnxnT8q6HZirVdbfjrxVdrozdlQNXMYBP4LnxlKgR851RWp2/39
 2N/DgX4of2QjYmkXd+nJ6OLZDfiFQVMQzhmDlQjrV35kF1RMorqt6fTw8SMrzxJ4+kBu+K6Wl
 74n1M5sUvphKgueyMZugZK4xGmV3EjUrYj/RG+mvVbSqSSIeJwdZLtOkMLDqBdWwraTUlmojJ
 4fmYj4xX26SL5J/4Q2hSLUhjRJ7uKfhNNiA1n3drbRA5AheXlVW7mabDYoHF6lNpPy2zABV2M
 /8pBjSseFiumXihGPEvSJ7XSTANOfXAQ7XH30hZXy/QOd+M6OLhiH3iYk7LkMOBU5GEzBKM/l
 L6d+nuRe4/4yeAvGXvja8M422L21TbEDjNJqlBnYbFPDDRngoumafTMF+Gwg0SnGKXhWl8SX+
 WZimleGpz6846jgl0mkvbk77+CowjHpTviGomKwIkTYTFTmbJUC2M5p1Eo/03+iyvP0HNATxm
 9a8+9LaiP0jyex9jY5Mk9cG4OQaxWyet80CfmNX33aQ66VT7/gLJps4HfIyI/kbSvkFEcOLJC
 4w83KZ/u8OxltmI+hern/t1PPyT3tSThrlkQH86DNgO1Lx4fWwZ9RavmQdCHFzTlHpiWDqWp6
 RYYITx3K9YGQvopCWGDwQCl3ZuI6hbREH5ZgOnl6A4wM1aSFLl1UJeoDP5nHtvOGIRClsaCU0
 smdEihUsaCGJS1JUuwDJLl6SHnOGdyh0fIxRGzhFVi4TjgOZSPhBikKMr3/I2mdd8Qe/6sYE0
 mOPSjPgeeqc6TnAbmN66LgaXe0jWtCKxIzK9YIBAW9RQEYO3/Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 2:24 PM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   051143e1602d90ea71887d92363edd539d411de5
> commit: 1df23c6fe5b0654ece219985a0c32e40b100bd9a compat_ioctl: move HDIO ioctl handling into drivers/ide
> date:   5 months ago
> config: xtensa-randconfig-s002-20200522 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-193-gb8fad4bc-dirty
>         git checkout 1df23c6fe5b0654ece219985a0c32e40b100bd9a
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=xtensa CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>    ./arch/xtensa/include/generated/uapi/asm/unistd_32.h:391:41: sparse: sparse: no newline at end of file
> >> drivers/ide/ide-ioctls.c:15:24: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected signed int *__pu_addr @@    got signed int [noderef] [usertypsigned int *__pu_addr @@
> >> drivers/ide/ide-ioctls.c:15:24: sparse:    expected signed int *__pu_addr
> >> drivers/ide/ide-ioctls.c:15:24: sparse:    got signed int [noderef] [usertype] <asn:1> *
> >> drivers/ide/ide-ioctls.c:15:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:1> *to @@    got f] <asn:1> *to @@
>    drivers/ide/ide-ioctls.c:15:24: sparse:    expected void [noderef] <asn:1> *to
> >> drivers/ide/ide-ioctls.c:15:24: sparse:    got signed int *__pu_addr


I think this is a bug in the xtensa asm/uaccess.h, but I don't know why it
only showed up now.

>    drivers/ide/ide-ioctls.c:17:16: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected long *__pu_addr @@    got long [noderef] <aslong *__pu_addr @@
>    drivers/ide/ide-ioctls.c:17:16: sparse:    expected long *__pu_addr
>    drivers/ide/ide-ioctls.c:17:16: sparse:    got long [noderef] <asn:1> *
>    drivers/ide/ide-ioctls.c:17:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void [noderef] <asn:1> *to @@    got n:1> *to @@
>    drivers/ide/ide-ioctls.c:17:16: sparse:    expected void [noderef] <asn:1> *to
>    drivers/ide/ide-ioctls.c:17:16: sparse:    got long *__pu_addr

This looks like an old bug in the ide driver, unrelated to my patch.

     Arnd
