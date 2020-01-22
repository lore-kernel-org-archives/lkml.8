Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC78C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E54F2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDESidat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAVQIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42196 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so3188412plk.9;
        Wed, 22 Jan 2020 08:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RwmVjb1P+TinMgl/i9OOzkk8Hc144qqJmxw0PSemH0=;
        b=UDESidatWuSTvj7S76hWmq58ZgfYBFUicwm9GTv/O5TYUkrgNsZ+YYuf0sJw8pyWSR
         rV8tQi/o6SF20xXJEBa9ZHSKfa9lfzMe2npXa5xIB/U5qelmjf7TCidbDUSw9x7TWoTj
         ryK7MFFvpSt7b6NeUaeaMYO2680MmiFGhbraldCs8NYzYYI/vEnA7LZOUYggnuS0BNB7
         dnWKHnyKXAiQxEs7E1McfhSevTAj2R5LilbM8/udhgUhLunhRARieuJi9fPhGekxlNoJ
         Q7e5b/9x6T6sJVSsEI9TNKjPKah5WYsT6YgwHU9FsFV2i65rYHSGuwVsrDxkwLLg/7x0
         gWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4RwmVjb1P+TinMgl/i9OOzkk8Hc144qqJmxw0PSemH0=;
        b=dME/o4b+iv3duxxQnZPGBjfAK3+QYJcp/RCwN/EMLkukjFS1ZzVZoZXS+RE/ESd0re
         RGN4weNAlWOjdm0XyqjzZoe/KxndEYNc20f6iLC0PUGmczO5zMoJsXI4mGYN/fd3Dkza
         u3lOtDM1aMU7W6XpPbIDfK9CCpYTNzicenkiOzE61JvqxCF4+ENKAGckyI1qIuWMfSE0
         DGxOmxh4GsWkoLdecO23PIfzRWsiYefh8CfC+Z+ywIzOB/4JClqK/nWlxFSF6BJ51L0D
         kye7O8+cq+SsuhGuWIrnp7w4HOovopReCwmGDNA2mi7vNHMIGtJFmez2ZeLtViFsc4uU
         6RZQ==
X-Gm-Message-State: APjAAAUFm5MeFHl/9PKpgL1b3F+urnVpx/ObSv8AeOM5lNiJvnR6N9OU
        igPUGDi8kJV6NTHKbr1QmY0xVaaA
X-Google-Smtp-Source: APXvYqy481nH2pFeyxUolU7JXKmZ1LQ5oIKHU1SBlUIR/Chr7GV/CEBIu0hPr6umIciRayOyxBXQCQ==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11mr11733859plx.45.1579709285837;
        Wed, 22 Jan 2020 08:08:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i23sm46822572pfo.11.2020.01.22.08.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 08:08:04 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 0/6] hwmon: k10temp driver improvements
Date:   Wed, 22 Jan 2020 08:07:54 -0800
Message-Id: <20200122160800.12560-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements various improvements for the k10temp driver.

Patch 1/6 introduces the use of bit operations.

Patch 2/6 converts the driver to use the devm_hwmon_device_register_with_info
API. This not only simplifies the code and reduces its size, it also
makes the code easier to maintain and enhance. 

Patch 3/6 adds support for reporting Core Complex Die (CCD) temperatures
on Zen2 (Ryzen and Threadripper) CPUs (note that reporting is incomplete
for Threadripper CPUs - it is known that additional temperature sensors
exist, but the register locations are unknown).

Patch 4/6 adds support for reporting core and SoC current and voltage
information on Ryzen CPUs (note: voltage and current measurements for
Threadripper and EPYC CPUs are known to exist, but register locations
are unknown, and values are therefore not reported at this time).

Patch 5/6 removes the maximum temperature from Tdie for Ryzen CPUs.
It is inaccurate, misleading, and it just doesn't make sense to report
wrong information.

Patch 6/6 adds debugfs files to provide raw thermal and SVI register
dumps. This may help in the future to identify additional sensors and/or
to fix problems.

With all patches in place, output on Ryzen 3900X CPUs looks as follows
(with the system under load).

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.39 V
Vsoc:         +1.18 V
Tdie:         +79.9°C
Tctl:         +79.9°C
Tccd1:        +61.8°C
Tccd2:        +76.5°C
Icore:       +46.00 A
Isoc:        +12.00 A

The voltage and current information is limited to Ryzen CPUs. Voltage
and current reporting on Threadripper and EPYC CPUs is different, and the
reported information is either incomplete or wrong. Exclude it for the time
being; it can always be added if/when more information becomes available.

Tested with the following Ryzen CPUs:
    1300X A user with this CPU in the system reported somewhat unexpected
          values for Vcore; it isn't entirely if at all clear why that is
          the case. Overall this does not warrant holding up the series.
    1600
    1800X
    2200G
    2400G
    2700
    2700X
    2950X
    3600X
    3800X
    3900X
    3950X
    3970X
    EPYC 7302
    EPYC 7742

Many thanks to everyone who helped to test this series.

---
v4: Normalize current calculations do show 1A / LSB for core current and
    0.25A / LSB for SoC current. The reported current values are board
    specific and need to be scaled using the configuration file.
    Clarified that the maximum temperature of 70 degrees C (which is no
    longer displayed) was associated to Tctl and not to Tdie.
    Added debugfs support.

v3: Added more Tested-by: tags
    Added detection for 3970X, and report Tccd1 for this CPU.

v2: Added Tested-by: tags as received.
    Don't display voltage and current information for Threadripper and EPYC.
    Stop displaying the fixed (and wrong) maximum temperature of 70 degrees C
    for Tdie on model 17h/18h CPUs.
