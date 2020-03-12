Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C11CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B044206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="TSGsROt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCLQYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:24:01 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:49238 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbgCLQYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1584030238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfe3yZIQd262IIPGQ/j+WLth856bk7lXY/5X+w6TGgg=;
        b=TSGsROt24sS/sJDxtzK6OFj9xt8iem+3Vb/SlEmhnAzGfiTjHcIbtp0Bw3UYZiLXVZLSmU
        nUVUxaKZKf2ntc1M7F54bqDMG0JWDJae7W8okA1hLGMfNZIZMLxHeBgZWDQJR8oXgDRWQ0
        dOAU3Mv2vVdflhgd2Dkj/+6ouCdiV1I=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-52-7hawdrWGOzmqhHYLC7xyBA-1; Thu, 12 Mar 2020 16:23:57 +0000
X-MC-Unique: 7hawdrWGOzmqhHYLC7xyBA-1
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (52.133.244.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 16:23:55 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc%4]) with mapi id 15.20.2793.013; Thu, 12 Mar 2020
 16:23:55 +0000
Subject: Re: [PATCH v3 1/8] usb: Add MA-USB Host kernel module
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
References: <efe5dbe1-4bd7-43cb-1eea-b6b999dd15e6@displaylink.com>
 <20200312152037.GA383349@kroah.com>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <a950d4e0-b9e6-ef44-9c83-35958154b36f@displaylink.com>
