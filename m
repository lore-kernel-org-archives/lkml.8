Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8140C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E12F20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q19hdjim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbgIAPvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:51:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgIAPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:51:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081FoANV174298;
        Tue, 1 Sep 2020 15:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BJNLXtlqaEToKSsENhPBjm8oi2i2ztaQ9ZdndhtUWws=;
 b=Q19hdjimkn+cLPx11zxB0sauk464/AivYL5BdiHW9VZOIJsH5WOGHIBSfF8VjYa78maZ
 gv1wQKIgy0crUT9sr6agTEcbWSYBTxqCRnMfH8AFynaeNs6rYSFSlV8O5YWXbVFoGevm
 faFTd+LCj3Z/vsedewejxGElWQLePcNTmDenYcSFJI3ankJlgJq8tdDTinTwGB6rKV4x
 74xcH4gfYgL6YQrRCtF4KHeRg/2+SASCaTZq09oS1TpXPUOu8O+i9zvyM5vh94poBgLQ
 P83OCVxKbc5EjW9tz8Jc3KQ7Ww3+mcFku4awOkbd+JNxtKXi6VP5xDr9wq+TcLh/O5+I uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 337eym574e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 15:51:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081FochZ154670;
        Tue, 1 Sep 2020 15:51:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3380x3qb5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 15:51:26 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 081FpOc7017946;
        Tue, 1 Sep 2020 15:51:24 GMT
X-PEP-VERSION: 2.0
Received: from [10.154.191.218] (/10.154.191.218) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Tue, 01 Sep 2020 08:51:23 -0700
ORGANIZATION: Oracle Corp
USER-AGENT: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <0ec31395-56d9-c490-4e42-1c27bbc69df3@oracle.com>
Date:   Tue, 1 Sep 2020 08:51:14 -0700 (PDT)
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 0/1] USB EHCI: repeated resets on full and low
 speed devices
References: <cover.1598887346.git.khalid@gonehiking.org>
 <20200901023117.GD571008@rowland.harvard.edu>
In-Reply-To: <20200901023117.GD571008@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 8:31 PM, Alan Stern wrote:
> On Mon, Aug 31, 2020 at 10:23:30AM -0600, Khalid Aziz wrote:
>> [Resending since I screwed up linux-usb mailing list address in
>> cut-n-paste in original email]
>>
>>
>> I recently replaced the motherboard on my desktop with an MSI B450-A
>> Pro Max motherboard. Since then my keybaords, mouse and tablet have
>> become very unreliable. I see messages like this over and over in
>> dmesg:
>>
>> ug 23 00:01:49 rhapsody kernel: [198769.314732] usb 1-2.4: reset full-=
speed USB
>>  device number 27 using ehci-pci
>> Aug 23 00:01:49 rhapsody kernel: [198769.562234] usb 1-2.1: reset full=
-speed USB
>>  device number 28 using ehci-pci
>> Aug 23 00:01:52 rhapsody kernel: [198772.570704] usb 1-2.1: reset full=
-speed USB
>>  device number 28 using ehci-pci
>> Aug 23 00:02:02 rhapsody kernel: [198782.526669] usb 1-2.4: reset full=
-speed USB
>>  device number 27 using ehci-pci
>> Aug 23 00:02:03 rhapsody kernel: [198782.714660] usb 1-2.1: reset full=
-speed USB
>>  device number 28 using ehci-pci
>> Aug 23 00:02:04 rhapsody kernel: [198784.210171] usb 1-2.3: reset low-=
speed USB device number 26 using ehci-pci
>> Aug 23 00:02:06 rhapsody kernel: [198786.110181] usb 1-2.4: reset full=
-speed USB device number 27 using ehci-pci
>> Aug 23 00:02:08 rhapsody kernel: [198787.726158] usb 1-2.4: reset full=
-speed USB device number 27 using ehci-pci
>> Aug 23 00:02:10 rhapsody kernel: [198790.126628] usb 1-2.1: reset full=
-speed USB device number 28 using ehci-pci
>> Aug 23 00:02:10 rhapsody kernel: [198790.314141] usb 1-2.4: reset full=
-speed USB device number 27 using ehci-pci
>> Aug 23 00:02:12 rhapsody kernel: [198792.518765] usb 1-2.4: reset full=
-speed USB device number 27 using ehci-pci
>>
>> The devices I am using are:
>>
>> - Logitech K360 wireless keyboard
>> - Wired Lenovo USB keyboard
>> - Wired Lenovo USB mouse
>> - Wired Wacom Intuos tablet
>>
>> After a reset, the wireless keyboard simply stops working. Rest of
>> the devices keep seeing intermittent failure.
>>
>> I tried various combinations of hubs and USB controllers to see what
>> works. MSI B450-A motherboard has USB 3.0 and USB 3.1 controllers. I
>> added a USB 2.0 PCI card as well for this test:
>>
>> 03:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 400 Series =
Chipset USB 3.1 XHCI Controller (rev 01)
>> 29:01.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
>> 29:01.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
>> 29:01.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (=
rev 04)
>> 2c:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Matisse USB=
 3.0 Host Controller
