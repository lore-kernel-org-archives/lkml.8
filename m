Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3BCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA44E20734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405695AbgFSQq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395472AbgFSQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A429C0613EF;
        Fri, 19 Jun 2020 09:46:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9P-00043X-Nx; Fri, 19 Jun 2020 18:45:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 57BBC1C032F;
        Fri, 19 Jun 2020 18:45:59 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:45:59 -0000
From:   "tip-bot2 for Heinrich Schuchardt" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Descriptions for stub helper functions
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200615234231.21059-1-xypron.glpk@gmx.de>
References: <20200615234231.21059-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Message-ID: <159258515914.16989.6888969686155066646.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     8c0a839c2bccb756454e35e8977e44fcf2bd417e
Gitweb:        https://git.kernel.org/tip/8c0a839c2bccb756454e35e8977e44fcf2bd417e
Author:        Heinrich Schuchardt <xypron.glpk@gmx.de>
AuthorDate:    Tue, 16 Jun 2020 01:42:31 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 16 Jun 2020 11:01:07 +02:00

efi/libstub: Descriptions for stub helper functions

Provide missing descriptions for EFI stub helper functions.
Adjust formatting of existing descriptions to kernel style.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Link: https://lore.kernel.org/r/20200615234231.21059-1-xypron.glpk@gmx.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 78 ++++++++++++++---
 drivers/firmware/efi/libstub/efistub.h         | 10 +-
 2 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 89f0752..d40fd68 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -32,6 +32,10 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
+/**
+ * efi_char16_puts() - Write a UCS-2 encoded string to the console
+ * @str:	UCS-2 encoded string
+ */
 void efi_char16_puts(efi_char16_t *str)
 {
 	efi_call_proto(efi_table_attr(efi_system_table, con_out),
@@ -83,6 +87,10 @@ u32 utf8_to_utf32(const u8 **s8)
 	return c32;
 }
 
+/**
+ * efi_puts() - Write a UTF-8 encoded string to the console
+ * @str:	UTF-8 encoded string
+ */
 void efi_puts(const char *str)
 {
 	efi_char16_t buf[128];
@@ -113,6 +121,16 @@ void efi_puts(const char *str)
 	}
 }
 
+/**
+ * efi_printk() - Print a kernel message
+ * @fmt:	format string
+ *
+ * The first letter of the format string is used to determine the logging level
+ * of the message. If the level is less then the current EFI logging level, the
+ * message is suppressed. The message will be truncated to 255 bytes.
+ *
+ * Return:	number of printed characters
+ */
 int efi_printk(const char *fmt, ...)
 {
 	char printf_buf[256];
@@ -154,13 +172,18 @@ int efi_printk(const char *fmt, ...)
 	return printed;
 }
 
-/*
- * Parse the ASCII string 'cmdline' for EFI options, denoted by the efi=
+/**
+ * efi_parse_options() - Parse EFI command line options
+ * @cmdline:	kernel command line
+ *
+ * Parse the ASCII string @cmdline for EFI options, denoted by the efi=
  * option, e.g. efi=nochunk.
  *
  * It should be noted that efi= is parsed in two very different
  * environments, first in the early boot environment of the EFI boot
  * stub, and subsequently during the kernel boot.
+ *
+ * Return:	status code
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
@@ -286,13 +309,21 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	return (char *)cmdline_addr;
 }
 
-/*
+/**
+ * efi_exit_boot_services() - Exit boot services
+ * @handle:	handle of the exiting image
+ * @map:	pointer to receive the memory map
+ * @priv:	argument to be passed to @priv_func
+ * @priv_func:	function to process the memory map before exiting boot services
+ *
  * Handle calling ExitBootServices according to the requirements set out by the
  * spec.  Obtains the current memory map, and returns that info after calling
  * ExitBootServices.  The client must specify a function to perform any
  * processing of the memory map data prior to ExitBootServices.  A client
  * specific structure may be passed to the function via priv.  The client
  * function may be called multiple times.
+ *
+ * Return:	status code
  */
 efi_status_t efi_exit_boot_services(void *handle,
 				    struct efi_boot_memmap *map,
@@ -361,6 +392,11 @@ fail:
 	return status;
 }
 
+/**
+ * get_efi_config_table() - retrieve UEFI configuration table
+ * @guid:	GUID of the configuration table to be retrieved
+ * Return:	pointer to the configuration table or NULL
+ */
 void *get_efi_config_table(efi_guid_t guid)
 {
 	unsigned long tables = efi_table_attr(efi_system_table, tables);
@@ -408,17 +444,18 @@ static const struct {
 };
 
 /**
- * efi_load_initrd_dev_path - load the initrd from the Linux initrd device path
+ * efi_load_initrd_dev_path() - load the initrd from the Linux initrd device path
  * @load_addr:	pointer to store the address where the initrd was loaded
  * @load_size:	pointer to store the size of the loaded initrd
  * @max:	upper limit for the initrd memory allocation
- * @return:	%EFI_SUCCESS if the initrd was loaded successfully, in which
- *		case @load_addr and @load_size are assigned accordingly
- *		%EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
- *		device path
- *		%EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
- *		%EFI_OUT_OF_RESOURCES if memory allocation failed
- *		%EFI_LOAD_ERROR in all other cases
+ *
+ * Return:
+ * * %EFI_SUCCESS if the initrd was loaded successfully, in which
+ *   case @load_addr and @load_size are assigned accordingly
+ * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd device path
+ * * %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
+ * * %EFI_OUT_OF_RESOURCES if memory allocation failed
+ * * %EFI_LOAD_ERROR in all other cases
  */
 static
 efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
@@ -481,6 +518,16 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				    load_addr, load_size);
 }
 
+/**
+ * efi_load_initrd() - Load initial RAM disk
+ * @image:	EFI loaded image protocol
+ * @load_addr:	pointer to loaded initrd
+ * @load_size:	size of loaded initrd
+ * @soft_limit:	preferred size of allocated memory for loading the initrd
+ * @hard_limit:	minimum size of allocated memory
+ *
+ * Return:	status code
+ */
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_addr,
 			     unsigned long *load_size,
@@ -505,6 +552,15 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	return status;
 }
 
+/**
+ * efi_wait_for_key() - Wait for key stroke
+ * @usec:	number of microseconds to wait for key stroke
+ * @key:	key entered
+ *
+ * Wait for up to @usec microseconds for a key stroke.
+ *
+ * Return:	status code, EFI_SUCCESS if key received
+ */
 efi_status_t efi_wait_for_key(unsigned long usec, efi_input_key_t *key)
 {
 	efi_event_t events[2], timer;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index bcd8c0a..ac756f1 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -157,8 +157,14 @@ typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
 #define EFI_EVT_NOTIFY_WAIT	0x00000100U
 #define EFI_EVT_NOTIFY_SIGNAL	0x00000200U
 
-/*
- * boottime->wait_for_event takes an array of events as input.
+/**
+ * efi_set_event_at() - add event to events array
+ *
+ * @events:	array of UEFI events
+ * @ids:	index where to put the event in the array
+ * @event:	event to add to the aray
+ *
+ * boottime->wait_for_event() takes an array of events as input.
  * Provide a helper to set it up correctly for mixed mode.
  */
 static inline
