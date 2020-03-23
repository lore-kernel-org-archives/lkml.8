Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4974FC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15520842
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZbITrOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCWPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:22 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40435 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCWPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:22 -0400
Received: by mail-wm1-f47.google.com with SMTP id a81so9424178wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1foJ/7dzFcW1ibnyR1fQ1dVKm6BmjeU6Wk64TSBnq4=;
        b=dZbITrOfxNqhB943lLNdXwVtR2EFgCwHzU/1Qld/fltEX4chtm3OSUkBuU0ICOY4aO
         iXjDaa2KBJNad3bW208trlJ5vWtWs2qSUO5cFbCWAOPc0aJK6geXgoC48h8gNDT3SqOd
         eh2idO/7t281mDhsQgXRbteC84wZx0d3EIm4K3SWACunViLwSIKESBFnwPu2oqF05UIl
         QqMtt1oU+CJU5iZbck6iY1AHEkmD6oTOYExHGK3nrkdWqGxoJQuACH+1VaJntESNH0b8
         vAx6n+Zbrm8CpLBt+/nxADtpGpw7+Hxsokai6KcHJ7PEtQ7OXhhkPrSCrN4GEdaop+1i
         4V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1foJ/7dzFcW1ibnyR1fQ1dVKm6BmjeU6Wk64TSBnq4=;
        b=Up9YAQEZT5NZIyivDk4DGQeWbaVe3TJHSgVwwVeYUzKbnRYHsQdReUBLUNocKirReB
         qPpthHnHkAMUh4nj7cqB+cSbOVoUfEZEueWUd135gb8KJISZlWhNza2GVTMyY3Za4V3G
         qJf/pqGFYTYqPZEqcLbaxPZM9xoIDqOdbv59r6PvrEQ5QQsf556ajHLl0A6qmwO1DYQB
         hJuZikKgoH77UJ8oGE8nxcTerKLF7d/Eok+2MXQLRFIsbHglsMbAiwLlK0r2u4COVcdL
         sb9Jy0xMAOjX45CydgzPOuqDqpMbYyIyifh3SLFkufruR6II+AhQX+nsZUTa882C6iL3
         Cftg==
X-Gm-Message-State: ANhLgQ06vOvmZEcAaE4jE4RKmxz5EP+7S00TKafmos9udMA7kynCVPfZ
        gLu0y8ave23Ihqjvf8Uwgch1l4pSK3w=
X-Google-Smtp-Source: ADFU+vunD/RIW3cj5Jk6VTD3QhV9HV8x9FzBtr8VJ4h21ScDs8qNQ2qpZLDfaz/CEcu1mm9nIjR8iQ==
X-Received: by 2002:a1c:7c0d:: with SMTP id x13mr26990667wmc.44.1584975620669;
        Mon, 23 Mar 2020 08:00:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k15sm1084196wrm.55.2020.03.23.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:00:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/5] nvmem: patches (set 2) for 5.7
Date:   Mon, 23 Mar 2020 15:00:02 +0000
Message-Id: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.7 which includes
- sprd nvmem provider fixes 
- mxs-ocotp driver cleanup
- add proper checks for read/write callbacks and support root-write only

If its not too late, Can you please queue them up for 5.7.

thanks for you help,
srini

Anson Huang (1):
  nvmem: mxs-ocotp: Use devm_add_action_or_reset() for cleanup

Baolin Wang (1):
  nvmem: sprd: Determine double data programming from device data

Freeman Liu (2):
  nvmem: sprd: Fix the block lock operation
  nvmem: sprd: Optimize the block lock operation

Nicholas Johnson (1):
  nvmem: Add support for write-only instances

 drivers/nvmem/core.c        | 10 +++++--
 drivers/nvmem/mxs-ocotp.c   | 30 ++++++++------------
 drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
 drivers/nvmem/sprd-efuse.c  | 27 ++++++++++++++----
 4 files changed, 89 insertions(+), 34 deletions(-)

-- 
2.21.0

