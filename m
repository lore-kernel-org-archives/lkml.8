Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DFAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6422071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YryXzqT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgHYISH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgHYIR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:17:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4ECC061574;
        Tue, 25 Aug 2020 01:17:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so1274122wme.4;
        Tue, 25 Aug 2020 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zEFfvA2kHwjuvhR3Qz6nkbsxorcU/wr3Elf4vtaspII=;
        b=YryXzqT2z2b/ohM1i+A1G9iTyVisdOicIRL6ywEH8JvdOgS92NZjWJ0PPrzIavBINj
         j3t9HAkeiv99v241TrXsAihavrCvI8zTL+yyN64iEr2Ip0TKgGH4sZk/Y4vh0QUu5hH7
         Dzye6Bj63WqyHrdIMHCseZojYoz2QkSr0RKERwUr+4nojOOttD7BwD1oJ5jXV9bVdiFE
         xNs7kD3x1jdg6wIrcpIJFTIDGw2jmxRlQCM9C38tkpdUzk+qyKmsrVDiuGJ51c8XGbyV
         E/sIp6hnNGWABWO+ebNGunoJFnNBgt1nAWgxg3aeoqnWk06i1DstFewiErHwX9RojyWm
         PVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zEFfvA2kHwjuvhR3Qz6nkbsxorcU/wr3Elf4vtaspII=;
        b=cgu+wRJTkUUcsqetWjS5Qiul+JrpldwPcaQSSMffKPdzI++3NJqjsjCM/sA3KG6t06
         3h47a+mOUPZCj0VfdjWjVgJeFAz/LnwCnZbaAyGNXI7qNOFbonintZlDSMDsLDYgQiSK
         8ZuOA+dWFeqAYMBBahweCO2s3F86E1AoCois7qR/ZHAVLVrAjvvzQAMh8Mr3sr93dd1K
         a4ce4MBL3G9Qjg0Xm36OiTP4guT+Ct227zA7PGvmdAQ1A7aLCz3hBslhKvtMn+hxjrZc
         KiZElo6AnaCZk5eHBYtEPhsRL2TXE9JUGRPOckXvQtDRUd282uq0UaBOsBc20EEVK3E4
         MLHg==
X-Gm-Message-State: AOAM532BpyqZuoigCA3iEqH/Cc9dL1uuNQzkbRIYAZz0kCJJTXe85k5u
        Tf2/kONtxGAIWYPUmP6bLX4=
X-Google-Smtp-Source: ABdhPJyBNz/akXKtnS93s6DuFveM+sB5KYPVWADdLttJekfGdyWoHpoO8pfV2rUwqiPMVVgOSt+82A==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr912400wmh.56.1598343474830;
        Tue, 25 Aug 2020 01:17:54 -0700 (PDT)
Received: from lenovo-laptop (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id a7sm4014284wmj.24.2020.08.25.01.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 01:17:54 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Tue, 25 Aug 2020 09:17:52 +0100
To:     David Laight <David.Laight@aculab.com>
Cc:     'Alex Dewar' <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "accessrunner-general@lists.sourceforge.net" 
        <accessrunner-general@lists.sourceforge.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Message-ID: <20200825081752.hj3zyhg2qumzd64n@lenovo-laptop>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <3e882693bb344424af37d4d35f3db605@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e882693bb344424af37d4d35f3db605@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 08:12:05AM +0000, David Laight wrote:
> From: Alex Dewar
> > Sent: 24 August 2020 23:23
> > kernel/cpu.c: don't use snprintf() for sysfs attrs
> > 
> > As per the documentation (Documentation/filesystems/sysfs.rst),
> > snprintf() should not be used for formatting values returned by sysfs.
> > 
> > In all of these cases, sprintf() suffices as we know that the formatted
> > strings will be less than PAGE_SIZE in length.
> 
> Hmmmm....
> I much prefer to see bounded string ops.
> sysfs really ought to be passing through the buffer length.
> The buffer size should probably be SYSFS_BUF_LEN not PAGE_SIZE
> (even it happens to typically be the same).
> If PAGE_SIZE is big (or small) passing a 4k buffer may be
> more appropriate than a PAGE_SIZE one.
> 
> 	David

We could use scnprintf() instead I guess. But an expression like:
	return sprintf(buf, "%d\n", value);
will never overflow if buf is PAGE_SIZE, right...?

> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
