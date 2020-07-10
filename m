Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F2FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C830206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJCPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:15:40 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:50802 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgGJCPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:15:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id CFFD020160C8;
        Fri, 10 Jul 2020 10:15:37 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j_CSdWE8rvp2; Fri, 10 Jul 2020 10:15:37 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id ADCC020160B5;
        Fri, 10 Jul 2020 10:15:37 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id A0373C01FBA;
        Fri, 10 Jul 2020 10:15:37 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 6A1C8202299; Fri, 10 Jul 2020 10:15:37 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] shtc1: add support for device tree bindings
Date:   Fri, 10 Jul 2020 10:15:33 +0800
Message-Id: <20200710021536.27544-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DTS bindings to the shtc driver
The patches add the compatible table and of_property_read_bool to the
shtc1.c. Newly created Yaml document has been released to the
Documentation/devicetree/hwmon/sensirion,shtc1.yaml

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 Version 5
    devicetree/driver-source: name conversion sensirion,low-precision sensirion,blocking-io
	use const: 0x70 with the reg:
 Version 4
	Fix errors report by make dt_binding_check (devicetree)
	Set maintainers for the yaml document to my own.
 Version 3
	Fix errors report with checkpatch.pl
	Correct logic, add (!) when check for sensirion,low_precision
 Version 2
	remove the #ifdef CONFIG_OF
	ignore platform data if dev->of_node is valid
	use boolean only therefor use sensirion,low_precise to fit the logic
	add missing driver.of_match_table entry
 Version 1
	initial version
