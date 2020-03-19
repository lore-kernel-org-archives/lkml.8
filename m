Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C9CC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE02020724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN5ZTlCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgCSPtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:49:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33974 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbgCSPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:49:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id j16so2876862otl.1;
        Thu, 19 Mar 2020 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eIpAPE4bbOBAfFME9IvVmrEoKjf4SO3wxrl/1DOrGIY=;
        b=gN5ZTlCBPhL4PM0smB2Er8TdtB7xP/S8N49KJdA4jXznoCyPm8a9l7PPuDEJ32M6Pq
         0+orHcX2Kdb9VfyyZPM88Mvymyz5C+/cRG6dMz0pTfninMN95lvEE04k9JqWCQpZUb6v
         oRuw+dRmUzHpvooUma0ewLJVwWJAu7GJlYEOWanGT43+ao5y7qVTn06x7Q+plRSafRKD
         CS23YgJ+TSZSX+Tm0fxJHIzXbJIFXCuKtGMDMpZF+AI1vF2cmjXcj8l7Qo3lESGJFlbf
         b6lcSMjmCYZDQAbDKDA0lXPxsPcV0eGTiXTtZXnBzjstQoz57ho62v748ROxDrFFWdFG
         jE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eIpAPE4bbOBAfFME9IvVmrEoKjf4SO3wxrl/1DOrGIY=;
        b=VC/T3gJ3hGSBS4igF/0ftBFAIo4LScsGfG6MEjh8xGs/j24c2gh0x2bi3D1VktnXbo
         z1hV/V9BG9eBwaKi4obGFTnMJPMgXZSmArEVGTGBnb2rNUN2QcGX7RfAp7JNBaesVVeT
         gftd/cFHlGyiy8zrL6lPQwU2oV1llrUNfhhzRxVU6f4GO0+z5Vr5eSFp360hOlQU09/a
         QY6wLbGjbWDbxWJa5N7Xxo0X60w+xdgBk4/Ev8biGiaY5zU/MqR6D+K2dMIfA2pRURwS
         c7UKfB63MYQhuqEtqT94WvTa8YXaqtaIk/rCKBqaihf/xUzujmQvlFFzkwvLjQwXBLgS
         kV9A==
X-Gm-Message-State: ANhLgQ0mTQijXDOwCEBslhD6YXRLIpOpqP08q30p+GPq7ZYIR+CjHD3X
        +uUTRQFtR/tfb8pdiM2ftGA9QLgR
X-Google-Smtp-Source: ADFU+vu61VibsoJNbsbH4t3WztE1aIItFEhgyby8gN8WkalhC0OtAfI3yreiPcnBK95dC0UsebsWuA==
X-Received: by 2002:a9d:720a:: with SMTP id u10mr2678439otj.177.1584632963787;
        Thu, 19 Mar 2020 08:49:23 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id n20sm903083ota.54.2020.03.19.08.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:49:23 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:49:21 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     adam.vaughn.xh@renesas.com
Subject: [PATCH v2 0/2] hwmon: (pmbus) add support for Gen 2 Renesas digital
 multiphase
Message-ID: <cover.1584568073.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds support for 2nd generation Renesas digitial multiphase
voltage regulators. This functionality extends the existing ISL68137 PMBus
driver.

The series contains 2 patches:
  - patch #1 adds extends the ISL68137 driver to support Gen 2 devices
  - patch #2 adds documentation for the newly supported devices

Grant Peltier (2):
  hwmon: (pmbus) add support for 2nd Gen Renesas digital multiphase
  docs: hwmon: Update documentation for isl68137 pmbus driver

 Documentation/hwmon/isl68137.rst | 541 ++++++++++++++++++++++++++++++-
 drivers/hwmon/pmbus/Kconfig      |   6 +-
 drivers/hwmon/pmbus/isl68137.c   | 112 ++++++-
 3 files changed, 633 insertions(+), 26 deletions(-)

-- 
2.20.1

