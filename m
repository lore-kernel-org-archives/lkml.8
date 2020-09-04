Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D7BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568552064E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgBl+jKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgIDQnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:43:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38522 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgIDQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:43:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084GhiKB148964;
        Fri, 4 Sep 2020 16:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sR4rwJMWbaTjfjVfpcEpvMpdWlkEnJYWvlPrpzsa6p4=;
 b=mgBl+jKkrwZW10c9acRUm6qUeGr21LFkS2vmTz1Ho3NRXP/fPqugIjoxlsL1WBBl1LFM
 f6V6FOTOxOSlt81+34JW3Jn2byTeIIk9pjGZD/toO2GojUunTFb4NpIUdyeegz+XgUNQ
 z5VIUWM1D5jcT/yAL18TcckvB/xbIr9pZFSxkR8/cRtAF+YAxEJx5XazjEDR21YHDpWB
 g7Mckt1MM9hkrHvLiQ+n9CUUlVMb2/RtZDIltvZN0KTwmfTXzOn+Ebi0Cg93f5Gm1efI
 KBRu9WsLeXPCUE3hJDP2peSDFlBz2npjRuBBrGuJ9SFMHcYWW4PORDKtcp7ujzMjKt30 yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmndv0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 16:43:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084GfGfG018221;
        Fri, 4 Sep 2020 16:43:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33bhs4r9tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 16:43:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084Gha3Z012720;
        Fri, 4 Sep 2020 16:43:37 GMT
Received: from [10.65.176.103] (/10.65.176.103)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 09:43:36 -0700
Subject: Re: [RFC PATCH 1/1] usb: ehci: Remove erroneous return of EPROTO upon
 detection of stall
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
References: <cover.1598887346.git.khalid@gonehiking.org>
 <8248a5f80a8aa7cd391fa36a907d342fad38563b.1598887346.git.khalid@gonehiking.org>
 <20200904151920.GA3414684@kroah.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
X-Pep-Version: 2.0
Message-ID: <5393eab7-8203-1696-ffc6-7e06cd63638a@oracle.com>
Date:   Fri, 4 Sep 2020 10:43:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200904151920.GA3414684@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 9:19 AM, Greg KH wrote:
> On Mon, Aug 31, 2020 at 10:08:43AM -0600, Khalid Aziz wrote:
>> With the USB 3.0/3.1 controller on MSI B450-A Pro Max motherboard,
>> full speed and low speed devices see constant resets making
>> keyboards and mouse unreliable and unusable. These resets are caused
>> by detection of stall in qtd_copy_status() and returning EPROTO
>> which in turn results in TT buffers in hub being cleared. Hubs do
>> not seem to repsond well to this and seem to hang which causes
>> further USB transactions to time out. A reset finally clears the
>> issue until we repeat the cycle all over again.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Cc: Khalid Aziz <khalid@gonehiking.org>
>> ---
>>  drivers/usb/host/ehci-q.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
>> index 8a5c9b3ebe1e..7d4b2bc4633c 100644
>> --- a/drivers/usb/host/ehci-q.c
>> +++ b/drivers/usb/host/ehci-q.c
>> @@ -214,10 +214,6 @@ static int qtd_copy_status (
>>  		 * When MMF is active and PID Code is IN, queue is halted.
>>  		 * EHCI Specification, Table 4-13.
>>  		 */
>> -		} else if ((token & QTD_STS_MMF) &&
>> -					(QTD_PID(token) =3D=3D PID_CODE_IN)) {
>> -			status =3D -EPROTO;
>> -		/* CERR nonzero + halt --> stall */
>>  		} else if (QTD_CERR(token)) {
>>  			status =3D -EPIPE;
>> =20
>=20
> Removing this check is not a good idea, any chance you can come up with=

> some other test instead for this broken hardware?
>=20
> What about getting a USB hub that works?  :)
>=20

I agree removing that check is not the right way to fix this problem. It
just so happens, the USB resets disappear when that check is removed. It
is more likely that check needs to be refined further to differentiate
between a hub that was unplugged (reason for the original commit) and a
hub that is seeing split transaction errors on full/low speed devices.

I am not sure if hardware is broken. I currently am using one of the
four hubs I have in a working configuration. The hub I was using before
motherboard replacement on my desktop stopped working with new
motherboard. Suspecting hardware defect on the motherboard, I bought a
PCI plug in USB 2.0 card but that showed the same failure. So I got two
more USB hubs just in case my existing hubs were broken. In all I tried
seven combinations of hardware and five of them failed the same way.
Every one of these hubs, keyboards, mouse and tablet works with no
problems on my laptop. All high speed and super speed devices (various
storage devices I have) work flawlessly on my desktop plugged into any
port or any hub. My desktop is a Ryzen 5 3600X in an MSI B450-A pro max
motherboard. Previous motherboard on my desktop was an ASRock Z77
Extreme motherboard with Intel core i7-3770. My laptop is an Intel
i5-7300U in a Lenovo thinkpad. Somehow hubs are getting set up
differently for split transactions full/low speed devices between two
machines.

Since I have a working configuration of hardware, my next steps are to
use my desktop with working configuration of hardware and then go deeper
into USB debugging to find out what is wrong with non-working
configurations.

Thanks,
Khalid


