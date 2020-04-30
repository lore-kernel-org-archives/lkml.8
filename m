Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A17C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC9F2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="e+nMu4IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgD3QvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:51:20 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:45510 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgD3QvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1588265476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlxOSzY7DyqQ922sFYFaHGINUH00ScHBA82oF/NegS8=;
        b=e+nMu4IXDMqT+fCOb8vTwln9hidEa8B0NVa1jboY7cfuLeLXun5XMiz4AyTEemLgDW1w9f
        L5ScsCIbLvE91BgetFIUtx8Q7yDJ76HGb3pJe/8eO4WpraTZarA/rAvMSl91yszmBTC3vX
        R/J0eGvPKEB2907rzSwmcD9/rgOWil4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-261-DCnm9DRTPBS4IHXDb2v0xQ-1; Thu, 30 Apr 2020 17:51:15 +0100
X-MC-Unique: DCnm9DRTPBS4IHXDb2v0xQ-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:6f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 16:51:13 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 16:51:13 +0000
Subject: Re: [External] Re: [PATCH v5 0/8] Add MA USB Host driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
References: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
 <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200428110459.GB1145239@kroah.com>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <b14a2f71-3931-8d32-43a1-cbf52add48bb@displaylink.com>
Date:   Thu, 30 Apr 2020 18:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200428110459.GB1145239@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: LNXP265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::17) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (94.189.199.177) by LNXP265CA0005.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 16:51:12 +0000
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3cf2075-9f5d-447d-4e1c-08d7ed26b0f1
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB10232E5B3AB0A308F9AFEC6D91AA0@VI1PR1001MB1023.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8EGsi/dw/EVkQV/+9QoN8ycwNpT1aSHq18kLcYOlaXX/mOSC9GX7ZdtL0EMTFpfAYLhKUAmTHnPvAPGhZ7jw5VfbMHg/QB59vT4tL7Tc3x6nYaLstGSUy07m6xEZut0JuPzHB5phgF1dkV0DnMrQqNdFBACC8B21gL6ShOUbaS2VgsBde4dHdh7ywrpe41iTtpGt1Cond+VSB2Uic5ZJ3MwBLv3WByrH+cgFKpsthifEnsTaaCNBNg9Ipsukuj+JN9H14krXcdZSXnWd6r12AeYVDou1EZ4VitosJuUOiDiJpIpXrzd2DwzmoMd2nn572RQAIJ1vu3u0Ta601Y9xhPJiMrSkC9us6FBe7tFNRxAl1LdzhepZvrhqivJCin88I8es3PWd8PbCrhGnrkpEW7wWvKWBKBgrOhOydvNke7pbjrd9nZFx+aoROcMD2bO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39840400004)(346002)(366004)(136003)(396003)(8936002)(6916009)(52116002)(8676002)(31696002)(36756003)(31686004)(2906002)(16576012)(316002)(66946007)(4326008)(86362001)(107886003)(16526019)(26005)(186003)(956004)(66556008)(478600001)(2616005)(44832011)(5660300002)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: l18Woqx67z0ho64q9DB+OTmOuZOhSMdQbz/I5fWvHt/zUdRW3RwBvptZWj6MtU/TPIsXvVDPtXDDqcxOiSuJnUgtkoO7vMa+TEBQtRjHp8b4Ce5wGSVwm9onWZlXW6cgQ62ND4nehat0j0SCHb3wm4e3NEhuF+MO/Ln3EyASfZWrFGDEZRwAToMi6OzGqKXsJzax2XO0yX6KonOD/787R/ymViLQGeddEBmKlCcxj0k1/F+9+iUZEfVgopjeWNhI2QwU9Arh5JDzkbEP6S8mhfc4maSSpKehzEhX70XFNWVp1UKm1MYHi/tXsBCOIb4ImWAd7Kc3XMgQW0KoNYPghEMosPCjhYIdvxBJPIUbw96BtbskYn3xMxvGpSLU0YKqcqKn9wATaH9MobU92KTTpV4REEaFDcEHMaD971NwT8Sv1WN9gK3VFtH7ljACVx4tgAdkSaQuhaDIXRSrdy0PQOtdqPPWfBQK/M9AQFHEj8tHWmWCfHqxEqshykt/WcYSvyGCsHVeoJHb7ldsraYZKjmp8KbKeKnK8TMYxoMuqNeTKQvJYzrodxcvEnf+LTYSu/swxUg0axuLdxzFow4YXBUhSz7HnyHtmgpdTKfiLKPovCXYdCf0qimmkyWQv71cIBV0Lqeuc0ZKLV+cJLRjQKD0UiH1F0HanldOo8ypYJ6QqSDhfZOKIlRZjunbSGshDrGM0t9m+tXSVPTucXHJTuBLLDzuUGufe0qVYvIAL+GDusp1GDjs1hsINQBhMfLC3wnvYigycx2fZmV3ga2UHVKe3pNZq+HThSBT14OvgsA=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cf2075-9f5d-447d-4e1c-08d7ed26b0f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 16:51:13.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eambabzkrvs6t+IYUQYonYbrcLrp9mTAHhhSP5OhK+pzQO+CDVClkuFbihkwIclGiQzmQ3XLj1XiwZ0YraG4PKJERHMHJgPImIIs7f5RXCahRtocmZ7P1cfbWV8E9Eor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1023
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.4.20. 13:04, Greg KH wrote:
> On Sat, Apr 25, 2020 at 11:19:46AM +0200, vladimir.stankovic@displaylink.=
com wrote:
>> Media Agnostic (MA) USB Host driver provides USB connectivity over an
>> available network, allowing host device to access remote USB devices
>> attached to one or more MA USB devices (accessible via network).
>>
>> This driver has been developed to enable the host to communicate
>> with DisplayLink products supporting MA USB protocol (MA USB device,
>> in terms of MA USB Specification).
>>
>> MA USB protocol used by MA USB Host driver has been implemented in
>> accordance with MA USB Specification Release 1.0b.
>=20
> Is that a USB-released spec?
Correct, document is being maintained by USB IF and is publicly available.
However, I just noticed a typo, correct version is 1.0a. Will correct.

In short, MA USB Specification defines an MA USB protocol that performs USB
communication via any communication medium. As such, it defines how to pack
USB data within MA USB payload, and how to communicate with remote MA USB d=
evice.
>=20
>>
>> This driver depends on the functions provided by DisplayLink's
>> user-space driver.
>=20
> Where can that userspace code be found?
>=20
> thanks,
>=20
> greg k-h
>=20
Userspace code is not publicly available. However, in short, it's purpose i=
s
twofold, to provide interface to application layer, and to prepare MA USB p=
ackets
that will be used by remote device.

Related to userspace related questions (i.e. comments around two devices us=
ed),
we can provide detailed description of the used IPC. In that sense, please =
state
the most appropriate way/place to state/publish such description (i.e. is i=
t ok
to add it within the cover letter, or publicly available URL is preferred).=
=20

--=20
Regards,
Vladimir.

