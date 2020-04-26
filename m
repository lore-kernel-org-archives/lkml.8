Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63194C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB6B206CD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="Px2TTiFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgDZMdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:33:15 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:36923 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgDZMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1587904391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=73bYSNjAIG8h7FjkczmpGhuUSgoCWA9KHzAr1OKKiN4=;
        b=Px2TTiFQ44HVAEVXORZm3OjP4JV9DfRL3fSgjb64pbXOOZb4t0EhJMsXYg5zoadNfHoB7I
        37uXHIddeTgQWcTqsQgnRt6TYUK6tmeycuMHvL0TtlVdvf8cOOBhIrs9/jslOAiKUg4zMl
        5tqE1oBJoZdM4MJi1BusPi3PgY+rawQ=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-117-hhlPHE5pOWK1GIOdiHQI6A-1; Sun, 26 Apr 2020 13:33:09 +0100
X-MC-Unique: hhlPHE5pOWK1GIOdiHQI6A-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1232.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:dc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 12:33:06 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 12:33:05 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Subject: Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mausb-host-devel@displaylink.com
References: <Pine.LNX.4.44L0.2004252027360.13475-100000@netrider.rowland.org>
Message-ID: <48e45671-1f07-c994-8083-04199822c818@displaylink.com>
Date:   Sun, 26 Apr 2020 14:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <Pine.LNX.4.44L0.2004252027360.13475-100000@netrider.rowland.org>
Content-Language: en-US
X-ClientProxiedBy: LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::16) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (94.189.199.177) by LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 12:33:04 +0000
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23285bb-3822-47f4-7414-08d7e9ddf7ab
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB12329126574F656C8058865191AE0@VI1PR1001MB1232.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39830400003)(956004)(2616005)(26005)(44832011)(6666004)(2906002)(36756003)(478600001)(81156014)(186003)(8676002)(8936002)(86362001)(31696002)(5660300002)(66946007)(16576012)(16526019)(4326008)(6916009)(52116002)(6486002)(316002)(107886003)(66556008)(31686004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X299i9Vvy352Ry7mSy0KNymxH1B4HQtNPCGZWAFRdr9ceHhLCIJvvzMkYYpkBa/QGS4AlnXAH3yQKt9WcHwOOO3SZNzcbyjEnK81cqbHi1iUqdcgEThe5UQl0Hum2FBV75lI4+1ChKmGipoQjFHpSZuuMgC6kBGlDw0YOkwg2lkWfrJaBu0TqF/k3MmqvMe2LrI44/iKb8sPdeACNzm3xcCp3hBy9dc+ZT4vQLTGWihEF1ZFijLTRWcX6I+XYCWKNNCZOo5+cNbH/Hv8V4YNk+sruE2qUHnwk6gyFN9z1+bOrUd6NDJrbwABg+iIYBnOxT5h2JnAFX4EpjPSELNly7PYINyRK9L731O41mahqP/wR2U7s+AMeaZfmmSiHAHjd7VQIhozulj5u9emNCEQvn/dbNcMujAjBwqLrNSk1XSSLT3pYl4i1sOM8V2XzKmj
X-MS-Exchange-AntiSpam-MessageData: 0pDktgiIIGBRzTsZmjMXU//9aBc+2R9jSkQrVYvFc/esQSRrV1vUdClUb+JlI6I8VNJf4A0YI1QY4tly4ltfP+jw/M+mRU9p/OwlI99r3+aOmWih1bD4suGkxdzzEHVRKGxI0PdqUVHQitD2SMZbPeYLbBgc7wTi6MwQZ7gE96u1O6v4ZuQKdzBlV3vPO2bspN7xIQVLhpxtwqvVkPEoUkCk1EtvLABCX8cuHrCYpaXxNcZr71OLxvA04hZi9B4nUbH56xQQfgyJo5IU028Qu8A+rpaPPiSeP8U6w7q8WL4XxVmVrDGVMt+Mifmy8WZ1aGhFuqV1mJtZNlVLv0XMA2qGsaGyj8zBBPDiH2L8fgMZI0cHJUBdhVRR/feFlg4r/uKAGLrvQ2BBAhtHTzoFDQ8idpftXPdXCPasUZ1Zr1U59zqoLPq4BUYnMvJ8yaKtpbNTzQzxGXxPE9DFZX62KdZuTSjDvED/LK6me8wUj7es/0qpT0+mtGievkPNyrUOKv13HfY2NXy+qjroZ+jBxTR2tPHDeSX+gdsvD50IW2FVXiLiLEQbIKKZhze1CMrtXKhZJLeXANM85ARJuobHWrTuiV3KsZ37LFimI7TUXMn0YYfdtViVejvbVnnqsbxdz8dzKcnXPvYXU4KGr1GCGU6cp9NDNsiS8JZll5y8Twjfc1QPUxzoyLnelLD/5+PK93bPTk/XVSwDmYxWhStr+Pa5kdzDljUY8jnyFvWUMj/pI20cdL7E5ALQ11MBp8as+/eaGQlqi2YSqU+nqa68RU83Y/e2PJgPxq5ZFvEMU+8=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23285bb-3822-47f4-7414-08d7e9ddf7ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 12:33:05.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVsr2kQrwQSu/ONy9neoyk/6Zpskg0ykX+eEfAhuGwZeBX9/lVurAr2B//SWeh5DqlAsl7EqHqePWAWf+URTDkj1SDmgiZ1pyFTkDj6mOfTAuj//+JSL+XZAeHMgbb/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1232
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.4.20. 02:32, Alan Stern wrote:
> On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:
>=20
>> Protocol adaptation layer (PAL) implementation has been added to
>> introduce MA-USB structures and logic.
>>
>> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
>=20
> ...
>=20
>> +=09/*
>> +=09 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where i=
t
>> +=09 * should not, so it is breaking the USB drive on the linux
>> +=09 */
>> +=09urb->transfer_flags &=3D ~URB_SHORT_NOT_OK;
>=20
> Removing the SHORT_NOT_OK flag is _not_ a valid thing to do.  It will=20
> cause drivers to malfunction.
>=20
> Can you please explain this comment?
>=20
> =09What SCSI driver?
>=20
> =09When is the flag being added?
>=20
> =09How does it break USB drives?
>=20
> =09Why haven't you already reported this problem to the=20
> =09appropriate maintainers?
>=20
> Alan Stern
>=20

Hi,

Issue that removal of SHORT_NOT_OK flag addressed is linked to particular
set of Kingston USB 3.0 flash drives (super speed) - other USB flash drives
haven't had this flag set. Without this "fix", those Kingston flash drives
are not being enumerated properly.

This particular line was added in the early stage of development, during
enumeration process implementation. The reason why it remained in the code
since is because we haven't noticed any side-effects, even with various
USB devices being attached to remote MA-USB device, including flash drives,
cameras, wireless mice, etc.

The problem has been reported, and is actively being investigated.

As soon as it gets addressed properly (w/o global negation of the flag),
a new patch will be pushed.

--=20
Regards,
Vladimir.

