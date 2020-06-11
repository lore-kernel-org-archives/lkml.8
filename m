Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE190C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2BA206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="BTTQ8ZMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgFKS0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:26:04 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:50519 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbgFKS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:26:03 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jun 2020 14:26:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1591899961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jJhc+bV4KHkBFgvBBIvRJTDxxrZSWptzciQqi4M/G4=;
        b=BTTQ8ZMI9gy6KXYzIBz0uPGF8dsLK5m5AsqWma+/ED1anPg5tCCqXtFUhZ/GOV1rcdbBi/
        KD2yxCt0MRPUjh9vdFzHS1DvgUvdHnQL6+b3gn6p/XoThZm5IK2NDPg1Mx6i4OywBUXCdU
        WYFajFzZOit9PqzKAl4cwTG2/++433A=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-210-aSl9mJuPM1mnL13RNF2UAg-1; Thu, 11 Jun 2020 19:19:28 +0100
X-MC-Unique: aSl9mJuPM1mnL13RNF2UAg-1
Received: from AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:129::21)
 by AM0PR10MB2386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Thu, 11 Jun
 2020 18:19:27 +0000
Received: from AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd:9bf7:579b:62b4]) by AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd:9bf7:579b:62b4%7]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 18:19:27 +0000
Subject: Re: [PATCH v6 3/8] usb: mausb_host: HCD initialization
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-4-vladimir.stankovic@displaylink.com>
 <20200515130312.GC1937631@kroah.com>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <5d9f7621-88a7-195f-979e-a31694128905@displaylink.com>
Date:   Thu, 11 Jun 2020 20:19:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200515130312.GC1937631@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: LNXP123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::25) To AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:129::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (94.189.196.243) by LNXP123CA0013.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 18:19:26 +0000
X-Originating-IP: [94.189.196.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46b2fab-b6bf-406b-72f3-08d80e33f9c3
X-MS-TrafficTypeDiagnostic: AM0PR10MB2386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB23867FBD40061FE8D4C6B5B891800@AM0PR10MB2386.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktLTW7kBciq0N55rs7nvDBt7ZVaWavMkUJxb4gCgYW8OSE5hXaSJihaPVozLVdg4O/OzFsj8VRtvbis2laQZmrUHvr+2QHUVRFE/d1WMwIJX3lqtpIcSL+AmyLKDs1GfxoxpsGDiuY0EGqXP3f9ztWZHLsR8FkbscRB7Eq8watZubViBJqMX15yGPXxNUE6dHy952q58+APvYDbGAVlEUPAgwQ0teNzBA2e3hTzONPVGYOf5dppSI+QKz56/+HYT0KBCJd4XRqlMvL3/u2PQ8B+RQO7yF0Wj3acC6qjvIht/XEgNvmABXWJ94aka6Z6pwhSL7YIQ82pviXzUXnC7Amxtw+3+ZSvx0fd2YpmJo2WJ71uWu6fEbC6X1usqavWr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(956004)(44832011)(66946007)(36756003)(31686004)(6916009)(66556008)(66476007)(2616005)(316002)(31696002)(4744005)(8936002)(8676002)(86362001)(16576012)(16526019)(5660300002)(4326008)(2906002)(107886003)(186003)(26005)(52116002)(478600001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PkPbyegoh7BAIX49Dwf95WdrMg/1m++Qo8RYLmSgNluNRZXwPs1+sbpql37qQQkz/j5GQdawMmf/78xUPUU6aHRsa8uMpxHkYrywFjCsz++Wc6skBbkLopV7/ivdLzKI6yfZx2sf2Y+7pR1VLBZt3F3swDAzGsvWD907G7YgupibRMWiDleZ4B/xHv/Yey3OSJZR49vRWe1xbbIpeC+MpjqYl8Rey+IP+kP7kPxzS/3s/ohELhfR+bgJD6ssUu0dq+kDju1Xa+8zwV0Kedl683+bVSoeVg2uM/Rh2Ze6XOPzQovbkd2V+dsKePb/k1Ji/+it14qAxQIxZqg5zj+bQaID9Sw8jgwSTV7d3dIWlG6mKdqLy84MIk0MvFkPMipJ10lEgrx3clpMHYtu6ATyOejCWrf+CsczwR3ZX08EpHYN1fo6ZuDhf0KOZtrBCNFper0pO7L4djKgr1mgyCejwKBtVk3WGkc2bTsbwepS1UM=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46b2fab-b6bf-406b-72f3-08d80e33f9c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 18:19:27.0671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jn6MNUo7dnxrkpOVzWDOzWg9rwzWygqOeucd737gS96Iv2n0WOCdsrs9ZIBJHTI4anDuztWALOMUJg5gmTycrvFjUa3DVEDm18iKGEHFBnntviEgaRPk79PJGu3HogFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2386
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.5.20. 15:03, Greg KH wrote:
> On Fri, May 15, 2020 at 02:34:57PM +0200, Vladimir Stankovic wrote:
>> Implemented HCD initialization/deinitialization functionality.
>=20
> Shortest changelog ever :(
>=20
> Please describe things better.
>=20
> thanks,
>=20
> greg k-h
>=20
Agree. We'll start adding a bunch of documentation and comments in
following patch versions - this was a quick fix during patchset reorg done
in initial phase of upstreaming.

--=20
Regards,
Vladimir.

