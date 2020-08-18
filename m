Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8138AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57EB32067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXXy4d11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgHRIeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:34:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC6EC061389;
        Tue, 18 Aug 2020 01:34:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l60so9093507pjb.3;
        Tue, 18 Aug 2020 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=szP+8DM2fo2Wg0FXKp5oArkPY3dRWu1AVOY6u2GDxKg=;
        b=kXXy4d11xMBXcJj+fsuZKlC40XsOYUs9qFdqzuKei+P99PVGYB4cy5YvPiCQ9SE5gc
         nwowHtPWMwFGXmPyaIHawdQfK5b06JAnIyDjOBe3YW++Q1BV0EX6kfoY8km/11uZY8hV
         YprH1emQ2HNL0jUmKDhfxqGEcu+tHvd3Vtkby05p+VNjxGkQZQBEPYl+7IXbofAl6BG3
         hhOroOHfCMUIFb1yeteG3XTgjOWMSn+dJWzkVa23ynA8tSGk1jcOWqU1t6F/2rg4cH0O
         Xw3eM1EmBGSLh20rgcywQjdmExvL2tkXvXtQYrrhFcy/p1TGSvWno4qJpYUyybKlEz3c
         pc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=szP+8DM2fo2Wg0FXKp5oArkPY3dRWu1AVOY6u2GDxKg=;
        b=GEUMHkv9et6kytyATo1Bjk5Dq3sclEtC9cwA8XFEEgoWrai68JVpkjmtMOSxliZ256
         HnyzfqLr6ImkQNkFS0EVN3ZqC3HgbpLZda4OKq5/wpc58oIl6qKyU7GY+uSBHJY3dUPZ
         FRtwQP/WOI5baBNrBUB20/zbrD7MJ9yL6PkJA54lnkEiCZQCE5jVK61pJf9SfauKXgya
         REeSCba++qEpCnBmS6l82T4AHLd6vrR/gHGs7l/GVDCmfp6OmxCokmtGH+VsZyn1lvlu
         +WXfCX9Oy0PqKr1h83i+CkC+DDMeDL15bWIIJ8nxrqoouMBGmPIAa4eyVRpyEZKuSLgU
         XEFg==
X-Gm-Message-State: AOAM532HqF4zYRm2aWzo6aDlXBuO6F+5uZ4NwkUzzlkQ0OmEUvcKTDp1
        gwvheujqq17jGDVP0CIPzpxjKODRq1A=
X-Google-Smtp-Source: ABdhPJx/UC+X2o5gXzjptm7LMgpeuMJeCeHbSRiXInZVSqmm1lN4kB/ZsnKF8m/DRi8+r0YbjnrTpw==
X-Received: by 2002:a17:902:bd90:: with SMTP id q16mr14299265pls.196.1597739641056;
        Tue, 18 Aug 2020 01:34:01 -0700 (PDT)
Received: from oppo (69-172-89-151.static.imsbiz.com. [69.172.89.151])
        by smtp.gmail.com with ESMTPSA id l78sm23898616pfd.130.2020.08.18.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 01:34:00 -0700 (PDT)
Date:   Tue, 18 Aug 2020 16:33:57 +0800
From:   Qingyu Li <ieatmuttonchuan@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        kuba@kernel.org, matthieu.baerts@tessares.net,
        stefan@datenfreihafen.org, arnd@arndb.de, gustavoars@kernel.org,
        bigeasy@linutronix.de
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/bluetooth/rfcomm/sock.c: add CAP_NET_RAW check.
Message-ID: <20200818083357.GA5442@oppo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a raw PF_BLUETOOTH socket,
CAP_NET_RAW needs to be checked first.

Signed-off-by: Qingyu Li <ieatmuttonchuan@gmail.com>
---
 net/bluetooth/rfcomm/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index ae6f80730561..d67d49e5aa00 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -321,6 +321,9 @@ static int rfcomm_sock_create(struct net *net, struct socket *sock,
 	if (sock->type != SOCK_STREAM && sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;

+	if (sock->type == SOCK_RAW && !kern && !capable(CAP_NET_RAW))
+		return -EPERM;
+
 	sock->ops = &rfcomm_sock_ops;

 	sk = rfcomm_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
--
2.17.1

