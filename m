Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C782074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="tSzYE5hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEOMfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:35:24 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:59569 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgEOMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1589546119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJBXvSMQXbw6pX6LZRQCOMkllPcDqAoI51LFmB1eHsc=;
        b=tSzYE5hDAWoTpXIGH2OIDDRNHMBTXQNS+kTHVNtSAElYhWer04qCUnvaRbxZjn4D3YSbKL
        yqCyNMUerwOii1uTCYeu+Py3ALx28CqMeb95C53rC3jxUhzQeUnCURf1D5G/LuU1SQvbJD
        SaI7qCCLSLObwFMET3mgOzpv4hXmtxA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-247-PaLfHvWuPemn8TPGDNJUfg-2; Fri, 15 May 2020 13:35:18 +0100
X-MC-Unique: PaLfHvWuPemn8TPGDNJUfg-2
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1230.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 12:35:16 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7%11]) with mapi id 15.20.3000.016; Fri, 15 May
 2020 12:35:16 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v6 0/8] Add MA USB Host driver
Date:   Fri, 15 May 2020 14:34:54 +0200
Message-Id: <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR09CA0140.eurprd09.prod.outlook.com (2603:10a6:803:12c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Fri, 15 May 2020 12:35:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90ad8091-048a-4145-0e57-08d7f8cc6b99
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB12308B095F10143D1B3A470D91BD0@VI1PR1001MB1230.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vpg94IWn8UfkD7f++OJLLSdcB7BbZPiapfL8Hv0d1xgJ8zDpTu/a/i+x1EXJfRjTTvlpZI78kdGyjZwkLKzwix0wSMq5w7d0Uok4p/wK0jIDcx3bPC2CFcrgibTFU4gkSOsdqouEZXs870tKwBkJDVWYV+ATXxLCiuVoAA9khw/IYV7wDeeTZal6z57jn6e5M818i+pSvgKQcuKWWtAvREXsDyfW1BrYSX9iA4JW3nP6373fnv3b8XfYRQuW9kYLa1c/hj4823UhN715JDu3s6PlFbZ6YwaytGLwtmR9wlA3YUJX1by2mB0R8bAqfgNIe3q7YIIOWSpoxzrZG7FV+mVub9yWwhXX71i0P7QdDchoLyE4Ie8Q1RoP400BuUkCv59tcRMf0p8OlQD9WI22TPCQG6AtN3Z+0w5+gsdEwnpvdLHLLcnS+qSpftiiJwgu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39840400004)(366004)(346002)(376002)(36756003)(86362001)(5660300002)(107886003)(6666004)(66946007)(66476007)(66556008)(2906002)(4326008)(16526019)(956004)(6486002)(8676002)(186003)(8936002)(6512007)(6506007)(1076003)(478600001)(26005)(44832011)(6916009)(316002)(2616005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SblHJoRbajM672MPyPfNzsDs36RwhpF53JlIJ7bWU5uVv+Gy501jzihmXhmG0Q77C217C4cl66Kz4uLADi9H4REapYGMpSFFUdD7lvj/55BhVjUoA9RMRui4czdieopS+jNHkBEiQQ832mUJY2ulUAUfdWeQ3zEMZuzKfmZ+JkYa2GUmjXn++DZ9AhSbaPNP5hG1vSpseQCR+j2s9KlMhz3DkWhC2Km9bFbtqlKM1/I8OufSqP5pF55YLgxkiPf+Z54QJXMKvYZn9r5PSsBYpTs7fG61dB/BmwW22wSAAMIS+KKyoiVahhnrg00VniwdVlJ9gmeKTSkmDNOwJAUb5rnZty17DDC3Hyh/Oqn+V+eS0vsFFkvo0w3MDtkiHeznBXlo7CDqq6dQgTJ+fNkTIXyTX+o12b6kN+TFoDofxF29jYHbp99nUrw7S4dRedMV8IK61ioCkGoBGkD8iPyC7VV9Do8qurnkY1y/yby67q4=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ad8091-048a-4145-0e57-08d7f8cc6b99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:35:16.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgeooecx6iKdlNFbK3WTZM8dyM2/U+Uhpednvyrb1QJX2Rm+vP5xh09+dcKiQQ6EJNNkHXspKuSknHIbflQBAsHZ97JzDwV7AR0XobWf2pUJ1eTkFsksJOZdZy3nmdZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1230
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Media Agnostic (MA) USB Host driver provides USB connectivity over an
available network, allowing host device to access remote USB devices
attached to one or more MA USB devices (accessible via network).

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

v5:
- Updated kernel configuration with MA info
- Addressed build warnings for c6x architecture
- Fixed coccinelle warnings

v6:
- Changed module location to drivers/usb/host/mausb
- Switched from custom to dev_* logging
- Utilize misc device for the driver
- Removed versioning info from log entries

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
 drivers/usb/Makefile                         |    1 +
 drivers/usb/host/mausb/Kconfig               |   15 +
 drivers/usb/host/mausb/Makefile              |   15 +
 drivers/usb/host/mausb/hcd.c                 | 1780 +++++++++++++++
 drivers/usb/host/mausb/hcd.h                 |  154 ++
 drivers/usb/host/mausb/hpal.c                | 2094 ++++++++++++++++++
 drivers/usb/host/mausb/hpal.h                |  340 +++
 drivers/usb/host/mausb/hpal_data.c           |  713 ++++++
 drivers/usb/host/mausb/hpal_data.h           |   34 +
 drivers/usb/host/mausb/hpal_events.c         |  614 +++++
 drivers/usb/host/mausb/hpal_events.h         |   85 +
 drivers/usb/host/mausb/ip_link.c             |  367 +++
 drivers/usb/host/mausb/ip_link.h             |   88 +
 drivers/usb/host/mausb/ma_usb.h              |  869 ++++++++
 drivers/usb/host/mausb/mausb_address.h       |   26 +
 drivers/usb/host/mausb/mausb_core.c          |  191 ++
 drivers/usb/host/mausb/mausb_driver_status.h |   17 +
 drivers/usb/host/mausb/mausb_event.h         |  224 ++
 drivers/usb/host/mausb/utils.c               |  317 +++
 drivers/usb/host/mausb/utils.h               |   16 +
 22 files changed, 7969 insertions(+)
 create mode 100644 drivers/usb/host/mausb/Kconfig
 create mode 100644 drivers/usb/host/mausb/Makefile
 create mode 100644 drivers/usb/host/mausb/hcd.c
 create mode 100644 drivers/usb/host/mausb/hcd.h
 create mode 100644 drivers/usb/host/mausb/hpal.c
 create mode 100644 drivers/usb/host/mausb/hpal.h
 create mode 100644 drivers/usb/host/mausb/hpal_data.c
 create mode 100644 drivers/usb/host/mausb/hpal_data.h
 create mode 100644 drivers/usb/host/mausb/hpal_events.c
 create mode 100644 drivers/usb/host/mausb/hpal_events.h
 create mode 100644 drivers/usb/host/mausb/ip_link.c
 create mode 100644 drivers/usb/host/mausb/ip_link.h
 create mode 100644 drivers/usb/host/mausb/ma_usb.h
 create mode 100644 drivers/usb/host/mausb/mausb_address.h
 create mode 100644 drivers/usb/host/mausb/mausb_core.c
 create mode 100644 drivers/usb/host/mausb/mausb_driver_status.h
 create mode 100644 drivers/usb/host/mausb/mausb_event.h
 create mode 100644 drivers/usb/host/mausb/utils.c
 create mode 100644 drivers/usb/host/mausb/utils.h


base-commit: 24085f70a6e1b0cb647ec92623284641d8270637
--=20
2.17.1

