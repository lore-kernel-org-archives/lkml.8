Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4D2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED4C2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262834;
	bh=sN4L9Gs8QE+27ACgGqSkv9n0S8W8q73V5o460r4ndmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=brjE43KoToEis+Td0JriOa6lWQ/bvK9gle2gFML9/CAnP7qfMOxDTosv0KGM69ecT
	 EMKsOF7iJ+Hpm6oMCYE/7oRCmOY0tM9XvFjeAsGcedKhgoVOdKGrIYzcARPQ77DsNP
	 OBIlkxwHBS9LsUJ9Uc+NmtsrHjzH4TW/kO4GdISE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgHXJxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:53:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40006 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbgHXJxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:53:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id 185so8889663ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qOI6mgVQsXhswtlh+nRMl8mcplOyzJ4EGRwszMJYGjM=;
        b=qK1IJ1W9M6+pV+wvL4VdHvINvkpSTPys4qbga1Km8XRzAoFi8gKkPqNS8TvZlNn628
         Dx/BVQg9h9PTy/iJHHH0oSECgIn35Sa2Bn/bz+BlqkQRGVsevPvTzSSmvOwdHhrAAs+u
         +TK5bIOKPQFg6n9FwoelePda79oRyqF6hmaeyKfCAIowdvD4Nq5u/9ubKxIIj2Kc12sH
         TdtQ6RThCQKuG2HnJ4salBGsFLoePL8cvTQl0YX/EAjzGklfykGMo6h4Z8fQ6QjFzEBy
         638DhGcWMFAjb0TejG/mBDkW7kg9BG+r+6NCnx32emTQaKecYU+N6heGt68et2Eeywr2
         PpNA==
X-Gm-Message-State: AOAM530xx7QalzbkjhYjQVcJr1gSJwx/FR6E1Bf04aaj4w6H4VzXebs0
        bYESF0OR3HAxy38EGIvOjAtyMMYqMHwu5A==
X-Google-Smtp-Source: ABdhPJyy66+vEw++oLjQgv0kaWO8AV+ZPKIu0F9ZCAyuasppszI3aZ47UuuFXlVUmwZl3bBX5+8gQw==
X-Received: by 2002:a2e:9852:: with SMTP id e18mr2304273ljj.415.1598262824449;
        Mon, 24 Aug 2020 02:53:44 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id y13sm2079944ljd.19.2020.08.24.02.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 02:53:43 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kA9Ac-0000Ey-KF; Mon, 24 Aug 2020 11:53:43 +0200
Date:   Mon, 24 Aug 2020 11:53:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/greybus/es2.c:439 message_send() error: double unlocked
 'es2->cport_out_urb_lock' (orig line 417)
Message-ID: <20200824095342.GF21288@localhost>
References: <202008140324.LLig4g2M%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008140324.LLig4g2M%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 03:26:27AM +0800, kernel test robot wrote:
> Hi Greg,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dc06fe51d26efc100ac74121607c01a454867c91
> commit: b81beec9cb2d586412c7166c893894930f19965e staging: greybus: move es2 to drivers/greybus/
> date:   12 months ago
> config: x86_64-randconfig-m001-20200813 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> New smatch warnings:
> drivers/greybus/es2.c:439 message_send() error: double unlocked 'es2->cport_out_urb_lock' (orig line 417)
> drivers/greybus/es2.c:879 cport_out_callback() error: double unlocked 'es2->cport_out_urb_lock' (orig line 871)
> drivers/greybus/es2.c:1018 arpc_sync() error: double unlocked 'es2->arpc_lock' (orig line 992)
> 
> Old smatch warnings:
> drivers/greybus/es2.c:441 message_send() error: double unlocked 'es2->cport_out_urb_lock' (orig line 439)

None of these warnings make any sense. Is the robot drunk?

