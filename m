Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB382C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A87120637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfHuBWzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgCWQGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:06:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43537 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgCWQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:06:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id v23so2042986ply.10;
        Mon, 23 Mar 2020 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfgyUozrcyVeIbWTe9VtWlhfGhnTXRnr9DGhPby8qnk=;
        b=AfHuBWzvmao3HKK/QvqGqUTqv0rDERPhbye0AYcbj792E6g5lFTGhLA+tBb6mvNIuK
         LxP8ewdVIquY36g+KYK9OeIMuyg9kR5+GVQc+lfok7RFn43U857WRZvBAsPTx/Fq4MTd
         jtmSXqGMTnek9Wl+Qwq04Q9mBye0ilpcTThB7uAWDD+xWWXCaQSqUkTqdIFH5updjkgT
         7iD4vhn+bgsFDlCnDdxVtN7h2jhqltEsx3C+kROScwebF0FtGWfsGYiYdrue4PYOvRKx
         akANVv2xhDEcMnQhrLxWIN4yULIF3SDuM6JMKIUW4kJzTYiz3yykZasmktnADSBq7Otf
         bpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfgyUozrcyVeIbWTe9VtWlhfGhnTXRnr9DGhPby8qnk=;
        b=t9rP60jn/X0mq5CfOdIuul+5ZiwCP0/9fyzf77SjRwPfvDomMwCXbTHiud2AmnvCdX
         JwF0BXcievXq809lqcTbqHssXbjxmpoKX5fqtjPX0m2MEL5seSYOZEBa8ufq3yKEWTNR
         vVYvLTmQsY+/cNZ8y8IMHDrHsoWv1j0OPQ3ABFRsRWaoPGiqdOahi1X1vRQq4PONUuOE
         ZAkmAj1qX5Aox7VRQgUteZHAoa3HHa244de8dCO3kt7+4ABTtrt5Jgs1hZxSUiCu4/Xd
         dateBygXfyLuo8u99VlTTqYU0mChhgGJDaRRoja7v6jd00WqpDoUGkYGXpL3+bhFk1Wp
         0vFg==
X-Gm-Message-State: ANhLgQ3OXgswPgCsAQFcAGIwEAt5xM5RkrTaC5XQac3/8aqCJnXL0Pll
        yCq7UmYqcXcKlXUVucx7D9w=
X-Google-Smtp-Source: ADFU+vvYHYwYzS7UqIFqca37UDib2pFfcnYx0Ir1n6BUVHFwa6OnPaZvwCCtsCKcNoYLaWbRAgGFOg==
X-Received: by 2002:a17:90a:aa0c:: with SMTP id k12mr26804196pjq.193.1584979580067;
        Mon, 23 Mar 2020 09:06:20 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id a10sm6871641pfi.16.2020.03.23.09.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:06:19 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert+renesas@glider.be, tomas.winkler@intel.com,
        tglx@linutronix.de, hdegoede@redhat.com, treding@nvidia.com,
        suzuki.poulose@arm.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v4 0/5] drivers: new helper for ioremapping memory resources
Date:   Tue, 24 Mar 2020 00:06:07 +0800
Message-Id: <20200323160612.17277-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit "drivers: provide devm_platform_ioremap_resource()",
It was wrap platform_get_resource() and devm_ioremap_resource() as
single helper devm_platform_ioremap_resource(). but now, many drivers
still used platform_get_resource() and devm_ioremap_resource()
together in the kernel tree. The reason can not be replaced is they
still need use the resource variables obtained by platform_get_resource().
so provide this helper.

The first patch in this series adds a wrapper for these two calls and
the other uses it in a driver.

v3 -> v4:
	- modified the description of a parameter res in patch 1.
	- modified patch 5's commit comment.
v2 -> v3:
	- rename the function to
	  devm_platform_get_and_ioremap_resource() by Sergei's suggestion.
	- make the last parameter res as optional by Geert's suggestion.
	- Reimplement devm_platform_ioremap_resource by calling
	  devm_platform_get_and_ioremap_resource() by Geert's suggestion.

v1 -> v2:
	- add some real users of this function (Thanks for greg k-h's reminder)

Dejin Zheng (5):
  drivers: provide devm_platform_get_and_ioremap_resource()
  usb: host: xhci-plat: convert to
    devm_platform_get_and_ioremap_resource
  usb: host: hisilicon: convert to
    devm_platform_get_and_ioremap_resource
  usb: dwc2: convert to devm_platform_get_and_ioremap_resource
  driver core: platform: Reimplement devm_platform_ioremap_resource

 drivers/base/platform.c         | 27 +++++++++++++++++++++++----
 drivers/usb/dwc2/platform.c     |  3 +--
 drivers/usb/host/xhci-histb.c   |  3 +--
 drivers/usb/host/xhci-plat.c    |  3 +--
 include/linux/platform_device.h |  3 +++
 5 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.25.0

