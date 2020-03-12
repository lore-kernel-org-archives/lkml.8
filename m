Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A7C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA152071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="FB5O/arS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgCLOmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:42:25 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:49930 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbgCLOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1584024141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R5IdgNseernW6eeYDT3ug8vPqyZRfh3nmsZ+M5JDabg=;
        b=FB5O/arS9JfRCbYMFjCs5TDCC1THV/m7wqTjHnUOliQ9JldLQbact1NmcuZg09V2D/ZgUB
        vo1eTpuGvyQsFfoyARX4YsQmYmCm7f7lwW+nMWt/UWGqbs2kVi120MszjEpG85FuaA4bIU
        SaoeqZr3efrDQoMHxNAEKa6LMxqumnA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
 (Using TLS) by relay.mimecast.com with ESMTP id
 uk-mta-211-ksR818cOOHy1roYoqFkhIg-1; Thu, 12 Mar 2020 14:42:19 +0000
X-MC-Unique: ksR818cOOHy1roYoqFkhIg-1
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB2206.EURPRD10.PROD.OUTLOOK.COM (20.177.60.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Thu, 12 Mar 2020 14:42:18 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc%4]) with mapi id 15.20.2793.013; Thu, 12 Mar 2020
 14:42:18 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Subject: [PATCH v3 0/8] Add MA USB Host driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Message-ID: <8c24bff9-79a6-ca53-ce8f-fb503163db24@displaylink.com>
