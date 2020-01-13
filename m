Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0D0C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CC6207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578929051;
	bh=XUhFU2WK3EqPyXllO3fnnsmfHvN5+iVSVuWuQ2Is24Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NmwexpzkOe06lrXlMlH6krerfaRbvfmyrKwuZ9Tht91LmTwjWz1L49lWsOTDDrXOv
	 uVhdG/E9lfqy1BWR6BJy1wXKWD+QUoIbNHhYG7XUdq1wEhKoQ5IUPGGMeCvvxSEtd1
	 cgFS3qDzU8++agQc5ZiOcr4Pb42wsUelhfEHaw0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAMPYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:24:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39784 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:24:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so10509865lja.6;
        Mon, 13 Jan 2020 07:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JePuBeBt6EnoL+3kn/xgq5rquMyVPay3z8pk7Z13gvY=;
        b=USZdufscWmBeBgPByQ8G8/YHOBB9WKd10y9b5KoVh7QEf5nGUgL/VpnW0VyM6GlntE
         vzU8bCvIwZzphaZTr0AOiSERedHLpnfRS/LgFeF3CRoPStu+x2eOPLWyDOvUx66w3bqI
         1Q3mcbyvelRnyd1EZ2ac3L+Sowq8QU75ukVjE2aP656j+b/yxCDlFgl5V22UZkX3+Wce
         v/bFGfbdLQ79jbzLrxcycP/NZ4i7CSRhITafwtWea+pa8RMxw7slRN0XDylj66Pg0zUk
         kHOFLINvHS3FHfLrdlpeB9moVsL0hk8O49ldo+ZwoZs7qvKns1nxWTmqcBaZpf+xS+Pa
         acbA==
X-Gm-Message-State: APjAAAX0iizRFjd2P0G+Nw3aDD1Tstqa6QOT+rswTmKt5B4cFsVwto/X
        ZBDrq6Y46jJ+Bqn4NPcE2hs=
X-Google-Smtp-Source: APXvYqx9y5a9WxQbAroR31etc8GZA8cMjFK1xEM8Er7Tn8MjDxEn7c84sQbAkH2LDyWV3aXl0/Xcag==
X-Received: by 2002:a2e:2283:: with SMTP id i125mr11452435lji.244.1578929047657;
        Mon, 13 Jan 2020 07:24:07 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id u24sm6100821ljo.77.2020.01.13.07.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:24:06 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ir1ZW-0005nf-Ga; Mon, 13 Jan 2020 16:24:06 +0100
Date:   Mon, 13 Jan 2020 16:24:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 7/7] USB: serial: f81232: Add gpiolib to GPIO device
Message-ID: <20200113152406.GD2301@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-8-hpeter+linux_kernel@gmail.com>
 <20191023122208.GW24768@localhost>
 <ef91b42d-e81d-ecdd-c688-0cb3f0b94906@gmail.com>
 <20200108144600.GK30908@localhost>
 <2908e99e-ae4e-9385-92af-58381aa119a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2908e99e-ae4e-9385-92af-58381aa119a9@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:43:48AM +0800, Ji-Ze Hong (Peter Hong) wrote:

> Johan Hovold 於 2020/1/8 下午 10:46 寫道:

> > I understood from your other mail that the gpio device would not be able
> > to control the pins of an enabled port. In either case, I think you need
> > to refuse a request for a pin that's already in use by the corresponding
> > port.
> 
> OK, I'll change the code as previous mail as following:
> 
> I can read the UART enable state from GPIO Device, so I can do when the
> GPIO is associated with UART enabled, change it as output only otherwise
> can be set to input/output.
> 
> > Also is there a way to determine the number of available pins by
> > detecting the chip/package type? I'm assuming not all 36 pins are always
> > accessible?
> 
> Yes, we had register to get package type, I'll add UART enable & package
> type to determinate final GPIO pin out.

I suggest you start without any gpiochip, just add a simple control
driver which enables each UART (only the ones available in the package
and which have not been hardware disabled perhaps).

We don't want a user to be able to change the tranceiver mode behind the
serial driver's back so to speak.

Exposing GPIO pins (not MODE pins) in packages which have those enabled
should be fine, but you can add that later.

Johan
