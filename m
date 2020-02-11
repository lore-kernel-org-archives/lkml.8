Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA9C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1A92070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgBKXgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:36:53 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48011 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBKXgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:36:53 -0500
X-Originating-IP: 172.58.46.204
Received: from localhost (unknown [172.58.46.204])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id ED55E60005;
        Tue, 11 Feb 2020 23:36:44 +0000 (UTC)
Date:   Tue, 11 Feb 2020 15:36:23 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ACPI: Tiny power button driver
Message-ID: <cover.1581463668.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual machines often use an ACPI power button event to tell the
machine to shut down gracefully.

Provide an extremely lightweight "tiny power button" driver to handle
this event by signaling init directly, rather than running a separate
daemon (such as acpid or systemd-logind) that adds to startup time and
VM image complexity.

I originally proposed a change to the ACPI power button driver to
introduce an optional path to signal init, but Rafael expressed a
preference to have this as a separate, mutually exclusive driver
instead. The result did come out much simpler, conceptually, with the
added benefit of being able to disable CONFIG_INPUT entirely for a
kernel that exclusively targets cloud/VM systems.

The first patch in the series just moves HID definitions to
acpi/button.h in preparation for sharing them with the tiny-power-button
driver. The second patch provides the driver itself.

Josh Triplett (2):
  acpi: button: move HIDs to acpi/button.h
  acpi: Add new tiny-power-button driver to directly signal init

 drivers/acpi/Kconfig             | 24 +++++++++++++++++
 drivers/acpi/Makefile            |  1 +
 drivers/acpi/button.c            |  3 ---
 drivers/acpi/tiny-power-button.c | 46 ++++++++++++++++++++++++++++++++
 include/acpi/button.h            |  4 +++
 5 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/tiny-power-button.c

-- 
2.25.0

