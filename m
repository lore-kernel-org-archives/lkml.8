Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5FFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F154206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ne8qy7BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGXJhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXJhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:37:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34570C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:37:42 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b30so4843709lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TQWChaGcld1X+jt6TSrRbT5d69VNh8YdsaNVfKXJuY=;
        b=Ne8qy7BB6Y/7TKH1bliOs0RBd4vcuED8WeR396vymk9sAlufq/RXK9OvvOAOKekoT6
         pXymUgec0ISJT7TxLDIWTVDVglo9UcgR20dy/VLWWRY17kxHMlGG60UdnM0I48wQ9jeu
         fQUfUKlgsF2GuEOdu2DjPttH7ZNLTM7bwMDv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TQWChaGcld1X+jt6TSrRbT5d69VNh8YdsaNVfKXJuY=;
        b=kdJ1ZTeK0Y7sTcs2z+TC9fG9kTpn3cnWCqG+zScyMX1UI0Giz/wU8TiApVS11OQu6p
         U/g0J9F5mrst4AK0ZpGmqS8zya3mQNagY+8FNeq9xv7yQp4+ZHpdjt8VtPPH1CkrQqd2
         C9FL1UCtRhGFnCjvSL/2troLjnXFmvJvsZUT39oMj92alcjIiXrcqbFT9smwASsaES9L
         lLEyiOsdA4sdpHxnmOaHVVyOe8w5IuGOFtxQ6DRLnNrBrR08lvxKFse5kpF3ONEXecE4
         rsvHXuogmGJ3KCPidfql8q7WTeWlA0jiEzA3KLjBN0UAK2bmsIcLNJA5iaxwYoEJk72A
         QU8Q==
X-Gm-Message-State: AOAM533vQHUV8k/yuOWR5katc/BOkcP2z77GNyRPU8dFko9XDMT0ZCZA
        cgVBb7S85mRHDjCJvwEmHBFDx39E8bsYkcIG+WBWjw==
X-Google-Smtp-Source: ABdhPJxFM2by9Dsl4Q00h1MKaIBnGcQKERhBxfp23nVMGa9arHxE0+0yVNbsFcgbMzInjHlHpismO9fhP/Cla8ZD8DI=
X-Received: by 2002:ac2:5f81:: with SMTP id r1mr4508456lfe.168.1595583460497;
 Fri, 24 Jul 2020 02:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200717090155.10383-1-rayagonda.kokatanur@broadcom.com>
 <20200717090155.10383-3-rayagonda.kokatanur@broadcom.com> <20200723202053.GD908@ninjato>
In-Reply-To: <20200723202053.GD908@ninjato>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Fri, 24 Jul 2020 15:07:28 +0530
Message-ID: <CAHO=5PEeek5EiXk3ZAmXPFRQ4xKF4e3z-pe6Yq9t4iV+7AUJYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: iproc: add slave pec support
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        Robert Richter <rrichter@marvell.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 1:50 AM Wolfram Sang <wsa@kernel.org> wrote:
>
>
> > +     /* Enable partial slave HW PEC support if requested by the client */
> > +     iproc_i2c->en_s_pec = !!(slave->flags & I2C_CLIENT_PEC);
> > +     if (iproc_i2c->en_s_pec)
> > +             dev_info(iproc_i2c->device, "Enable PEC\n");
>
> Where do you set the I2C_CLIENT_PEC flag for the slave? Is your backend
> code publicly available?

I2C_CLIENT_PEC should be set by backend before calling i2c_slave_register() ie

client->flags |= I2C_CLIENT_PEC;
ret = i2c_slave_register(client, i2c_slave_eeprom_slave_cb);
------
------
------

My backend code is not yet publicly available.

>
> I may need a second thought here, but I am not sure I2C_CLIENT_PEC is
> the right way to enable PEC. Isn't it actually depending on the backend
> if PEC is needed? I.e. is the backend an I2C device or an SMBus device?
>
Yes, it depends on the backend. If backend is SMBUS device and
supports PEC then it should set client->flags |= I2C_CLIENT_PEC,
before calling i2c_slave_register(), so that the slave bus driver will
enable PEC in device.

Best regards,
Rayagonda
