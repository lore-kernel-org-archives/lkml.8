Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D599AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BE9207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598339455;
	bh=dQMacCg8yIXojo4mdVO7miSHLYj4KBh3hibTEc08+zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QlzO0uVyfL9qFHT02Xz8iM8aPF5ASSw8RY6mkfOCMLgQUh6tox2w7eNz1THPNDu+1
	 u4bzAuHIrIaIMNXDKQ1MjY+mvNcd+apRpdAYg0u2/77HtPtLtRL0Ba2jc7pMtXPd7R
	 bYJkh2Il8M0xMNMvpjGVH1CFdbjkjDlgLULfOoxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgHYHKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:10:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33935 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbgHYHKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:10:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id y2so12585391ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=13DBrasR/HMQi1VXerJktw4SUoBsPx8Gxf47XLucXZ4=;
        b=dW/8Pz7tUd8DrqORGgE2x9FbxD1RDu2sCCv1ld4lTq3LG6iluANURAKRU2juDsMvJr
         CH8BxyVS3ChXsseYeVhgqaUwMsz1hte/3YT9c8faru8Pe5bULNz/L2+Knp6pIatx6bF2
         V6YZeLuVXw46M4tggEvtqV1H5N5GSqRvn4+I4tTAXY+FiPMxAOMki+U0H2D6Sulz4dNJ
         TLkuczpR1Ea47KGdSWxdJJG6nOXd5MaEZcuj8GkOgcgIyMt1ChOzZ0FlZQuebhlQ0x2y
         OQSm8EK+rf9WpyZBb0a+0DjRA/qQVPyZDv9U96O7K6WW7cNb3oaGUBrJGCxIMnWQZogI
         8KPQ==
X-Gm-Message-State: AOAM5308OackkhBJIy6vk3k4rIiU1TKFW3yoMtTg1P3/AF+hMC1qujfC
        V+Ry+lCjRhJXDkpw7kkEdCA=
X-Google-Smtp-Source: ABdhPJwpW3nVy8rSZ/XTgJxeNKkUfHuYSSISVfNtwMCNetYiPHb45HHVTGFmuR7pyI19V5IpOEJ92Q==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr3873846lja.17.1598339444993;
        Tue, 25 Aug 2020 00:10:44 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h7sm2636230ljc.75.2020.08.25.00.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 00:10:44 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kAT6R-00032T-Bv; Tue, 25 Aug 2020 09:10:43 +0200
Date:   Tue, 25 Aug 2020 09:10:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Xia, Hui" <hui.xia@intel.com>
Cc:     Johan Hovold <johan@kernel.org>, lkp <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-all] Re: drivers/greybus/es2.c:439 message_send() error:
 double unlocked 'es2->cport_out_urb_lock' (orig line 417)
Message-ID: <20200825071043.GJ21288@localhost>
References: <202008140324.LLig4g2M%lkp@intel.com>
 <20200824095342.GF21288@localhost>
 <MWHPR11MB1613967593B79A01BE785F03E5570@MWHPR11MB1613.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MWHPR11MB1613967593B79A01BE785F03E5570@MWHPR11MB1613.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:37:04AM +0000, Xia, Hui wrote:
> >-----Original Message-----
> >From: Johan Hovold <johan@kernel.org>
> >Sent: 2020年8月24日 17:54
> >To: kernel test robot <lkp@intel.com>
> >Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; kbuild-all@lists.01.org;
> >linux-kernel@vger.kernel.org
> >Subject: [kbuild-all] Re: drivers/greybus/es2.c:439 message_send() error: double
> >unlocked 'es2->cport_out_urb_lock' (orig line 417)
> >
> >On Fri, Aug 14, 2020 at 03:26:27AM +0800, kernel test robot wrote:
> >> Hi Greg,
> >>
> >> First bad commit (maybe != root cause):
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   dc06fe51d26efc100ac74121607c01a454867c91
> >> commit: b81beec9cb2d586412c7166c893894930f19965e staging: greybus:
> >move es2 to drivers/greybus/
> >> date:   12 months ago
> >> config: x86_64-randconfig-m001-20200813 (attached as .config)
> >> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> New smatch warnings:
> >> drivers/greybus/es2.c:439 message_send() error: double unlocked
> >> 'es2->cport_out_urb_lock' (orig line 417)
> >> drivers/greybus/es2.c:879 cport_out_callback() error: double unlocked
> >> 'es2->cport_out_urb_lock' (orig line 871)
> >> drivers/greybus/es2.c:1018 arpc_sync() error: double unlocked
> >> 'es2->arpc_lock' (orig line 992)
> >>
> >> Old smatch warnings:
> >> drivers/greybus/es2.c:441 message_send() error: double unlocked
> >> 'es2->cport_out_urb_lock' (orig line 439)
> >
> >None of these warnings make any sense. Is the robot drunk?

> It is a false positive. Please kindly ignore.
> There was a bug in robot that sent unconfident reports out directly
> and has been fixed. Sorry for inconvenient.

Ok, thanks for confirming.

Johan