>>
>> I have a bus powered USB 3.0 hub, a bus powered USB 2.0 hub and a
>> self powered USB 2.0 hub built into my monitor.
>>
>> I have connected my devices directly into the ports on motherboard
>> and PCI card as well as into external hub. Here are the results I
>> saw when devices wee plugged into various combination of ports:
>>
>> 1. USB 3.0/3.1 controller - does NOT work
>> 2. USB 2.0 controller - WORKS
>> 3. USB 3.0/3.1 controller -> Self powered USB 2.0 hub in monitor - doe=
s
>>    NOT work
>> 4. USB 3.0/3.1 controller -> bus powered USB 3.0 hub - does NOT work
>> 5. USB 3.0/3.1 controller -> Bus powered USB 2.0 hub - WORKS
>> 7. USB 2.0 controller -> Bus powered USB 3.0 hub - does NOT work
>> 8. USB 2.0 controller -> Bus powered 2.0 hub - Does not work
>=20
> The error messages in your log extract all refer to ehci-pci, which is =

> the driver for a USB-2 controller.  They are completely unrelated to an=
y=20
> problems you may be having with USB-3 controllers.

I just happened to cut and paste the messages from when I was testing
with the USB 2.0 controller. Here are the messages when I ran the test
with USB 3.0 controller:

Aug 13 14:25:48 rhapsody kernel: [78779.868354] usb 1-9.4: reset
full-speed USB  device number 38 using xhci_hcd
Aug 13 14:26:18 rhapsody kernel: [78809.939457] usb 1-9.4: reset
full-speed USB  device number 38 using xhci_hcd
Aug 13 14:26:39 rhapsody kernel: [78830.899982] usb 1-9.4: reset
full-speed USB  device number 38 using xhci_hcd
Aug 13 14:26:39 rhapsody kernel: [78831.379883] usb 1-9.2: reset
low-speed USB device number 36 using xhci_hcd
Aug 13 14:26:40 rhapsody kernel: [78832.043900] usb 1-9.3: reset
low-speed USB device number 37 using xhci_hcd
Aug 13 14:26:47 rhapsody kernel: [78839.520211] usb 1-9.4: reset
full-speed USB device number 38 using xhci_hcd
Aug 13 14:26:49 rhapsody kernel: [78841.035843] usb 1-9.2: reset
low-speed USB device number 36 using xhci_hcd
Aug 13 14:26:50 rhapsody kernel: [78841.695837] usb 1-9.3: reset
low-speed USB device number 37 using xhci_hcd
Aug 13 14:27:57 rhapsody kernel: [78909.299772] usb 1-9.4: reset
full-speed USB device number 38 using xhci_hcd
Aug 13 14:27:58 rhapsody kernel: [78909.779179] usb 1-9.2: reset
low-speed USB device number 36 using xhci_hcd
Aug 13 14:28:05 rhapsody kernel: [78916.650851] usb 1-9.4: reset
full-speed USB device number 38 using xhci_hcd
Aug 13 14:32:02 rhapsody kernel: [79153.986777] usb 1-9.4: reset
full-speed USB device number 38 using xhci_hcd
Aug 13 14:32:22 rhapsody kernel: [79173.898757] usb 1-9.4: reset
full-speed USB device number 38 using xhci_hcd
Aug 13 14:32:23 rhapsody kernel: [79175.174206] usb 1-9.3: reset
low-speed USB device number 37 using xhci_hcd
Aug 13 14:32:24 rhapsody kernel: [79175.833619] usb 1-9.2: reset
low-speed USB device number 36 using xhci_hcd
Aug 13 14:34:23 rhapsody kernel: [79295.230293] usb 1-9.4: reset
full-speed USB device number 38 using xhci_hcd

