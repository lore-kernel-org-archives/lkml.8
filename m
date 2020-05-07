Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC35C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFEF20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7E9vxwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEGLOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEGLOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:14:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026ACC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 04:14:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t16so1936885plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+rp0hHwgqIdfgMKxOUzphxxo4JDZCcfnfLUjyAdUEiI=;
        b=S7E9vxwgne3IjONysfCfx0M3VX2AbXVhOXdey3dogNGV2F9OwqcBy3oTnxsMV7KGHv
         +C0iOQhkPwhJuz3mhviDDa7H5Hy+OffpMWdD4yp1YJ750RC0BNC7bBwXGYRxEzN3/sWq
         dBvNuWJmqhUgJIScldGp5wGxTV0vfwtEQnuOCvP9ellFEIiR7tvUi9pyVNUdeT/2vPlU
         KCUfperFTOp1Q5Xn0pNcdhUCPmcvZakvQuFhVNTXsgGPfgTBHCDqsl3IAJVb8PDH7A09
         jp8W9Il/Ex9De7qbCIerpVY3XezcvMHQq4qxT6KdR0kUaw9cP5USOO7TNMnkNjABweta
         wrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+rp0hHwgqIdfgMKxOUzphxxo4JDZCcfnfLUjyAdUEiI=;
        b=MF7AhyicpjMdxwa/I8rKt7BHJ5KWRdO5t6dgYSOIzQ/e12uvy3+eE5EgOoS9djs5fI
         Xwia4Z6oLg/WYUQ2/JANBuNcKKNeJ56aDRKII7Xz9fa96LKQ5nWOg/9qNyzRycwsM0Va
         xgmkfDmEr8xPOheywXTRP8EKruSx3ApjPHlBFB98kL3+71ARa1KARcXXDhdpjkZLP8XY
         l5dypQ7TILnUXt/HVw1Imwq+zSeucd/j3FLVlKNduL8Ur9HICyuTkj4XKQgFAFUtvQZ8
         HTL4SrW8PVx+0wwaLbEHgmDlFPBYfltIVsTzpU4qX8Y0ZB9RKmwwjZDgigsbsIa0clwa
         /PuQ==
X-Gm-Message-State: AGi0PubM+BykbN7Bbtds6nGjfCvbbdiiUKVh87WdQmoonOLX+FY8K5qI
        oL3XWjwPHNRDH5Vf9JeycOk=
X-Google-Smtp-Source: APiQypLaeQmfMqENPb7tQLhoxQC3jxPkAodQ3l/6XIitoKL8eDkg01q/ii73kk1m0Mx56maZ5k9kDg==
X-Received: by 2002:a17:902:bf46:: with SMTP id u6mr12316877pls.318.1588850093478;
        Thu, 07 May 2020 04:14:53 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id l30sm7304041pje.34.2020.05.07.04.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 04:14:52 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] Enable stmpe811 on stm32f429-disco board
Date:   Thu,  7 May 2020 19:14:45 +0800
Message-Id: <1588850086-24169-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset has following one patchs changed in V2 based on V1

Changes in V2:

[Patch V2 3/4]: remove id, blocks, irq-trigger from dts node.

Changes in V1:

[Patch 1/4]: add I2C3 support on STM32F429 SoC
[Patch 2/4]: Add pin map for I2C3 controller on stm32f4
[Patch 3/4]: enable stmpe811 on stm32429-disco board
[Patch 4/4]; Fix stmpe811 get xyz data timeout issue