> vim +439 drivers/greybus/es2.c
> 
> d29b3d631e57240 drivers/staging/greybus/es2.c    Alex Elder         2015-06-13  385  
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  386  /*
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  387   * Returns zero if the message was successfully queued, or a negative errno
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  388   * otherwise.
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  389   */
> 2537636abae5b81 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-03  390  static int message_send(struct gb_host_device *hd, u16 cport_id,
> 7cf7bca9ec5659e drivers/staging/greybus/es2.c    Johan Hovold       2015-04-07  391  			struct gb_message *message, gfp_t gfp_mask)
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  392  {
> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  393  	struct es2_ap_dev *es2 = hd_to_es2(hd);
> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  394  	struct usb_device *udev = es2->usb_dev;
> 7cf7bca9ec5659e drivers/staging/greybus/es2.c    Johan Hovold       2015-04-07  395  	size_t buffer_size;
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  396  	int retval;
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  397  	struct urb *urb;
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  398  	unsigned long flags;
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  399  
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  400  	/*
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  401  	 * The data actually transferred will include an indication
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  402  	 * of where the data should be sent.  Do one last check of
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  403  	 * the target CPort id before filling it in.
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  404  	 */
> 144670c2ae3f9b4 drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  405  	if (!cport_id_valid(hd, cport_id)) {
> 100e90000840741 drivers/staging/greybus/es2.c    Johan Hovold       2015-12-07  406  		dev_err(&udev->dev, "invalid cport %u\n", cport_id);
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  407  		return -EINVAL;
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  408  	}
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  409  
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  410  	/* Find a free urb */
> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  411  	urb = next_free_urb(es2, gfp_mask);
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  412  	if (!urb)
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  413  		return -ENOMEM;
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  414  
> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  415  	spin_lock_irqsave(&es2->cport_out_urb_lock, flags);
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  416  	message->hcpriv = urb;
> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27 @417  	spin_unlock_irqrestore(&es2->cport_out_urb_lock, flags);

How is this a double unlock?

> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  418  
> d29b3d631e57240 drivers/staging/greybus/es2.c    Alex Elder         2015-06-13  419  	/* Pack the cport id into the message header */
> d29b3d631e57240 drivers/staging/greybus/es2.c    Alex Elder         2015-06-13  420  	gb_message_cport_pack(message->header, cport_id);
> 491e60d63fde0a9 drivers/staging/greybus/es2.c    Johan Hovold       2015-04-07  421  
> 821c620afa1ad29 drivers/staging/greybus/es2.c    Alex Elder         2015-06-13  422  	buffer_size = sizeof(*message->header) + message->payload_size;
> 491e60d63fde0a9 drivers/staging/greybus/es2.c    Johan Hovold       2015-04-07  423  
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  424  	usb_fill_bulk_urb(urb, udev,
> 606addd2847ccc5 drivers/staging/greybus/es2.c    Alexandre Bailon   2015-06-15  425  			  usb_sndbulkpipe(udev,
> 403074b50b66f1a drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  426  					  es2->cport_out_endpoint),
> 821c620afa1ad29 drivers/staging/greybus/es2.c    Alex Elder         2015-06-13  427  			  message->buffer, buffer_size,
> 7cf7bca9ec5659e drivers/staging/greybus/es2.c    Johan Hovold       2015-04-07  428  			  cport_out_callback, message);
> 977e209ab41073d drivers/staging/greybus/es2.c    Alexandre Bailon   2015-08-31  429  	urb->transfer_flags |= URB_ZERO_PACKET;
> 495787a792ac498 drivers/staging/greybus/es2.c    Alex Elder         2016-06-03  430  
> 495787a792ac498 drivers/staging/greybus/es2.c    Alex Elder         2016-06-03  431  	trace_gb_message_submit(message);
> 495787a792ac498 drivers/staging/greybus/es2.c    Alex Elder         2016-06-03  432  
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  433  	retval = usb_submit_urb(urb, gfp_mask);
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  434  	if (retval) {
> 05e3095563670ab drivers/staging/greybus/es2.c    Viresh Kumar       2016-06-23  435  		dev_err(&udev->dev, "failed to submit out-urb: %d\n", retval);
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  436  
> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  437  		spin_lock_irqsave(&es2->cport_out_urb_lock, flags);
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  438  		message->hcpriv = NULL;
> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27 @439  		spin_unlock_irqrestore(&es2->cport_out_urb_lock, flags);
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  440  
> 4b1d82047ebbb10 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  441  		free_urb(es2, urb);
> d29b3d631e57240 drivers/staging/greybus/es2.c    Alex Elder         2015-06-13  442  		gb_message_cport_clear(message->header);
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  443  
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  444  		return retval;
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  445  	}
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  446  
> 3e136cc9e05e1a3 drivers/staging/greybus/es2.c    Johan Hovold       2015-07-01  447  	return 0;
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  448  }
> f587027e793cf89 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  449  
> 
> :::::: The code at line 439 was first introduced by commit
> :::::: 4b1d82047ebbb108e9961fffd51f8ccd54459221 greybus: es2: rename es2 data structures
> 
> :::::: TO: Alex Elder <elder@linaro.org>
> :::::: CC: Greg Kroah-Hartman <gregkh@google.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Johan
