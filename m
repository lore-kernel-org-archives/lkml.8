Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47945C3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4F92068F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3+9YPzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBRX4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:56:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37904 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBRX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:56:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so11498293pfc.5;
        Tue, 18 Feb 2020 15:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RaNnl3+uu7fV0u4Un9uuTw80YtZZSfmJ9Z7lllWiZwI=;
        b=q3+9YPzso4OBjcsYS2BGJQuc8RXnF5FAOBKDmsn4C+kUWEPNeBpu34WaqyCW892Rx9
         +ikfWY67U+3ZmXajhzgMqKeEuzNDfjI8hlYDQf+9PP/l7gSfgcQWQOdNP3T1TsPtP8+A
         Zti+38TKv0ZapaDQnVOb/EtYxZh8XbF58UqIb3qEDYAeQzer+jWuPd8ngsgNoBxbltmv
         5JMOSDtI+7J9nvpLyQcWwd28aWQWysec9iFlnQ/LHc9YML1AVMtDSdO08srWz0rdBQZG
         3YjIBU7P2osVOZBfqQ4Q6/v/xcALtHxkLUy2CDGlY/ADQIctpN6FXmaMhuX98ogMctJK
         5I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RaNnl3+uu7fV0u4Un9uuTw80YtZZSfmJ9Z7lllWiZwI=;
        b=PRmT6J2kixoqnNPoKH+5aY0hqqwyNHB5LhksIKAm286w0h6FClaW+Sg26t2+WCfQ47
         qCFMzsUpiNA2czVNpPbVlX1IcDX220bDOL/1GVI3MncVqTsXKJ8u536gOpgosuEHj4EF
         y8UBdQtcpBGZCUPrdtFF55zZif62mCt0nMecx1jtxL1hmn1rA1fVL+WUXVXqB7stPVtR
         GIknYi4UimM4n06jt3VxKvQzPT5TJQ7wykyDRblY7U1NRKFRILTTJRe9baumVIQMFWwN
         rw7hUhwOyMIpO/2VajaYWvdtwgcXXbx9/OdPp4T9HyL8dgM98UXo7vyAZmB/e976BCIB
         TnBA==
X-Gm-Message-State: APjAAAVE1HnUGeJ468t6vxTxAEAipZ1zlYlNC+C8NbFw8T8/JNyPL3px
        mcQu+u0AQZfegtOg/3CsyQU=
X-Google-Smtp-Source: APXvYqwZmgIEHqOxLQ1cyJyx3ogGpJoEg6ROKfneriZnTEoj6j1aqMsH+aDmEeM9a0OC3ahr/2pl2w==
X-Received: by 2002:a63:5807:: with SMTP id m7mr23349426pgb.83.1582070168618;
        Tue, 18 Feb 2020 15:56:08 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::5:1718])
        by smtp.gmail.com with ESMTPSA id d3sm80558pjx.10.2020.02.18.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:56:08 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/2] usb: gadget: aspeed: allow to customize vhub device
Date:   Tue, 18 Feb 2020 15:55:58 -0800
Message-Id: <20200218235600.6763-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch series allows people to customize IDs/strings in vhub's
device descriptor through device tree properties.

Patch #1 overrides IDs and strings in device descriptor if according
device tree properties are defined.

Patch #2 moves fixup-usb1-device-descriptor logic from get_descriptor
handler to "ast_vhub_fixup_dev_desc" function for consistency.

The patch series needs to be applied on top of "aspeed-g6: enable usb
support" patch set to avoid merge conflicts.

Tao Ren (2):
  usb: gadget: aspeed: allow to customize vhub device IDs/strings
  usb: gadget: aspeed: fixup usb1 device descriptor at init time

 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 93 +++++++++++++++++-------
 1 file changed, 68 insertions(+), 25 deletions(-)

-- 
2.17.1

