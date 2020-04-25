Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F3DC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB76D2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="KkK71qCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDYJUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:20:21 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:34231 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgDYJUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1587806415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWmHQ7TqnUwTOSqjURO2avUgpvbQDuZhnWbVVnlFCls=;
        b=KkK71qCKJs/eo71TbM1qOvSHNDyLWatcry2hBAatjSf8wLC+AATDuUP3e5nv2b+ahUi47Z
        WyzLAaikHrikZVmpzsckelAKBAPF08lNE2D6P7KNqaHxM2I1cTm2qNW5L7+nqmhF4LW8sT
        v3V37IzC51hGZo1btx8b9kcM7yOs0LE=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-233-hIbZqVSwO5Sd4dvbv3S0tA-2; Sat, 25 Apr 2020 10:20:13 +0100
X-MC-Unique: hIbZqVSwO5Sd4dvbv3S0tA-2
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 25 Apr
 2020 09:20:09 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 09:20:09 +0000
From:   vladimir.stankovic@displaylink.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v5 0/8] Add MA USB Host driver
Date:   Sat, 25 Apr 2020 11:19:46 +0200
Message-Id: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
References: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: LO2P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::23) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by LO2P265CA0131.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sat, 25 Apr 2020 09:20:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b297b9f8-7b5c-42c8-0949-08d7e8f9d9a8
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB105616F8A5F26AEF8278B2AE91D10@VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(39840400004)(396003)(376002)(9686003)(6512007)(8936002)(66946007)(316002)(52116002)(66476007)(6666004)(5660300002)(8676002)(66556008)(81156014)(1076003)(86362001)(6486002)(478600001)(6506007)(956004)(6916009)(2906002)(4326008)(26005)(36756003)(2616005)(186003)(16526019)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1ZT/uEvbhF/fvEEkrSw5aSOe6hUSXtGFlgcd3JNRX2IausZglghSloGEGhaznJf0QvSojFQvco0/Ly3RQH0fdVaChhhDmZRKc3Xa9EJmWQv7OGHQpEtFDbmPG9B1hZD8iXlU9ECvXaRzs+HxVTQvcwAqCKwDbXQtRKNE+cA7YzBu1pXevxX8NhsBHp4GtaYFZc1Ux1LFk5C7iUGG44Fweqnc3Ajq8fU4cFvouzpY9HAnxaBXiXQsr+MbpIwq2dH1dIU+zTIszkejCIsVk3dY2Fa1dYEUzRntVQTmddbP1PloKAqJQiEMuyFhqSIb+4Mq8yKH7C6Bsj0NevGeZBizjhB9ZjddHiYt+240uD2M0rhSriE51++92qtS316TPUqDeFETLmnyYLhL2bkRt4TfdOnoOWUT1Oo1KxguEwgHuaOGCBDb8U6eJDxsvcr4avS
X-MS-Exchange-AntiSpam-MessageData: UxcVXsoIZtqudmeZlVXMIHXsPPbtAdDFG22vmTOUkxOmnmaJbM4pl+fL+qmNJEm7NpBjQUGXTlAUUqmnSshCOGJ/2EYqyn3/DpNNf8v11Pdk7cdrVcPNM4wpwFjXVJVyOrT4GpxrHYk6iTqsy5c6RdlTWTGOwRDFOgGeRZmdgZKA2EchJTR13gi5ZDqcLBMiqgvr2v3RQey9Zm77Zc3a/8i9DG3FgdFGQbr6Bw0noQUksCga2IbQAFpAwbgEkSHgaJTGoZV5KWNj/XF3ufK15Ch6zd+M4f/EYcR8YqjHT9NZ9vHF7e9dI4dpxZretNkusnCHCvJkCM84eiKx8GTtiWeMU82Tagu1YRb5sryoMyaG4Ooi8OWoEAbZaOnLtqNEMbkY0j/PwME//ofNx8xgQC44UR3CoPK5xdclrZxKP9pXfu0zQLXtaWk6cr1o1MDS5vGHLsX4F6u9O79W5F8K4lhiqg+0ny6UThm+6639FWho3R8GtQRzwVxyjH8PRklkNObStn0lyVRhrHoCDawcN9Ra8TLGEcBJ4TcrZogtW6sTMUU2fORkhijZmhc3qQqI1ijpJWUTkBIv645yABxahcHZaYw9I0hoa8TQQ7wo1pFTrg00LVRMHzif45XV4+I0Zr/4cfuowjG51DOKfyFjoK3NxzKSdL2cG/E0gRukdZmaAscvPRtlcmVVdUgtaFg/ZW3QmYmYNMTaGzIf6lRyyCOSYCOcY2bZoJ0juPlbtehBuqm1OuCRijKtB1Z+YRwL9XD4a3JNvT7VD4XloCnehco5XQuUQ2gLMW68nKOGcBg=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b297b9f8-7b5c-42c8-0949-08d7e8f9d9a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 09:20:09.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaBsVqjlxGvsENT4N1xqau7c4XP8FkV8fEpdtY299zERqIEGqdD+8uwuvV4piVT2V+Z4uXhyBpQ8fYV9QSlRw/6dToaPtRfKhPf0pqITyehVtixhLRgz9rIqhY+ZkqQx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1056
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
 drivers/usb/mausb_host/Kconfig               |   15 +
 drivers/usb/mausb_host/Makefile              |   17 +
 drivers/usb/mausb_host/hcd.c                 | 1874 ++++++++++++++++
 drivers/usb/mausb_host/hcd.h                 |  162 ++
 drivers/usb/mausb_host/hpal.c                | 2082 ++++++++++++++++++
 drivers/usb/mausb_host/hpal.h                |  339 +++
 drivers/usb/mausb_host/hpal_data.c           |  714 ++++++
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
 drivers/usb/mausb_host/utils.c               |  358 +++
 drivers/usb/mausb_host/utils.h               |   45 +
 22 files changed, 8156 insertions(+)
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


base-commit: ab51cac00ef2859f20a73d33a53f3a8987b65e11
--=20
2.17.1