Date:   Thu, 12 Mar 2020 17:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200312152037.GA383349@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.183.132] (91.208.120.1) by VI1PR08CA0192.eurprd08.prod.outlook.com (2603:10a6:800:d2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Thu, 12 Mar 2020 16:23:54 +0000
X-Originating-IP: [91.208.120.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 942dac3d-7a8b-41fc-81b9-08d7c6a1c26e
X-MS-TrafficTypeDiagnostic: VI1PR10MB3167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB3167A8DE077DF75AB2BD86EB91FD0@VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39840400004)(199004)(16576012)(66946007)(2906002)(5660300002)(316002)(4326008)(36756003)(54906003)(6486002)(52116002)(956004)(2616005)(66476007)(66556008)(44832011)(966005)(107886003)(478600001)(8676002)(86362001)(8936002)(81156014)(81166006)(6916009)(31686004)(186003)(26005)(31696002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB3167;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCbVs3SK9zVeEHJlm550SKCrnrfNaeYX55vbWpeV+sWELcuLKVyju7KvI/UzNUucD5OToIAInt/tI8Le3X8HbWxVePk6zFFQYLGD3Lc8qgDDneFcj8HhTM1KV1Kl7Ecwz0ODI1kobYA8m7wEPR2A/dY2wWknGQ89nZYm/5WBg75/VyJRU3FIw8WDP7jz/OdSYkDvDAT9eMaHqgBzmsXsuBwBgB/a8IADP2Zlzz86eAQ7CH8RbbqaORwzvUMBm65HdHKjXEq3uItLzDKJSEwrEah+1OpIIi0OaKOYHydehSTH2LjGBazw36Yfo0jngUNOxUgDKX+uOVKaiWYMJWX/80MD4XlwmazrEIFGKq1X8I6jexGnBnwH9fjHV+V7EfdARXWTOe0waNEde6nR5W9UJx6KhQOM9JoVqjpyMdvyaxNuV5iEf/+BNiUBZ4t3wuc5F+Pfywu31OOfrOZfly0u3Ch55lT0gZZKKg7vUUt1qq8fg2sGHzzy0AKf3DpUmIjDifTpyXQ14QjWWekxcsGlEQ==
X-MS-Exchange-AntiSpam-MessageData: HRg4/ksBClWNbG1UlQ2YDipTQcXdPG9zbZIQQXnyfpCARR4RxkrlXvLKsLnvA9fGuKMsD4E8fuQN8i22a9hGqTcCXfqXnloef20RJv7kFY07CEkVskg+Ws+1YWLhNTTVEz9qgYMwYEfhxRDpAmoRow==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942dac3d-7a8b-41fc-81b9-08d7c6a1c26e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 16:23:55.2019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFkJmKXG3KYtYrnG5rKMID8lpdJqJ5qcCSZU3EiCKkmOakbBAW11vfRAphHBux6FxAnuhcvrQtt6R5N1kzDlVbdLyIjWpeCh/f02LurxtxbLKDG1coVSiRFnKW6nBghg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3167
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.3.20. 16:20, Greg KH wrote:
> On Thu, Mar 12, 2020 at 03:42:30PM +0100, Vladimir Stankovic wrote:
>  > Added utility macros, kernel device creation and cleanup, functions fo=
r
>  > handling log formatting and a placeholder module for MA-USB Host devic=
e
>  > driver.
>  >
>  > Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
>  > ---
>  > MAINTAINERS | 7 +++
>  > drivers/usb/Kconfig | 2 +
>  > drivers/usb/Makefile | 2 +
>  > drivers/usb/mausb_host/Kconfig | 14 +++++
>  > drivers/usb/mausb_host/Makefile | 12 ++++
>  > drivers/usb/mausb_host/mausb_core.c | 90 +++++++++++++++++++++++++++++
>  > drivers/usb/mausb_host/utils.c | 85 +++++++++++++++++++++++++++
>  > drivers/usb/mausb_host/utils.h | 40 +++++++++++++
>  > 8 files changed, 252 insertions(+)
>  > create mode 100644 drivers/usb/mausb_host/Kconfig
>  > create mode 100644 drivers/usb/mausb_host/Makefile
>  > create mode 100644 drivers/usb/mausb_host/mausb_core.c
>  > create mode 100644 drivers/usb/mausb_host/utils.c
>  > create mode 100644 drivers/usb/mausb_host/utils.h
>  >
>  > diff --git a/MAINTAINERS b/MAINTAINERS
>  > index 235ab38ed478..12aac44196d7 100644
>  > --- a/MAINTAINERS
>  > +++ b/MAINTAINERS
>  > @@ -10226,6 +10226,13 @@ W: https://linuxtv.org=20
> <https://linuxtv.org>
>  > S: Maintained
>  > F: drivers/media/radio/radio-maxiradio*
>  > +MA USB HOST DRIVER
>  > +M: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
>  > +L: mausb-host-devel@displaylink.com
>  > +W: https://www.displaylink.com=20
> <https://www.displaylink.com>
>  > +S: Maintained
>  > +F: drivers/usb/mausb_host/*
>  > +
>  > MCAN MMIO DEVICE DRIVER
>  > M: Dan Murphy <dmurphy@ti.com>
>  > M: Sriram Dash <sriram.dash@samsung.com>
>=20
> Does that patch look correct?
>=20
> Does this apply?
>=20
> Something is odd here :(
>=20
>=20
>  > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>  > index 275568abc670..4e92f1fa0fa5 100644
>  > --- a/drivers/usb/Kconfig
>  > +++ b/drivers/usb/Kconfig
>  > @@ -164,6 +164,8 @@ source "drivers/usb/misc/Kconfig"
>  > source "drivers/usb/atm/Kconfig"
>  > +source "drivers/usb/mausb_host/Kconfig"
>  > +
>  > endif # USB
>  > source "drivers/usb/phy/Kconfig"
>=20
> Yeah, something is really wrong with your email client :(
>=20
> Can you use 'git send-email' to send all of these out so they do not get
> corrupted?
>=20
> That will also fix the lack of email threading which this series still
> has as well.
>=20
> thanks,
>=20
> greg k-h
I'd say it's the issue with mail server used by company, since patches=20
and mails were generated via git (i.e. used git imap-send to create mail=20
drafts). One of the reasons we've sent attachments in the first version=20
of the patch was to avoid weird mail client/server issues.

Anyhow, I've tried applying diffs from linux-usb mailthread and from=20
patchwork, and that failed as expected, stating that patch is corrupt.=20
However, comparison of those diffs with the .patch file generated with=20
git, provided somewhat odd result: only first 30+ lines of the diff=20
(mail headers excluded) contained additional space chars that are not=20
part of the git-generated .patch files (specifically, a single space=20
char is added at the start of each line that is not being modified by=20
the patch itself; only Kconfig, Makefile, and MAINTAINERS are affected);=20
the rest of the diff (new source code) matched with .patch file.

Been expecting "tabs vs spaces" issue that is specific to mail=20
clients/servers, but this makes it a bit odd.

Will check if this issue (prepended single space chars) is already=20
reported/fixed within the community.

Regards,
Vladimir.

