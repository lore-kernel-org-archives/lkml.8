Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F3EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF5120768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595507854;
	bh=74nsSEGTQlxHCQroHp1QhmDj8lEC7XVNAOzfwUfuaxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h05R0hjtHVn6sYpbNV6VAkkIMVUY1EAC2RIect0vDDf4Liz93gIdQFd7Dr+lxmK6x
	 r4lXG5SnKYC9Cai8xkWaaSufETmNYR9i4PYVmLzZ4hDUtBr2JnTQ5BHDUcEQ8ftkbW
	 o+Puu1N0ElH6qsy5pvkKd0JTuEcOx5kpcKMd89NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGWMhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:37:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40289 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:37:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id j11so6149633ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TbdqUjGoPs4mHIRTk4dFCt8/crXquSHYgZzaX/f+u2c=;
        b=m5qUryj9CuBt1afOA6sS18Km83K+5zgJKtOKdWErq1zAUSKAqfLgYCjQ4bJyqQqx7u
         kcjugS+1d3+E6xOcrCAt8UZ0t88wi7q3n/A5lieRYz+bgIinMaEMIFUXz09YTTLQ8DPo
         vq4T5M0sF5XAlw4GozwENHNH9T2IH67Nss+wz2xZot3VdBw9VBo8oLY60gT7m5+dF4h/
         yqlmBOUlRLV/i6IUrqXhML9KH4ttELyincLHv+WPp+Aj8E/FE1itIXYyyT7F7TINirzL
         C1l1TDwGzidCNd9j3f6kh63/ILy/qH767jGAnDndUJeMjopbnQLhCBWzlzNvJMJCA6yq
         YXRg==
X-Gm-Message-State: AOAM532vWZnbk2zyUrMe/Rqze67L4c3TltJzx68aw60UyLPVhY2V6xqZ
        2mFkKPX0acT4m+BPhQOFUwU=
X-Google-Smtp-Source: ABdhPJyNDFL7vCZUil6J39elv3735RWn6rd4BszPfg5NmqP4oM4ed3sOJ0cRTN4fXG5Q0KIG7iS8ww==
X-Received: by 2002:a2e:9810:: with SMTP id a16mr1755491ljj.157.1595507850412;
        Thu, 23 Jul 2020 05:37:30 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v5sm2633942lji.75.2020.07.23.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:37:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jyaTU-0001pi-29; Thu, 23 Jul 2020 14:37:24 +0200
Date:   Thu, 23 Jul 2020 14:37:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: drivers/tty/serial/pmac_zilog.c:255:36: sparse: sparse: context
 imbalance in 'pmz_receive_chars' - unexpected unlock
Message-ID: <20200723123724.GN3634@localhost>
References: <202007231701.CV9tyb31%lkp@intel.com>
 <20200723121617.GM3634@localhost>
 <CAHp75VeXh0vsydRay1a3uBP2kSsr6bNV7bT=vgCS7CSSRYT1mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeXh0vsydRay1a3uBP2kSsr6bNV7bT=vgCS7CSSRYT1mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:26:54PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 23, 2020 at 3:19 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Jul 23, 2020 at 05:29:14PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   d15be546031cf65a0fc34879beca02fd90fe7ac7
> > > commit: 08d5470308ac3598e7709d08b8979ce6e9de8da2 serial: core: fix sysrq overhead regression
> > > date:   4 weeks ago
> > > config: m68k-randconfig-s032-20200723 (attached as .config)
> > > compiler: m68k-linux-gcc (GCC) 9.3.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.2-93-g4c6cbe55-dirty
> > >         git checkout 08d5470308ac3598e7709d08b8979ce6e9de8da2
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > >
> > > sparse warnings: (new ones prefixed by >>)
> > >
> > > >> drivers/tty/serial/pmac_zilog.c:255:36: sparse: sparse: context imbalance in 'pmz_receive_chars' - unexpected unlock
> >
> > This warning is far from new,
> 
> I suspect it's a new sparse and kbuildbot that decided to unveil old sins.

Possibly.

> > but let's add the missing annotation
> > nonetheless:
> >
> >         https://lore.kernel.org/r/20200723121423.24217-1-johan@kernel.org
> 
> Feel free to add Reviewed-by: Andy Shevchenko
> <andy.shevchenko@gmail.com> to them.

Thanks, and sorry I missed this before sending a v2 with the missing
ampersands added. It's better if you reply to the cover letter so Greg's
tooling will pick it up:

	https://lore.kernel.org/r/20200723123327.5843-1-johan@kernel.org

Johan
