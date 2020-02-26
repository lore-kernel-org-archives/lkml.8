Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191BAC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE692467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="VJIjyQGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgBZJ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:58:05 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:38175 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727882AbgBZJ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1582711081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hC9c8CydEvd6aCYhbJXnHofSb6efADUzLwiX7yC4Wds=;
        b=VJIjyQGNClTIPNhdrIQO8QW1gcIk1H8KF/l4yJ7QNgetWd6EdSvhNqLrpVtR8Qv8peFlko
        H+cPsX+yWUYCq0drZ8IPoAeJZ1npodD1g61YD3Fsb3iQgBHIJ5tuQhCwPyFtGeBHy0UU5y
        B8QTSL+pxQ2qHa/5+rHMK4Ffy2zI0Ww=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-242-jhbiw6uuPUSl6RLTEssBeA-1; Wed, 26 Feb 2020 09:57:59 +0000
X-MC-Unique: jhbiw6uuPUSl6RLTEssBeA-1
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM (52.133.63.154) by
 AM0PR10MB2676.EURPRD10.PROD.OUTLOOK.COM (20.178.119.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 09:57:57 +0000
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6]) by AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 09:57:57 +0000
Received: from [172.17.183.132] (80.93.235.40) by VI1PR07CA0276.eurprd07.prod.outlook.com (2603:10a6:803:b4::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.11 via Frontend Transport; Wed, 26 Feb 2020 09:57:57 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Subject: [PATCH v2 2/8] usb: mausb_host: Add link layer implementation
Thread-Topic: [PATCH v2 2/8] usb: mausb_host: Add link layer implementation
Thread-Index: AQHV7Is4B5/wTQstJEyXDV+B3jhSng==
Date:   Wed, 26 Feb 2020 09:57:57 +0000
Message-ID: <ec6f3afd-9fc6-d2a0-8153-5edfc3892eeb@displaylink.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0276.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::43) To AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:40::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1f22821-7547-4d96-3078-08d7baa25b33
x-ms-traffictypediagnostic: AM0PR10MB2676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR10MB2676C2401703653FCC854EE291EA0@AM0PR10MB2676.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:16;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39840400004)(346002)(189003)(199004)(81166006)(8936002)(44832011)(8676002)(81156014)(956004)(36756003)(478600001)(71200400001)(2906002)(30864003)(5660300002)(16576012)(316002)(54906003)(86362001)(66946007)(26005)(64756008)(66446008)(2616005)(31686004)(4326008)(6916009)(66476007)(66556008)(16526019)(52116002)(107886003)(31696002)(186003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB2676;H:AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgzCBx3XTluqGLdyNJJ/6c4umOB28eFxFvS6PoYc2Z4kI8xE+v5u3icJDG398L0bb8TqaO4Rpr6VxPTmL4/sxcCqa5I8GjROuxLTzAdOIgLdRaC8FbHbuVFUN/TalmnALrZVaGgDi4bNHRvVsEcUndKf49bjBOb+tDvl0cfojZRCebzUmFeHEXKgy3ej/fVD/s+KcLlkuq1XK0duImRoaUM1pTfi+i7gxAPGbRIt2TKX/W36UkCPG1I2y/5iTeyNmMG3vT7sjWYrhd8W4elv5sYM6VkUMMyNx+xfGdwtjEDZAXa0k/1WvFLo9xlikG9rfiRF+Qx4HvpTsXFUGvCH6zyza6wA5DNzK3vk2FxSfyjSx1yjpnmVzjWQIZFVgpfn4t21rHMCt+DJbk22SzK0p8vAHccxdeQjSdSx4a2q3D9SpPd6w+2okCmLihDQ5yLM
x-ms-exchange-antispam-messagedata: zNaPt687fa7yFCFcxKyfs/pfL1JRJseXo5ueBETAreZxbDklQwyA8l2hG1Ncn7JojovW4n+yJSxssLMxNU167NBkQdnXjSi7R2VcFbIX08r/RuNlV30JKcv4nWRASGMOdlO59z5tmomgY6cH9Jiofg==
Content-ID: <E0A645BAACD9734AB2B919F126835EE1@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f22821-7547-4d96-3078-08d7baa25b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 09:57:57.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SytgAsbrRMc7epftNfI6p4N33FfxDgVpF96MJ/P+V6YQ+tioTrk6kRGqIwmm4TuUT8/+zUTYZVNruXG//AWWQKFWn3XksP11KGwWQ4vlGw4+ZR/nmgPuzXgMTR8BGLxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2676
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
  drivers/usb/mausb_host/Makefile  |   1 +
  drivers/usb/mausb_host/ip_link.c | 346 +++++++++++++++++++++++++++++++
  drivers/usb/mausb_host/ip_link.h |  83 ++++++++
  3 files changed, 430 insertions(+)
  create mode 100644 drivers/usb/mausb_host/ip_link.c
  create mode 100644 drivers/usb/mausb_host/ip_link.h

diff --git a/drivers/usb/mausb_host/Makefile=20
b/drivers/usb/mausb_host/Makefile
index ad7fec4d9ff9..4db9dbfc1ebb 100644
--- a/drivers/usb/mausb_host/Makefile
+++ b/drivers/usb/mausb_host/Makefile
@@ -8,6 +8,7 @@
  obj-$(CONFIG_HOST_MAUSB) +=3D mausb_host.o
  mausb_host-y :=3D mausb_host.o
  mausb_host-y +=3D utils.o
+mausb_host-y +=3D ip_link.o
   ccflags-y +=3D -I$(srctree)/$(src)
  ccflags-y +=3D -g
diff --git a/drivers/usb/mausb_host/ip_link.c=20
b/drivers/usb/mausb_host/ip_link.c
new file mode 100644
index 000000000000..2c036295412c
--- /dev/null
+++ b/drivers/usb/mausb_host/ip_link.c
@@ -0,0 +1,346 @@
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
+=09strcpy(ctx->ip_addr, ip_addr);
+=09ctx->port =3D port;
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
+=09struct sockaddr_in sockaddr;
+=09int status =3D 0;
+
+=09struct mausb_ip_ctx *ip_ctx =3D container_of(work, struct mausb_ip_ctx,
+=09=09=09=09=09=09   connect_work);
+
+=09if (!ip_ctx->udp) {
+=09=09status =3D sock_create_kern(ip_ctx->net_ns, AF_INET, SOCK_STREAM,
+=09=09=09=09=09  IPPROTO_TCP, &ip_ctx->client_socket);
+=09=09if (status < 0) {
+=09=09=09mausb_pr_err("Failed to create socket: status=3D%d",
+=09=09=09=09     status);
+=09=09=09goto callback;
+=09=09}
+=09} else {
+=09=09status =3D sock_create_kern(ip_ctx->net_ns, AF_INET, SOCK_DGRAM,
+=09=09=09=09=09  IPPROTO_UDP, &ip_ctx->client_socket);
+=09=09if (status < 0) {
+=09=09=09mausb_pr_err("Failed to create socket: status=3D%d",
+=09=09=09=09     status);
+=09=09=09goto callback;
+=09=09}
+=09}
+
+=09memset(&sockaddr, 0, sizeof(sockaddr));
+=09sockaddr.sin_family=09 =3D AF_INET;
+=09sockaddr.sin_port=09 =3D htons(ip_ctx->port);
+=09sockaddr.sin_addr.s_addr =3D in_aton(ip_ctx->ip_addr);
+
+=09__mausb_ip_set_options((struct socket *)ip_ctx->client_socket,
+=09=09=09       ip_ctx->udp);
+
+=09status =3D kernel_connect(ip_ctx->client_socket,
+=09=09=09=09(struct sockaddr *)&sockaddr, sizeof(sockaddr),
+=09=09=09=09O_RDWR);
+=09if (status < 0) {
+=09=09mausb_pr_err("Failed to connect to host %s:%d, status=3D%d",
+=09=09=09     ip_ctx->ip_addr, ip_ctx->port, status);
+=09=09goto clear_socket;
+=09}
+
+=09queue_work(ip_ctx->recv_workq, &ip_ctx->recv_work);
+=09mausb_pr_info("Connected to host %s:%d, status=3D%d", ip_ctx->ip_addr,
+=09=09      ip_ctx->port, status);
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
+=09=09=09=09mausb_pr_warn("Setting TCP_QUICKACK failed: %s:%d, status=3D%d=
",
+=09=09=09=09=09      ip_ctx->ip_addr, ip_ctx->port,
+=09=09=09=09=09      status);
+=09=09=09}
+=09=09}
+
+=09=09status =3D kernel_recvmsg(client_socket, &msghd, &vec, 1,
+=09=09=09=09=09vec.iov_len, (int)msghd.msg_flags);
+=09=09if (status =3D=3D -EAGAIN) {
+=09=09=09return -EAGAIN;
+=09=09} else if (status <=3D 0) {
+=09=09=09mausb_pr_warn("kernel_recvmsg host %s:%d, status=3D%d",
+=09=09=09=09      ip_ctx->ip_addr, ip_ctx->port, status);
+
+=09=09=09__mausb_ip_recv_ctx_free(&ip_ctx->recv_ctx);
+=09=09=09ip_ctx->fn_callback(ip_ctx->ctx, ip_ctx->channel,
+=09=09=09=09=09    MAUSB_LINK_RECV, status, NULL);
+=09=09=09return status;
+=09=09}
+
+=09=09mausb_pr_debug("kernel_recvmsg host %s:%d, status=3D%d",
+=09=09=09       ip_ctx->ip_addr, ip_ctx->port, status);
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
index 000000000000..b5b9ec63d6a9
--- /dev/null
+++ b/drivers/usb/mausb_host/ip_link.h
@@ -0,0 +1,83 @@
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
+=09struct socket *client_socket;
+=09struct net    *net_ns;
+=09char=09      ip_addr[INET6_ADDRSTRLEN];
+=09u16=09      port;
+=09bool=09      udp;
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


