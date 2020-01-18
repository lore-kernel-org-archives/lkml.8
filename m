Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79270C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2DA2469A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY5M4FvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgARR0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:26:24 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44135 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgARR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:26:23 -0500
Received: by mail-yw1-f66.google.com with SMTP id t141so15886319ywc.11;
        Sat, 18 Jan 2020 09:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pcd9IeGcNNBUcKOyRHFaGz/TtdBvNMJdJIjUqyVupNo=;
        b=NY5M4FvRmv20Vy+SjbHj5Th/m03s56uHs5rHahfdmdaQymV0UqOGwYj62Rn/ApmDB3
         hDKuDAZ1tRGCfjpNlSGTrcCn2cf1aGst9RDvwORGHKpaV/BkG9uAQcqqOs9nK9F4P7OT
         L3tDLkJwmVidDl96suDMTer28Y66h0V5E+OI/W8/nLhy57vD0rx9uWtJrPKORJq+z1xb
         +OV2uzpWEi3hOXsBbm9UBaxa07xu4WsxpUiF/UBSUL9qe3SHa9CgkVLH5LaLuy8thaEZ
         R0Mf/XAhOSlN3zkk0/tKli944AtRbai8SM4JS/BlyYxwbsUSSKq1gaJ+IDrtSaQzm8pA
         mEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Pcd9IeGcNNBUcKOyRHFaGz/TtdBvNMJdJIjUqyVupNo=;
        b=YsmRxB6MsXsjzmnDdOJhIn7qPy6bJgq1rZdUp6f8Y6wRT0wQ+gBc+I+8gQ5cPO3YrC
         /JM6xaM3XMYcVX+RpHsSlRngtcG96uQv5ytSkeWO8A/JrGgnFmqW+BqyzsTkO0+95qdd
         8FaYPat6C2i/3vOM20QmQi1HBQo4E+hW8FPtoa3MY0juDvsjjV2mgge6f3h94iopVw9z
         XZ9J47DTtU5lElgt3H5kDOcOh4YtbwDIE23tcfZDVJphKw7tcYTbG+xlz9Xi1ZePAhfU
         MBCMX6acm/AwycxFeDsfORnWNl34YCnUDhALKU6gdJN8QqgfA9tKaASDDfzI8I+dbjss
         i+zA==
X-Gm-Message-State: APjAAAX6uIVoiO+8RanHf+rHmcKfkuCeBryCuqYPPBVhu+wz4rCMqDUA
        QnEHLH5PEmrKfKhJNvmiWRSQDVBR
X-Google-Smtp-Source: APXvYqxwxMqakk2ZscL1/TyEO/8mGdSuagfcJksCgulQMeGbSL4fbrQ+aIXq0KmP4vhT55SW6Gk6pA==
X-Received: by 2002:a81:6f07:: with SMTP id k7mr36934728ywc.395.1579368382762;
        Sat, 18 Jan 2020 09:26:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x84sm12867190ywg.47.2020.01.18.09.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 09:26:22 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/5] hwmon: k10temp driver improvements
Date:   Sat, 18 Jan 2020 09:26:10 -0800
Message-Id: <20200118172615.26329-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements various improvements for the k10temp driver.

Patch 1/5 introduces the use of bit operations.

Patch 2/5 converts the driver to use the devm_hwmon_device_register_with_info
API. This not only simplifies the code and reduces its size, it also
makes the code easier to maintain and enhance. 

Patch 3/5 adds support for reporting Core Complex Die (CCD) temperatures
on Ryzen 3 (Zen2) CPUs.

Patch 4/5 adds support for reporting core and SoC current and voltage
information on Ryzen CPUs.

Patch 5/5 removes the maximum temperature from Tdie for Ryzen CPUs.
It is inaccurate, misleading, and it just doesn't make sense to report
wrong information.

With all patches in place, output on Ryzen 3900X CPUs looks as follows
(with the system under load).

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.36 V
Vsoc:         +1.18 V
Tdie:         +86.8°C
Tctl:         +86.8°C
Tccd1:        +80.0°C
Tccd2:        +81.8°C
Icore:       +44.14 A
Isoc:        +13.83 A

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
    3800X
    3900X
    3950X

v2: Added tested-by: tags as received.
    Don't display voltage and current information for Threadripper and EPYC.
    Stop displaying the fixed (and wrong) maximum temperature of 70 degrees C
    for Tdie on model 17h/18h CPUs.
