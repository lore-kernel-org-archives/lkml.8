Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68893C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9F520658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="jI9IiBco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGZHKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:10:49 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:57862
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgGZHKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a/6YtpVBx6ut/6H01GHkDdZEwZkFmbmgp9fI9UowpI=;
 b=jI9IiBcoK5CVi623fE+I9194D00wapcswZAtlDUaO6fa3ViN9XSejR7eYCYbvhJwnWx02Rs+yZxyHiF9IJJ46BjIq4yUgFQQOsKMbuA8ppLlYDQYvN2bq8eeSxv/kLl1GbfHynHhXfzZSg8mMk8g1UhP27BJFMR8twbI6/2rvsU=
Received: from DB6PR0402CA0014.eurprd04.prod.outlook.com (2603:10a6:4:91::24)
 by VI1PR0402MB3600.eurprd04.prod.outlook.com (2603:10a6:803:7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Sun, 26 Jul
 2020 07:10:43 +0000
Received: from DB5EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:91:cafe::c7) by DB6PR0402CA0014.outlook.office365.com
 (2603:10a6:4:91::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Sun, 26 Jul 2020 07:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 DB5EUR01FT025.mail.protection.outlook.com (10.152.4.240) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.10 via Frontend Transport; Sun, 26 Jul 2020 07:10:42 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.56) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sun, 26 Jul 2020 07:10:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDaCSPLVrdYhoBaHs2gNyU2NH2AYrqCJ6vlR5kNnzBzxrn50mEacb7wyUmtMIUimTdznPuIJNQTCwExOt15crwnl1Bm7nPyinAzhtKOjZQCXQu4x7JfZHHtuFgOyhAHHJTMNOwz12uiaLJ62MAM+lqnb5o93BkCDwk03YCv6y9kQhKsNOK3SPDkPuIV86EpD5ZcKU6fEMPvdJsOl3gk91qiU2+vV9r2zDma+OfdZETwyx9N7HxeJXLWUP0U8GKd1Ay7rrfutVFMYe4cSfOIkhmJVal/OxWC33WhVQa4xHAeb/3+cdfjjGBdt2IkJwRKOfwaZoQywD9r7d8KlDwSruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPeNo9a3Y1GLKRFpjD7NW8/Pn90+P9YUFjuaWm80Y3Y=;
 b=WFyYMeRoDHcC0a0d6EX+zuKopsXfUcTcah0NX8v9q/L4cFnjg+cHhwzt0H7g6//mkneXHOhdwzA3UYKwEY8G4517iQt7qs5VenMOTpPWeth3+N1Dmg2ExHgtP6tegJLx0AuvxJYxNNvLnpBt2vSo2TgjauagkT6ARjxI2g0VXQ/eqHY220M4NZ67qDXcMzSuetqjjh2433vpsfx09HJMLvkQT1wCXzzb+qaDaW3gS+ZfRZp/hSeBIlDKOVr4ocQItOqMCKu2KuLEbjy6Y9hZZ0kH1kR65iJn/lbT6IK+KJpZcODnTSX/oIjChaC1/kf8ikNU0eh4WuKdLO/L0nxmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB7099.eurprd04.prod.outlook.com (2603:10a6:10:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Sun, 26 Jul
 2020 07:10:40 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::2d61:d6fe:3c2:3e14]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::2d61:d6fe:3c2:3e14%3]) with mapi id 15.20.3216.028; Sun, 26 Jul 2020
 07:10:40 +0000
Subject: Re: [PATCH v3] usb: dwc3: Add support for VBUS power control
To:     Mark Brown <broonie@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
CC:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com
References: <20200619142512.19824-1-mike.looijmans@topic.nl>
 <20200723075612.tn5dbkhes2chohwh@axis.com>
 <20200723110523.GA4759@sirena.org.uk>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2698920d-90ba-4c46-abda-83e18e2093c8@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.ac9c2a67-d7df-4f70-81b3-db983bbfb4db@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <e63ee918-c9e3-a8ee-e7c5-577b5a3e09be@topic.nl>
