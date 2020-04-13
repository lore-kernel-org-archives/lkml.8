Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49DFC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7670F2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="g8hE5aW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgDMPQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:16:20 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:38515 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729618AbgDMPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1586790974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOtFhsbkk4dbjMeHoDTim3iujHv2hVTdsuobaZ0rcDk=;
        b=g8hE5aW0m4yp4fXYTjy/c22jNSFwuAoN2rtEmnkhMUFM9sll6yqaiJsshhGj7T1AOlExco
        YOgs0YX2GuJJwpSKfnQnZ7cyaT0emp57p16V+pmC2nZ9P+koRg500I92ZMGTBMoJKA9UWW
        NDFpEglKVWwYw4cFaEE4hO79GW7kOmY=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-52-ZmkiEsgRNDuYHAsK4wWUzw-1; Mon, 13 Apr 2020 16:16:13 +0100
X-MC-Unique: ZmkiEsgRNDuYHAsK4wWUzw-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1454.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:e6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Mon, 13 Apr
 2020 15:16:12 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 15:16:12 +0000
Subject: Re: [PATCH v4 4/8] usb: mausb_host: Implement initial hub handlers
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mausb-host-devel@displaylink.com
References: <Pine.LNX.4.44L0.2003271236040.14887-100000@netrider.rowland.org>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <cc081805-36c1-f01d-d461-cc10829ed9eb@displaylink.com>
Date:   Mon, 13 Apr 2020 17:16:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <Pine.LNX.4.44L0.2003271236040.14887-100000@netrider.rowland.org>
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::15) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (94.189.199.177) by LO2P265CA0195.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26 via Frontend Transport; Mon, 13 Apr 2020 15:16:11 +0000
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19996698-88e1-446f-e8e9-08d7dfbd99d2
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1454E3224BED2A309C40D34591DD0@VI1PR1001MB1454.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39830400003)(346002)(396003)(376002)(136003)(366004)(4326008)(6666004)(52116002)(8676002)(16576012)(66476007)(8936002)(66556008)(5660300002)(81156014)(6486002)(316002)(107886003)(36756003)(66946007)(956004)(6916009)(186003)(2906002)(26005)(16526019)(31696002)(2616005)(478600001)(86362001)(31686004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGuEXCiv6qQIO3LA5qKdEnaiFBcStCkIjp2L4PDpXbU+2CRPh4JmY4Cx2dpf47Z7KMwKDNv1lOY5Aud2GqDcIxRhAGM9BvwE1zBcjc1wmPVpFQDPgW/2b+16s81rs4VbabnMfw8DCZZGZnSpCyMh8k3fyLFPKfkYXn+gSjjrXqJgYKZXljyM5zbxHJACeDWLTwjQDABUw7DUk2g9CtcYYZDdF5pLqzrGaLnUqEN3GnGmYo0vn3NAgUXg1cWxV5jIEu6ZE2ed6bmMc/gjsJCIQATo1fVAcsg+955uB27KawOyhStRw4PQjxmvXGf42OI9nQNP12nSCeeZTVEk+mpnQY/y7LVOJIjIAycSGkVOZ3EYQbMkNQrPvvjJmBNtmmgSrkHfgsY0CNUvhRRW70vkZ4DwFfcdVDcITmhpnKJNp2Edts4P/3Sm5jxWHEF2s8CE
X-MS-Exchange-AntiSpam-MessageData: SxJAKOKqv21Fb2jdvxP9sn3fjp6LA/gFbMTJdCTXCi7B7DFM96YhXuADScy5TpR6HSp/+23TEi4SmjZtLYK8ZpXjv1neoZJSLgsWxoT5LqY2B52lmtDCktoU23tSpyOUCsjE1H5lv6gsumszLWXoxw==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19996698-88e1-446f-e8e9-08d7dfbd99d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 15:16:12.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RxzspluueFc8rjaknRfKNoqqpfC7x2uaGpGB15qNsOacGJ4u1udEk10fFWehZVKyDFR2U58KcVZCHezwCnfSm+8BQSM87jpr/4re8j/W9bcAPmfsxfqsKfPCBeYRi/r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1454
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.3.20. 17:37, Alan Stern wrote:
> On Fri, 27 Mar 2020 vladimir.stankovic@displaylink.com wrote:
>=20
>> Implemented handlers for subset of HCD events.
>>
>> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
>> ---
>> +/*
>> + * For usb 2.0 logitech camera called multiple times, once during
>> + * enumeration of device and later after mausb_reset_device.
>> + */
>> +static int mausb_address_device(struct usb_hcd *hcd, struct usb_device =
*dev)
>=20
>> +/*
>> + * For usb 2.0 logitech camera called multiple times, once during enume=
ration
>> + * of device and later after mausb_reset_device. In latter case it is
>> + * required to address the device again in order for ep0 to work proper=
ly.
>> + */
>> +static int mausb_enable_device(struct usb_hcd *hcd, struct usb_device *=
dev)
>=20
>> +/*
>> + * For usb 2.0 logitech camera called multiple times,
>> + * followed by either mausb_enable_device or mausb_address_device.
>> + * Resets device to non-addressed state.
>> + */
>> +static int mausb_reset_device(struct usb_hcd *hcd, struct usb_device *d=
ev)
>=20
> Why on earth do you have all these comments about Logitech cameras?  A=20
> host controller driver shouldn't care about the type of devices it gets=
=20
> connected to.
>=20
> Alan Stern
>=20
You're right. As it turns out, it is leftover during development.
Implementation has been tested with cameras from other vendors as well.

We'll remove those in next patch version.
=20
Regards,
Vladimir.

