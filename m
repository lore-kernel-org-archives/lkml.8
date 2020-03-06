Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A140C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6B72146E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0SCpXGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCFQUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:20:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37375 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCFQUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:20:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1342146pfn.4;
        Fri, 06 Mar 2020 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HT85QxwdFTCLPqBgxQh69fgGjpwmL/OKcBc+DMSRtbY=;
        b=U0SCpXGzRVAUN/CEpW1P2vaOBisrt31nPw63g11ueKaCltoVoyX5Wr7SuUysDk7M7R
         pBjGeqAQSdG35me8VFTutvq/n4HG9wXCpjEoB8YnBTmHO5bbgnF13WhemvM1q2982NS9
         /dkSjQecKSQdimDWgO9V6x6zg/ueJvzJ1veDWZonPveO3KjkwCVjm2S5b7jVooAkVosa
         V+m5PsLLH/IuC1UJnM995wVZ7D47chcGqT4X08QYt4N2HzrGz8N19zyGqVTnungYB4yQ
         ZdtF8HoY6vOEupmbSBi6NMD27J6AAjeWpKiwswq+83OmiSFDrax/wlQaE2489y+hqPKy
         vb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=HT85QxwdFTCLPqBgxQh69fgGjpwmL/OKcBc+DMSRtbY=;
        b=eGJLZPXLXJZ41mBjffcrOq6SMaKRsfRNj8XeKFAv7ToYVDy3jwec1YxNlv7TYBFHu2
         j8/pst8uAxkLsR3hwujxJO3UPnAhtzoIdVBZiL43vPvmzNB8dYabSIT1Zn0bL0Fqlss1
         gWfNxeMaN3I+KjaUn0e1rUMVVwXnehCbbgsUQL2hzpTTzGnBa4mc59GMO4EMxXAri/GX
         eRGakwtkOpotKyjw9ssWDjC7vNTaTZQSbBFlx+j95uD8XrcfBCfx8EZ0z0Z9nkjknR0d
         jlXKK+9Y8K1rtXdIWXqCRcMjW8Q5vIyMhRZeoOKfmuUz34UvPfq7oX5tKCeBqC8By0Ut
         CrBQ==
X-Gm-Message-State: ANhLgQ1h9+fT7XcFCwxaJOesA8GLBqeOxg1B7sgthBc3wRFjldpQNON6
        qIpstSbkEJcHjyYqbPjc7ypa4zMz
X-Google-Smtp-Source: ADFU+vt/x/gDdrv8nW5YW6NkMcQXxfUC6YKNJVxfnaZBTijdPleSG0DWGOoyEKmWOZaaV6eb0f99xA==
X-Received: by 2002:a63:9d04:: with SMTP id i4mr4055404pgd.294.1583511600857;
        Fri, 06 Mar 2020 08:20:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r3sm30036021pfq.126.2020.03.06.08.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Mar 2020 08:20:00 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.6-rc5
Date:   Fri,  6 Mar 2020 08:19:58 -0800
Message-Id: <20200306161958.31030-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.6-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.6-rc5

Thanks,
Guenter
------

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.6-rc5

for you to fetch changes up to 44f2f882909fedfc3a56e4b90026910456019743:

  hwmon: (adt7462) Fix an error return in ADT7462_REG_VOLT() (2020-03-03 12:42:55 -0800)

----------------------------------------------------------------
hwmon fixes for v5.6-rc5

Fix an error return in the adt7462 driver, bad voltage limits
reported by the xdpe12284 driver, and a broken documentation
reference in the adm1177 driver documentation.

----------------------------------------------------------------
Dan Carpenter (1):
      hwmon: (adt7462) Fix an error return in ADT7462_REG_VOLT()

Mauro Carvalho Chehab (1):
      docs: adm1177: fix a broken reference

Vadim Pasternak (1):
      hwmon: (pmbus/xdpe12284) Add callback for vout limits conversion

 Documentation/hwmon/adm1177.rst |  3 +--
 drivers/hwmon/adt7462.c         |  2 +-
 drivers/hwmon/pmbus/xdpe12284.c | 54 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)
