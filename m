Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA95C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9962087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8hn3QZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAVDBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:01:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33252 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgAVDBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:01:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so2671754pgk.0;
        Tue, 21 Jan 2020 19:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xAGUqDF53pB8VMuMvpBoiRKxeymCwVfxrUoJ08X25M=;
        b=R8hn3QZCAwgs5cL2MUEcAx5e5aGrdPKAGs/w8dmOXUWV6doaHTtrF2TnaBUJulFIyz
         Kvg7oGuK9zGNt263sfvqN39+heO/qQpPzR9q+Gej4z4wDoJdHbfw5Sed7sTnoCAbrGLi
         Fs7s31iCp62txho799KqQ2unhLtO0PKFCgfQ3xBCQR5Lw6+vo5eG06sRMxncE1WCNPcP
         3/FfO6lgQuAMV+eWRqe8kTequ8WZo1DXX/5HuRI9eQLFkEYQx4rTApWNmPWUnTtqzM9A
         2gaksk1Fr8aK6dAhyHsKqiso3PjqxTGx2c54YTS0cIBI9zvG7+WCCXrwip1xn1KpRToj
         nVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xAGUqDF53pB8VMuMvpBoiRKxeymCwVfxrUoJ08X25M=;
        b=Qdg/hjlBNCathMf6iTYC0Vm2UYkWVm5bbdfj1+ZPubouAJg2Nf/50KMF0yAETAIRSA
         rqsORerSnMeueUrTOhggGnRKctav2REotdgu4FTwEd9ge0CIj2jqTi0w3Hy6m8Hf7bPz
         57onJ0sZwFVnqtguz7lUGkyPRCNykcukiQFKBA/3znjZc8EzbGWD3nbBZBf4MAOXBy4p
         G2XMVdwFiYbTdZFzcmNMuZJHC6C/QrwTwTQetPqBL8euBNZXoq6WLxKGsuiPuDeQ/KDE
         MbtNH6NjMTpFMoeW7CSzblrA/qQJzclMZt5m++zRPnDDUwu/+MEdKaRjTbohdeNW10Bn
         Q1kg==
X-Gm-Message-State: APjAAAUuD6f7ixfd4p5Dq6j/Lo3l/805XgYjdNp4kzB098uoiFnucYii
        u9phzaqmow2OcxBemNa/r5Y=
X-Google-Smtp-Source: APXvYqw/MThBheZyVETuW7d/jcgXlXpMqqnUuoKoIAqjZ8ljazaTKAlGtGljweSbZAqdTw4+163QOw==
X-Received: by 2002:a63:597:: with SMTP id 145mr8498882pgf.384.1579662102269;
        Tue, 21 Jan 2020 19:01:42 -0800 (PST)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id a23sm46838001pfg.82.2020.01.21.19.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 19:01:41 -0800 (PST)
From:   jassisinghbrar@gmail.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, masami.hiramatsu@linaro.org
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v3 0/2] Max3420 udc driver
Date:   Tue, 21 Jan 2020 21:01:36 -0600
Message-Id: <20200122030136.7300-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Changes since v2:
 # Remove inconsistent licence term from the driver

Changes since v1:
 # No functional changes, just cosmetic changes as suggested in review.
   o prepend everything with MAX3420_
   o avoid CaMeLcAsE
   o use GENMASK some more
   o reorder struct max3420_ep and struct max3420_udc members
   o added some comments
   o changed license in dt-bindings
   o changed interrupt property to names


Jassi Brar (2):
  dt-bindings: max3421-udc: add dt bindings for MAX3420 UDC
  usb: gadget: add udc driver for max3420

 .../bindings/usb/maxim,max3420-udc.yaml       |   69 +
 drivers/usb/gadget/udc/Kconfig                |   10 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/max3420_udc.c          | 1331 +++++++++++++++++
 4 files changed, 1411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
 create mode 100644 drivers/usb/gadget/udc/max3420_udc.c

-- 
2.20.1

