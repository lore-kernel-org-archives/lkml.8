Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F1CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C956D206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tfr4hut2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIAW5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:57:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:57:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081MsabW119623;
        Tue, 1 Sep 2020 22:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JnpmDtSqdgZ8Qo0nmwK77Wr3l27dEGsHABeVPi7Ih9M=;
 b=Tfr4hut2D2vl4wIfNVBeKf18toi87Qqm1rxk2g7vccbGDx/06o4ZrfoKD2+gJXFc4xr+
 WmydL6igHvFINPfaGwFKlFhwCmIBPkGriRZ1jr9fKUsEa018YzUhmn3dy6OTdDITl+Ix
 HdGHSf70T+DAhlVq6HfE6+r97j/dskFtLppzgWYVTzZYMZMxA/a4vGkyREl5hlSQ7T/E
 HAbMzmLoIDmjw4/Q1Tqp283o8b1JpkxTMwvl7a1gceSwe4Jz1Fuzs2/kaK4swp5yKM0p
 UmbGz6BXxzxaFgqe1uVYdOd9shF04/i68bLA9jvWv61prI9eRukCqGzoP0xoa4lNIXo3 fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 337eym77ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 22:57:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081MtBvm004152;
        Tue, 1 Sep 2020 22:55:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3380kp003j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 22:55:12 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 081Mt31t032307;
        Tue, 1 Sep 2020 22:55:03 GMT
Received: from [10.154.191.218] (/10.154.191.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 15:55:02 -0700
Subject: Re: [RFC RESEND PATCH 0/1] USB EHCI: repeated resets on full and low
 speed devices
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1598887346.git.khalid@gonehiking.org>
 <20200901023117.GD571008@rowland.harvard.edu>
 <608418fa-b0ce-c2a4-ad79-fe505c842587@oracle.com>
 <20200901163602.GG587030@rowland.harvard.edu>
 <4d1ab90a-ec55-85e8-d646-cfa58f08d449@oracle.com>
 <20200901195159.GA599114@rowland.harvard.edu>
From:   Khalid Aziz <khalid.aziz@oracle.com>
X-Pep-Version: 2.0
Organization: Oracle Corp
Message-ID: <68228cc9-5d1a-6872-0956-a7006fe3b943@oracle.com>
Date:   Tue, 1 Sep 2020 16:54:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200901195159.GA599114@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 1:51 PM, Alan Stern wrote:
> On Tue, Sep 01, 2020 at 11:00:16AM -0600, Khalid Aziz wrote:
>> On 9/1/20 10:36 AM, Alan Stern wrote:
>>> On Tue, Sep 01, 2020 at 09:15:46AM -0700, Khalid Aziz wrote:
>>>> On 8/31/20 8:31 PM, Alan Stern wrote:
>>>>> Can you collect a usbmon trace showing an example of this problem?
>>>>>
>>>>
>>>> I have attached usbmon traces for when USB hub with keyboards and mo=
use
>>>> is plugged into USB 2.0 port and when it is plugged into the NEC USB=
 3.0
>>>> port.
>>>
>>> The usbmon traces show lots of errors, but no Clear-TT events.  The=20
>>> large number of errors suggests that you've got a hardware problem;=20
>>> either a bad hub or bad USB connections.
>>
>> That is what I thought initially which is why I got additional hubs an=
d
>> a USB 2.0 PCI card to test. I am seeing errors across 3 USB controller=
s,
>> 4 USB hubs and 4 slow/full speed devices. All of the hubs and slow/ful=
l
>> devices work with zero errors on my laptop. My keyboard/mouse devices
>> and 2 of my USB hubs predate motherboard update and they all worked
>> flawlessly before the motherboard upgrade. Some combinations of these
>> also works with no errors on my desktop with new motherboard that I ha=
d
>> listed in my original email:
>=20
> It's a very puzzling situation.
>=20
> One thing which probably would work well, surprisingly, would be to buy=
=20
> an old USB-1.1 hub and plug it into the PCI card.  That combination is =

> likely to be similar to what you see when plugging the devices directly=
=20
> into the PCI card.  It might even work okay with the USB-3 controllers.=

>=20
>> 2. USB 2.0 controller - WORKS
>> 5. USB 3.0/3.1 controller -> Bus powered USB 2.0 hub - WORKS
>>
>> I am not seeing a common failure here that would point to any specific=

>> hardware being bad. Besides, that one code change (which I still can't=

>> say is the right code change) in ehci-q.c makes USB 2.0 controller wor=
k
>> reliably with all my devices.
>=20
> The USB and EHCI designs are flawed in that under the circumstances=20
> you're seeing, they don't have any way to tell the difference between a=
=20
> STALL and a host timing error.  The current code treats these situation=
s=20
> as timing/transmission errors (resulting in device resets); your change=
=20
> causes them to be treated as STALLs.  However, there are known, common =

> situations in which those same symptoms really are caused by=20
> transmission errors, so we don't want to start treating them as STALLs.=

>=20
> Besides, I suspect that your code change does _not_ make the USB-2=20
> controller work reliably with your devices.  You should collect a usbmo=
n=20
> trace under those conditions; I predict it will be full of STALLs.  And=
=20
> furthermore, I believe these STALLs will not show up in a usbmon trace =

> made with the devices plugged directly into the PCI card.  If I'm right=
=20
> about these things, the errors are still present even with your patch; =

> all it does is hide them.
>=20
> Short of a USB bus analyzer, however, there's no way to tell what's=20
> really going on.

I have managed to find a hardware combination that seems to work, so for
now at least my machine is usable. I will figure out how to interpret
usbmon output and run more experiments. There seems to be a real problem
in the driver somewhere and should be solved.

Thanks,
Khalid


