Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489D7C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB3524673
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAUQBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:01:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:62805 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbgAUQB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:01:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="228885497"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2020 08:01:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 477C662B; Tue, 21 Jan 2020 18:01:15 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/38] platform/x86: intel_scu_ipc: Reformat kernel-doc comments of exported functions
Date:   Tue, 21 Jan 2020 19:00:49 +0300
Message-Id: <20200121160114.60007-14-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
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
index a5ca1aae9547..518b044d8ecb 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -220,14 +220,14 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
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
@@ -236,14 +236,14 @@ int intel_scu_ipc_ioread8(u16 addr, u8 *data)
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
@@ -252,17 +252,17 @@ int intel_scu_ipc_iowrite8(u16 addr, u8 data)
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
@@ -271,18 +271,17 @@ int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
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
@@ -291,19 +290,18 @@ int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
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
@@ -313,16 +311,16 @@ int intel_scu_ipc_update_register(u16 addr, u8 bits, u8 mask)
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
@@ -342,16 +340,16 @@ int intel_scu_ipc_simple_command(int cmd, int sub)
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

