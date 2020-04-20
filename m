Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01552C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E3B206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CBIXMZhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDTQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgDTQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:37:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2265C025493
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:37:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu11so88801pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbyBhtQXovOuohU3c8+wtKegG5T8ke0e4KECHuLLxNg=;
        b=CBIXMZhV6/MqDLrkiTD2GE+TJSt1fsk24nuP9MV9qjvnAraII1VF7DYlCrx3h2TuG7
         VfI3zfk/34XS5OjeWqDdx5Kga+Rreu8fligEIWu7tKkWdlS6lfOhhpCl0P6iKYTO7Zr/
         /VrV7/pHtUuR2LuvlD9Go2eAAv/M7BJoDZlSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbyBhtQXovOuohU3c8+wtKegG5T8ke0e4KECHuLLxNg=;
        b=SaAgpkqS3rTcCWzoo1poox00nzc/8FIuFrKwgc7Z0GKXkrYWTqZKQOJVp1ZOnhSmSs
         qA1gt4OMOpVuvEp8eT6gZfxT4mbW3k9m9SjQU937PEVFK92SVNhFSVrKDDbHdNZhnEsU
         G3e9paOZSGifGwfE2Wbyohorr1DOwdb/nWL9ptLJc3wJQvrC3gsSXy4SWmKIJCrPmedt
         tUoBvQrGRj5LmyeDs5YTXmBf8auUCadzEQFYRWlOZ+Hn2A36eEYS7URk8M6Nusyp5LyW
         ZB+eaXanagF1+5TI5xSSogD9t6nddt85gbDAtmn0DRKDi/u4QVfDVv4qn6sv296Bc6Av
         vuGA==
X-Gm-Message-State: AGi0Pua1kLXqoU7mkCSvuhSaeLw0+5O6WOOmn6/yvSnzuAEVcJhqzUbI
        NX0wnGHBTFYtJJNafReaxXOqSwaI6QU=
X-Google-Smtp-Source: APiQypLd5N1x6fRFN6a9H3PYT0ahd3JGW2wCx3SWRBf4T62ZoB1Za2xgPLKjku41zG8TUnQwNptRsQ==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr286694pjj.122.1587400644979;
        Mon, 20 Apr 2020 09:37:24 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id cp22sm98109pjb.28.2020.04.20.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:37:24 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v0 0/2] Type-C charger support using power_supply
Date:   Mon, 20 Apr 2020 10:36:55 -0600
Message-Id: <20200420163657.60650-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking to expose Type-C charging ports using a power_supply class. In this
patch series I have done this by creating a config option to enable this by
adding support directly into the typec driver. I would like some feedback on
this general approach.

I have been testing on a system that uses an ACPI implementation of UCSI and
things are working as expected.

Mathew King (2):
  typec: Move typec class structs into a header file
  typec: Add Type-C charger

 drivers/usb/typec/Kconfig   |  11 ++
 drivers/usb/typec/Makefile  |   1 +
 drivers/usb/typec/charger.c | 204 ++++++++++++++++++++++++++++++++++++
 drivers/usb/typec/charger.h |  33 ++++++
 drivers/usb/typec/class.c   | 108 ++++++++-----------
 drivers/usb/typec/class.h   |  63 +++++++++++
 6 files changed, 356 insertions(+), 64 deletions(-)
 create mode 100644 drivers/usb/typec/charger.c
 create mode 100644 drivers/usb/typec/charger.h
 create mode 100644 drivers/usb/typec/class.h

-- 
2.26.1.301.g55bc3eb7cb9-goog

