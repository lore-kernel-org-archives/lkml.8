Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8DC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475122053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588060378;
	bh=8IWPpUph0MluIpXFKr7pn9ptLovWIoIypwp458MMOpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l5CBOuWpnlCFuxaZrIgnaOYtskUXt9kLfBq3RXCU00xpa3JS42MkuqQArfvLoIKur
	 lrmbuPsPKnDC65Dc/ClBg9oIysJ1LmwwY2y75fcsHQ3cxRm8uKHB9aA1wFqj04RGVN
	 wi+RtdmqBHsfv0xhxWOkyrO2amOmgXfIerIza05s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgD1Hw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:52:57 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:25769 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD1Hwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:52:54 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 03S7qc6L011853
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:52:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 03S7qc6L011853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588060359;
        bh=QPAQvrairyv/g99zYJPMQ7WDBrdaFd2bW853qF/5aXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=weNGx2Z6XS22im/pq2oCo5m4ZGkjz8I6CaacYx34oPH/F0fcfs4tQmQg0YKNLqQy0
         E3jeQgZrr+7lp8hJ7D0A1s2fBFDrfO3C696AmbP7raL6yn3Elj9cPJNL0eOwR/ohM4
         9Ku3EZj2XI5yPnj2zzYnXLSazlNklCTtH5Q8/WrPOIqRQB16cz0Rolto0tWmqisGBy
         VyIJWJ4Qr6UivZSvpHdj9FEKM/4i2TNbpDks/VBcW2T5FKoZJs2SbOle6eez2idkt2
         TL0vpcH0B2aIWM/B9nHbqLcZ+359ObscbHcnVMX/+1fCi5W7qfwktuetTP5QVOVO3i
         /3w1Tk6RuZQpQ==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id b6so6609399uak.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:52:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuaH7mxTv9T7KIMEXjwzLG8mUJR/blGXTa9LjaBreV+7w0RYNAxl
        yV7KoOQAFm1Yf/EdzkDk/wIqshgz8wRXtWB+8Tw=
X-Google-Smtp-Source: APiQypJb1/OJIWgvmQ4YLflHEvxCw5scmVMbfuEMCiQcthiRE4P93Oeyk61i9y3G9miJ3m+3ZNzrMfNEvCp9s68eGo4=
X-Received: by 2002:ab0:cd:: with SMTP id 71mr18483445uaj.109.1588060357644;
 Tue, 28 Apr 2020 00:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200425080343.GA2048673@kroah.com> <20200426024436.7534-1-xujialu@vimux.org>
In-Reply-To: <20200426024436.7534-1-xujialu@vimux.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Apr 2020 16:52:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS3P2uCOnE3zX59QKOg7SgtS25j-1VXdHE32vrDyCA2_A@mail.gmail.com>
Message-ID: <CAK7LNAS3P2uCOnE3zX59QKOg7SgtS25j-1VXdHE32vrDyCA2_A@mail.gmail.com>
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
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

On Sun, Apr 26, 2020 at 11:48 AM xujialu <xujialu@vimux.org> wrote:
>
> Add a script to generate a more precise gtags.files from *.cmd files.
>
> For navigating linux sources, it will be more efficient if gtags/cscope
> just collects source files that needed for compilation. The kernel
> makefiles already create *.cmd files that contain the files we needed,
> then just extracts files list from them and into gtags.files cause it's
> the the default name list file for gtags.


This is unneeded.

scripts/tags.sh supports COMPILED_SOURCE=1
to collect tags only from compiled sources.

Please do not reinvent the wheel
to achieve similar things.


$ time make COMPILED_SOURCE=1 gtags
  GEN     gtags

real 0m7.623s
user 0m7.459s
sys 0m1.124s


is fine for me.

If the existing code is problematic,
we need to improve it,
not add the second one.





>
> make defconfig
> make
> scripts/gtags_files_generator.sh
> gtags [-f gtags.files]
>
> Enjoy with vim+gtags. :)
>
> Here is a log for comparison with 'make gtags':
>
> $ time make ARCH=arm cscope
>   GEN     cscope
>
> real    1m20.600s
> user    1m36.004s
> sys     0m8.192s
> $ wc -l cscope.files
> 31201 cscope.files              #collected too many files we don't care
>
> $ time ./scripts/gtags_files_generator.sh
>
> Succeed, 3716 gtags.files listed!
>
> real    0m1.593s                #collected files only we care
> user    0m1.704s
> sys     0m0.256s
>                                 #collected also dts and dtsi


Why do you need to collect dts and dtsi?







> $ grep dts gtags.files
> arch/arm/boot/dts/xxxxxx-clocks.dtsi
> arch/arm/boot/dts/xxxxxx.dtsi
> arch/arm/boot/dts/xxxxxxxx.dts
> arch/arm/boot/dts/xxxxxxxx.dtsi
>
> Signed-off-by: xujialu <xujialu@vimux.org>
> ---
>  scripts/gtags_files_generator.sh | 48 ++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100755 scripts/gtags_files_generator.sh
>
> diff --git a/scripts/gtags_files_generator.sh b/scripts/gtags_files_generator.sh
> new file mode 100755
> index 000000000000..04698d9234a7
> --- /dev/null
> +++ b/scripts/gtags_files_generator.sh
> @@ -0,0 +1,48 @@
> +#!/bin/bash -e
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Author: xujialu <xujialu@vimux.org>
> +#
> +# A script for generating gtags.files after compilation.
> +#
> +# Usage:
> +#      make defconfig
> +#      make
> +#      scripts/gtags_files_generator.sh
> +#      gtags [-f gtags.files]
> +
> +
> +gtags_files_list()
> +{
> +       ls ${AUTOCONF_H} $(realpath -e --relative-to=. \
> +               $(find ${KBUILD_OUTPUT} -name "*$1.cmd" -exec \
> +               grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
> +               awk '!a[$0]++' | sed "s,^,${KBUILD_OUTPUT},") |
> +               sed -e '/\.\./d' | awk '!a[$0]++'
> +       )
> +}
> +
> +gtags_files_generator()
> +{
> +       GTAGS_FILES=$PWD/gtags.files
> +
> +       echo && [ $# = 1 ] && cd $1
> +
> +       SYSTEM_MAP=$(find -name System.map -print -quit)
> +
> +       [ -z "${SYSTEM_MAP}" ] && echo "Failed, please compile first!" && exit 1
> +
> +       KBUILD_OUTPUT=${SYSTEM_MAP%/*}/
> +       KBUILD_OUTPUT=${KBUILD_OUTPUT#*/}
> +
> +       AUTOCONF_H=${KBUILD_OUTPUT}include/generated/autoconf.h
> +
> +       grep Configuration ${AUTOCONF_H} | sed 's/ \* //'
> +       gtags_files_list > ${GTAGS_FILES}
> +
> +       echo && [ $# = 1 ] && sed -i "s|^|$1|" ${GTAGS_FILES}
> +
> +       echo "Succeed, $(wc -l ${GTAGS_FILES}) listed!"
> +}
> +
> +gtags_files_generator $1 2>/dev/null
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
