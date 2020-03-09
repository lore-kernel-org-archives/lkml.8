Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F63CC10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2596520674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="UfruMseM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCIH0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:26:52 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:22249 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgCIH0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1583738809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6j56N+oGDWSZld0vpKNO703/BsX2vuh7KvRq3S/0BS8=;
        b=UfruMseM6XbJiAxck+iW/RB3olWSor4KovFmmMbE/HgFzmN9ynxf/39QQwSeWCko41Vld+
        Y6nTpSeFrEavNxPIKJF/0fjNnCD22H9wLpDsOB8OKfQUDt7sDPn3dTfA5yEmGrk8fWrVEU
        rZuAIWODCIWq9a49M4ECySqX6IfuJgE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-XH0P4KF5OQiozH15H4AWYg-1; Mon, 09 Mar 2020 07:26:48 +0000
X-MC-Unique: XH0P4KF5OQiozH15H4AWYg-1
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB3311.EURPRD10.PROD.OUTLOOK.COM (52.133.244.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Mon, 9 Mar 2020 07:26:46 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc%4]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 07:26:46 +0000
Subject: Re: [External] Re: [PATCH v2 0/8] Add MA USB Host driver
To:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
References: <013d6b8e-3e61-b41d-614a-8c115f2e2c9f@displaylink.com>
 <1582727977.17520.30.camel@suse.com>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <02bda3b3-483f-9380-bb6b-a99741a27b59@displaylink.com>
Date:   Mon, 9 Mar 2020 08:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1582727977.17520.30.camel@suse.com>
Content-Language: en-US
X-ClientProxiedBy: VI1PR0701CA0037.eurprd07.prod.outlook.com
 (2603:10a6:800:90::23) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.183.132] (91.208.120.1) by VI1PR0701CA0037.eurprd07.prod.outlook.com (2603:10a6:800:90::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.9 via Frontend Transport; Mon, 9 Mar 2020 07:26:46 +0000
X-Originating-IP: [91.208.120.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b22b5521-9caf-4bea-0f2b-08d7c3fb3965
X-MS-TrafficTypeDiagnostic: VI1PR10MB3311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB33111493FAC2F25E6704779C91FE0@VI1PR10MB3311.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39830400003)(396003)(366004)(376002)(136003)(199004)(189003)(16576012)(66946007)(66556008)(31696002)(110136005)(316002)(31686004)(66476007)(54906003)(81166006)(478600001)(8676002)(6486002)(86362001)(81156014)(36756003)(8936002)(26005)(956004)(2616005)(2906002)(44832011)(16526019)(186003)(5660300002)(4326008)(4744005)(52116002)(107886003)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB3311;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WWFPn9Pv5PSJv/nxhGu6AKzYelDv17dMX2sCqY4YhDBOmbgCB7EehUhjLGaY4yhG6DomCAXN45OciNFytITesKDm8iijrbgkGNxXu5Sdp+bm+PrAcDkEGO2MJl3y3T+xpOotE9iq0Q4ExXz+UHCuSroHJKJEERGY2OUk9loevGT8eTiiMyq5zOidYnZm9lzcpKbmviWLC6JD5Yx9W0UWAcnyL6N5TKtQx741DPFW9kgswffAyALuioWRO5INB+mixW62ZEN9tbLH2kUMrh/4UPX1tv0LULSMQ/A5U4uxsb7D50ceuxPrdNfF3bMGuq/jpjPLrwp1J4zhd+yAeo7o+aY6etRqmRB7+6w6yr2H905LXKwQRRENI+OAU+2JYjKGijr6ezo4T8LxtLzJlr3jkLQoZjYj8z4Igp4v+q6ztFh1xZcgrLD8aZqj6858bJO
X-MS-Exchange-AntiSpam-MessageData: eTnMhJWJ98Pz85ibRghF0sV7uEUlCU9NYmpFoupBOSrt2ZX7uAU9rwISikAwuLU5GU4bIrYNM5DjrSRm4iOzfDVqiRHcDZj/NbC9PM2M24AigFOf4iWEZ9L0H81lrJ5qr7TtXlyPPUqJ7xuEdTji4g==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22b5521-9caf-4bea-0f2b-08d7c3fb3965
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 07:26:46.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52yGg8gt8xj2/zvhAG1zaFewvc6cxqvRXtwBNXXGlSvwU0u2oiQBUREubWhVg6xmb+ypqo93h3XzEDmsRX8rtbh55B2hphfpz5YOH0BgB0pLfv24JlhAe3zprAD5rFHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3311
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.2.20. 15:39, Oliver Neukum wrote:
> Am Mittwoch, den 26.02.2020, 09:57 +0000 schrieb Vladimir Stankovic:
>> MA USB Host driver provides USB connectivity over an available
>> network, allowing host device to access remote USB devices attached
>> to one or more MA USB devices (accessible via network).
>=20
> Hi,
>=20
> you are limiting this to IPv4. IIRC MA-USB allows for direct use
> of WiFi. Do you see a way of adding this in due course?
>=20
> =09Regards
> =09=09Oliver
>=20
IPv6 support will be part of v3 patch.

--=20
Regards,
Vladimir.