Date:   Thu, 12 Mar 2020 15:42:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Content-Language: en-US
X-ClientProxiedBy: VI1PR07CA0241.eurprd07.prod.outlook.com
 (2603:10a6:802:58::44) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.183.132] (91.208.120.1) by VI1PR07CA0241.eurprd07.prod.outlook.com (2603:10a6:802:58::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 14:42:18 +0000
X-Originating-IP: [91.208.120.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4c7887d-d9f0-4665-0d00-08d7c6939075
X-MS-TrafficTypeDiagnostic: VI1PR10MB2206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB2206057FE769063C70E8F46D91FD0@VI1PR10MB2206.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39840400004)(346002)(376002)(396003)(136003)(199004)(66556008)(66946007)(316002)(66476007)(81156014)(2616005)(956004)(44832011)(26005)(6916009)(2906002)(4326008)(16526019)(107886003)(31696002)(54906003)(5660300002)(36756003)(6486002)(81166006)(8936002)(186003)(16576012)(6666004)(86362001)(8676002)(478600001)(31686004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2206;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjmwj1q8M5dz3KSya/GYjjntCkthQmzVqWNyD4VOkcQSfIT60Scvmme+iWLTlLJ060ySd4ETIXDgir61pisltXbXrjaQZBCPqhC1+qxz71+nNqvd7eD+oSC11DtWhNJiECCn3uLzarr6QxDUPPX6rEX3cL76On7rKaf/RyKBDLyZyfxBjwi4mtf2v5C543liMIdw8PAxPQUkqnefG7Wu8IiIN8jZ6YUun6Wp76CBOgb6ZNqxMJSpA7vu2aSUAXOCcYtvRaIGBV4PJY9Z5b2Fslg/DnIFfcarAv8172+N06OJVmRbwXfF30pv2DX6quEAawFXQXA0heTgUYXLFaS1glFm72ld5kpz1TsglxdY/eUW3RXISzookTaSJvAVDO1HDLScJF7BVLs28cP875t84di0N8q/Mxb/m97SeFakF3gZVz5u23iGYVYZpgrOpLbP
X-MS-Exchange-AntiSpam-MessageData: 2YvLhHkmBNIJn/tE3fsN9eEBOdteiZv29Kb+eTVp8wDSDzQVuszPwt9jI6I9BlKH73QIC10800/GHKe5AkNjHrlhtblLnLVnjQRzmUwUp6Fwqjcxie3SYbmojPAHwE8iHekY319fpnogX23AV+KTOQ==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c7887d-d9f0-4665-0d00-08d7c6939075
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 14:42:18.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPAi2dUL0baIImOEomx9EVPLv87OuA8X5YlmF4P8NOd+TJSQ3FlnTvmT59KOEmwPVtA53jUoqW+S3SpokAWCywe9SpatXw5+JetTuLNPJI7+dSBLNfk4I3YbOXsGFkxu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2206
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Media Agnostic Universal Serial Bus (MA USB) Host driver provides USB
connectivity over an available network, allowing host device to access
remote USB devices attached to one or more MA USB devices (accessible
via network).

This driver has been developed to enable the host to communicate
with DisplayLink products supporting MA USB protocol (MA USB device,
in terms of MA USB Specification).

MA USB protocol used by MA USB Host driver has been implemented in
accordance with MA USB Specification Release 1.0b.

This driver depends on the functions provided by DisplayLink's
user-space driver.

v2:
- Fixed licensing info in headers
- Reorganized code to lower file count
- Patch has been split into 8 smaller patches

v3:
- Fixed nested spinlock usage
- Implemented IPv6 support

Vladimir Stankovic (8):
   usb: Add MA-USB Host kernel module
   usb: mausb_host: Add link layer implementation
   usb: mausb_host: HCD initialization
   usb: mausb_host: Implement initial hub handlers
   usb: mausb_host: Introduce PAL processing
   usb: mausb_host: Add logic for PAL-to-PAL communication
   usb: mausb_host: MA-USB PAL events processing
   usb: mausb_host: Process MA-USB data packets

  MAINTAINERS                                  |    7 +
  drivers/usb/Kconfig                          |    2 +
  drivers/usb/Makefile                         |    2 +
  drivers/usb/mausb_host/Kconfig               |   14 +
  drivers/usb/mausb_host/Makefile              |   17 +
  drivers/usb/mausb_host/hcd.c                 | 1897 ++++++++++++++++
  drivers/usb/mausb_host/hcd.h                 |  162 ++
  drivers/usb/mausb_host/hpal.c                | 2083 ++++++++++++++++++
  drivers/usb/mausb_host/hpal.h                |  339 +++
  drivers/usb/mausb_host/hpal_data.c           |  719 ++++++
  drivers/usb/mausb_host/hpal_data.h           |   34 +
  drivers/usb/mausb_host/hpal_events.c         |  611 +++++
  drivers/usb/mausb_host/hpal_events.h         |   85 +
  drivers/usb/mausb_host/ip_link.c             |  374 ++++
  drivers/usb/mausb_host/ip_link.h             |   87 +
  drivers/usb/mausb_host/ma_usb.h              |  869 ++++++++
  drivers/usb/mausb_host/mausb_address.h       |   26 +
  drivers/usb/mausb_host/mausb_core.c          |  212 ++
  drivers/usb/mausb_host/mausb_driver_status.h |   17 +
  drivers/usb/mausb_host/mausb_event.h         |  224 ++
  drivers/usb/mausb_host/utils.c               |  360 +++
  drivers/usb/mausb_host/utils.h               |   45 +
  22 files changed, 8186 insertions(+)
  create mode 100644 drivers/usb/mausb_host/Kconfig
  create mode 100644 drivers/usb/mausb_host/Makefile
  create mode 100644 drivers/usb/mausb_host/hcd.c
  create mode 100644 drivers/usb/mausb_host/hcd.h
  create mode 100644 drivers/usb/mausb_host/hpal.c
  create mode 100644 drivers/usb/mausb_host/hpal.h
  create mode 100644 drivers/usb/mausb_host/hpal_data.c
  create mode 100644 drivers/usb/mausb_host/hpal_data.h
  create mode 100644 drivers/usb/mausb_host/hpal_events.c
  create mode 100644 drivers/usb/mausb_host/hpal_events.h
  create mode 100644 drivers/usb/mausb_host/ip_link.c
  create mode 100644 drivers/usb/mausb_host/ip_link.h
  create mode 100644 drivers/usb/mausb_host/ma_usb.h
  create mode 100644 drivers/usb/mausb_host/mausb_address.h
  create mode 100644 drivers/usb/mausb_host/mausb_core.c
  create mode 100644 drivers/usb/mausb_host/mausb_driver_status.h
  create mode 100644 drivers/usb/mausb_host/mausb_event.h
  create mode 100644 drivers/usb/mausb_host/utils.c
  create mode 100644 drivers/usb/mausb_host/utils.h

--=20
2.17.1

