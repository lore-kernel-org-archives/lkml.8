Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA2DC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D63421835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVj+S+nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAVSTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:19:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46252 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAVSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:19:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so3910427pgb.13;
        Wed, 22 Jan 2020 10:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=vz27NAypvKnOYVfML3aV6UsXgqBBJ3TOPhh75RFKQdQ=;
        b=bVj+S+nY/LX+PIQVXpxLKKPrDo7UbEY7K+tg2qNTxnr327+HjEbfhvngtXqwlZN1fq
         xPTuLHEcoA02B2jFxpeZuUtUyWiSQ2cDhBAELBSyc70Ei+JsVRUx2ghAWhLGMHfgVEer
         IYKX1t5mVbZe+K7n/+b3aZvlZd1fn8lJSjEbf8Fs+Xauo2tiZS9WgY6oZTli3PdbgJTH
         ayQ/rslhcxmb36n+izipsc7U6AQI6bu3kN/zRnaypJS4jQGN0qZluU9MWWdbXQVOniZX
         2eW2qD6pzDGkjzJFQgAQZg2NhC/Uno53n1Ec6rTFFDj+ZkbDPqUcdGJHJXNa5XEKnIsC
         NmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=vz27NAypvKnOYVfML3aV6UsXgqBBJ3TOPhh75RFKQdQ=;
        b=V5bWG9/HG01agPSQr7n6CAmbgVw8E0GGJiwGo/37ST2OVf51D7seqs83yFuZVor1U6
         M2ZmIuJLI01k+pdP8D2xJqHm+hT3dJcl5ESFbr+FDcAGKh1iCQqrQjli/vtcLU6p5ScE
         5FhnvlTABu82dFD4zC4R4s32m3F8/3ozO0T95WS+HkmhofBVNpShPjan5j7TKUf894Vn
         9JvNndOsea46Ro3qVbZTYjzQItEDYv7VAH0SV8TCfdzfIFhmVuALIQ/pM9zSUECIqPxc
         j4wmcwqQlKye9f4ts65jj9zcIQrxkB7J/qpcLRfz86oja6fY0KeXvaZxy6Q/Q2Nh3AZ3
         q6NQ==
X-Gm-Message-State: APjAAAVsmeqjOB/myJkARbWGfn48yvGjiYn06itCi8nlrK5ls9ly1SEm
        zV9t9Va904MoFESbjiiD/U77c52M
X-Google-Smtp-Source: APXvYqwZFVAKAWPmMCZ9N4wtUls1yUSIpp2Qp48tPT6YFwShAP8YS9Pi8UuG4qffnKlEYDc1iSgsPw==
X-Received: by 2002:a63:184d:: with SMTP id 13mr12304172pgy.132.1579717180514;
        Wed, 22 Jan 2020 10:19:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id hg11sm4239183pjb.14.2020.01.22.10.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 10:19:39 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.5-rc8
Date:   Wed, 22 Jan 2020 10:19:37 -0800
Message-Id: <20200122181937.18953-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.5-rc8 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.5-rc8

Thanks,
Guenter
------

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.5-rc8

for you to fetch changes up to 3bf8bdcf3bada771eb12b57f2a30caee69e8ab8d:

  hwmon: (core) Do not use device managed functions for memory allocations (2020-01-17 07:57:16 -0800)

----------------------------------------------------------------
hwmon fixes for v5.5-final

In hwmon core, do not use the hwmon parent device for device managed
memory allocations, since parent device lifetime may not match hwmon
device lifetime.

Fix discrepancy between read and write values in adt7475 driver.

Fix alarms and voltage limits in nct7802 driver.

----------------------------------------------------------------
Gilles Buloz (2):
      hwmon: (nct7802) Fix voltage limits to wrong registers
      hwmon: (nct7802) Fix non-working alarm on voltages

Guenter Roeck (1):
      hwmon: (core) Do not use device managed functions for memory allocations

Luuk Paulussen (1):
      hwmon: (adt7475) Make volt2reg return same reg as reg2volt input

 drivers/hwmon/adt7475.c |  5 ++--
 drivers/hwmon/hwmon.c   | 68 ++++++++++++++++++++++++++------------------
 drivers/hwmon/nct7802.c | 75 +++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 113 insertions(+), 35 deletions(-)
