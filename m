Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB77C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3C220748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="g8HtRbp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgC0P0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:26:35 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:35767 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgC0P0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1585322791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3l5GNSaZLOK8H0VrY4857keIqqb1qMgiOQTpyLfBESo=;
        b=g8HtRbp/rFtmIhwPo4BLlkgtlyiwCDCJXFql3dYhHorbu8vEI/TsPaznE6Y5cB0Qd8yHoB
        uLhmZE9zoTYIJIRoWgsU4Q3J4c3/hGInwjM+PZPj3uvVJI8bFuLag/nPWDtM7X3W4qn/SV
        NdkXem8MWzdp1bEugWyXw0EiWs21lZw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-145-sL5xLStXNkuelsvazCI0VQ-1; Fri, 27 Mar 2020 15:26:29 +0000
X-MC-Unique: sL5xLStXNkuelsvazCI0VQ-1
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM (10.255.30.19) by
 AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM (52.134.81.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 27 Mar 2020 15:26:27 +0000
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab]) by AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab%6]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 15:26:27 +0000
From:   vladimir.stankovic@displaylink.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v4 0/8] Add MA USB Host driver
Date:   Fri, 27 Mar 2020 16:26:06 +0100
Message-Id: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8c24bff9-79a6-ca53-ce8f-fb503163db24@displaylink.com>
References: <8c24bff9-79a6-ca53-ce8f-fb503163db24@displaylink.com>
X-ClientProxiedBy: VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::19) To AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:28::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Fri, 27 Mar 2020 15:26:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb31189c-78cb-498c-077e-08d7d26337a3
X-MS-TrafficTypeDiagnostic: AM0PR10MB1939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB193991A69172903E76A1BFBA91CC0@AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39840400004)(396003)(366004)(136003)(376002)(346002)(2906002)(316002)(66946007)(66476007)(5660300002)(4326008)(2616005)(956004)(66556008)(16526019)(6486002)(6666004)(36756003)(186003)(81166006)(81156014)(8676002)(8936002)(107886003)(478600001)(6916009)(1076003)(86362001)(6506007)(6512007)(52116002)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WM20QdcYtQDDY8iMnVtBZGQ0sN7yB3kZ7eGYucdi0AUsDq3oUL1QygpT819jdlgs79mn8TmNrYN1t1KctmKdbERGkCW3ckyNXf1Pa98DWOg2znxUA63gT/NqIPZQ0+OREfdD68y3l1/P/T2E1PThI8HIFpVjXd/lzhglCLbwqxaDNZCQrjXHeCZI5UaA81h4G8+kYsOyRs2C1bUAqaLZRXjc6lwaEnmaGbOUst67NQzS3gm4gpJBd8C46rGtKBde4uy+qn+mnkrA3Er2s4AaBdcldEvhrug3azyy/TysYaOnbUY84XWcpJReBRePfcxDub+2U3He9+3E7G91FoSubls76PTTgW2L+67D9+ScJ4hFz0IHt4ve5maV40Az+0WzkKZAfw9fzYh+w65aPHtdLuKWFPGELZRmzX0ynJZ99YM2SHJZf4pfVO9+2/3NcZ+x
X-MS-Exchange-AntiSpam-MessageData: 5hqr0SAkuotslne3QX8yB3wagzVfrMEkA08PEfaze50JdtPtNL2L2aB7Vgt0RokfimEiJjYDT+2TKXEIahaGZw4NJVwBgh4bSxx2JPkYs6nM/OBwsuibK9DJMFmxXMQqTCfE2T52XbS1tizQ9/JXew==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb31189c-78cb-498c-077e-08d7d26337a3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 15:26:27.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phyGHC4R41YGIcsbs+GlzH9iLk4ConAgzJY1LK+USOhBQc+0+dwbGz81Wu2CgnQ/vCXjnx/sGLqTPZd13ZdBs1sbFHUP1Zh6iGPIf2o+l94y5SY86Gpu5RPKf7ZDzl7x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1939
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
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

v4:
- No code changes
- Re-sent patch with different mail client config

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

