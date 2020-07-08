Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE09C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B3A20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgGHNeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgGHNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:34:06 -0400
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jul 2020 06:34:06 PDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F1C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:34:06 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 517EB10190FA4;
        Wed,  8 Jul 2020 15:27:04 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 0F1416106EC8;
        Wed,  8 Jul 2020 15:27:04 +0200 (CEST)
X-Mailbox-Line: From 40dc1c5997ecc8784fc98706c5321f9d48240310 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1594212527.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 8 Jul 2020 14:48:47 +0200
Subject: [PATCH 0/3] Fix races on device removal
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent dynamic SPI device addition below a controller which is
being removed.  To do so, set the controller's "dead" flag using
kill_device() (patch [3/3]).

Serialize access to a device's "dead" flag with a newly introduced
rw_semaphore in lieu of the device_lock to avoid deadlocks occurring
with the new use case (patch [2/3]).

Add a missing check for the "dead" flag upon driver binding
(patch [1/3]).


Lukas Wunner (3):
  driver core: Avoid binding drivers to dead devices
  driver core: Use rwsem for kill_device() serialization
  driver core: Avoid adding children below a dead parent

 drivers/base/base.h  |  2 ++
 drivers/base/core.c  | 47 ++++++++++++++++++++++++++++++++------------
 drivers/base/dd.c    | 12 ++++++++++-
 drivers/nvdimm/bus.c |  8 +-------
 drivers/spi/spi.c    |  3 +++
 5 files changed, 51 insertions(+), 21 deletions(-)

-- 
2.27.0

