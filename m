Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206B7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E852320759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="Cv4NvDXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEOMf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:35:56 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:30951 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgEOMf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1589546122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1rwSjAXrFoIzAOMCgJWbeM1d88Hvk5OP3iTmCL4KHk=;
        b=Cv4NvDXF24zShaFr/Y227svAjrNMHd3PXR1ZXAJiCcTxCj9G3TGZ7tgBlQq+4bJxP8xHGK
        3jhttQd/6hIv8kGV9Dj6Al5TzpxX23ZwL+sifh24uKqMN/J6/ZMDZrZ57ER5K31XdTTvTS
        JdfUEsL9Jn+6jvJYwJtxeq5QkGg9JmU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-247-gzeGw5vdMqqo63p9LFLChg-3; Fri, 15 May 2020 13:35:19 +0100
X-MC-Unique: gzeGw5vdMqqo63p9LFLChg-3
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1230.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 12:35:17 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7%11]) with mapi id 15.20.3000.016; Fri, 15 May
 2020 12:35:17 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v6 2/8] usb: mausb_host: Add link layer implementation
Date:   Fri, 15 May 2020 14:34:56 +0200
Message-Id: <20200515123502.12099-3-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR09CA0140.eurprd09.prod.outlook.com (2603:10a6:803:12c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Fri, 15 May 2020 12:35:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c22ad6af-3c69-40ae-0636-08d7f8cc6c5f
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB12308A3F51CC1371113656D191BD0@VI1PR1001MB1230.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xf8wjcLIuNC52/ZpwXOTMjDHtV3iSIma10Jr34nTnPqC0LDMjTb5GD4+UQWr0v9PHhT1gs/ameoI4y4V61EzSsVDQw0f8rx0RcP+qmfydH4kzPq9BUuZTJ/F0uF2wfWVM9tU5QmDU9FsDAI9FQwfOQvg8ssDym1tqoUj02Df/8FsFod3l58rCJH13XXqixXh9CTxT0NRz39p5Sdnw84lSk0KCeu5iFgWJYu0aKg4UMLm5li0buWYcM3ecxcPdTlnLk0OvRSCxLuvsyj9tY88hRZputXPNALMYLXQVNnZ0UHo0glnPbVI0gYptrQXQ928FQAiFMcF1+HAWSGO6xqCsSs63RVhssP+QmoK3bfXPPcGO5fcptqMjqThgWeBMnwrEyS0Gh2f+bbZwWsCgD6Pg4p3KMk+Qz8rDps4HoCV3wWnBU3tCyL1m+c2Ep7h2qeU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39840400004)(366004)(346002)(376002)(36756003)(86362001)(5660300002)(107886003)(6666004)(66946007)(66476007)(66556008)(2906002)(4326008)(16526019)(956004)(6486002)(8676002)(186003)(8936002)(6512007)(6506007)(30864003)(1076003)(478600001)(26005)(44832011)(6916009)(316002)(2616005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TnOMTGwEuggvbEL7Hz0FsDqvUAX226WjqWzm50KTdI4TYa693Wmlhy0B5s5VBAsNAD9fICnlAvOMqOCca3iMY9KPRrQSmx6lxs13hiRy1h6aN0iUbzihEclc2D+6KM+hfVf0FRpagU0uFWyeTJsZ2NvGVBOtXoS+b6SywGNN8cIuLFQocoK81+LQYtXYkag8/cYpPjxRNUQMQ5WvwVIgyO13DWOjFEgXNxLmZWOduqpYGvTlCWVGoPMZkSVXLNcUE5l+f4GTN3P1+npbnzu3ubont6hEsP5ZCFaf+8JL0kdRUr32xNdHWyw2Rol6bIUBj/pCJifKBQPIa7YqqgrOcWx5jzyB8qPIKcKgIvc5WA7M4OC3cCpra+ohYN96EaOUAXtiYMAg8bgEtHEsXdYrXv+whwo63cOJmcMC73wdqBTY4TlMjBLY+qHaAEZae/H6OovpxK2KZlZu1Pp7xmyUKPxMz+LZimGT4pFIgjiOx98wS5WWKlZkoUkRxADhHZhx
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22ad6af-3c69-40ae-0636-08d7f8cc6c5f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:35:17.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0+i7UFEWx4hZmRE65iUN7osV0YvFXKU+Mu65DHgIhtcsdbE25gcsv6VDXSrtoSPV+HWAiOGRLWAUqHbaMhZU4pV7RCqxtcCjUKslZnFShLfq+3RoM12jBB9mDBBgj1+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1230
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
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
 drivers/usb/host/mausb/Makefile  |   1 +
 drivers/usb/host/mausb/ip_link.c | 367 +++++++++++++++++++++++++++++++
 drivers/usb/host/mausb/ip_link.h |  88 ++++++++
 3 files changed, 456 insertions(+)
 create mode 100644 drivers/usb/host/mausb/ip_link.c
 create mode 100644 drivers/usb/host/mausb/ip_link.h

diff --git a/drivers/usb/host/mausb/Makefile b/drivers/usb/host/mausb/Makef=
ile
index cafccac0edba..acc8ad3f0eff 100644
--- a/drivers/usb/host/mausb/Makefile
+++ b/drivers/usb/host/mausb/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_USB_HOST_MAUSB) +=3D mausb_host.o
 mausb_host-y :=3D mausb_core.o
 mausb_host-y +=3D utils.o
