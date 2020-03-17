Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34609C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0386D2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456930;
	bh=7uUf4ls1frgYC0YC7nGl7q8HJwlLjSoEjGcFoFzYh6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xHcDVDzcB+71J5ekOmPi1vEKsUH/GYlzfRuPO1AEDpIaJMcRUB3gK5d5gY34Cdu9d
	 RM9gbWvGUyAupdTYL03lF/gHEXqq6/DDAnkqfAGGpoLYkBszwYe3Bl+TTAklbOqeA7
	 LR5bOIgGKZycNi1BBNQVkstvG95CvKa/6SHcKFV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCQOz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgCQOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7BCD2076D;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=7uUf4ls1frgYC0YC7nGl7q8HJwlLjSoEjGcFoFzYh6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0iz7+p2FjXdEzZ4NMy7+vG9MSSy1NrTujtgV8+mFlQd9qGyvfGAmJmgzoBAaLNRz
         44afYt+cfm5LmFXzqvTK0lwdAHgSf82tunHruQ4sJaiNMUOf3JWfzsekCvlSOmt3FU
         d20WpQNBY2DFHVBi2cU4ey87RCcusKFQU0MyYUf0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000ANB-RV; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Subject: [PATCH 13/17] i2c: include/linux/i2c.h: fix a doc warning
Date:   Tue, 17 Mar 2020 15:54:22 +0100
Message-Id: <24cbf9166b21531186e5b6d37a3f9201f957abef.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't let non-letters inside a literal block without escaping it, as
the toolchain would mis-interpret it:

./include/linux/i2c.h:518: WARNING: Inline strong start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/i2c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f834687989f7..f6b942150631 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -506,7 +506,7 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * @smbus_xfer_atomic: same as @smbus_xfer. Yet, only using atomic context
  *   so e.g. PMICs can be accessed very late before shutdown. Optional.
  * @functionality: Return the flags that this algorithm/adapter pair supports
- *   from the I2C_FUNC_* flags.
+ *   from the ``I2C_FUNC_*`` flags.
  * @reg_slave: Register given client to I2C slave mode of this adapter
  * @unreg_slave: Unregister given client from I2C slave mode of this adapter
  *
@@ -515,7 +515,7 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * be addressed using the same bus algorithms - i.e. bit-banging or the PCF8584
  * to name two of the most common.
  *
- * The return codes from the @master_xfer{_atomic} fields should indicate the
+ * The return codes from the ``master_xfer{_atomic}`` fields should indicate the
  * type of error code that occurred during the transfer, as documented in the
  * Kernel Documentation file Documentation/i2c/fault-codes.rst.
  */
-- 
2.24.1

