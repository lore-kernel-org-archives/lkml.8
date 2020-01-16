Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F20C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECCE2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218310;
	bh=L7Azx0j8baqSXd4yPjBniGnmFyiKXO6reJH8SF9bPKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sX0GOTYcavQbZY+4POpYkcggnjRLs9waQXCAgP8G+iusSVKD5lKz7/OPmtHTRmqaA
	 aZ/2/QKPjapSYm2ptT9x029Vq7I26nXuSJ6EHDxMovS1szgnTrWl9+usZCoYibDnLg
	 WOneg/cYxxCv3jqKPIPbNZjlKJNeTr5S9mTBF9+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbgAPXpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391008AbgAPXXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:23:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70E002077C;
        Thu, 16 Jan 2020 23:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217000;
        bh=L7Azx0j8baqSXd4yPjBniGnmFyiKXO6reJH8SF9bPKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nd7EoW6uCZGjGpfz59IG8ZC1f8eqbumDoB/arC3MBGHA5VCRijO6ttdWDAQoPmQKt
         no0XSNbMvojodzYNUXlVzZz7zO8rtfbgq9m8FR20OplAUN20W8K+6EBnQDkkxoknps
         t+CqqelIc5Py3RCPkG4XBwVgxAZYUhV8huCT773U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 091/203] Documentation/ABI: Fix documentation inconsistency for mlxreg-io sysfs interfaces
Date:   Fri, 17 Jan 2020 00:16:48 +0100
Message-Id: <20200116231753.639849272@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

commit f4094826779dcafe7087e80850513b923eeefdeb upstream.

Fix attribute name from "jtag_enable", which described twice to
"cpld3_version", which is expected to be instead of second appearance
of "jtag_enable".

Fixes: 2752e34442b5 ("Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -29,13 +29,13 @@ Description:	This file shows the system
 
 		The files are read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld3_version
 
 Date:		November 2018
 KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
 Description:	These files show with which CPLD versions have been burned
-		on LED board.
+		on LED or Gearbox board.
 
 		The files are read only.
 


