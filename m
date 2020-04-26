Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D4EC55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F32206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="atP5rfBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgDZOpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 10:45:39 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:29566 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgDZOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 10:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1587912337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MqrV7PzcGM+Tx8r0dwdcXCPpTW8yidqSPETSRomd5w=;
        b=atP5rfBLlF3vvtQRTx5vwThnaLkFMCiYd+xe3XcdoZGdYdGCgKxlvJUbrW7HrwVVeh1tiE
        2rJg6EL+GECF/4jXgVIs/wg3f6qpKuZOxGINA+flrM+9R6CBqpf+qs9z0ouLRN+1jWnODj
        xFdPDVvBg/ub4bZu6JALjV1Z4rlNsS0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-VGW5YQGFM9aJprls0MNvFA-1; Sun, 26 Apr 2020 15:45:35 +0100
X-MC-Unique: VGW5YQGFM9aJprls0MNvFA-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1438.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:de::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 14:45:32 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 14:45:32 +0000
Subject: Re: [External] Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL
 processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mausb-host-devel@displaylink.com
References: <Pine.LNX.4.44L0.2004261025550.15458-100000@netrider.rowland.org>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <871dcf46-19f8-f152-99c0-8185832ed109@displaylink.com>
Date:   Sun, 26 Apr 2020 16:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <Pine.LNX.4.44L0.2004261025550.15458-100000@netrider.rowland.org>
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::24) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (94.189.199.177) by LO2P265CA0324.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 14:45:31 +0000
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 907d431f-0edc-4c98-0535-08d7e9f078a0
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB14388E3210BB3A31D7EB153091AE0@VI1PR1001MB1438.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39830400003)(136003)(396003)(376002)(346002)(31686004)(8676002)(478600001)(81156014)(44832011)(2906002)(52116002)(8936002)(6486002)(316002)(4326008)(31696002)(956004)(2616005)(186003)(16526019)(86362001)(26005)(107886003)(66476007)(66946007)(66556008)(36756003)(16576012)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwOOE+bKjDFwFWay3COg3uT+NVTfrk3q4ZwLBhMUyyqG8IWNDSOJO6qjiOBtfTlmLUoGutDJoOQU88KM+FoCTMXH9Rnr59exFwWbqMWP6pa0xCApf0rhKWtHPQQH1XRmzk+/DdAK/DGIPvH09al65FTUyj9NHBo7nI9ziy02pTn3txgqrh1Kr+PeYruvFV7qwMO/oXakNNZZhQofzg9MbEuayC9Q7ZB2kFn181WUPm3PEiYyPgXTR529PuTzuAOIcLimhJdymLrbGDbFWnSx7Ba0zVpNDE/mZqWlClnZrrC9ABxs7v384h2NME2MMOVyoQbMYL8cm0P5Ci9sHSiogg5hG5xoIh9rv/9qIDwsSY0+hFFbmLGob2B80mEKgNUUCn8VGvZ5zN/wlZxUW+9Nuu1CqGQKPTlCMLa1s4xwouTEmZb7Fp0ZlLAfTzoGZCNX
X-MS-Exchange-AntiSpam-MessageData: jpdJ6GFQPBJHKGdA8oI6NJ92eKcqOIIjilZr8XBkvS/R5rM4YBMMBN53vA8R1ScUb/huSUQ2Ji9bs9po2g07E8ZcIe7Ms747GbRsm2nsnDSRQBp7GpJH+MTBo7TskdoZvPPLZARvYFEkC1GFvWbMbl/0uzJKkOgJUczB6G/3WOgMolcw7JtLADOhGDjMXy8h+RFd/RnJ30bj0vA0paKaCu0QY7AIsXfMmwtsj30OAIjwQRT4XyHUGFdf/Lw7MkzGe/ZnSSGjqltfUQJK/uCFTYm+v8XZq+jrZyATH7kcFDQg09S1upMva0gCsCOdPml2s+ysVkQSi16XiInKXiIrAiBjMu2kCFIF3/QcCDfPhINTmhRedXMVmNMarkazg+YXPef8yI6IHX9FIX784OJ4btML0YsPvWxn7dneLKD8roBEq5rnUGSqcqWMNY1km5W6T29P3VDcMe8YMu3Eojc18/Gp6lDOzBVT4bp7CT52bJDVLMlTtuWEgXVb1gNt51CV/fRg98k4SvSHWQ8DNGVp6/+8Si/TJwNwFpNKjNk/6HqQxl8r4ZHge535/jlrZmCM01pwdhbceN8DEk6wPCNS4A5UGOGktgMvFk7HR96rQM526NozS+ZUshrvEZpz+ylnKggh4aLGwtE1x8VWeR3b1Byzm1iXrQzbjvntGIO+vp2qpkMMre2is3d9mR++ZLPeGxlxFZGFBN5F468LUWaJ7jk1hv5cEW+KNoGejT5XMCI1J8MECMSvR9hfgYVIaUv2as/R7C4jiFjVqJGnlGYZrxXfr4sIhYsfpqyWrU5RShI=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907d431f-0edc-4c98-0535-08d7e9f078a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 14:45:32.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZndGvEIfEDDzfbU14aVUg7Z4Q/7OC/otbmsEOmmmpFAQAvhdWi4pTF5N6bqfaOQ1BoOLrwCQJp4sx3BURs1TClIgNx1GJh1lqrCV/j2r0fx3CikiCSuaHUNuirGL7yw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1438
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.4.20. 16:31, Alan Stern wrote:
> On Sun, 26 Apr 2020, Vladimir Stankovic wrote:
>=20
>> On 26.4.20. 02:32, Alan Stern wrote:
>>> On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:
>>>
>>>> Protocol adaptation layer (PAL) implementation has been added to
>>>> introduce MA-USB structures and logic.
>>>>
>>>> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
>>>
>>> ...
>>>
>>>> +=09/*
>>>> +=09 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where=
 it
>>>> +=09 * should not, so it is breaking the USB drive on the linux
>>>> +=09 */
>>>> +=09urb->transfer_flags &=3D ~URB_SHORT_NOT_OK;
>>>
>>> Removing the SHORT_NOT_OK flag is _not_ a valid thing to do.  It will=
=20
>>> cause drivers to malfunction.
>>>
>>> Can you please explain this comment?
>>>
>>> =09What SCSI driver?
>>>
>>> =09When is the flag being added?
>>>
>>> =09How does it break USB drives?
>>>
>>> =09Why haven't you already reported this problem to the=20
>>> =09appropriate maintainers?
>>>
>>> Alan Stern
>>>
>>
>> Hi,
>>
>> Issue that removal of SHORT_NOT_OK flag addressed is linked to particula=
r
>> set of Kingston USB 3.0 flash drives (super speed) - other USB flash dri=
ves
>> haven't had this flag set. Without this "fix", those Kingston flash driv=
es
>> are not being enumerated properly.
>=20
> Please explain in detail how the enumeration of these Kingston flash
> drives fails.  Or if such an explanation has already been posted,
> please provide a link to it.

Will reproduce the issue once again (w/o the fix) and run through the event=
s.
Issue has been noticed during early development, and addressed right away.
>=20
>> This particular line was added in the early stage of development, during
>> enumeration process implementation. The reason why it remained in the co=
de
>> since is because we haven't noticed any side-effects, even with various
>> USB devices being attached to remote MA-USB device, including flash driv=
es,
>> cameras, wireless mice, etc.
>=20
> Come to think of it, the SHORT_NOT_OK flag is mainly used with HCDs
> that don't have scatter-gather support.  Since your mausb driver does
> support scatter-gather, you most likely won't encounter any problems=20
> unless you go looking for them specifically.
>=20
>> The problem has been reported, and is actively being investigated.
>=20
> Where was the problem reported (URL to a mailing list archive)?  Who is
> investigating it?

Ticket has been submitted to DisplayLink's internal issue-tracking system
and is being investigated by mausb-host-devel team.
>=20
>> As soon as it gets addressed properly (w/o global negation of the flag),
>> a new patch will be pushed.
>=20
> Thank you.
>=20
> Alan Stern
>=20


--=20
Regards,
Vladimir.

