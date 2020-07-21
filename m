Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE24C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0348F2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595316239;
	bh=otMBES4cNlXYQJWSMVEcDmZf+INtX693XsEPSnVWV3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WDE4X4eecAxk/LlbmEN/zseLjL+M2I1WTvRp5jckqGyBTEs4kE3/CqJPpQw2lLeD7
	 o6/+q5x87BDTucGwyY4nwyzIDCwwQVT5Gc+kYWBsyyyie4sx7KggEu5Jdh5rS4u+s5
	 kuVylY8pU0r+u7f5drUsJzogGLz5+x5vxw6Wabcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgGUHX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:23:57 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44403 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:23:56 -0400
Received: by mail-lj1-f169.google.com with SMTP id s9so22937173ljm.11;
        Tue, 21 Jul 2020 00:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iq3wUuhZioiO177l+TpqDsiXCkQPlbt663CBqkmosCw=;
        b=YO6/ItSuiqu/cq1+3uQepqfY+AOqzK7bXuFU0gkODp3aFLcYwem5WwF5tvk9DaN4RI
         cTpLNESXYIvUkRbPnZ5vFGN+3TuhUFw0FuY/Dw6Zmx1SodZa6sPpfM5IfOJVWMcYzrqG
         d23NQuGCNb5Zw4p8HzRvK0dU7oyC8jk0KsjXXDr5ynIOGlj1mCRpZarI/CYaAigRhN/K
         8wk9DoG7QQuSc5pCpUwthhWOjW2MeflVDk1BAC4MOEV3iQhh/2VzuJ8CvOU9Zw7QTOxg
         qkFT/Qy83EosgYlBJ7z+lc2mqDelm2gXpqNs8w+GitrSlFPAGF1vqPhejZwD7MSY4ME2
         SFkw==
X-Gm-Message-State: AOAM5326YJfDrDDBZa4cG1mB8D69jI/z+7Zuk4Z5MOC1MuNt7gxDRWMH
        yU9w4zWL9dqMy/1xAakLug2hzkpJ8H0=
X-Google-Smtp-Source: ABdhPJwWmYDoU22uqy6cber6vfVaw5krIXT72V3t4aEAInm74g/AKFxrZZwkRtn3cCPQksawEYn/BA==
X-Received: by 2002:a2e:8210:: with SMTP id w16mr11917513ljg.419.1595316234437;
        Tue, 21 Jul 2020 00:23:54 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r13sm4011428ljg.101.2020.07.21.00.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 00:23:53 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jxmcw-0006eM-T0; Tue, 21 Jul 2020 09:23:50 +0200
Date:   Tue, 21 Jul 2020 09:23:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Erik Ekman <erik@kryo.se>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: qcserial: add EM7305 QDL product ID
Message-ID: <20200721072350.GC3634@localhost>
References: <20200717185118.3640219-1-erik@kryo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717185118.3640219-1-erik@kryo.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:51:18PM +0200, Erik Ekman wrote:
> When running qmi-firmware-update on the Sierra Wireless EM7305 in a Toshiba
> laptop, it changed product ID to 0x9062 when entering QDL mode:
> 
> usb 2-4: new high-speed USB device number 78 using xhci_hcd
> usb 2-4: New USB device found, idVendor=1199, idProduct=9062, bcdDevice= 0.00
> usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 2-4: Product: EM7305
> usb 2-4: Manufacturer: Sierra Wireless, Incorporated
> 
> The upgrade could complete after running
>  # echo 1199 9062 > /sys/bus/usb-serial/drivers/qcserial/new_id
> 
> qcserial 2-4:1.0: Qualcomm USB modem converter detected
> usb 2-4: Qualcomm USB modem converter now attached to ttyUSB0
> 
> Signed-off-by: Erik Ekman <erik@kryo.se>

Applied, thanks.

Would you mind posting the output of "usb-devices" (or "lsusb -v") for
this device for completeness?

Johan