>=20
>> I narrowed the failure down to following lines (this code was added
>> in 5.5 with commit 64cc3f12d1c7 "USB: EHCI: Do not return -EPIPE
>> when hub is disconnected"):
>>
>> drivers/usb/host/ehci-q.c:
>>
>>  217                 } else if ((token & QTD_STS_MMF) &&
>>  218                                         (QTD_PID(token) =3D=3D PI=
D_CODE_IN)) {
>>  219                         status =3D -EPROTO;
>>  220                 /* CERR nonzero + halt --> stall */
>>
>> At the time of failure, when we reach this conditional, token is
>> either 0x80408d46 or 0x408d46 which means following bits are set:
>>
>> QTD_STS_STS, QTD_STS_MMF, QTD_STS_HALT, QTD_IOC, QTD_TOGGLE
>>
>> and=20
>>
>>         QTD_PID =3D 1
>>         QTD_CERR =3D 3
>>         QTD_LENGTH =3D 0x40 (64)
>>
>> This causes  the branch "(token & QTD_STS_MMF) && (QTD_PID(token) =3D=3D=

>> PID_CODE_IN" to be taken and qtd_copy_status() returns EPROTO. This
>> return value in qh_completions() results in ehci_clear_tt_buffer()
>> being called:
>>
>> drivers/usb/host/ehci-q.c:
>>  472                         /* As part of low/full-speed endpoint-hal=
t processi     ng
>>  473                          * we must clear the TT buffer (11.17.5).=

>>  474                          */
>>  475                         if (unlikely(last_status !=3D -EINPROGRES=
S &&
>>  476                                         last_status !=3D -EREMOTE=
IO)) {
>>  477                                 /* The TT's in some hubs malfunct=
ion when t     hey
>>  478                                  * receive this request following=
 a STALL (     they
>>  479                                  * stop sending isochronous packe=
ts).  Sinc     e a
>>  480                                  * STALL can't leave the TT buffe=
r in a bus     y
>>  481                                  * state (if you believe Figures =
11-48 - 11     -51
>>  482                                  * in the USB 2.0 spec), we won't=
 clear the      TT
>>  483                                  * buffer in this case.  Strictly=
 speaking      this
>>  484                                  * is a violation of the spec.
>>  485                                  */
>>  486                                 if (last_status !=3D -EPIPE)
>>  487                                         ehci_clear_tt_buffer(ehci=
, qh, urb,
>>  488                                                         token);
>>  489                         }
>>
>> It seems like clearing TT buffers in this case is resulting in hub
>> hanging. A USB reset gets it going again until we repeat the cycle
>> over again. The comment in this code says "The TT's in some hubs
>> malfunction when they receive this request following a STALL (they
>> stop sending isochronous packets)". That may be what is happening.
>=20
> What makes you think that?  Do you have any evidence that the hub is=20
> receiving a STALL?  Indeed, the commit you referenced above specificall=
y=20
> mentions that when MMF is set and the PID code is IN then it is not a=20
> STALL.
>=20

You are probably right about that. I do not understand USB protocol well
enough. Eliminating clearing TT buffers when split transaction is
incomplete fixed the problem for me. If I changed qtd_copy_status() to
return EPIPE as it was doing before commit 64cc3f12d1c7, USB resets went
away on my machine, so I am wondering if the comment at
drivers/usb/host/ehci-q.c:477 is applicable here.

>> Removing the code that returns EPROTO for such case solves the
>> problem on my machine (as in the RFC patch)
>=20
> It certainly can't solve the problem for any USB-3 connections, because=
=20
> the patch doesn't touch any of the USB-3 driver code.

Right. It solves the problem I see with USB 2.0 controller. I continue
to see issues with USB 3.0 if I move the hub to a USB 3.0 port.

>=20
>>  but that probably is not
>> the right solution. I do not understand USB protocol well enough to
>> propose a better solution. Does anyone have a better idea?
>=20
> Can you collect a usbmon trace showing an example of this problem?
Sure. I will do that. Tracing the code when debugging for USB 2.0
controller led me to that specific line of code. As I said, I do not
understand USB well enough to say if changing that code is the right
solution, and it indeed solves the problem for USB 2.0 only.

>=20
> One possibility is to introduce a special quirk for the NEC uPD72010x=20
> EHCI controller.  But we should hold off on that until we know exactly =

> what is happening.

I do not believe whatever is causing USB resets is unique to NEC chip. I
am seeing issues on the USB 3.0 controllers as well.

>=20
> Alan Stern
>=20

Thanks,
Khalid

