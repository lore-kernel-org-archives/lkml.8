Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E087AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9962071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="RZgBA/bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgCLOnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:43:02 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:56976 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727608AbgCLOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1584024177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=07jfgdKp+b9l+YJhK7l3er9zREsOJGB3zwx4pbw0Du0=;
        b=RZgBA/bjfQ4m+GV0yEo9EACgfL3OwP6n22aLMA29Gc57IEl3g7wdL44W/YuLDD1avQNuxu
        5djXHgj1MWits9VHRtsriYjoZjr/qxDhQPVoudU7MvXjNfmCHp6CzxMNPLsajQwaEPMGXc
        Bq1ZUH8FQRYiflnFTVTzq9T1hcNg8Qg=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-253-OjNgRCl5Px2hSFx8-KpNsw-1; Thu, 12 Mar 2020 14:42:56 +0000
X-MC-Unique: OjNgRCl5Px2hSFx8-KpNsw-1
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB2814.EURPRD10.PROD.OUTLOOK.COM (20.178.126.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 14:42:54 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc%4]) with mapi id 15.20.2793.013; Thu, 12 Mar 2020
 14:42:54 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Subject: [PATCH v3 2/8] usb: mausb_host: Add link layer implementation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Message-ID: <299ca9c5-f7b2-e4f4-b34f-a0903cd336b3@displaylink.com>