+mausb_host-y +=3D ip_link.o
diff --git a/drivers/usb/host/mausb/ip_link.c b/drivers/usb/host/mausb/ip_l=
ink.c
new file mode 100644
index 000000000000..74bf6cce3c7a
--- /dev/null
+++ b/drivers/usb/host/mausb/ip_link.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include "ip_link.h"
+
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
+=09=09dev_err(mausb_host_dev.this_device, "Invalid IP address received: ad=
dress=3D%s",
+=09=09=09ip_addr);
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
+=09=09=09dev_warn(mausb_host_dev.this_device, "Failed to set tcp no delay =
option: status=3D%d",
+=09=09=09=09 status);
+=09}
+
+=09status =3D kernel_setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO_NEW,
+=09=09=09=09   (char *)&timeo, sizeof(timeo));
+=09if (status < 0)
+=09=09dev_warn(mausb_host_dev.this_device, "Failed to set recv timeout opt=
ion: status=3D%d",
+=09=09=09 status);
+
+=09status =3D kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_NEW,
+=09=09=09=09   (char *)&send_timeo, sizeof(send_timeo));
+=09if (status < 0)
+=09=09dev_warn(mausb_host_dev.this_device, "Failed to set snd timeout opti=
on: status=3D%d",
+=09=09=09 status);
+
+=09optval =3D MAUSB_LINK_BUFF_SIZE;
+=09status  =3D kernel_setsockopt(sock, SOL_SOCKET, SO_RCVBUF,
+=09=09=09=09    (char *)&optval, optlen);
+=09if (status < 0)
+=09=09dev_warn(mausb_host_dev.this_device, "Failed to set recv buffer size=
: status=3D%d",
+=09=09=09 status);
+
+=09optval =3D MAUSB_LINK_BUFF_SIZE;
+=09status  =3D kernel_setsockopt(sock, SOL_SOCKET, SO_SNDBUF,
+=09=09=09=09    (char *)&optval, optlen);
+=09if (status < 0)
+=09=09dev_warn(mausb_host_dev.this_device, "Failed to set send buffer size=
: status=3D%d",
+=09=09=09 status);
+
+=09optval =3D MAUSB_LINK_TOS_LEVEL_EF;
+=09status  =3D kernel_setsockopt(sock, IPPROTO_IP, IP_TOS,
+=09=09=09=09    (char *)&optval, optlen);
+=09if (status < 0)
+=09=09dev_warn(mausb_host_dev.this_device, "Failed to set QOS: status=3D%d=
",
+=09=09=09 status);
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
+=09=09=09dev_err(mausb_host_dev.this_device, "Failed to create socket: sta=
tus=3D%d",
+=09=09=09=09status);
+=09=09=09goto callback;
+=09=09}
+=09} else {
+=09=09status =3D sock_create_kern(ip_ctx->net_ns, family, SOCK_DGRAM,
+=09=09=09=09=09  IPPROTO_UDP, &ip_ctx->client_socket);
+=09=09if (status < 0) {
+=09=09=09dev_err(mausb_host_dev.this_device, "Failed to create socket: sta=
tus=3D%d",
+=09=09=09=09status);
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
+=09=09dev_info(mausb_host_dev.this_device, "Connecting to %pI4:%d, status=
=3D%d",
+=09=09=09 &ip_ctx->dev_addr_in.sa_in.sin_addr,
+=09=09=09 htons(ip_ctx->dev_addr_in.sa_in.sin_port), status);
+#if IS_ENABLED(CONFIG_IPV6)
+=09} else if (family =3D=3D AF_INET6) {
+=09=09sa =3D (struct sockaddr *)&ip_ctx->dev_addr_in.sa_in6;
+=09=09sa_size =3D sizeof(ip_ctx->dev_addr_in.sa_in6);
+=09=09dev_info(mausb_host_dev.this_device, "Connecting to %pI6c:%d, status=
=3D%d",
+=09=09=09 &ip_ctx->dev_addr_in.sa_in6.sin6_addr,
+=09=09=09 htons(ip_ctx->dev_addr_in.sa_in6.sin6_port), status);
+#endif
+=09} else {
+=09=09dev_err(mausb_host_dev.this_device, "Wrong network family provided")=
;
+=09=09status =3D -EINVAL;
+=09=09goto callback;
+=09}
+
+=09status =3D kernel_connect(ip_ctx->client_socket, sa, sa_size, O_RDWR);
+=09if (status < 0) {
+=09=09dev_err(mausb_host_dev.this_device, "Failed to connect to host, stat=
us=3D%d",
+=09=09=09status);
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
+=09=09dev_alert(mausb_host_dev.this_device, "Socket ctx is NULL!");
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
+static inline void __mausb_ip_recv_ctx_clear(struct mausb_ip_recv_ctx *rec=
v_ctx)
+{
+=09recv_ctx->buffer   =3D NULL;
+=09recv_ctx->left=09   =3D 0;
+=09recv_ctx->received =3D 0;
+}
+
+static inline void __mausb_ip_recv_ctx_free(struct mausb_ip_recv_ctx *recv=
_ctx)
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
+=09=09=09=09dev_warn(mausb_host_dev.this_device, "Setting TCP_QUICKACK fai=
led, status=3D%d",
+=09=09=09=09=09 status);
+=09=09=09}
+=09=09}
+
+=09=09status =3D kernel_recvmsg(client_socket, &msghd, &vec, 1,
+=09=09=09=09=09vec.iov_len, (int)msghd.msg_flags);
+=09=09if (status =3D=3D -EAGAIN) {
+=09=09=09return -EAGAIN;
+=09=09} else if (status <=3D 0) {
+=09=09=09dev_warn(mausb_host_dev.this_device, "kernel_recvmsg, status=3D%d=
",
+=09=09=09=09 status);
+
+=09=09=09__mausb_ip_recv_ctx_free(&ip_ctx->recv_ctx);
+=09=09=09ip_ctx->fn_callback(ip_ctx->ctx, ip_ctx->channel,
+=09=09=09=09=09    MAUSB_LINK_RECV, status, NULL);
+=09=09=09return status;
+=09=09}
+
+=09=09dev_vdbg(mausb_host_dev.this_device, "kernel_recvmsg, status=3D%d",
+=09=09=09 status);
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
diff --git a/drivers/usb/host/mausb/ip_link.h b/drivers/usb/host/mausb/ip_l=
ink.h
new file mode 100644
index 000000000000..faa5a9acabbd
--- /dev/null
+++ b/drivers/usb/host/mausb/ip_link.h
@@ -0,0 +1,88 @@
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
+
+#define MAUSB_LINK_BUFF_SIZE=0916777216
+#define MAUSB_LINK_TOS_LEVEL_EF 0xB8
+
+extern struct miscdevice mausb_host_dev;
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

