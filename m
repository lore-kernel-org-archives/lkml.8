Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A76C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AE52193E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSE/BPX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGNDgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:36:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD847C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:36:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s9so19942783ybj.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zNQV95i7c6JcJLlsny6Fhc23+QJFeBp9C60Maw1tGG4=;
        b=hSE/BPX913HTAs++baLX4mt1JgCuoxgt/V9igV0OR3rWM++ODniXgdSBD7s+jXLHhR
         a452v+zASbCdRzM9C18yCMZHTmFww6nQiHdnKQKfyqeNHa1BxFDBXXrmuQOxFtyDdUUS
         I/1eB5quNOsb0K8jVl1LObnoefnQk5OALxRZ/mYNqe+hzRywAxJEC9JPF2GJ/iwSquYi
         UnM4P0svZlU/mxf+0n83oM1QEM7mV05C2iIGpPhyHlQ6JdIpOwuJleqPTYN9HRjfhlpO
         FRIm6k3tIqAZBXakOrcIk1Env3Kclme5mD5xynU+EKbRHGJ707PPIsAlALWHniOjfPY2
         wIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zNQV95i7c6JcJLlsny6Fhc23+QJFeBp9C60Maw1tGG4=;
        b=bJazKCy8SuTd5ZN28jW78KVtN9TpJX+vzHsbRRtIFNh5TSK1aeiptF9U6ftyZ0lpdM
         dru8vxikG5u238DykoW145eA//xJMyZb3D+hLGQcgxYz4KoqvEbm2iB3XC1hWfYA7RB4
         NHnsBsnnQLdBmnlYPJiFHElsnhvQk9Sp7yjclEMbiXCcV+KYlb3w+FJbWYs1Xbv7EbER
         KwVPIPI8VAWsUoOZ6Avkmrb31XUG1m11QnxdZK7UzQOerolCJljOV/7cw1ALDuRDLAyx
         hudgxt1VdbzVVb3bRZXkK3jgwSmhadrFNg83EtAyFO2c5zoSGZke+ThskT7jAVH1+Di/
         Pj5Q==
X-Gm-Message-State: AOAM530b8IxWZi2m/9p6hT8KRUYlxjkHEsFkk8qhaReqbGRcJkpyy9st
        RjQfk1vR1abVbH+cZslA30UvVxGsglVA
X-Google-Smtp-Source: ABdhPJxnEf16kvDaLZZB9IfoIH2D+Xb4ovNqya7VkOUTo5ipYiwqV6Qi6ORPMZNHMpsbUnYXRU344QdXRV+v
X-Received: by 2002:a25:803:: with SMTP id 3mr2023649ybi.518.1594697769925;
 Mon, 13 Jul 2020 20:36:09 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:34:51 +0800
Message-Id: <20200714033453.4044482-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 0/2] tcpm: Error handling for tcpm_register_partner_altmodes
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Kyle Tso (2):
  usb: typec: Comment correction for typec_partner_register_altmode
  usb: typec: tcpm: Error handling for tcpm_register_partner_altmodes

 drivers/usb/typec/class.c     | 2 +-
 drivers/usb/typec/tcpm/tcpm.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.27.0.389.gc38d7665816-goog

