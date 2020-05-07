Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0688C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B9E208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="DFiwmbOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEGLKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:10:43 -0400
Received: from mail1480c50.megamailservers.eu ([91.136.14.80]:52920 "EHLO
        mail118c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:10:43 -0400
X-Greylist: delayed 5387 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 07:10:40 EDT
X-Authenticated-User: 017623705678@o2online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1588841847;
        bh=9AVDDx9V2gYEDXeTNlt74d5XCNEQnpqZSN3VPF09Hgo=;
        h=To:From:Subject:Cc:Date:From;
        b=DFiwmbOa3bgHNh4E9inRazcp5ciZtrCxazNafTMLDonUPgSCmOd9v9TPzF+s77SnE
         y4i96EzAKd2AClwwSb+xMAfynZ1ywVT05uhToWTlr1vJsvRrWmH+A8C7gKtmJwUBgD
         Vi1KqGd1mhmSi/2iIxmC2efbA2yxdzcQYrrDPmTo=
Feedback-ID: 017623705678@o2
Received: from [192.168.2.2] (ipservice-092-210-125-153.092.210.pools.vodafone-ip.de [92.210.125.153])
        (authenticated bits=0)
        by mail118c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 0478vNmH019869;
        Thu, 7 May 2020 08:57:25 +0000
To:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From:   Tobias Baumann <017623705678@o2online.de>
Subject: RTL8723BS driver doesn't work for,me but I can help testing
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Message-ID: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
Date:   Thu, 7 May 2020 10:57:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE
X-Antivirus: AVG (VPS 200506-0, 06.05.2020), Outbound message
X-Antivirus-Status: Clean
X-CTCH-RefID: str=0001.0A782F27.5EB3CD45.009D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=KaGsTjQD c=1 sm=1 tr=0 a=hSNHuiTHMbSMD4yx1hjzQA==:117
        a=hSNHuiTHMbSMD4yx1hjzQA==:17 a=IkcTkHD0fZMA:10 a=oCcaPWc0AAAA:8
        a=xa8cPLTrDijPg6maogsA:9 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Community

I was referred to you by Martin. I have an older Android TV box that 
runs for over 3 years with Armbian Linux (Debian Jessie Headless Kernel 
3.10.99). I'm looking forward to the new kernels and I'm glad that older 
hardware is still supported.
Together with Oleg(balbes150) and Martin(xdarklight) I am testing the 
new kernel 5.x for ARM ( Amlogic S812 / Meson8m2 ) . Martin has written 
a patch for the SDIO controller in the last days so that also Wifi 
module and MMC are recognized. I could now successfully load the driver 
module RTLWIFI from the kernel. But unfortunately the card is only 
listed on the desktop as "not ready" or in the terminal (iwlist) as "no 
scan result". In the dmesg/lsmod RTLWIFI->RTL8723bs is loaded and the 
module is loaded with version v4.3.5.5_12290.20140916_BTCOEX20140507-4E40 .=



I would like to ask you to check the driver because even in kernel 
3.10.99 a newer version (v4.3.16_13854.20150410_BTCOEX20150119-5844) is 
loaded and also at github are hard kernels ( version 2017 Kernel 4.9>) 
and ap17 and thirdyouth (v5.2.17.1_26955.20180307_COEX20180201-6f52). 
More recent ones can also be found - these have already been 
successfully tested with Debian 10. i hope that this may solve the 
problem with my Linux box.

I would appreciate feedback on this request or information about 
debugging . My Linux box is also available for testing purposes

Kindly
Tobias Baumann (RaptorSDS)



-- 
Diese E-Mail wurde von AVG auf Viren gepr=C3=BCft.
http://www.avg.com

