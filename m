Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC55C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6222077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1JyAlas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgAPOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:18:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45792 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:18:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so9935988pgk.12;
        Thu, 16 Jan 2020 06:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ei7Y1m250KVmR/VCccXNoI6+dT6cSuShODQGj03wesc=;
        b=N1JyAlas/s7DaRqWbHTMXMTcLR0IrO7WdhG8M2keA8EI5i6d98GelFNadUaHoe1ann
         8cVtn9XlOp81IqrCDx6BapxlxQq4A2aZBVoKYijmvBr49p7V4DSl98vYHNJCtxSYiuOA
         i9Nxgd4N6iBY04SBI0ooamDkNIqxN8GPfmpF3aW9IgHAyBX1QluAPmCEndykt4B+1kr4
         HCtcfOcp9z7ANJ4WcbFZwmITY4y9iZnjC+4Fha283BO63QnUdhqPH2zIqT1NMLZkBIsS
         5BWrE9KQlwCcvOkIiriJozsG1XBcu0uhFN2QbnPO2cdzIIvJtWY6wFwJ3pGF7ENNVp2p
         67cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ei7Y1m250KVmR/VCccXNoI6+dT6cSuShODQGj03wesc=;
        b=Z2uyu+55kwQiOE7F+r63t3Aca7ckOQfH77CA+99RmogBVTsDfMltTi7F3PtpX5Ty09
         9wJ7yE6//OIL+NYwepHDb2uxCUozIcAa+j4HBzgkvZwKScj6lR/IgIHqAKyEEKFrlLTx
         qOBsThqPKKPnZHOFt7YtaHVwbHXzxfMFD90hn++045rzS0FDBx+/XW+SSBf+RIQkVz23
         AwRzzGRFzixJwBVHGxqIagilp50lW5MHTfhlDakvLdL/MXENwlwbcQ7GCTsR4u09GcLZ
         /VwnG3y6FL6eL6qwyG6TVYYxOajQxFMfTU9Yf3UxRDYyS44lcU3rjVJ5bB3mFObdUNGI
         cAhA==
X-Gm-Message-State: APjAAAXrtV34cADGKN2Uw5iGVRrocqDiNhU8SxWxSZke5tLIawLzYTId
        fgexy6ThIkMo2puyYH6ZF7S7WWu5
X-Google-Smtp-Source: APXvYqyx7OOrytlIdD2VggmangoJcnuG0bdTbGas05OSwAgxyGvHIZu2tXeTj49GJI9xMkCJtCDSgA==
X-Received: by 2002:a63:7d6:: with SMTP id 205mr40463604pgh.131.1579184289955;
        Thu, 16 Jan 2020 06:18:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5sm2490943pju.29.2020.01.16.06.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 06:18:08 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 0/4] hwmon: k10temp driver improvements
Date:   Thu, 16 Jan 2020 06:17:56 -0800
Message-Id: <20200116141800.9828-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements various improvements for the k10temp driver.

Patch 1/4 introduces the use of bit operations.

Patch 2/4 converts the driver to use the devm_hwmon_device_register_with_info
API. This not only simplifies the code and reduces its size, it also
makes the code easier to maintain and enhance. 

Patch 3/4 adds support for reporting Core Complex Die (CCD) temperatures
on Ryzen 3 (Zen2) CPUs.

Patch 4/4 adds support for reporting core and SoC current and voltage
information on Ryzen CPUs.

With all patches in place, output on Ryzen 3900 CPUs looks as follows
(with the system under load).

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.36 V
Vsoc:         +1.18 V
Tdie:         +86.8°C  (high = +70.0°C)
Tctl:         +86.8°C
Tccd1:        +80.0°C
Tccd2:        +81.8°C
Icore:       +44.14 A
Isoc:        +13.83 A

The patch series has only been tested with Ryzen 3900 CPUs. Further test
coverage will be necessary before the changes can be applied to the Linux
kernel.
