Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD3B2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgHXJgf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:36:35 -0400
Received: from gw-eagle2.siemens.com ([194.138.20.69]:11513 "EHLO
        gw-eagle2.siemens.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgHXJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:36:32 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2020 05:36:30 EDT
Received: from mail2.dc4ca.siemens.de (mail2.dc4ca.siemens.de [139.25.224.94])
        by gw-eagle2.siemens.com (Postfix) with ESMTPS id 592E1468008;
        Mon, 24 Aug 2020 11:28:13 +0200 (CEST)
Received: from DEMCHDC8A0A.ad011.siemens.net (demchdc8a0a.ad011.siemens.net [139.25.226.106])
        by mail2.dc4ca.siemens.de (Postfix) with ESMTPS id 4E10D1552BD22;
        Mon, 24 Aug 2020 11:28:13 +0200 (CEST)
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 24 Aug 2020 11:28:12 +0200
Received: from CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) by
 CNPEK01M06MSX.ad011.siemens.net ([139.24.237.223]) with mapi id
 15.01.2044.004; Mon, 24 Aug 2020 17:28:09 +0800
From:   "Wang, Sheng Long" <shenglong.wang.ext@siemens.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Sheng Long Wang <china_shenglong@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: RE: [PATCH v3] usb-serial:cp210x: add support to software flow
 control
Thread-Topic: [PATCH v3] usb-serial:cp210x: add support to software flow
 control
Thread-Index: AQHWdscbn5u/RYWMnkqBpjeEIyjP+KlBhWMAgATzlACAAInCwA==
Date:   Mon, 24 Aug 2020 09:28:09 +0000
Message-ID: <f21d4cc8b12d4ec6870623472ca7df09@siemens.com>
References: <20200820075240.13321-1-china_shenglong@163.com>
 <97836b78-740b-cf70-4803-27305b6e0a4d@siemens.com>
 <20200824090948.GC21288@localhost>
In-Reply-To: <20200824090948.GC21288@localhost>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcejAwNDNjYnhcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xZTQ5YzYxZC1lNWVjLTExZWEtYmU1OS1iMDBjZDE2OTA4NjRcYW1lLXRlc3RcMWU0OWM2MWYtZTVlYy0xMWVhLWJlNTktYjAwY2QxNjkwODY0Ym9keS50eHQiIHN6PSIyNTEwIiB0PSIxMzI0MjczNDg4ODE2NTU1ODciIGg9Ik4yT21wR1RxOUxNKzQ2dUl5MXE4QlJMRWtFbz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUhBQUFBQWpSNlBnK0huV0FZWmFyOHdMMmVEL2hscXZ6QXZaNFA4QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUJBQUFBVGFuck9nQUFBQUFBQUFBQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: 
x-document-confidentiality: NotClassified
x-originating-ip: [139.24.108.238]
x-tm-snts-smtp: D19F5371A4BF487AD73746162E220B87BAA644334B4D139CA133D1D1F789C5EE2000:8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

    Thanks for your reminding. I am adjusting patch according to the latest Linux Master branch.

With best regards,
Wang Sheng Long
Siemens Ltd., China
RC-CN DI FA R&D SW
Tianyuan road No.99
611731 CHENGDU, China
Mobil: +86 15281074996
mailto:shenglong.wang.ext@siemens.com



-----Original Message-----
From: Johan Hovold <johan@kernel.org> 
Sent: Monday, August 24, 2020 5:10 PM
To: Kiszka, Jan (CT RDA IOT SES-DE) <jan.kiszka@siemens.com>
Cc: Sheng Long Wang <china_shenglong@163.com>; Wang, Sheng Long (EXT) (RC-CN DI FA R&D SW) <shenglong.wang.ext@siemens.com>; johan@kernel.org; gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb-serial:cp210x: add support to software flow control

On Fri, Aug 21, 2020 at 07:32:58AM +0200, Jan Kiszka wrote:
> On 20.08.20 09:52, Sheng Long Wang wrote:
> > From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> > 
> > When data is transmitted between two serial ports, the phenomenon of 
> > data loss often occurs. The two kinds of flow control commonly used 
> > in serial communication are hardware flow control and software flow 
> > control.
> > 
> > In serial communication, If you only use RX/TX/GND Pins, you can't 
> > do hardware flow. So we often used software flow control and prevent 
> > data loss. The user sets the software flow control through the 
> > application program, and the application program sets the software 
> > flow control mode for the serial port chip through the driver.
> > 
> > For the cp210 serial port chip, its driver lacks the software flow 
> > control setting code, so the user cannot set the software flow 
> > control function through the application program. This adds the 
> > missing software flow control.
> > 
> > Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> > 
> > Changes in v3:
> > -fixed code style, It mainly adjusts the code style acccording  to 
> > kernel specification.
> 
> Patch does not apply. You forgot to rebase over latest tty/tty-next or 
> linux master.

That should be the usb-next branch of the usb-serial tree:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/

or linux-next (or, currently, Linus's master branch).

You can use "scripts/get_maintainer.sh --scm" to determine which tree to base your work against.

Johan
