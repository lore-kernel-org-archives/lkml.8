Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB075C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE4F206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5/MMJ5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgIARAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:00:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56828 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgIARAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:00:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081Gsr8o013992;
        Tue, 1 Sep 2020 17:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=aibERFvdWUYyUmBPyrFjkji1LkSFLR29QppeRLSjaDY=;
 b=H5/MMJ5QuXxZhpwreszvtwwTWXDkuqFToe0zYEtxEGW6D+CgiayRbUQORvvAoKQ7hhdC
 O2VNA5CkOp6VVHFr85FCmNfR/PJLQRtx3X3f/t8EVsInT2l3oKvVDqsuUDa6gKAoQRzl
 wtxZpDKhwAWlk8zCY1CPgJiHxCTxb2fGsb+ODuYpNdoXsrZ2JldTpWFToDyvkg8lG3QN
 +ZboiQURhXPZ+WWRBsmSqXjyM9WOkREjsRrn3i33QdweBmfeM4QM5+9YBt3A/6lmkxT7
 kVbJxm0kqo6WaUiAqvZwFBAjjdjZQv10E7y1KdTuLXfkK5Ve+pSsxBOc3es7pGSAI5+r FQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eeqwqw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 17:00:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081GxfIH029482;
        Tue, 1 Sep 2020 17:00:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3380xwsywp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 17:00:29 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 081H0RpH028907;
        Tue, 1 Sep 2020 17:00:27 GMT
Received: from [10.154.191.218] (/10.154.191.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 10:00:26 -0700
Subject: Re: [RFC RESEND PATCH 0/1] USB EHCI: repeated resets on full and low
 speed devices
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1598887346.git.khalid@gonehiking.org>
 <20200901023117.GD571008@rowland.harvard.edu>
 <608418fa-b0ce-c2a4-ad79-fe505c842587@oracle.com>
 <20200901163602.GG587030@rowland.harvard.edu>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
X-Pep-Version: 2.0
Message-ID: <4d1ab90a-ec55-85e8-d646-cfa58f08d449@oracle.com>
Date:   Tue, 1 Sep 2020 11:00:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200901163602.GG587030@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 10:36 AM, Alan Stern wrote:
> On Tue, Sep 01, 2020 at 09:15:46AM -0700, Khalid Aziz wrote:
>> On 8/31/20 8:31 PM, Alan Stern wrote:
>>> Can you collect a usbmon trace showing an example of this problem?
>>>
>>
>> I have attached usbmon traces for when USB hub with keyboards and mous=
e
>> is plugged into USB 2.0 port and when it is plugged into the NEC USB 3=
=2E0
>> port.
>=20
> The usbmon traces show lots of errors, but no Clear-TT events.  The=20
> large number of errors suggests that you've got a hardware problem;=20
> either a bad hub or bad USB connections.

That is what I thought initially which is why I got additional hubs and
a USB 2.0 PCI card to test. I am seeing errors across 3 USB controllers,
4 USB hubs and 4 slow/full speed devices. All of the hubs and slow/full
devices work with zero errors on my laptop. My keyboard/mouse devices
and 2 of my USB hubs predate motherboard update and they all worked
flawlessly before the motherboard upgrade. Some combinations of these
also works with no errors on my desktop with new motherboard that I had
listed in my original email:

2. USB 2.0 controller - WORKS
5. USB 3.0/3.1 controller -> Bus powered USB 2.0 hub - WORKS

I am not seeing a common failure here that would point to any specific
hardware being bad. Besides, that one code change (which I still can't
say is the right code change) in ehci-q.c makes USB 2.0 controller work
reliably with all my devices.

--
Khalid