Date:   Thu, 12 Mar 2020 15:42:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Content-Language: en-US
X-ClientProxiedBy: VI1PR07CA0221.eurprd07.prod.outlook.com
 (2603:10a6:802:58::24) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.183.132] (91.208.120.1) by VI1PR07CA0221.eurprd07.prod.outlook.com (2603:10a6:802:58::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.7 via Frontend Transport; Thu, 12 Mar 2020 14:42:54 +0000
X-Originating-IP: [91.208.120.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac1e700-5e3f-48c8-7520-08d7c693a604
X-MS-TrafficTypeDiagnostic: VI1PR10MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB2814EA5CCAA44D9FEDB191A291FD0@VI1PR10MB2814.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(136003)(39840400004)(199004)(478600001)(2616005)(4326008)(8676002)(81156014)(8936002)(107886003)(31696002)(6916009)(31686004)(52116002)(30864003)(66946007)(66556008)(66476007)(36756003)(81166006)(16576012)(316002)(6486002)(2906002)(86362001)(956004)(26005)(5660300002)(186003)(54906003)(16526019)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2814;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFvpEcg57bvK/gRkrFyrH11axOncUrmJpTuiXG43J7MXhbwd5ECuEnIHXftomVyK10vtWNqoVvkbwj0nm24Yakn4iomt+F0OL8Lj4VcaMmjcmHm/0k96Sey26XCP+vRkeTujIVM6UxaCgAXSFIU1nVCaKeovJIIRK/2i8Vq0X2utYaLaJatwregYBioxakzE+4r3UQtvJKX0x2sC/4MH3ZldVeFYfNYdYIsZgUDWb9Cubh1eMOWOgLnXFF/ncK/ow0NA8PNKmzKjyCZb+Q7PPfeR712ddT8cxtZXlHIB2UyYwpeHzQdhSw0hFVQYW6xlIklmILMv79r7lDt2UMY7RKxZdFOXMpVwasRYnuquJY/KQiThOrmeRx/JONmNLXca0uj7UKvXBkkYRhrkvco8HckYioF4KjYfuEQT+eSQT90oOkMXjjzuTSpkpR/eZ2H0
X-MS-Exchange-AntiSpam-MessageData: IZDTVXuAXi885ome/PTq1+TpbdVDj39wHk+aQZ+DERpzKGkjL5mEcAQpxE3kZHtLBkBDAbsyOJZ8UbOvO1n/5iZ7PHV0aQ94k2a6ETTRkYRj4LxnYqkcf1HcrF8QZOeeYOdaI7ir+niu19BJldLPnA==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac1e700-5e3f-48c8-7520-08d7c693a604
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 14:42:54.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RG6fD6VEvGWNW+MNYEr3257HZQ0CoLyNRX8uuGKeQAshhtfpxxmWrEdzqA2M9NVeBAN62HyjSpGFb9dsZym/HL57ehc5b4Thwlx2XBmvuwQPFamjBixaxsjmsG9SYqj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2814
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented link layer using kernel sockets. Link layer
manages network communication and provides interface for upper
layers of MA-USB stack.

Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
---
  drivers/usb/mausb_host/Makefile  |   1 +
  drivers/usb/mausb_host/ip_link.c | 374 +++++++++++++++++++++++++++++++
  drivers/usb/mausb_host/ip_link.h |  87 +++++++
  3 files changed, 462 insertions(+)
  create mode 100644 drivers/usb/mausb_host/ip_link.c
  create mode 100644 drivers/usb/mausb_host/ip_link.h

diff --git a/drivers/usb/mausb_host/Makefile=20
b/drivers/usb/mausb_host/Makefile
index 2e353fa0958b..19445b73b50b 100644
--- a/drivers/usb/mausb_host/Makefile
+++ b/drivers/usb/mausb_host/Makefile
@@ -8,5 +8,6 @@
  obj-$(CONFIG_HOST_MAUSB) +=3D mausb_host.o
  mausb_host-y :=3D mausb_core.o
  mausb_host-y +=3D utils.o
+mausb_host-y +=3D ip_link.o
   ccflags-y +=3D -I$(srctree)/$(src)
diff --git a/drivers/usb/mausb_host/ip_link.c=20
b/drivers/usb/mausb_host/ip_link.c
new file mode 100644
index 000000000000..49b592c02210
--- /dev/null
+++ b/drivers/usb/mausb_host/ip_link.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include "ip_link.h"
+
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/net.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/workqueue.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+
+#include "utils.h"
+
+static void __mausb_ip_connect(struct work_struct *work);
+static int __mausb_ip_recv(struct mausb_ip_ctx *ip_ctx);
+static void __mausb_ip_recv_work(struct work_struct *work);
+static inline void __mausb_ip_recv_ctx_clear(struct mausb_ip_recv_ctx
+=09=09=09=09=09     *recv_ctx);
+static inline void __mausb_ip_recv_ctx_free(struct mausb_ip_recv_ctx
+=09=09=09=09=09    *recv_ctx);
+
+int mausb_init_ip_ctx(struct mausb_ip_ctx **ip_ctx,
+=09=09      struct net *net_ns,
+=09=09      char ip_addr[INET6_ADDRSTRLEN],
+=09=09      u16 port, void *context,
+=09=09      void (*fn_callback)(void *ctx, enum mausb_channel channel,
+=09=09=09=09=09  enum mausb_link_action act,
+=09=09=09=09=09  int status, void *data),
+=09=09      enum mausb_channel channel)
+{
+=09struct mausb_ip_ctx *ctx;
+
+=09*ip_ctx =3D kzalloc(sizeof(**ip_ctx), GFP_ATOMIC);
+=09if (!*ip_ctx)
+=09=09return -ENOMEM;
+
+=09ctx =3D *ip_ctx;
+=09ctx->client_socket =3D NULL;
+=09__mausb_ip_recv_ctx_clear(&ctx->recv_ctx);
+
+=09if (in4_pton(ip_addr, -1,
+=09=09     (u8 *)&ctx->dev_addr_in.sa_in.sin_addr.s_addr, -1,
+=09=09     NULL) =3D=3D 1) {
+=09=09ctx->dev_addr_in.sa_in.sin_family =3D AF_INET;
+=09=09ctx->dev_addr_in.sa_in.sin_port =3D htons(port);
+#if IS_ENABLED(CONFIG_IPV6)
+=09} else if (in6_pton(ip_addr, -1,
+=09=09=09    (u8 *)&ctx->dev_addr_in.sa_in6.sin6_addr.in6_u, -1,
+=09=09=09    NULL) =3D=3D 1) {
+=09=09ctx->dev_addr_in.sa_in6.sin6_family =3D AF_INET6;
+=09=09ctx->dev_addr_in.sa_in6.sin6_port =3D htons(port);
+#endif
+=09} else {
+=09=09mausb_pr_err("Invalid IP address received: address=3D%s",
+=09=09=09     ip_addr);
+=09=09kfree(ctx);
+=09=09return -EINVAL;
+=09}
+
+=09ctx->net_ns =3D net_ns;
+
+=09if (channel =3D=3D MAUSB_ISOCH_CHANNEL)
+=09=09ctx->udp =3D true;
+
+=09ctx->connect_workq =3D alloc_ordered_workqueue("connect_workq",
+=09=09=09=09=09=09     WQ_MEM_RECLAIM);
+=09if (!ctx->connect_workq) {
+=09=09kfree(ctx);
+=09=09return -ENOMEM;
+=09}
+
+=09ctx->recv_workq =3D alloc_ordered_workqueue("recv_workq", WQ_MEM_RECLAI=
M);
+=09if (!ctx->recv_workq) {
+=09=09destroy_workqueue(ctx->connect_workq);
+=09=09kfree(ctx);
+=09=09return -ENOMEM;
+=09}
+
+=09INIT_WORK(&ctx->connect_work, __mausb_ip_connect);
+=09INIT_WORK(&ctx->recv_work, __mausb_ip_recv_work);
+
+=09ctx->channel=09 =3D channel;
+=09ctx->ctx=09 =3D context;
+=09ctx->fn_callback =3D fn_callback;
+
+=09return 0;
+}
+
+void mausb_destroy_ip_ctx(struct mausb_ip_ctx *ip_ctx)
+{
+=09if (!ip_ctx)
+=09=09return;
+
+=09if (ip_ctx->connect_workq) {
+=09=09flush_workqueue(ip_ctx->connect_workq);
+=09=09destroy_workqueue(ip_ctx->connect_workq);
+=09}
+
+=09if (ip_ctx->recv_workq) {
+=09=09flush_workqueue(ip_ctx->recv_workq);
+=09=09destroy_workqueue(ip_ctx->recv_workq);
+=09}
+=09if (ip_ctx->client_socket)
+=09=09sock_release(ip_ctx->client_socket);
+=09__mausb_ip_recv_ctx_free(&ip_ctx->recv_ctx);
+
+=09kfree(ip_ctx);
+}
+
+static void __mausb_ip_set_options(struct socket *sock, bool udp)
+{
+=09u32 optval =3D 0;
+=09unsigned int optlen =3D sizeof(optval);
+=09int status =3D 0;
+=09struct __kernel_sock_timeval timeo =3D {.tv_sec =3D 0, .tv_usec =3D 500=
000U };
+=09struct __kernel_sock_timeval send_timeo =3D {.tv_sec =3D 1, .tv_usec =
=3D 0 };
+
+=09if (!udp) {
+=09=09optval =3D 1;
+=09=09status =3D kernel_setsockopt(sock, IPPROTO_TCP, TCP_NODELAY,
+=09=09=09=09=09   (char *)&optval, optlen);
+=09=09if (status < 0)
+=09=09=09mausb_pr_warn("Failed to set tcp no delay option: status=3D%d",
+=09=09=09=09      status);
+=09}
+
+=09status =3D kernel_setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO_NEW,
+=09=09=09=09   (char *)&timeo, sizeof(timeo));
+=09if (status < 0)
+=09=09mausb_pr_warn("Failed to set recv timeout option: status=3D%d",
+=09=09=09      status);
+
+=09status =3D kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_NEW,
+=09=09=09=09   (char *)&send_timeo, sizeof(send_timeo));
+=09if (status < 0)
+=09=09mausb_pr_warn("Failed to set snd timeout option: status=3D%d",
+=09=09=09      status);
+
+=09optval =3D MAUSB_LINK_BUFF_SIZE;
+=09status  =3D kernel_setsockopt(sock, SOL_SOCKET, SO_RCVBUF,
+=09=09=09=09    (char *)&optval, optlen);
+=09if (status < 0)
+=09=09mausb_pr_warn("Failed to set recv buffer size: status=3D%d",
+=09=09=09      status);
+
+=09optval =3D MAUSB_LINK_BUFF_SIZE;
+=09status  =3D kernel_setsockopt(sock, SOL_SOCKET, SO_SNDBUF,
+=09=09=09=09    (char *)&optval, optlen);
+=09if (status < 0)
+=09=09mausb_pr_warn("Failed to set send buffer size: status=3D%d",
+=09=09=09      status);
+
+=09optval =3D MAUSB_LINK_TOS_LEVEL_EF;
+=09status  =3D kernel_setsockopt(sock, IPPROTO_IP, IP_TOS,
+=09=09=09=09    (char *)&optval, optlen);
+=09if (status < 0)
+=09=09mausb_pr_warn("Failed to set QOS: status=3D%d", status);
+}
+
+static void __mausb_ip_connect(struct work_struct *work)
+{
+=09int status =3D 0;
+=09struct sockaddr *sa;
+=09int sa_size;
+=09struct mausb_ip_ctx *ip_ctx =3D container_of(work, struct mausb_ip_ctx,
+=09=09=09=09=09=09   connect_work);
+=09unsigned short int family =3D ip_ctx->dev_addr_in.sa_in.sin_family;
+
+=09if (!ip_ctx->udp) {
+=09=09status =3D sock_create_kern(ip_ctx->net_ns, family, SOCK_STREAM,
+=09=09=09=09=09  IPPROTO_TCP, &ip_ctx->client_socket);
+=09=09if (status < 0) {
+=09=09=09mausb_pr_err("Failed to create socket: status=3D%d",
+=09=09=09=09     status);
+=09=09=09goto callback;
+=09=09}
+=09} else {
+=09=09status =3D sock_create_kern(ip_ctx->net_ns, family, SOCK_DGRAM,
+=09=09=09=09=09  IPPROTO_UDP, &ip_ctx->client_socket);
+=09=09if (status < 0) {
+=09=09=09mausb_pr_err("Failed to create socket: status=3D%d",
+=09=09=09=09     status);
+=09=09=09goto callback;
+=09=09}
+=09}
+
+=09__mausb_ip_set_options((struct socket *)ip_ctx->client_socket,
+=09=09=09       ip_ctx->udp);
+
+=09if (family =3D=3D AF_INET) {
+=09=09sa =3D (struct sockaddr *)&ip_ctx->dev_addr_in.sa_in;
+=09=09sa_size =3D sizeof(ip_ctx->dev_addr_in.sa_in);
+=09=09mausb_pr_info("Connecting to %pI4:%d, status=3D%d",
+=09=09=09      &ip_ctx->dev_addr_in.sa_in.sin_addr,
+=09=09=09      htons(ip_ctx->dev_addr_in.sa_in.sin_port),
+=09=09=09      status);
+#if IS_ENABLED(CONFIG_IPV6)
+=09} else if (family =3D=3D AF_INET6) {
+=09=09sa =3D (struct sockaddr *)&ip_ctx->dev_addr_in.sa_in6;
+=09=09sa_size =3D sizeof(ip_ctx->dev_addr_in.sa_in6);
+=09=09mausb_pr_info("Connecting to %pI6c:%d, status=3D%d",
+=09=09=09      &ip_ctx->dev_addr_in.sa_in6.sin6_addr,
+=09=09=09      htons(ip_ctx->dev_addr_in.sa_in6.sin6_port),
+=09=09=09      status);
+#endif
+=09} else {
+=09=09mausb_pr_err("Wrong network family provided");
+=09=09status =3D -EINVAL;
+=09=09goto callback;
+=09}
+
+=09status =3D kernel_connect(ip_ctx->client_socket, sa, sa_size, O_RDWR);
+=09if (status < 0) {
+=09=09mausb_pr_err("Failed to connect to host, status=3D%d", status);
+=09=09goto clear_socket;
+=09}
+
+=09queue_work(ip_ctx->recv_workq, &ip_ctx->recv_work);
+
+=09goto callback;
+
+clear_socket:
+=09sock_release(ip_ctx->client_socket);
+=09ip_ctx->client_socket =3D NULL;
+callback:
+=09ip_ctx->fn_callback(ip_ctx->ctx, ip_ctx->channel, MAUSB_LINK_CONNECT,
+=09=09=09    status, NULL);
+}
+
+void mausb_ip_connect_async(struct mausb_ip_ctx *ip_ctx)
+{
+=09queue_work(ip_ctx->connect_workq, &ip_ctx->connect_work);
+}
+
+int mausb_ip_disconnect(struct mausb_ip_ctx *ip_ctx)
+{
+=09if (ip_ctx && ip_ctx->client_socket)
+=09=09return kernel_sock_shutdown(ip_ctx->client_socket, SHUT_RDWR);
+=09return 0;
+}
+
+int mausb_ip_send(struct mausb_ip_ctx *ip_ctx,
+=09=09  struct mausb_kvec_data_wrapper *wrapper)
+{
+=09struct msghdr msghd;
+
+=09if (!ip_ctx) {
+=09=09mausb_pr_alert("Socket ctx is NULL!");
+=09=09return -EINVAL;
+=09}
+
+=09memset(&msghd, 0, sizeof(msghd));
+=09msghd.msg_flags =3D MSG_WAITALL;
+
+=09return kernel_sendmsg(ip_ctx->client_socket, &msghd, wrapper->kvec,
+=09=09=09      wrapper->kvec_num, wrapper->length);
+}
+
+static inline void __mausb_ip_recv_ctx_clear(struct mausb_ip_recv_ctx=20
*recv_ctx)
+{
+=09recv_ctx->buffer   =3D NULL;
+=09recv_ctx->left=09   =3D 0;
+=09recv_ctx->received =3D 0;
+}
+
+static inline void __mausb_ip_recv_ctx_free(struct mausb_ip_recv_ctx=20
*recv_ctx)
+{
+=09kfree(recv_ctx->buffer);
+=09__mausb_ip_recv_ctx_clear(recv_ctx);
+}
+
+static int __mausb_ip_recv(struct mausb_ip_ctx *ip_ctx)
+{
+=09struct msghdr msghd;
+=09struct kvec vec;
+=09int  status;
+=09bool peek =3D true;
+=09unsigned int optval =3D 1;
+=09struct socket *client_socket =3D (struct socket *)ip_ctx->client_socket=
;
+
+=09/* receive with timeout of 0.5s */
+=09while (true) {
+=09=09memset(&msghd, 0, sizeof(msghd));
+=09=09if (peek) {
+=09=09=09vec.iov_base =3D ip_ctx->recv_ctx.common_hdr;
+=09=09=09vec.iov_len  =3D sizeof(ip_ctx->recv_ctx.common_hdr);
+=09=09=09msghd.msg_flags =3D MSG_PEEK;
+=09=09} else {
+=09=09=09vec.iov_base =3D
+=09=09=09    ip_ctx->recv_ctx.buffer +
+=09=09=09    ip_ctx->recv_ctx.received;
+=09=09=09vec.iov_len =3D ip_ctx->recv_ctx.left;
+=09=09=09msghd.msg_flags =3D MSG_WAITALL;
+=09=09}
+
+=09=09if (!ip_ctx->udp) {
+=09=09=09status =3D kernel_setsockopt(client_socket, IPPROTO_TCP,
+=09=09=09=09=09=09   TCP_QUICKACK,
+=09=09=09=09=09=09   (char *)&optval,
+=09=09=09=09=09=09   sizeof(optval));
+=09=09=09if (status !=3D 0) {
+=09=09=09=09mausb_pr_warn("Setting TCP_QUICKACK failed, status=3D%d",
+=09=09=09=09=09      status);
+=09=09=09}
+=09=09}
+
+=09=09status =3D kernel_recvmsg(client_socket, &msghd, &vec, 1,
+=09=09=09=09=09vec.iov_len, (int)msghd.msg_flags);
+=09=09if (status =3D=3D -EAGAIN) {
+=09=09=09return -EAGAIN;
+=09=09} else if (status <=3D 0) {
+=09=09=09mausb_pr_warn("kernel_recvmsg, status=3D%d", status);
+
+=09=09=09__mausb_ip_recv_ctx_free(&ip_ctx->recv_ctx);
+=09=09=09ip_ctx->fn_callback(ip_ctx->ctx, ip_ctx->channel,
+=09=09=09=09=09    MAUSB_LINK_RECV, status, NULL);
+=09=09=09return status;
+=09=09}
+
+=09=09mausb_pr_debug("kernel_recvmsg, status=3D%d", status);
+
+=09=09if (peek) {
+=09=09=09if ((unsigned int)status <
+=09=09=09=09=09sizeof(ip_ctx->recv_ctx.common_hdr))
+=09=09=09=09return -EAGAIN;
+=09=09=09/* length field of mausb_common_hdr */
+=09=09=09ip_ctx->recv_ctx.left =3D
+=09=09=09    *(u16 *)(&ip_ctx->recv_ctx.common_hdr[2]);
+=09=09=09ip_ctx->recv_ctx.received =3D 0;
+=09=09=09ip_ctx->recv_ctx.buffer=09  =3D
+=09=09=09    kzalloc(ip_ctx->recv_ctx.left, GFP_KERNEL);
+=09=09=09peek =3D false;
+=09=09=09if (!ip_ctx->recv_ctx.buffer) {
+=09=09=09=09ip_ctx->fn_callback(ip_ctx->ctx,
+=09=09=09=09=09=09    ip_ctx->channel,
+=09=09=09=09=09=09    MAUSB_LINK_RECV,
+=09=09=09=09=09=09    -ENOMEM, NULL);
+=09=09=09=09return -ENOMEM;
+=09=09=09}
+=09=09} else {
+=09=09=09if (status < ip_ctx->recv_ctx.left) {
+=09=09=09=09ip_ctx->recv_ctx.left -=3D (u16)status;
+=09=09=09=09ip_ctx->recv_ctx.received +=3D (u16)status;
+=09=09=09} else {
+=09=09=09=09ip_ctx->fn_callback(ip_ctx->ctx,
+=09=09=09=09=09=09    ip_ctx->channel,
+=09=09=09=09=09=09    MAUSB_LINK_RECV, status,
+=09=09=09=09=09=09    ip_ctx->recv_ctx.buffer);
+=09=09=09=09__mausb_ip_recv_ctx_clear(&ip_ctx->recv_ctx);
+=09=09=09=09peek =3D true;
+=09=09=09}
+=09=09}
+=09}
+
+=09return status;
+}
+
+static void __mausb_ip_recv_work(struct work_struct *work)
+{
+=09struct mausb_ip_ctx *ip_ctx =3D container_of(work, struct mausb_ip_ctx,
+=09=09=09=09=09=09   recv_work);
+=09int status =3D __mausb_ip_recv(ip_ctx);
+
+=09if (status <=3D 0 && status !=3D -EAGAIN)
+=09=09return;
+
+=09queue_work(ip_ctx->recv_workq, &ip_ctx->recv_work);
+}
diff --git a/drivers/usb/mausb_host/ip_link.h=20
b/drivers/usb/mausb_host/ip_link.h
new file mode 100644
index 000000000000..5946151e4e4e
--- /dev/null
+++ b/drivers/usb/mausb_host/ip_link.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_IP_LINK_H__
+#define __MAUSB_IP_LINK_H__
+
+#include <linux/inet.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <net/net_namespace.h>
+
+#define MAUSB_LINK_BUFF_SIZE=0916777216
+#define MAUSB_LINK_TOS_LEVEL_EF 0xB8
+
+enum mausb_link_action {
+=09MAUSB_LINK_CONNECT=09=3D 0,
+=09MAUSB_LINK_DISCONNECT=09=3D 1,
+=09MAUSB_LINK_RECV=09=09=3D 2,
+=09MAUSB_LINK_SEND=09=09=3D 3
+};
+
+enum mausb_channel {
+=09MAUSB_CTRL_CHANNEL  =3D 0,
+=09MAUSB_ISOCH_CHANNEL =3D 1,
+=09MAUSB_BULK_CHANNEL  =3D 2,
+=09MAUSB_INTR_CHANNEL  =3D 3,
+=09MAUSB_MGMT_CHANNEL  =3D 4
+};
+
+struct mausb_kvec_data_wrapper {
+=09struct kvec *kvec;
+=09u32    kvec_num;
+=09u32    length;
+};
+
+struct mausb_ip_recv_ctx {
+=09u16  left;
+=09u16  received;
+=09char *buffer;
+=09char common_hdr[12] __aligned(4);
+};
+
+struct mausb_ip_ctx {
+=09struct socket=09=09*client_socket;
+=09union {
+=09=09struct sockaddr_in sa_in;
+#if IS_ENABLED(CONFIG_IPV6)
+=09=09struct sockaddr_in6 sa_in6;
+#endif
+=09} dev_addr_in;
+=09struct net=09=09*net_ns;
+=09bool=09=09=09udp;
+
+=09/* Queues to schedule rx work */
+=09struct workqueue_struct=09*recv_workq;
+=09struct workqueue_struct=09*connect_workq;
+=09struct work_struct=09recv_work;
+=09struct work_struct=09connect_work;
+
+=09struct mausb_ip_recv_ctx recv_ctx; /* recv buffer */
+
+=09enum mausb_channel channel;
+=09void *ctx;
+=09/* callback should store task into hpal queue */
+=09void (*fn_callback)(void *ctx, enum mausb_channel channel,
+=09=09=09    enum mausb_link_action act, int status, void *data);
+};
+
+int mausb_init_ip_ctx(struct mausb_ip_ctx **ip_ctx,
+=09=09      struct net *net_ns,
+=09=09      char ip_addr[INET6_ADDRSTRLEN],
+=09=09      u16 port,
+=09=09      void *ctx,
+=09=09      void (*ctx_callback)(void *ctx,
+=09=09=09=09=09   enum mausb_channel channel,
+=09=09=09=09=09   enum mausb_link_action act,
+=09=09=09=09=09   int status, void *data),
+=09=09      enum mausb_channel channel);
+int mausb_ip_disconnect(struct mausb_ip_ctx *ip_ctx);
+int mausb_ip_send(struct mausb_ip_ctx *ip_ctx,
+=09=09  struct mausb_kvec_data_wrapper *wrapper);
+
+void mausb_destroy_ip_ctx(struct mausb_ip_ctx *ip_ctx);
+void mausb_ip_connect_async(struct mausb_ip_ctx *ip_ctx);
+
+#endif /* __MAUSB_IP_LINK_H__ */
--=20
2.17.1


