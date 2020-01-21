Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7EC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCA522522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 02:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt0+NcVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAUCac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 21:30:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39222 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 21:30:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id 4so631892pgd.6;
        Mon, 20 Jan 2020 18:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQyPAfqAyljHnvWhswSI0j0AaXOWbrBUiwjxd8hEWfs=;
        b=Bt0+NcVbtyhKoPbU4w5EMFNOUoCclOtmzhRCrfG710xvJdFahXj+BqwWCMP/+lV/p6
         0TaEc3sDfjQdNoO6/tedQTBn1Uj6EaA7podeyfC4qC1a8FWIMEalPpdrnjDWH4yy0fV2
         EfnM1agj8iFckuwtSZu5jU/2/R2kklzvWNwO2vrw7BupLSYORiFi8Aatvmjlnr3aT3dz
         zK43sFEqi90gQX49hYRG0FfWj8Tozkcl8H/XefzMQg+JVxyHsrOOGc4uIZUkRoPR8XB0
         MixxWHbh1yvr+5sgn3eKONCeOTDYr2d6O8b5UmQuMTWn8Ua7ef3cd07oKfFWO0/yc/zh
         W5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=UQyPAfqAyljHnvWhswSI0j0AaXOWbrBUiwjxd8hEWfs=;
        b=AFRQIpwZ7UcUKttFL5QfG541ovbNUt2Az9btdNC3KS5rzIxTMiKslt11blykdZMfcx
         uG9dZdOkJg/K5umFwIsAZvP5ioOD4CWt+5aq+yeTnpgowjyKiuEdR2DbnicwczIeRdK0
         KM8vVn5v8bM0YdCN3dmtAMJS5dYfUZ+jKjJG8Wv9FlxIikzpeMPio775torNPPWae0wO
         Z3qbtg8geVOo3/TA9Fm1mBcJAzO1JEGencRh0JSA3exW8k/2wMeuM6jS4RI82M3gL0ir
         nMO3o5+bEacdBfuhHnfGpcnUn8xcz4acABw3y17Li4ENkjS/pD3G5Yc3qspL/pOz1Chj
         HnNA==
X-Gm-Message-State: APjAAAUVwd3NrlUYC7eQwCXlxk1I0+ML/bKEW2tt67GzIUAnoZQvzbDS
        F2WthzAe7Zlc8o7u9aImwhwuqM1t
X-Google-Smtp-Source: APXvYqwIk9UQhVc9EWq9JS2v2Hzscp7+O/f9asgIn1QReUfPblnnZ9VX/CJrpK9D0nmctwWk5QO/pA==
X-Received: by 2002:a63:5525:: with SMTP id j37mr2902151pgb.180.1579573831257;
        Mon, 20 Jan 2020 18:30:31 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p21sm40123272pfn.103.2020.01.20.18.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 18:30:30 -0800 (PST)
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
Subject: [PATCH v3 0/5] hwmon: k10temp driver improvements
Date:   Mon, 20 Jan 2020 18:30:22 -0800
Message-Id: <20200121023027.2081-1-linux@roeck-us.net>
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
on Zen2 (Ryzen and Threadripper) CPUs (note that reporting is incomplete
for Threadripper CPUs - it is known that additional temperature sensors
exist, but the register locations are unknown).

Patch 4/5 adds support for reporting core and SoC current and voltage
information on Ryzen CPUs (note: voltage and current measurements for
Threadripper and EPYC CPUs are known to exist, but register locations
are unknown, and values are therefore not reported at this time).

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
v2: Added Tested-by: tags as received.
    Don't display voltage and current information for Threadripper and EPYC.
    Stop displaying the fixed (and wrong) maximum temperature of 70 degrees C
    for Tdie on model 17h/18h CPUs.

v3: Added more Tested-by: tags
    Added detection for 3970X, and report Tccd1 for this CPU.
