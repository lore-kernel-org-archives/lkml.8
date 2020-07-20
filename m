Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F27DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3770A22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255540;
	bh=y0jQMJRXXfIRv6nloxWBlaqAL/HJyhH5rfj2UjXUYDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oWmpkDp/A1PvNo6FVot1IlHonCL/klXmTuIpdObierF0asYRWksP97T8RRulmnCiF
	 4udoUJq+zZU3uDvuce6pTTu4AvwdK4uR+Mgz3wSOOYv5U9vyla9C2p6RmfTd4ayDqx
	 IxocbpyKs3uhosyRQL4PFvdMg3MAN9l/tYEVBT3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgGTOcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:32:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51415 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:32:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so22499620wmg.1;
        Mon, 20 Jul 2020 07:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sVT35zDtcFJ4SrtuOpV/KcbsxZIq+XtepIT4986OMVM=;
        b=LxK48p+OMAS7Gxt6WdlrLJHQPQMnpBHJfBz4plMZ2sZTYTcOxBTc1GBl8DeNuzq+30
         ZKqLFC3ekbs4kH/JKyGPLApkvJfFaEcZSyakf3cGo5PjpOfwnOL5d99dLVstHAWBtDJZ
         J8UP6gVpG7+FUJXzcqTprFmdDRUKNQBxUL6QPJkRD6FDmT95YNsgPPtuVXcks2ApXCxc
         iHc0aX/915plhyMY9IOrzVKHOPQio2WlH+nr2/mOlS3wvwGD/lXH5ioE/sayyVGN18WA
         FWN8VBZkaFXMB7mPcodFSXZmayqmIN82opwtp4XRbbBwlo2gKl2/FrH/CVbQlyPycPsg
         tHyA==
X-Gm-Message-State: AOAM533Uj3UWD6mSt9QCAMITgcUnRJY7hbZBXm2BLAK9AFIrQnySk8Bo
        L+vQJhinpzFpXUCWU4iN1VI53k57
X-Google-Smtp-Source: ABdhPJwxjULIzhcpgO60wcS3l6o8v6D2AqgNgfIOwRnKNgJLdchd2VS7oB9RDrRo6h+7EZZqSyJXzg==
X-Received: by 2002:a7b:c5c5:: with SMTP id n5mr19779821wmk.103.1595255536295;
        Mon, 20 Jul 2020 07:32:16 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id t141sm34654245wmt.26.2020.07.20.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:32:14 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:32:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200720143213.GJ4074@dhcp22.suse.cz>
References: <20200720083956.GA4074@dhcp22.suse.cz>
 <20200720135857.GB1228057@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20200720135857.GB1228057@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 20-07-20 09:58:57, Alan Stern wrote:
[...]
> Can you provide the contents of /sys/kernel/debug/usb/devices and also a 

attached.

> usbmon trace showing a few rounds of this recurring activity?

This is not my area so I will need some help here. I assume I should
look for debug/usb/usbmon which contains quite some files for me
0s  0u  1s  1t  1u  2s  2t  2u
most of them provide data when cating them.

> section of the dmesg log with dynamic debugging enabled for the usbcore 
> module, as well.

Could you give me more details steps please?
-- 
Michal Hocko
SUSE Labs

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb.devices"


T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh=12
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 5.08
S:  Manufacturer=Linux 5.8.0-rc6-00001-g5714ee50bb43 xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=06 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=5800 Rev= 1.01
S:  Manufacturer=Broadcom Corp
S:  Product=5880
S:  SerialNumber=0123456789ABCD
C:* #Ifs= 2 Cfg#= 0 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=fe(app. ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  16 Ivl=125us
I:* If#= 1 Alt= 0 #EPs= 3 Cls=0b(scard) Sub=00 Prot=00 Driver=usbfs
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=125us

T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0a2b Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
P:  Vendor=1d6b ProdID=0003 Rev= 5.08
S:  Manufacturer=Linux 5.8.0-rc6-00001-g5714ee50bb43 xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

--fdj2RfSjLxBAspz7--
