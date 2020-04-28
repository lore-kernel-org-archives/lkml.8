Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647FAC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329F020661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcMTJMfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgD1Et7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41966 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbgD1Et7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588049397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2rnvwTU0bdcv0i2Iy3BuVSHcVapVzzi+YvkRwobbBm8=;
        b=bcMTJMfLegrrYknya0yV2TFa896xTok4ZH8vl20QovOBrUuW9CDd59yKi4YQe5m8w4D4o/
        cb9eGWz8zneS+JrE1ZXcteGK1uPA2CZhb6MYjGpKT+2uB04cDwoy239sMMSv4PrLKfno6W
        gATJhsavMn9FXd9z5n8QTsNBJq+0s/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-4E2djSixM5arJbl7oXv6lw-1; Tue, 28 Apr 2020 00:49:56 -0400
X-MC-Unique: 4E2djSixM5arJbl7oXv6lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BF051899520;
        Tue, 28 Apr 2020 04:49:54 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0B31001DC2;
        Tue, 28 Apr 2020 04:49:51 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netanel@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com, davem@davemloft.net,
        gshan@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2] net/ena: Fix build warning in ena_xdp_set()
Date:   Tue, 28 Apr 2020 14:49:45 +1000
Message-Id: <20200428044945.123511-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following build warning in ena_xdp_set(), which is
observed on aarch64 with 64KB page size.

   In file included from ./include/net/inet_sock.h:19,
      from ./include/net/ip.h:27,
      from drivers/net/ethernet/amazon/ena/ena_netdev.c:46:
   drivers/net/ethernet/amazon/ena/ena_netdev.c: In function         \
   =E2=80=98ena_xdp_set=E2=80=99:                                        =
            \
   drivers/net/ethernet/amazon/ena/ena_netdev.c:557:6: warning:      \
   format =E2=80=98%lu=E2=80=99                                          =
            \
   expects argument of type =E2=80=98long unsigned int=E2=80=99, but argu=
ment 4      \
   has type =E2=80=98int=E2=80=99                                        =
            \
   [-Wformat=3D] "Failed to set xdp program, the current MTU (%d) is   \
   larger than the maximum allowed MTU (%lu) while xdp is on",

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v2: Make ENA_PAGE_SIZE to be "unsigned long" and verify on aarch64
    with 4KB or 64KB page size configuration
---
 drivers/net/ethernet/amazon/ena/ena_netdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/e=
thernet/amazon/ena/ena_netdev.h
index 97dfd0c67e84..9e1860d81908 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -69,7 +69,7 @@
  * 16kB.
  */
 #if PAGE_SIZE > SZ_16K
-#define ENA_PAGE_SIZE SZ_16K
+#define ENA_PAGE_SIZE (_AC(SZ_16K, UL))
 #else
 #define ENA_PAGE_SIZE PAGE_SIZE
 #endif
--=20
2.23.0

