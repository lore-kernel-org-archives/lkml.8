Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B578C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A3E2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="n6DJtLO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgEONEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:04:45 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:56238 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbgEONEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1589547881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKEZdJGhF2cVc1g6JBViuNWXzNsaYXpIbUVf1+I8MIk=;
        b=n6DJtLO5ncRjK3tsb383Hdz/ZMC51cXDtZjNdDPfTd10AMSxpDHW0qAuGD6RMWrwsieogL
        daZWueQUSUVVc1ZPVxpXYGTli0oIwxYZPzfZsa15b8rd5ZYtYdO0lSVsZvAFJTMFlGgK8l
        Oxj7XY+J+JsTn6avo2laRuUOZSXWOD4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-119-H5MYv2odMvy08970U_L5LA-1; Fri, 15 May 2020 14:04:40 +0100
X-MC-Unique: H5MYv2odMvy08970U_L5LA-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1151.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:6f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 13:04:39 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7%11]) with mapi id 15.20.3000.016; Fri, 15 May
 2020 13:04:38 +0000
Subject: Re: [External] Re: [PATCH v5 0/8] Add MA USB Host driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
References: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
 <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200428110459.GB1145239@kroah.com>
 <b14a2f71-3931-8d32-43a1-cbf52add48bb@displaylink.com>
 <20200430200238.GB3843398@kroah.com>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <f0a4432e-d14a-0108-7d6e-edb648b6393f@displaylink.com>
