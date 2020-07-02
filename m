Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B25DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD0B20899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0QZy5CD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGBXLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGBXLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D01C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id by13so15890042edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMzEJo+28bJRwgIItNGH+QbqqgwBIbsILft3O9gtxgU=;
        b=E0QZy5CDBLHBjPzef3m/xpdl0MJwdObqQ+5+eW+5L3fkZYJ1BMyHoF36eH5RDi6ogz
         eUD11sXBy5+U8RRlyO5ANE2V4mN0BW949KzovtfK9F4SdAx42d4QWsBUgV/T61xAPlJn
         3ec4926bnFi5UCyWMWXkYOKZkZd33IUuypkZbfD387Wv0JB+YNOV+e1SS6wf+3oQSkfu
         dN97urZVlQtiqRlTHSC7SBZ6DduNCmG+Qoj2GHxTPflPOphz/8GT93WOhW9EQyP5BOb2
         Fdn5V4Ue7U8FeJKn3pt6gXHi6LR4F+d8tbAliPoUEJW76UeqM42T2g12SMNYTiMswSrj
         1waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMzEJo+28bJRwgIItNGH+QbqqgwBIbsILft3O9gtxgU=;
        b=L32E/yf02CQi3DsmH3PzsZ15lPBGbUze+XXlWgGYhVEpj4Yxqz7lvkS9KTg/yC4/Dk
         1cOfhMTilGATn9nyJ3sKeQ0p3+LuP3ZqXJ1uHCFM5QxCfuZc+1YlwhCNpCtQf/W+FXwU
         46rXT+zRU7aLWpLVDgtcgSstH0lyHQEDRZwuUBezQz7OFbcoGmYFPVLhSKPhbDyNL8wp
         AglSHZonR89VQHJbN4kLw4OIvb0lwH0Wqsj3pP4Ma0VIzTP/ZEnouk6NeNFOMfTev3n3
         mKWVTG1kXzTpfq1dO4uKYZL0QnPIBdvmMEWimXlCCPojSS+fAP6mRdAJeJ8j/26AFA1d
         wInA==
X-Gm-Message-State: AOAM530o4Frdv6ywVBfFxM+zNzvXLGmbaKtHxz4rfamEqfJMlWpyCbn5
        9V5WS81SBPi6t4Q52/Wu3ZceKxDA
X-Google-Smtp-Source: ABdhPJyHw/fU4g3meCkpRAiDmczhJLQIcBxpEQbN12IMgXF5I4t8ixiyvuNvdmDR99cG7veVnhaOYA==
X-Received: by 2002:a05:6402:1ad9:: with SMTP id ba25mr5624220edb.74.1593731464878;
        Thu, 02 Jul 2020 16:11:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:04 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/14] tidy-up options / reorganize lib.c
Date:   Fri,  3 Jul 2020 01:10:24 +0200
Message-Id: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of content in lib.c have been added by just appending at the
bottom of what was already present. As consequence, things are now
not well organized at all, especially when related to the options.
So, reorganize things a little bit here:
*) move all helpers on top
*) keep things alphabetically sorted
*) move options parsing in a separate file
*) move predefine-related stuff in a separate file


Luc Van Oostenryck (15):
  options: let handle_onoff_switch() use null terminated arrays
  options: move -Wsparse-all's processing out of handle_onoff_switch()
  options: move on top the definition of warning type enums
  options: make Wsparse_error less special
  options: handle_onoff_switch() can handle any flags, not only warnings
  options: move helpers up
  options: alphasort the handle_switch_[a-zA_Z]()
  options: avoid spaces between function name and arguments list
  options: move declaration of tabstop out of "token.h"
  options: add a small helper: handle_switch_finalize()
  options: move option parsing in a separate file
  options: keep the options sorted
  cleanup: move predefines in a separate file
  cleanup: move parsing helpers to parse.c
  cleanup: move hexval() to utils.c

 Makefile    |    2 +
 lib.c       | 1256 +--------------------------------------------------
 lib.h       |  119 +----
 options.c   |  998 ++++++++++++++++++++++++++++++++++++++++
 options.h   |  137 ++++++
 parse.c     |   38 ++
 predefine.c |  225 +++++++++
 token.h     |    1 -
 utils.c     |   17 +
 utils.h     |    4 +
 10 files changed, 1427 insertions(+), 1370 deletions(-)
 create mode 100644 options.c
 create mode 100644 options.h
 create mode 100644 predefine.c


base-commit: fa15396204a796135f71b5aef6cbbe3ba1fc0eb3
-- 
2.27.0

