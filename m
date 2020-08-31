Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC17CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8158C206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598856201;
	bh=y9nSHuhDgDMw5zpER+/tN+R20SRJvwg4qM3Lz4R94aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L3+F/HHO/6U0NnjeXgh802VCc8tDiHS6K/Gi9YTk1C3KZLdXBJ9Iska/m2HohngcW
	 M5jnJC/59nrSbTy+101oF6R83kBMB9P+ji5VzK0wC0b04CO/TpWIewvR2Bb+axjYaT
	 LDARGOFWGIAkyIAcxqqJUlfJ3GBTeVRl0onhVMPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgHaGnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:43:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41056 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgHaGnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:43:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id y4so4282032ljk.8;
        Sun, 30 Aug 2020 23:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wyW58DDBNp+B8mjoREWkn7J6NiyeeYGpM+salH1bjXM=;
        b=YrQiutvdvFIanhD9xE4LfIzFpyTWE0k81PP4HCgGdvc7vedd9MwJrIuRaKs1aC/CDy
         12UQFVaUiiXu7wdNUkmUXFuRIjiEUU61HsT/6RhEQD9ssSHhzpGX4nL9y4gxjVexjBkU
         eMtHveR49P0Xskn2fcXnLxq35kPvaZbWf4XVkBljKX97u2nRfoe1w3yP19WbyIiZo1mm
         9YjlmELBKPMKRaSClD/8RHI43+CKH6iWruY3P3O6wCf7QwBP1Q5g0zgMVUQUrLpEfIK0
         kpcyPPLv5ObKG7tPXMDRqYImfPeCVCOmfeRJC2s2+JAsZDeXZW6R3EhMOqQ92xZ8ILUy
         GwRw==
X-Gm-Message-State: AOAM533vBK6xwtEkIZ3X1OsGXb6nDmc1Nu2+xV6HLkRCPmm2opGtteOw
        14xYKNpUFlOcZ4DS25rfXME=
X-Google-Smtp-Source: ABdhPJzybFq958m1TKK2GCBj+0bVRPOnQGvnyOyx0GNhUh2y6CEFA1Dt5qSQPV3Ry/w8ygYnkLIsSg==
X-Received: by 2002:a2e:8690:: with SMTP id l16mr4245073lji.7.1598856194607;
        Sun, 30 Aug 2020 23:43:14 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id a16sm1374592ljj.108.2020.08.30.23.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 23:43:13 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kCdX0-0006dm-98; Mon, 31 Aug 2020 08:43:06 +0200
Date:   Mon, 31 Aug 2020 08:43:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Aleksander Morgado <aleksander@aleksander.es>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add support for
 SIM7070/SIM7080/SIM7090 modules
Message-ID: <20200831064306.GN21288@localhost>
References: <20200829090539.80140-1-aleksander@aleksander.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829090539.80140-1-aleksander@aleksander.es>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 11:05:39AM +0200, Aleksander Morgado wrote:
> These modules have 2 different USB layouts:
> 
> The default layout with PID 0x9205 (AT+CUSBSELNV=1) exposes 4 TTYs and
> an ECM interface:
> 
>   T:  Bus=02 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  6 Spd=480 MxCh= 0
>   D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
>   P:  Vendor=1e0e ProdID=9205 Rev=00.00
>   S:  Manufacturer=SimTech, Incorporated
>   S:  Product=SimTech SIM7080
>   S:  SerialNumber=1234567890ABCDEF
>   C:  #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=500mA
>   I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x4 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
>   I:  If#=0x5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> 
> The purpose of each TTY is as follows:
>  * ttyUSB0: DIAG/QCDM port.
>  * ttyUSB1: GNSS data.
>  * ttyUSB2: AT-capable port (control).
>  * ttyUSB3: AT-capable port (data).
> 
> In the secondary layout with PID=0x9206 (AT+CUSBSELNV=86) the module
> exposes 6 TTY ports:
> 
>   T:  Bus=02 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
>   D:  Ver= 2.00 Cls=02(commc) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
>   P:  Vendor=1e0e ProdID=9206 Rev=00.00
>   S:  Manufacturer=SimTech, Incorporated
>   S:  Product=SimTech SIM7080
>   S:  SerialNumber=1234567890ABCDEF
>   C:  #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=500mA
>   I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
>   I:  If#=0x5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> 
> The purpose of each TTY is as follows:
>  * ttyUSB0: DIAG/QCDM port.
>  * ttyUSB1: GNSS data.
>  * ttyUSB2: AT-capable port (control).
>  * ttyUSB3: QFLOG interface.
>  * ttyUSB4: DAM interface.
>  * ttyUSB5: AT-capable port (data).
> 
> Signed-off-by: Aleksander Morgado <aleksander@aleksander.es>

Now applied. Thanks, Aleksander.

Johan