Date:   Fri, 15 May 2020 15:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200430200238.GB3843398@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0417.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::21) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.21] (94.189.199.177) by LO2P265CA0417.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 13:04:38 +0000
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42a55bbc-fb45-4b0e-94ca-08d7f8d0864b
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB11514D1F8634F29888D955A391BD0@VI1PR1001MB1151.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1f3unZpHP8qOQ1mlawR90jKUpMSgEECxQw/XG79a8QvcA+VpR1QywqRvq1UuTZsECGoIJeu9pcHsFAwSK5QjdOjShtqQoOEC1xEjZfk5WMP9bgL9dLgj9LgbzQUrtTWucs8d5T97HYVe7zp0i8XSU0MXLc8tIWvRERPSC1arIV+jcuAzeWo76uGwln0YqPos0smwq7SFtgaYo+1fPcpgCaLyb4pzq+c+ycTCloxee5oqj3F7H5OfcvKXnUx7rs1whNsSwAgqsNa0LzwKL/0F8x46yqNEXhbTqtd9KIRLCMw8o3jnl1lqpI6BH121XbkyaIs/PhbCLWCTXyFZO5p/vPkGCazxzJn7sMdg98OOUOKmuO8MiC35ULmlFGW5wIOr49g7bREHvT02Pi0T43Ay2efAnVZLusMqf+NaeHRQyJS8c0wNo1SBK8oNSfx4vpVWe5ulFrjWG+cjRz31/LwO0dlqgthpL8xdnRr3lJ/Qgh995kR9O6cp4Nay/dlXEC3x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(39840400004)(136003)(346002)(5660300002)(36756003)(4326008)(44832011)(66946007)(6666004)(478600001)(107886003)(66476007)(66556008)(16526019)(31696002)(8676002)(52116002)(31686004)(6486002)(2906002)(8936002)(316002)(16576012)(956004)(26005)(86362001)(6916009)(2616005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: o6dtzsF+zh/jsu3SW/RKBiET9WL+VhpZudzS4NnXmjblb9Kdy75JYKa+w4SbSKaZE8++y5gy324jcQTkpAsCR2CWcfpgDzfCsWI4v2AFxC5D6r0FCoq3WW1GN7n7YzhmVGPmGWIMuweajFdRBJtCZ92dYydQApk9bW52X8bkrbpsWmz+5wM83VpWFSVKF4wLggxbPiWRGHYmYqa3p236gEuvlWbTYj8JzqETMvxMn3zmqHnn06ITaK477S5PWUuwT9hiWwJ594jdYwcRKWej1Spg9EkAC7gfalpDcnAT808RFxjwZxob8mRaC5xbXc+F90YfZnOjIwaE6vOTBKfZO5cKu6JVd5Zb7EnnLP5uAO+GqwGKTBedqdBMUCPO+0w3Jizjx32z3XuPnblDAGhG33W0qHr23F04wigfIYIIWJ/aHhFi70wVO24wEs/hCLQh4QQ8WV6GSBEdzj618BEkf7oxCg5yIX5KmpA8iMBywfE=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a55bbc-fb45-4b0e-94ca-08d7f8d0864b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 13:04:38.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/MAA2kovE8vg6DcxsgriV2ZPn3ahoY99ZYZ2qwfJPc+i4X4djHju8uOLf8QZ8LERmUw64VjF5rEzw9W106GEiVVMb9GuFq7+zAyKdAqgf1mEvnWZDXfK2WfCFosEJYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1151
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.4.20. 22:02, Greg KH wrote:
> On Thu, Apr 30, 2020 at 06:51:10PM +0200, Vladimir Stankovic wrote:
>> On 28.4.20. 13:04, Greg KH wrote:
>>> On Sat, Apr 25, 2020 at 11:19:46AM +0200, vladimir.stankovic@displaylin=
k.com wrote:
>>>> Media Agnostic (MA) USB Host driver provides USB connectivity over an
>>>> available network, allowing host device to access remote USB devices
>>>> attached to one or more MA USB devices (accessible via network).
>>>>
>>>> This driver has been developed to enable the host to communicate
>>>> with DisplayLink products supporting MA USB protocol (MA USB device,
>>>> in terms of MA USB Specification).
>>>>
>>>> MA USB protocol used by MA USB Host driver has been implemented in
>>>> accordance with MA USB Specification Release 1.0b.
>>>
>>> Is that a USB-released spec?
>> Correct, document is being maintained by USB IF and is publicly availabl=
e.
>> However, I just noticed a typo, correct version is 1.0a. Will correct.
>>
>> In short, MA USB Specification defines an MA USB protocol that performs =
USB
>> communication via any communication medium. As such, it defines how to p=
ack
>> USB data within MA USB payload, and how to communicate with remote MA US=
B device.
>>>
>>>>
>>>> This driver depends on the functions provided by DisplayLink's
>>>> user-space driver.
>>>
>>> Where can that userspace code be found?
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>> Userspace code is not publicly available. However, in short, it's purpos=
e is
>> twofold, to provide interface to application layer, and to prepare MA US=
B packets
>> that will be used by remote device.
>=20
> So you want us to take a one-off char-driver kernel code for a closed
> source userspace application for a public spec?  That feels really
> really odd, if not actually against a few licenses.  I hate to ask it,
> but are your lawyers ok with this?
>=20
>> Related to userspace related questions (i.e. comments around two devices=
 used),
>> we can provide detailed description of the used IPC. In that sense, plea=
se state
>> the most appropriate way/place to state/publish such description (i.e. i=
s it ok
>> to add it within the cover letter, or publicly available URL is preferre=
d).=20
>=20
> I asked a bunch of questions about this in the patches themselves, you
> all need to document the heck out of it everywhere you can, otherwise we
> can't even review the code properly.  Could you review it without
> knowing what userspace is supposed to be doing?
>=20
> But, note, I will not take a spec-compliant driver that requires closed
> source userspace code, nor should you even want me to do that if you
> rely on Linux.
>=20
> So please, release the userspace code, as it's going to have to be
> changed anyway as your current user/kernel api is broken/incorrect
> as-is.  Why not just bundle it in the kernel tree like we have the usbip
> code?  That way you know it all works properly, and better yet, it can
> be tested and maintained properly over time.
>=20
> thanks,
>=20
> greg k-h
>=20

We've started internal discussion around user/kernel IPC.
Other comments from v5 have been addressed within v6.

--=20
Regards,
Vladimir.

