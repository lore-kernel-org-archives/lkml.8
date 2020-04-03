Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8927FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF53206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="gqhu+E44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbgDCJYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37165 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id j19so6899117wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2C4d5NmswJWeckiXBSWO+i/RqWs4DFLHWnnzQXBbFA=;
        b=gqhu+E44z7/tR4IXKE4IpvLY/8f7+/6tJD7GkhkODruq8WzixSxPBhazMOZvq6lcMJ
         BQN+GsYtYZGfcVkBLsgW8yZ8720okStAbR/lwr8bq0fbCPSTlOYCYrdlROtWiXSesXXx
         fwa7MG393R4f3LiQkL5mcaPZUeuMJikgJOzVILzhWTj0cbQPHmCvhJGb+WVDCgYZ3wax
         gigyS/cE4HeAzlfpTWg+ODiKiktS22p//6yoAGCxnUN/cFsG/cOT+E6GfQeEtjBoTl5m
         zreYhiUDxqZmA9q9YbX6nBYNj9crWX/HW7cxhK793lI3u+LzDWngrunvKwtkuHRABe7+
         2XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=P2C4d5NmswJWeckiXBSWO+i/RqWs4DFLHWnnzQXBbFA=;
        b=e8b8ghvdszgKTNuLzZepgvOVamRcGxIcH57yNFH/90FtldAzpQ7UPMXVwF6G0eBodZ
         hqtCypvxBK2LZOaOuFhFPqTgtRM51GF0QK2bYaz7Z/M/cQMpqTJ9xohC0bVS8OnJUotH
         cRum34pLYQrzIaRvXCIJrdMrYi7FDy7ZHMmjlAAS+loW/W4oRtCpVKPwpNlBdF3rMgsb
         yi+gBvepXcYM5gEGx+cFmC6ZcA4USDZsC0We06JvMwYhm6uXJlGoCSm7sKDq+dPNKDGW
         HXF4/UW2CgwhKiR0xWNfjdE7kd7xWUgrg1ms8p3ovXVRXu64oxhOT+80gSwnW+/fCJ89
         AvyQ==
X-Gm-Message-State: AGi0PuYtrwWbK0nk8/iTIpTfycC6EASCoFEEjUlhqPDvH8Mm1jXyC2Uq
        rg2hSdzRP5Qtl2SsRSo16SsY7ztNyGUsLg==
X-Google-Smtp-Source: APiQypLTpeJt4+Ib//Vb193DmCYveXVs4p7/l3vAVHCIw5JsK4aB2q5mGfApnZykvKVLR9WqeJrYlw==
X-Received: by 2002:a1c:81c8:: with SMTP id c191mr2187738wmd.14.1585905881902;
        Fri, 03 Apr 2020 02:24:41 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z12sm11550525wrt.27.2020.04.03.02.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:41 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 0/7] serial: uartps: Revert dynamic port allocation
Date:   Fri,  3 Apr 2020 11:24:29 +0200
Message-Id: <cover.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there were several changes done in past in uartps drivers which have been
also done in uartlite driver.
Here is the thread about it
https://lore.kernel.org/linux-serial/20191203152738.GF10631@localhost/

This series reverts all patches which enabled dynamic port allocation and
returning driver to the previous state. There were added some features in
meantime which are not affected by this series.

Thanks,
Michal


Michal Simek (7):
  Revert "serial: uartps: Fix uartps_major handling"
  Revert "serial: uartps: Use the same dynamic major number for all
    ports"
  Revert "serial: uartps: Fix error path when alloc failed"
  Revert "serial: uartps: Do not allow use aliases >=
    MAX_UART_INSTANCES"
  Revert "serial: uartps: Change uart ID port allocation"
  Revert "serial: uartps: Move Port ID to device data structure"
  Revert "serial: uartps: Register own uart console and driver
    structures"

 drivers/tty/serial/xilinx_uartps.c | 211 +++++++----------------------
 1 file changed, 49 insertions(+), 162 deletions(-)

-- 
2.26.0

