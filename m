Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72180C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECB5206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585121079;
	bh=1Q+Uqw1+9lzFXKIYwBi+8xEK9cKWI3hwgkqNzMu+SGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=chSMlgJ96xfx4W51rY/k7nvFQ9Nx8+ldZT6tzd9ZVx4NfAhQ6X8lPHT8fyPvkYmrZ
	 Yxoe2pTeROTcrVmuiaQlpolq15F6qKkq+nhBf4OLVrJtdog3+524lIDpNp6hHlTnTD
	 +M5cjv7B6OnDJ8ZmA6VFRiOroCxWYMqNfZNYIMDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgCYHYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:24:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45929 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCYHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:24:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so1287693ljc.12;
        Wed, 25 Mar 2020 00:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yYMskD8YbmF5CznM9u2KgIQ2j22Tv3Z0+ltPHr127Bg=;
        b=OBTc4HXhEOfk36X1iCfEhUW8l234B7pDzb0GPJK6v8hT5QerZ2FA6Y0A/PTNyJv2Ig
         o67YZWI74PDQDHUoDFvvPn/r/qKQfioIfMPfZwYbuZBjXSCw8awbcXqSiTwOhAe1gOLB
         FdvTIrm00PYW4iHDDCM/QTrQ76QUmGZvwQVB74kkKtN5hxmd+XH19cW5kzLFOojTY4Sp
         vCMiyQe8CYKztvcmArSOYRvG2VTYZQhWyN0x0Knf3ba3kHVfkLPIDSLQ/7eCdhesl6B/
         mLstXhHv3+mhPE8/jxxKq0Gf6O2sDkGEiDqcbh7HpPJOBivJTTu0y/mLE5j8FHXF1Q95
         cxEg==
X-Gm-Message-State: AGi0PuaQ/VMbnc9SoJMXOgXZXMOJWqr7nmn0z+eucV8pQRAr0ilCjP17
        z6UjFaL4tHDOYtRfHvXbbuM=
X-Google-Smtp-Source: APiQypJH+A6SZ2ooqmfVGZuNsqIOVf7rzqFKFBoJ76EPElb5zuhOiYtvYqkjEEOptjhLa2hSaNcRgw==
X-Received: by 2002:a2e:985a:: with SMTP id e26mr1097032ljj.17.1585121071573;
        Wed, 25 Mar 2020 00:24:31 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id w7sm11130633lfn.19.2020.03.25.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 00:24:30 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jH0Of-0007X2-NK; Wed, 25 Mar 2020 08:24:17 +0100
Date:   Wed, 25 Mar 2020 08:24:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Cezary Jackiewicz <cezary@eko.one.pl>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] USB: serial: option: add support for ASKEY WWHC050
Message-ID: <20200325072417.GI5810@localhost>
References: <20200325054419.19128-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325054419.19128-1-paweldembicki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 06:44:17AM +0100, Pawel Dembicki wrote:
> ASKEY WWHC050 is a mcie LTE modem.
> The oem configuration states:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1690 ProdID=7588 Rev=ff.ff
> S:  Manufacturer=Android
> S:  Product=Android
> S:  SerialNumber=813f0eef6e6e
> C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
> E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=125us
> 
> Tested on openwrt distribution.
> 
> Co-Developed-by: Cezary Jackiewicz <cezary@eko.one.pl>
> Signed-off-by: Cezary Jackiewicz <cezary@eko.one.pl>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Thanks for the update. Series applied for -next.

Johan
