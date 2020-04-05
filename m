Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A27CC2BA16
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B40B206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKp4kxrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDEDBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:01:24 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:54639 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgDEDBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:01:24 -0400
Received: by mail-pj1-f73.google.com with SMTP id o20so1509256pjs.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 20:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=591U0a3uj9ivd77KkEIm1wqfWLnwA8UR+XpmgbL5TUM=;
        b=hKp4kxrW6XAOSPo5e47PZ4T9BUTPc550lpDbhxsApbvTsaCDnClin7TtKDNYXp3dgP
         naCTlZnAkqVQMptnT5UvtXV5t8y1k0lxANTtKavs+a0uTTxQAxSL135y/fcNhEwjbwQh
         EmwKH8BflZkz8oTREBxpCuZ4W/0jUAqoZQCXwctmGtwBOwCLLJU0HxvqXjGu721cnLzm
         Ok379Ew5s+3YK9HCiWtr7YKzpMCQ3FXhWMqikaeW8JJS9dklYlLHLxGegJwWmBxdCZ90
         J2l+heXciWqQPv+YJhOHbrx+Ct1I+yrA3QtiFsqnq8syOH53vchx3RBdNYEfkK4CWCb8
         SM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=591U0a3uj9ivd77KkEIm1wqfWLnwA8UR+XpmgbL5TUM=;
        b=bGGLCA66L74nuTInBk+rq8ARYY8780mizo9TsH8AvhZQA/7NkQJM53ZPoc9HxoAr41
         Z7gpp/1E3Vc06uAzzoiAxe1TLawj/jdM5VNyRST/w1qvg0hvAONm9jQ9qO0K45ey/khl
         QDYB7z3fCMqZ6OZI3rUJvGtdEC1Wc81knFF/NrLd5M6ZpAkJMyst8u4B9QDTIKxEt/54
         l0Lm3ViMWTSFuWX87kyg5YjgnvdC/Dc5RcUhXy4PF4cpNhpBstOXZ2cI6mWx6F6FJKHO
         J8LbVkf55KP/Zieez828HxWQRTQCPSf5dxOGfQP+RSLyzZuIT1mn/g3SONPIiiyi8DjV
         QqJQ==
X-Gm-Message-State: AGi0PubSOsCMT0Bhspm3hU/aw0uBqI1n2I/AfGpcfT4suzinlrYoDwAp
        RG1TXOh42zXOjRdKIbWKwSAmkywgcw==
X-Google-Smtp-Source: APiQypIpVtgrpRGuQhmH8vpxld8wtXdjmuaKlv6sGDOC8MvvoytVECMHXLkOuA7tHJE0sC2mGX6RM6rHEg==
X-Received: by 2002:a63:4d57:: with SMTP id n23mr15911198pgl.59.1586055681735;
 Sat, 04 Apr 2020 20:01:21 -0700 (PDT)
Date:   Sat,  4 Apr 2020 20:01:15 -0700
Message-Id: <20200405030118.191950-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH linux hwmon-next v3 0/3] SB-TSI hwmon driver v3
From:   Kun Yi <kunyi@google.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Kun Yi <kunyi@google.com>, openbmc@lists.ozlabs.org,
        joel@jms.id.au, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: addressed comment in v2 and improved documentation
v2: rewrote using devm_hwmon_device_register_with_info() API and addressed
    comments received in v1
v1: first version

Kun Yi (3):
  hwmon: (sbtsi) Add basic support for SB-TSI sensors
  hwmon: (sbtsi) Add documentation
  dt-bindings: (hwmon/sbtsi_tmep) Add SB-TSI hwmon driver bindings

 .../devicetree/bindings/hwmon/amd,sbtsi.txt   |  26 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sbtsi_temp.rst            |  40 +++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sbtsi_temp.c                    | 259 ++++++++++++++++++
 6 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/amd,sbtsi.txt
 create mode 100644 Documentation/hwmon/sbtsi_temp.rst
 create mode 100644 drivers/hwmon/sbtsi_temp.c

-- 
2.26.0.292.g33ef6b2f38-goog

