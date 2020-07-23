Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60EDC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E7C2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595506587;
	bh=UNqWfI54Zzp8Bm0/XGgDYLPyYHmBM47wWOIS1MfTtQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qF98flOiz1ndY+DbpdG76cpA5KKAL6N26ZmUYu2U/JJWm7YZO/+bs+02+LtywUIiu
	 2FA1xxEFkdN1jKphVFHbWXqP9CbHRqgRMvNtjvmbf94MVL+t4IenMvKkybdypMg92a
	 q/CbX+EgS2Dp4VKfgOQaXm/4bIB/kYQp5Nf7n2bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgGWMQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:16:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41476 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:16:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id z24so6067761ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXSNifhnmAevcl+qoQ0rGriRJG6GoQW9AnC2B+nYPSc=;
        b=kozKyuGNWeM7pg9rUUprVloG09rfKhXRE3tsopL3P9AuH7sjVHp2QHqJWpReoRg6Mk
         p9DKr2pdzBd3JbE5awhRQC6RijRFpQd/CeyW8m3/xiZl6RiZFALt+BzVNV/84rapy8+i
         7U1MXL8BV/EoJWr/KIO3Pye5hJU8psXWGflr0fU4PwQuYPEBR/hfpNbmzk+hNgycRMxE
         TQfyw/Gjqf3Pls59PPC1g5gUowau0G0W0tlfBtOZnEcAkeSznrMEb9ZUxfcCZIcjcw2X
         0Wym8lyyc+VQ0MVzg+lP/ui9u8NHsvQ2/owrGGSK93T1IzVzkSyKsgJESlTBdfFQVx8j
         G7QA==
X-Gm-Message-State: AOAM532dpFJF57+aJQ1apjXr1FIWzCe8UEbxcg2+SE96NDSA8ZMthbkg
        le2uvCMgdld2ELo9FuxpGaA=
X-Google-Smtp-Source: ABdhPJwihvFeWJLJu4uJij/sMUa6bc50EByXo5yU4m9UwYuHmLIYz2j+oW33SbLRqu3gRBenU7txFg==
X-Received: by 2002:a2e:9dd6:: with SMTP id x22mr1927124ljj.199.1595506583863;
        Thu, 23 Jul 2020 05:16:23 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v25sm2574883ljg.95.2020.07.23.05.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:16:23 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jya93-0006Kc-HO; Thu, 23 Jul 2020 14:16:17 +0200
Date:   Thu, 23 Jul 2020 14:16:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Johan Hovold <johan@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: drivers/tty/serial/pmac_zilog.c:255:36: sparse: sparse: context
 imbalance in 'pmz_receive_chars' - unexpected unlock
Message-ID: <20200723121617.GM3634@localhost>
References: <202007231701.CV9tyb31%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007231701.CV9tyb31%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 05:29:14PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d15be546031cf65a0fc34879beca02fd90fe7ac7
> commit: 08d5470308ac3598e7709d08b8979ce6e9de8da2 serial: core: fix sysrq overhead regression
> date:   4 weeks ago
> config: m68k-randconfig-s032-20200723 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-93-g4c6cbe55-dirty
>         git checkout 08d5470308ac3598e7709d08b8979ce6e9de8da2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/tty/serial/pmac_zilog.c:255:36: sparse: sparse: context imbalance in 'pmz_receive_chars' - unexpected unlock

This warning is far from new, but let's add the missing annotation
nonetheless:

	https://lore.kernel.org/r/20200723121423.24217-1-johan@kernel.org

Johan