Date:   Sun, 26 Jul 2020 09:10:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200723110523.GA4759@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:208:55::39) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:208:55::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Sun, 26 Jul 2020 07:10:39 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 069b833b-04f4-44c5-a03b-08d8313302af
X-MS-TrafficTypeDiagnostic: DB8PR04MB7099:|VI1PR0402MB3600:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3600D5D3CDF9FEF60227F4B296750@VI1PR0402MB3600.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: HA0s6wHErHHf0niynuQrT6gghaCq18HAORZdX/bTcTZoRTL7RsmB/fWY9dxkMkKgfHqfr26wLS4eo6yQjZTfeHfdR7VYfbqobrkMpPIKSFZbBqAP+8JLZLk/7wj1HxFkrAv3U40UtN53JT6zXN5X/Boj7sHPzzuW/rFHU2YpIAYiXBlCC5W12nhSIJU01fczEAYjGFiL0Jha7nkig58gSFhC9l2kANj2DUb74L2XBjbRHUW6lXODlc3zCJe50M0OzU0GxXD2f4eGe5FmKok2sAyb3OX0fifRoR9BQ5N/lqdGhfI19Vab/q0AQ4nRYQyOYcdqCRdT5m9kVi/jPLEpS4gORWxV544tPqnqAd78cgEgTeLb5cWDgvXq0HYsFdf6
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(136003)(376002)(396003)(346002)(366004)(2906002)(16526019)(31696002)(2616005)(956004)(83170400001)(8676002)(26005)(8936002)(31686004)(42882007)(186003)(44832011)(36916002)(4326008)(52116002)(5660300002)(66476007)(6486002)(66556008)(53546011)(110136005)(66946007)(36756003)(316002)(508600001)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nLdmHEfs0zDCV/QqV8gt/OKQ7rW5VvSNrA8MjSYxNE/Ytk/F+Fz7O+P8fF/3pl5fBUJmuUjhdVoL0j4AMs+gITQY8pZxFB3VpLqoc8GfOh7HGE8MxbUD2ATXs8GD1mG9HKAlJLLAKWlYEriG7a5AwbuD28lkiT8TYqdtdg31QUeIFjyzoPuBShnlF4NfOPV+1HjbO9MapDW0QeY6nRb9NEiWDzJ1hLNPPskVoG4RjOGJTEYdGiogZIl6CBNFKeRTdwcO3yh2cotwe6W2pEdFRWuBqahx7H94i4iJ5DgTsXrPvj3qRtbn1GLcGG7bkgio+UpVI7lYnotm6jBOaKpbQlHRUr35D46FE0I3NkhoW2+25bJPwMxklhElVE0lC0vi4JoZz/5VdfTuoWkInqA8aD6LXldFHwiMnVFIt8CnS6rLO1BafYpMRLG4E7vQJgCHcEvhnCjWM2Z/21Br046pf+X8KG8/pMJ55nK7aiueeHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7099
X-CodeTwo-MessageID: 01625145-49fd-4b89-baf9-ea6ecc539900.20200726071041@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1b5312ae-4ee3-42d9-ac47-08d8313300e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYjW28ytRWBL5yF5/vQbbkowiblurVOA49LGyxySt8yKalkoGBUDLkXKPzJnm8YZw7ybQnavNIOY5JaWe5LptarrbeZvd4yNdfI/osKoFSFC7+pRg0stefV+nHtE62MVX/DEK8UQSi7pTnxrDzhnrGncuI/kLBTeb/HIWfPVb3tyVOG1tL7hMQFQTDOGCKX1IpmsrIc+ilYpFLBiAhdxL0eg6JZMyQZb9nQG7bYCxGx78Tb+XCGslZsPZJa7pgLoe05KQ+wXj9ccpAf05ALLIXnDeeepbLnimfkez79Ly/LHgc2InOpQY+Da8cY5HOEahu5Q/rFZ+hC3raUukbVycvpv/SUlRCtd5NqlyysZcKxG1VHHd0OTAbZSpd0c2Hx5KcG1XUr+EFTOswIftSMMK+KqEKHPRPBZx6WpMkyotIth0Jj2YtEXC1PQRWJpim1T0aNK8Wqooz5CfsrFfM4Z55Y6hHYy1v/DnLI9MTSAO7RTaBIjK6xblWUcXp0grI/3
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(39830400003)(136003)(396003)(376002)(346002)(46966005)(508600001)(8676002)(53546011)(15974865002)(36916002)(36756003)(31696002)(186003)(47076004)(5660300002)(6486002)(7596003)(7636003)(356005)(26005)(2616005)(83170400001)(16526019)(82310400002)(336012)(42882007)(110136005)(31686004)(70206006)(70586007)(8936002)(316002)(16576012)(44832011)(956004)(2906002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2020 07:10:42.9553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069b833b-04f4-44c5-a03b-08d8313302af
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 23-07-2020 13:05, Mark Brown wrote:
> On Thu, Jul 23, 2020 at 09:56:14AM +0200, Vincent Whitchurch wrote:
>> On Fri, Jun 19, 2020 at 04:25:12PM +0200, Mike Looijmans wrote:
>>> +void dwc3_set_vbus(struct dwc3 *dwc, bool enable)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (enable !=3D dwc->vbus_reg_enabled) {
>>> +		if (enable)
>>> +			ret =3D regulator_enable(dwc->vbus_reg);
>>> +		else
>>> +			ret =3D regulator_disable(dwc->vbus_reg);
>  =20
>> dwc->vbus_reg is set to NULL when the regulator is not present.  These
>> regulator_* functions expect a non-NULL pointer so a NULL check is
>> required before calling them.
> Does the device actually support running without power so that's a thing
> that can happen?  _get_optional() should only ever be used for supplies
> that may be physically absent.

It's the 5V VBUS power for the USB "plug" that's being controlled here.=20
It must turned on when the controller is in "host" mode. Some boards=20
arrange this in hardware through the PHY, and some just don't have any=20
control at all and have it permanently on or off. On a board where the=20
5V is controlled using a GPIO line or an I2C chip, this patch is=20
required to make it work.


--=20
Mike Looijmans

