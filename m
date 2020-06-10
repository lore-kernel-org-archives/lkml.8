Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA8DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDFF2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ0Utuqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgFJWrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgFJWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:47:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9AC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 202so2416017lfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrXaxNfCCrjy4mZdxIeOmblIqOY4edahBMuJsDPGfgs=;
        b=tJ0UtuqeXdQYcredVb+QR8Liubj7HhXLCJWTN3xpjCbXIK2y5sa2FoDXAMEPYyCs/x
         K3tT4a3+7ls1KR15SQZcDk+8KEGhT8WyyNsKftN5JYpg0a9d6Vzgx/6MypQQ5ug3BJ6U
         rdmM5ge2iqsisUgu51M/eBEo3fM3iBThRk2f3+q824SQYsDz9yjceoU3dsT8Oimofl00
         6bnR8xRuFElg3OSxs47x6g8ASeEimtPrEOs+OIKyLVh2q9rTMt6upAuqSvC+EdPYM1qA
         BYjTDAoTMnnmON+ncpEES2VbHkrOeoUGCvRUBIqTAh1ruAMVd9jn6OnIa4eNSHbATWHR
         h0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrXaxNfCCrjy4mZdxIeOmblIqOY4edahBMuJsDPGfgs=;
        b=R3hN445UonKeBkWORTCd3VpgWqkaRMWMCWPWuCzSCflxMpu2/P4+vNE1uUcOatD6jc
         nhjEfPuDxkrSAnRSFh+TnB9VXrPaOPcyI6lTzKoMkoD7llFSCRDDgnf3pr9OXiHXOHDF
         vP8mmapT0aw4HQ/x3ojQgC2UBPsfmpuZoRJhdsH3+SGSAlaicaCIH0XEA65XQo+uThye
         vMHsB8kL4Slq1lOvh8gP1uDrwhwXjpZl25ck/KfsX8uBR2IsFYwaqGR9HKfTXwGvh9T5
         m9TzbDEuEXhLijq0ANHLLKhdo3mS80/0Nq8Io1qoakUGSQxhCBAT3dSxvl19fAvEGbnk
         O3vQ==
X-Gm-Message-State: AOAM532ATmNCDMyR0gm5j4tdxKMiRYtjFwFB05dV5ppbOYigGELKQt5J
        ZMjCblLmv7CHl3l/mr9ZJErZGUgPT60=
X-Google-Smtp-Source: ABdhPJyBrKb6lz+jy98KAGZsoFgB4V22k4l4LvTtX/19StyT9Jy4TYEeqegGgyeEzawoR5h3SypEWQ==
X-Received: by 2002:a19:fc0a:: with SMTP id a10mr2828097lfi.176.1591829241284;
        Wed, 10 Jun 2020 15:47:21 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id s17sm262506ljd.51.2020.06.10.15.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 15:47:20 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 0/4] drivers/misc: Constify static structs
Date:   Thu, 11 Jun 2020 00:47:00 +0200
Message-Id: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify some static structs that are not modified to allow the compiler
to put them in read-only memory. The patches are independent of each
other.

Rikard Falkeborn (4):
  misc: rtsx_usb: Constify struct usb_device_id
  misc: genwqe: Constify struct pci_error_handlers
  mei: hdcp: Constify struct mei_cl_device_id
  mic: vop: Constify static structs

 drivers/misc/cardreader/rtsx_usb.c | 2 +-
 drivers/misc/genwqe/card_base.c    | 2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c   | 2 +-
 drivers/misc/mic/vop/vop_main.c    | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.27.0

