Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DC0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10FA24676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAVQ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:28:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:35968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbgAVQ2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:28:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 08:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="275651327"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2020 08:28:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AEF5B525; Wed, 22 Jan 2020 18:28:14 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] platform/x86: intel_scu_ipc: Reformat kernel-doc comments of exported functions
Date:   Wed, 22 Jan 2020 19:28:13 +0300
Message-Id: <20200122162813.26070-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
References: <20200122162813.26070-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Format kernel-doc comments of the exported functions to follow the
typical format that does not have tab indentation. Also capitalize
parameter descriptions and add a missing period.

No functional changes intended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 112 +++++++++++++--------------
 1 file changed, 55 insertions(+), 57 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 0a722a844583..3d7da5266136 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -222,14 +222,14 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
 }
 
 /**
- *	intel_scu_ipc_ioread8		-	read a word via the SCU
- *	@addr: register on SCU
- *	@data: return pointer for read byte
+ * intel_scu_ipc_ioread8		-	read a word via the SCU
+ * @addr: Register on SCU
+ * @data: Return pointer for read byte
  *
- *	Read a single register. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
+ * Read a single register. Returns %0 on success or an error code. All
+ * locking between SCU accesses is handled for the caller.
  *
- *	This function may sleep.
+ * This function may sleep.
  */
 int intel_scu_ipc_ioread8(u16 addr, u8 *data)
 {
@@ -238,14 +238,14 @@ int intel_scu_ipc_ioread8(u16 addr, u8 *data)
 EXPORT_SYMBOL(intel_scu_ipc_ioread8);
 
 /**
- *	intel_scu_ipc_iowrite8		-	write a byte via the SCU
- *	@addr: register on SCU
- *	@data: byte to write
+ * intel_scu_ipc_iowrite8		-	write a byte via the SCU
+ * @addr: Register on SCU
+ * @data: Byte to write
  *
- *	Write a single register. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
+ * Write a single register. Returns %0 on success or an error code. All
+ * locking between SCU accesses is handled for the caller.
  *
- *	This function may sleep.
+ * This function may sleep.
  */
 int intel_scu_ipc_iowrite8(u16 addr, u8 data)
 {
@@ -254,17 +254,17 @@ int intel_scu_ipc_iowrite8(u16 addr, u8 data)
 EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
 
 /**
- *	intel_scu_ipc_readvv		-	read a set of registers
- *	@addr: register list
- *	@data: bytes to return
- *	@len: length of array
+ * intel_scu_ipc_readvv		-	read a set of registers
+ * @addr: Register list
+ * @data: Bytes to return
+ * @len: Length of array
  *
- *	Read registers. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
+ * Read registers. Returns %0 on success or an error code. All locking
+ * between SCU accesses is handled for the caller.
  *
- *	The largest array length permitted by the hardware is 5 items.
+ * The largest array length permitted by the hardware is 5 items.
  *
- *	This function may sleep.
+ * This function may sleep.
  */
 int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
 {
@@ -273,18 +273,17 @@ int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
 EXPORT_SYMBOL(intel_scu_ipc_readv);
 
 /**
- *	intel_scu_ipc_writev		-	write a set of registers
- *	@addr: register list
- *	@data: bytes to write
- *	@len: length of array
+ * intel_scu_ipc_writev		-	write a set of registers
+ * @addr: Register list
+ * @data: Bytes to write
+ * @len: Length of array
  *
- *	Write registers. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
+ * Write registers. Returns %0 on success or an error code. All locking
+ * between SCU accesses is handled for the caller.
  *
- *	The largest array length permitted by the hardware is 5 items.
- *
- *	This function may sleep.
+ * The largest array length permitted by the hardware is 5 items.
  *
+ * This function may sleep.
  */
 int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
 {
@@ -293,19 +292,18 @@ int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
 EXPORT_SYMBOL(intel_scu_ipc_writev);
 
 /**
- *	intel_scu_ipc_update_register	-	r/m/w a register
- *	@addr: register address
- *	@bits: bits to update
- *	@mask: mask of bits to update
+ * intel_scu_ipc_update_register	-	r/m/w a register
+ * @addr: Register address
+ * @bits: Bits to update
+ * @mask: Mask of bits to update
  *
- *	Read-modify-write power control unit register. The first data argument
- *	must be register value and second is mask value
- *	mask is a bitmap that indicates which bits to update.
- *	0 = masked. Don't modify this bit, 1 = modify this bit.
- *	returns 0 on success or an error code.
+ * Read-modify-write power control unit register. The first data argument
+ * must be register value and second is mask value mask is a bitmap that
+ * indicates which bits to update. %0 = masked. Don't modify this bit, %1 =
+ * modify this bit. returns %0 on success or an error code.
  *
- *	This function may sleep. Locking between SCU accesses is handled
- *	for the caller.
+ * This function may sleep. Locking between SCU accesses is handled
+ * for the caller.
  */
 int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
 {
@@ -315,16 +313,16 @@ int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
 EXPORT_SYMBOL(intel_scu_ipc_update_register);
 
 /**
- *	intel_scu_ipc_simple_command	-	send a simple command
- *	@cmd: command
- *	@sub: sub type
+ * intel_scu_ipc_simple_command	-	send a simple command
+ * @cmd: Command
+ * @sub: Sub type
  *
- *	Issue a simple command to the SCU. Do not use this interface if
- *	you must then access data as any data values may be overwritten
- *	by another SCU access by the time this function returns.
+ * Issue a simple command to the SCU. Do not use this interface if you must
+ * then access data as any data values may be overwritten by another SCU
+ * access by the time this function returns.
  *
- *	This function may sleep. Locking for SCU accesses is handled for
- *	the caller.
+ * This function may sleep. Locking for SCU accesses is handled for the
+ * caller.
  */
 int intel_scu_ipc_simple_command(int cmd, int sub)
 {
@@ -344,16 +342,16 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
 EXPORT_SYMBOL(intel_scu_ipc_simple_command);
 
 /**
- *	intel_scu_ipc_command	-	command with data
- *	@cmd: command
- *	@sub: sub type
- *	@in: input data
- *	@inlen: input length in dwords
- *	@out: output data
- *	@outlein: output length in dwords
+ * intel_scu_ipc_command	-	command with data
+ * @cmd: Command
+ * @sub: Sub type
+ * @in: Input data
+ * @inlen: Input length in dwords
+ * @out: Output data
+ * @outlen: Output length in dwords
  *
- *	Issue a command to the SCU which involves data transfers. Do the
- *	data copies under the lock but leave it for the caller to interpret
+ * Issue a command to the SCU which involves data transfers. Do the
+ * data copies under the lock but leave it for the caller to interpret.
  */
 int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 			  u32 *out, int outlen)
-- 
2.24.1

