Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8471EC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BEA20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="te1wWNct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHUQaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:30:46 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:56488 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728476AbgHUQZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:25:47 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id EBB911D17;
        Fri, 21 Aug 2020 19:25:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598027134;
        bh=jyfRlEFQUD7XRHMG3bSo/r11SXhmJjtN3vvdIU7bGLU=;
        h=From:To:CC:Subject:Date;
        b=te1wWNcttogkEWtwMbNp+Fdwm4kPliIGI+SIVp3AXAa5h/als68x+IlBnS9cat61I
         f2Q11auT7qnSUgUx8Iw9r5C46vHyx7QcKNDiu5Ks/zLbIqDZ75wLY+Togk2Nk6L6Nf
         dbD+fZ+li41jldhwNG4UVI+57U4r6MPYqGIrTPO8=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 21 Aug 2020 19:25:33 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 21 Aug 2020 19:25:33 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: [PATCH v2 07/10] fs/ntfs3: Add NTFS journal
Thread-Topic: [PATCH v2 07/10] fs/ntfs3: Add NTFS journal
Thread-Index: AdZ301N0gsGFJDIBQ7mXwMDIpiX6ow==
Date:   Fri, 21 Aug 2020 16:25:32 +0000
Message-ID: <d9480c0b1770413fbc75d0d8862fb302@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds NTFS journal

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
---
 fs/ntfs3/fslog.c | 5217 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 5217 insertions(+)
 create mode 100644 fs/ntfs3/fslog.c

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
new file mode 100644
index 000000000000..40a2bad0c858
--- /dev/null
+++ b/fs/ntfs3/fslog.c
@@ -0,0 +1,5217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/fslog.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/hash.h>
+#include <linux/nls.h>
+#include <linux/random.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/*
+ * LOG FILE structs
+ */
+
+#define MaxLogFileSize 0x100000000ull
+#define DefaultLogPageSize 4096
+#define MinLogRecordPages 0x30
+
+typedef struct {
+	NTFS_RECORD_HEADER rhdr; // 'RSTR'
+	__le32 sys_page_size; // 0x10: Page size of the system which initialized =
the log
+	__le32 page_size; // 0x14: Log page size used for this log file
+	__le16 ra_off; // 0x18:
+	__le16 minor_ver; // 0x1A:
+	__le16 major_ver; // 0x1C:
+	__le16 fixups[1];
+} RESTART_HDR;
+
+#define LFS_NO_CLIENT 0xffff
+#define LFS_NO_CLIENT_LE cpu_to_le16(0xffff)
+
+typedef struct {
+	__le64 oldest_lsn;
+	__le64 restart_lsn; // 0x08:
+	__le16 prev_client; // 0x10:
+	__le16 next_client; // 0x12:
+	__le16 seq_num; // 0x14:
+	u8 align[6]; // 0x16
+	__le32 name_bytes; // 0x1C: in bytes
+	__le16 name[32]; // 0x20: name of client
+} CLIENT_REC;
+
+static_assert(sizeof(CLIENT_REC) =3D=3D 0x60);
+
+/* Two copies of these will exist at the beginning of the log file */
+typedef struct {
+	__le64 current_lsn; // 0x00: Current logical end of log file
+	__le16 log_clients; // 0x08: Maximum number of clients
+	__le16 client_idx[2]; // 0x0A: free/use index into the client record arra=
ys
+	__le16 flags; // 0x0E: See RESTART_SINGLE_PAGE_IO
+	__le32 seq_num_bits; // 0x10: the number of bits in sequence number.
+	__le16 ra_len; // 0x14:
+	__le16 client_off; // 0x16:
+	__le64 l_size; // 0x18: Usable log file size.
+	__le32 last_lsn_data_len; // 0x20:
+	__le16 rec_hdr_len; // 0x24: log page data offset
+	__le16 data_off; // 0x26: log page data length
+	__le32 open_log_count; // 0x28:
+	__le32 align[5]; // 0x2C:
+	CLIENT_REC clients[1]; // 0x40:
+} RESTART_AREA;
+
+typedef struct {
+	__le16 redo_op; // 0x00:  NTFS_LOG_OPERATION
+	__le16 undo_op; // 0x02:  NTFS_LOG_OPERATION
+	__le16 redo_off; // 0x04:  Offset to Redo record
+	__le16 redo_len; // 0x06:  Redo length
+	__le16 undo_off; // 0x08:  Offset to Undo record
+	__le16 undo_len; // 0x0A:  Undo length
+	__le16 target_attr; // 0x0C:
+	__le16 lcns_follow; // 0x0E:
+	__le16 record_off; // 0x10:
+	__le16 attr_off; // 0x12:
+	__le16 cluster_off; // 0x14:
+	__le16 reserved; // 0x16:
+	__le64 target_vcn; // 0x18:
+	__le64 page_lcns[1]; // 0x20:
+} LOG_REC_HDR;
+
+static_assert(sizeof(LOG_REC_HDR) =3D=3D 0x28);
+
+#define RESTART_ENTRY_ALLOCATED 0xFFFFFFFF
+#define RESTART_ENTRY_ALLOCATED_LE cpu_to_le32(0xFFFFFFFF)
+
+typedef struct {
+	__le16 size; // 0x00:  In bytes
+	__le16 used; // 0x02: entries
+	__le16 total; // 0x04: entries
+	__le16 res[3]; // 0x06:
+	__le32 free_goal; // 0x0C:
+	__le32 first_free; // 0x10
+	__le32 last_free; // 0x14
+} RESTART_TABLE;
+
+static_assert(sizeof(RESTART_TABLE) =3D=3D 0x18);
+
+typedef struct {
+	__le16 off; // offset in the Open attribute Table
+	__le16 name_bytes;
+	__le16 name[1];
+} ATTR_NAME_ENTRY;
+
+typedef struct {
+	__le32 next; // 0x00: RESTART_ENTRY_ALLOCATED if allocated
+	__le32 bytes_per_index; // 0x04:
+	ATTR_TYPE type; // 0x08:
+	u8 is_dirty_pages; // 0x0C:
+	u8 is_attr_name; // 0x0B: Faked field to manage 'ptr'
+	u8 name_len; // 0x0C: Faked field to manage 'ptr'
+	u8 res;
+	MFT_REF ref; // 0x10: File Reference of file containing attribute
+	__le64 open_record_lsn; // 0x18:
+	void *ptr; // 0x20:
+} OPEN_ATTR_ENRTY;
+
+/* 32 bit version of 'OPEN_ATTR_ENRTY' */
+typedef struct {
+	__le32 next; // 0x00: RESTART_ENTRY_ALLOCATED if allocated
+	__le32 ptr; // 0x04:
+	MFT_REF ref; // 0x08:
+	__le64 open_record_lsn; // 0x10:
+	u8 is_dirty_pages; // 0x18:
+	u8 is_attr_name; // 0x19
+	u8 res1[2];
+	ATTR_TYPE type; // 0x1C:
+	u8 name_len; // 0x20:  in wchar
+	u8 res2[3];
+	__le32 AttributeName; // 0x24:
+	__le32 bytes_per_index; // 0x28:
+} OPEN_ATTR_ENRTY_32;
+
+#define SIZEOF_OPENATTRIBUTEENTRY0 0x2c
+// static_assert( 0x2C =3D=3D sizeof(OPEN_ATTR_ENRTY_32) );
+static_assert(sizeof(OPEN_ATTR_ENRTY) < SIZEOF_OPENATTRIBUTEENTRY0);
+
+/*
+ * One entry exists in the Dirty Pages Table for each page which is dirty =
at the
+ * time the Restart Area is written
+ */
+typedef struct {
+	__le32 next; // 0x00:  RESTART_ENTRY_ALLOCATED if allocated
+	__le32 target_attr; // 0x04:  Index into the Open attribute Table
+	__le32 transfer_len; // 0x08:
+	__le32 lcns_follow; // 0x0C:
+	__le64 vcn; // 0x10:  Vcn of dirty page
+	__le64 oldest_lsn; // 0x18:
+	__le64 page_lcns[1]; // 0x20:
+} DIR_PAGE_ENTRY;
+
+static_assert(sizeof(DIR_PAGE_ENTRY) =3D=3D 0x28);
+
+/* 32 bit version of 'DIR_PAGE_ENTRY' */
+typedef struct {
+	__le32 next; // 0x00:  RESTART_ENTRY_ALLOCATED if allocated
+	__le32 target_attr; // 0x04:  Index into the Open attribute Table
+	__le32 transfer_len; // 0x08:
+	__le32 lcns_follow; // 0x0C:
+	__le32 reserved; // 0x10:
+	__le32 vcn_low; // 0x14:  Vcn of dirty page
+	__le32 vcn_hi; // 0x18:  Vcn of dirty page
+	__le32 oldest_lsn_low; // 0x1C:
+	__le32 oldest_lsn_hi; // 0x1C:
+	__le32 page_lcns_low; // 0x24:
+	__le32 page_lcns_hi; // 0x24:
+} DIR_PAGE_ENTRY_32;
+
+static_assert(offsetof(DIR_PAGE_ENTRY_32, vcn_low) =3D=3D 0x14);
+static_assert(sizeof(DIR_PAGE_ENTRY_32) =3D=3D 0x2c);
+
+enum transact_state {
+	TransactionUninitialized =3D 0,
+	TransactionActive,
+	TransactionPrepared,
+	TransactionCommitted
+};
+
+typedef struct {
+	__le32 next; // 0x00: RESTART_ENTRY_ALLOCATED if allocated
+	u8 transact_state; // 0x04:
+	u8 reserved[3]; // 0x05:
+	__le64 first_lsn; // 0x08:
+	__le64 prev_lsn; // 0x10:
+	__le64 undo_next_lsn; // 0x18:
+	__le32 undo_records; // 0x20: Number of undo log records pending abort
+	__le32 undo_len; // 0x24: Total undo size
+} TRANSACTION_ENTRY;
+
+static_assert(sizeof(TRANSACTION_ENTRY) =3D=3D 0x28);
+
+typedef struct {
+	__le32 major_ver; // 0x00:
+	__le32 minor_ver; // 0x04:
+	__le64 check_point_start; // 0x08:
+	__le64 open_attr_table_lsn; // 0x10:
+	__le64 attr_names_lsn; // 0x18:
+	__le64 dirty_pages_table_lsn; // 0x20:
+	__le64 transact_table_lsn; // 0x28:
+	__le32 open_attr_len; // 0x30: In bytes
+	__le32 attr_names_len; // 0x34: In bytes
+	__le32 dirty_pages_len; // 0x38: In bytes
+	__le32 transact_table_len; // 0x3C: In bytes
+} NTFS_RESTART;
+
+static_assert(sizeof(NTFS_RESTART) =3D=3D 0x40);
+
+typedef struct {
+	__le64 alloc_size;
+	__le64 valid_size;
+	__le64 data_size;
+	__le64 total_size;
+} NEW_ATTRIBUTE_SIZES;
+
+typedef struct {
+	__le32 bitmap_off;
+	__le32 bits;
+} BITMAP_RANGE;
+
+typedef struct {
+	__le64 lcn;
+	__le64 len;
+} LCN_RANGE;
+
+/* The following type defines the different log record types */
+#define LfsClientRecord cpu_to_le32(1)
+#define LfsClientRestart cpu_to_le32(2)
+
+/* This is used to uniquely identify a client for a particular log file */
+typedef struct {
+	__le16 seq_num;
+	__le16 client_idx;
+} CLIENT_ID;
+
+/* This is the header that begins every Log Record in the log file */
+typedef struct {
+	__le64 this_lsn; // 0x00:
+	__le64 client_prev_lsn; // 0x08:
+	__le64 client_undo_next_lsn; // 0x10:
+	__le32 client_data_len; // 0x18:
+	CLIENT_ID client; // 0x1C: Owner of this log record
+	__le32 record_type; // 0x20: LfsClientRecord or LfsClientRestart
+	__le32 transact_id; // 0x24:
+	__le16 flags; // 0x28:	LOG_RECORD_MULTI_PAGE
+	u8 align[6]; // 0x2A:
+} LFS_RECORD_HDR;
+
+#define LOG_RECORD_MULTI_PAGE cpu_to_le16(1)
+
+static_assert(sizeof(LFS_RECORD_HDR) =3D=3D 0x30);
+
+typedef struct {
+	__le16 next_record_off; // 0x00: Offset of the free space in the page
+	u8 align[6]; // 0x02:
+	__le64 last_end_lsn; // 0x08: lsn for the last log record which ends on t=
he page
+} LFS_RECORD;
+
+static_assert(sizeof(LFS_RECORD) =3D=3D 0x10);
+
+typedef struct {
+	NTFS_RECORD_HEADER rhdr; // 'RCRD'
+	__le32 rflags; // 0x10:  See LOG_PAGE_LOG_RECORD_END
+	__le16 page_count; // 0x14:
+	__le16 page_pos; // 0x16:
+	LFS_RECORD record_hdr; // 0x18
+	__le16 fixups[10]; // 0x28
+	__le32 file_off; // 0x3c: used when major version >=3D 2
+} RECORD_PAGE_HDR;
+
+// Page contains the end of a log record
+#define LOG_PAGE_LOG_RECORD_END cpu_to_le32(0x00000001)
+
+static inline bool is_log_record_end(const RECORD_PAGE_HDR *hdr)
+{
+	return hdr->rflags & LOG_PAGE_LOG_RECORD_END;
+}
+
+static_assert(offsetof(RECORD_PAGE_HDR, file_off) =3D=3D 0x3c);
+
+/*
+ * END of NTFS LOG structures
+ */
+
+/* Define some tuning parameters to keep the restart tables a reasonable s=
ize */
+#define INITIAL_NUMBER_TRANSACTIONS 5
+
+enum NTFS_LOG_OPERATION {
+
+	Noop =3D 0x00,
+	CompensationLogRecord =3D 0x01,
+	InitializeFileRecordSegment =3D 0x02,
+	DeallocateFileRecordSegment =3D 0x03,
+	WriteEndOfFileRecordSegment =3D 0x04,
+	CreateAttribute =3D 0x05,
+	DeleteAttribute =3D 0x06,
+	UpdateResidentValue =3D 0x07,
+	UpdateNonresidentValue =3D 0x08,
+	UpdateMappingPairs =3D 0x09,
+	DeleteDirtyClusters =3D 0x0A,
+	SetNewAttributeSizes =3D 0x0B,
+	AddIndexEntryRoot =3D 0x0C,
+	DeleteIndexEntryRoot =3D 0x0D,
+	AddIndexEntryAllocation =3D 0x0E,
+	DeleteIndexEntryAllocation =3D 0x0F,
+	WriteEndOfIndexBuffer =3D 0x10,
+	SetIndexEntryVcnRoot =3D 0x11,
+	SetIndexEntryVcnAllocation =3D 0x12,
+	UpdateFileNameRoot =3D 0x13,
+	UpdateFileNameAllocation =3D 0x14,
+	SetBitsInNonresidentBitMap =3D 0x15,
+	ClearBitsInNonresidentBitMap =3D 0x16,
+	HotFix =3D 0x17,
+	EndTopLevelAction =3D 0x18,
+	PrepareTransaction =3D 0x19,
+	CommitTransaction =3D 0x1A,
+	ForgetTransaction =3D 0x1B,
+	OpenNonresidentAttribute =3D 0x1C,
+	OpenAttributeTableDump =3D 0x1D,
+	AttributeNamesDump =3D 0x1E,
+	DirtyPageTableDump =3D 0x1F,
+	TransactionTableDump =3D 0x20,
+	UpdateRecordDataRoot =3D 0x21,
+	UpdateRecordDataAllocation =3D 0x22,
+
+	UpdateRelativeDataInIndex =3D
+		0x23, // NtOfsRestartUpdateRelativeDataInIndex
+	UpdateRelativeDataInIndex2 =3D 0x24,
+	ZeroEndOfFileRecord =3D 0x25,
+};
+
+/*
+ * Array for log records which require a target attribute
+ * A true indicates that the corresponding restart operation requires a ta=
rget attribute
+ */
+static const u8 AttributeRequired[] =3D {
+	0xFC, 0xFB, 0xFF, 0x10, 0x06,
+};
+
+static inline bool is_target_required(u16 op)
+{
+	bool ret =3D op <=3D UpdateRecordDataAllocation &&
+		   (AttributeRequired[op >> 3] >> (op & 7) & 1);
+	return ret;
+}
+
+static inline bool can_skip_action(enum NTFS_LOG_OPERATION op)
+{
+	switch (op) {
+	case Noop:
+	case DeleteDirtyClusters:
+	case HotFix:
+	case EndTopLevelAction:
+	case PrepareTransaction:
+	case CommitTransaction:
+	case ForgetTransaction:
+	case CompensationLogRecord:
+	case OpenNonresidentAttribute:
+	case OpenAttributeTableDump:
+	case AttributeNamesDump:
+	case DirtyPageTableDump:
+	case TransactionTableDump:
+		return true;
+	default:
+		return false;
+	}
+}
+
+enum { lcb_ctx_undo_next, lcb_ctx_prev, lcb_ctx_next };
+
+/* bytes per restart table */
+static inline u32 bytes_per_rt(const RESTART_TABLE *rt)
+{
+	return le16_to_cpu(rt->used) * le16_to_cpu(rt->size) +
+	       sizeof(RESTART_TABLE);
+}
+
+/* log record length */
+static inline u32 lrh_length(const LOG_REC_HDR *lr)
+{
+	u16 t16 =3D le16_to_cpu(lr->lcns_follow);
+
+	return t16 > 1 ? sizeof(LOG_REC_HDR) + (t16 - 1) * sizeof(u64) :
+			 sizeof(LOG_REC_HDR);
+}
+
+typedef struct {
+	LFS_RECORD_HDR *lrh; // Log record header of the current lsn
+	LOG_REC_HDR *log_rec;
+	u32 ctx_mode; // lcb_ctx_undo_next/lcb_ctx_prev/lcb_ctx_next
+	CLIENT_ID client; // The client ID for the log records being returned
+	bool alloc; // if true the we should deallocate 'log_rec'
+} LCB;
+
+static void lcb_put(LCB *lcb)
+{
+	if (lcb->alloc)
+		ntfs_free(lcb->log_rec);
+	ntfs_free(lcb->lrh);
+	ntfs_free(lcb);
+}
+
+/*
+ * oldest_client_lsn
+ *
+ * find the oldest lsn from active clients.
+ */
+static inline void oldest_client_lsn(const CLIENT_REC *ca, __le16 next_cli=
ent,
+				     u64 *oldest_lsn)
+{
+	while (next_client !=3D LFS_NO_CLIENT_LE) {
+		const CLIENT_REC *cr =3D ca + le16_to_cpu(next_client);
+		u64 lsn =3D le64_to_cpu(cr->oldest_lsn);
+
+		/* ignore this block if it's oldest lsn is 0 */
+		if (lsn && lsn < *oldest_lsn)
+			*oldest_lsn =3D lsn;
+
+		next_client =3D cr->next_client;
+	}
+}
+
+static inline bool is_rst_page_hdr_valid(u32 file_off, const RESTART_HDR *=
rhdr)
+{
+	u32 sys_page =3D le32_to_cpu(rhdr->sys_page_size);
+	u32 page_size =3D le32_to_cpu(rhdr->page_size);
+	u32 end_usa;
+	u16 ro;
+
+	if (sys_page < SECTOR_SIZE || page_size < SECTOR_SIZE ||
+	    sys_page & (sys_page - 1) || page_size & (page_size - 1)) {
+		return false;
+	}
+
+	/* Check that if the file offset isn't 0, it is the system page size */
+	if (file_off && file_off !=3D sys_page)
+		return false;
+
+	/* Check support version 1.1+ */
+	if (le16_to_cpu(rhdr->major_ver) <=3D 1 && !rhdr->minor_ver)
+		return false;
+
+	if (le16_to_cpu(rhdr->major_ver) > 2)
+		return false;
+
+	ro =3D le16_to_cpu(rhdr->ra_off);
+	if (!IsQuadAligned(ro) || ro > sys_page)
+		return false;
+
+	end_usa =3D ((sys_page >> SECTOR_SHIFT) + 1) * sizeof(short);
+	end_usa +=3D le16_to_cpu(rhdr->rhdr.fix_off);
+
+	if (ro < end_usa)
+		return false;
+
+	return true;
+}
+
+static inline bool is_rst_area_valid(const RESTART_HDR *rhdr)
+{
+	const RESTART_AREA *ra;
+	u16 cl, fl, ul;
+	u32 off, l_size, file_dat_bits, file_size_round;
+	u16 ro =3D le16_to_cpu(rhdr->ra_off);
+	u32 sys_page =3D le32_to_cpu(rhdr->sys_page_size);
+
+	if (ro + offsetof(RESTART_AREA, l_size) > SECTOR_SIZE - sizeof(short))
+		return false;
+
+	ra =3D Add2Ptr(rhdr, ro);
+	cl =3D le16_to_cpu(ra->log_clients);
+
+	if (cl > 1)
+		return false;
+
+	off =3D le16_to_cpu(ra->client_off);
+
+	if (!IsQuadAligned(off) || ro + off > SECTOR_SIZE - sizeof(short))
+		return false;
+
+	off +=3D cl * sizeof(CLIENT_REC);
+
+	if (off > sys_page)
+		return false;
+
+	/*
+	 * Check the restart length field and whether the entire
+	 * restart area is contained that length
+	 */
+	if (le16_to_cpu(rhdr->ra_off) + le16_to_cpu(ra->ra_len) > sys_page ||
+	    off > le16_to_cpu(ra->ra_len)) {
+		return false;
+	}
+
+	/*
+	 * As a final check make sure that the use list and the free list
+	 * are either empty or point to a valid client
+	 */
+	fl =3D le16_to_cpu(ra->client_idx[0]);
+	ul =3D le16_to_cpu(ra->client_idx[1]);
+	if ((fl !=3D LFS_NO_CLIENT && fl >=3D cl) ||
+	    (ul !=3D LFS_NO_CLIENT && ul >=3D cl))
+		return false;
+
+	/* Make sure the sequence number bits match the log file size */
+	l_size =3D le64_to_cpu(ra->l_size);
+
+	file_dat_bits =3D sizeof(u64) * 8 - le32_to_cpu(ra->seq_num_bits);
+	file_size_round =3D 1u << (file_dat_bits + 3);
+	if (file_size_round !=3D l_size &&
+	    (file_size_round < l_size || (file_size_round / 2) > l_size)) {
+		return false;
+	}
+
+	/* The log page data offset and record header length must be quad-aligned=
 */
+	if (!IsQuadAligned(le16_to_cpu(ra->data_off)) ||
+	    !IsQuadAligned(le16_to_cpu(ra->rec_hdr_len)))
+		return false;
+
+	return true;
+}
+
+static inline bool is_client_area_valid(const RESTART_HDR *rhdr, bool usa_=
error)
+{
+	u16 ro =3D le16_to_cpu(rhdr->ra_off);
+	const RESTART_AREA *ra =3D Add2Ptr(rhdr, ro);
+	u16 ra_len =3D le16_to_cpu(ra->ra_len);
+	const CLIENT_REC *ca;
+	u32 i;
+
+	if (usa_error && ra_len + ro > SECTOR_SIZE - sizeof(short))
+		return false;
+
+	/* Find the start of the client array */
+	ca =3D Add2Ptr(ra, le16_to_cpu(ra->client_off));
+
+	/*
+	 * Start with the free list
+	 * Check that all the clients are valid and that there isn't a cycle
+	 * Do the in-use list on the second pass
+	 */
+	for (i =3D 0; i < 2; i++) {
+		u16 client_idx =3D le16_to_cpu(ra->client_idx[i]);
+		bool first_client =3D true;
+		u16 clients =3D le16_to_cpu(ra->log_clients);
+
+		while (client_idx !=3D LFS_NO_CLIENT) {
+			const CLIENT_REC *cr;
+
+			if (!clients ||
+			    client_idx >=3D le16_to_cpu(ra->log_clients))
+				return false;
+
+			clients -=3D 1;
+			cr =3D ca + client_idx;
+
+			client_idx =3D le16_to_cpu(cr->next_client);
+
+			if (first_client) {
+				first_client =3D false;
+				if (cr->prev_client !=3D LFS_NO_CLIENT_LE)
+					return false;
+			}
+		}
+	}
+
+	return true;
+}
+
+/*
+ * remove_client
+ *
+ * remove a client record from a client record list an restart area
+ */
+static inline void remove_client(CLIENT_REC *ca, const CLIENT_REC *cr,
+				 __le16 *head)
+{
+	if (cr->prev_client =3D=3D LFS_NO_CLIENT_LE)
+		*head =3D cr->next_client;
+	else
+		ca[le16_to_cpu(cr->prev_client)].next_client =3D cr->next_client;
+
+	if (cr->next_client !=3D LFS_NO_CLIENT_LE)
+		ca[le16_to_cpu(cr->next_client)].prev_client =3D cr->prev_client;
+}
+
+/*
+ * add_client
+ *
+ * add a client record to the start of a list
+ */
+static inline void add_client(CLIENT_REC *ca, u16 index, __le16 *head)
+{
+	CLIENT_REC *cr =3D ca + index;
+
+	cr->prev_client =3D LFS_NO_CLIENT_LE;
+	cr->next_client =3D *head;
+
+	if (*head !=3D LFS_NO_CLIENT_LE)
+		ca[le16_to_cpu(*head)].prev_client =3D cpu_to_le16(index);
+
+	*head =3D cpu_to_le16(index);
+}
+
+/*
+ * enum_rstbl
+ *
+ */
+static inline void *enum_rstbl(RESTART_TABLE *t, void *c)
+{
+	__le32 *e;
+	u32 bprt;
+	u16 rsize =3D t ? le16_to_cpu(t->size) : 0;
+
+	if (!c) {
+		if (!t || !t->total)
+			return NULL;
+		e =3D Add2Ptr(t, sizeof(RESTART_TABLE));
+	} else {
+		e =3D Add2Ptr(c, rsize);
+	}
+
+	/* Loop until we hit the first one allocated, or the end of the list */
+	for (bprt =3D bytes_per_rt(t); PtrOffset(t, e) < bprt;
+	     e =3D Add2Ptr(e, rsize)) {
+		if (*e =3D=3D RESTART_ENTRY_ALLOCATED_LE)
+			return e;
+	}
+	return NULL;
+}
+
+/*
+ * find_dp
+ *
+ * searches for a 'vcn' in Dirty Page Table,
+ */
+static inline DIR_PAGE_ENTRY *find_dp(RESTART_TABLE *dptbl, u32 target_att=
r,
+				      u64 vcn)
+{
+	__le32 ta =3D cpu_to_le32(target_attr);
+	DIR_PAGE_ENTRY *dp =3D NULL;
+
+	while ((dp =3D enum_rstbl(dptbl, dp))) {
+		u64 dp_vcn =3D le64_to_cpu(dp->vcn);
+
+		if (dp->target_attr =3D=3D ta && vcn >=3D dp_vcn &&
+		    vcn < dp_vcn + le32_to_cpu(dp->lcns_follow)) {
+			return dp;
+		}
+	}
+	return NULL;
+}
+
+static inline u32 norm_file_page(u32 page_size, u32 *l_size, bool use_defa=
ult)
+{
+	if (use_default)
+		page_size =3D DefaultLogPageSize;
+
+	/* Round the file size down to a system page boundary */
+	*l_size &=3D ~(page_size - 1);
+
+	/* File should contain at least 2 restart pages and MinLogRecordPages pag=
es */
+	if (*l_size < (MinLogRecordPages + 2) * page_size)
+		return 0;
+
+	return page_size;
+}
+
+static bool check_log_rec(const LOG_REC_HDR *lr, u32 bytes, u32 tr,
+			  u32 bytes_per_attr_entry)
+{
+	u16 t16;
+
+	if (bytes < sizeof(LOG_REC_HDR))
+		return false;
+	if (!tr)
+		return false;
+
+	if ((tr - sizeof(RESTART_TABLE)) % sizeof(TRANSACTION_ENTRY))
+		return false;
+
+	if (le16_to_cpu(lr->redo_off) & 7)
+		return false;
+
+	if (le16_to_cpu(lr->undo_off) & 7)
+		return false;
+
+	if (lr->target_attr)
+		goto check_lcns;
+
+	if (is_target_required(le16_to_cpu(lr->redo_op)))
+		return false;
+
+	if (is_target_required(le16_to_cpu(lr->undo_op)))
+		return false;
+
+check_lcns:
+	if (!lr->lcns_follow)
+		goto check_length;
+
+	t16 =3D le16_to_cpu(lr->target_attr);
+	if ((t16 - sizeof(RESTART_TABLE)) % bytes_per_attr_entry)
+		return false;
+
+check_length:
+	if (bytes < lrh_length(lr))
+		return false;
+
+	return true;
+}
+
+static bool check_rstbl(const RESTART_TABLE *rt, size_t bytes)
+{
+	u32 ts;
+	u32 i, off;
+	u16 rsize =3D le16_to_cpu(rt->size);
+	u16 ne =3D le16_to_cpu(rt->used);
+	u32 ff =3D le32_to_cpu(rt->first_free);
+	u32 lf =3D le32_to_cpu(rt->last_free);
+
+	ts =3D rsize * ne + sizeof(RESTART_TABLE);
+
+	if (!rsize || rsize > bytes || rsize + sizeof(RESTART_TABLE) > bytes ||
+	    bytes < ts || le16_to_cpu(rt->total) > ne || ff > ts || lf > ts ||
+	    (ff && ff < sizeof(RESTART_TABLE)) ||
+	    (lf && lf < sizeof(RESTART_TABLE))) {
+		return false;
+	}
+
+	/* Verify each entry is either allocated or points
+	 * to a valid offset the table
+	 */
+	for (i =3D 0; i < ne; i++) {
+		off =3D le32_to_cpu(*(__le32 *)Add2Ptr(
+			rt, i * rsize + sizeof(RESTART_TABLE)));
+
+		if (off !=3D RESTART_ENTRY_ALLOCATED && off &&
+		    (off < sizeof(RESTART_TABLE) ||
+		     ((off - sizeof(RESTART_TABLE)) % rsize))) {
+			return false;
+		}
+	}
+
+	/* Walk through the list headed by the first entry to make
+	 * sure none of the entries are currently being used
+	 */
+	for (off =3D ff; off;) {
+		if (off =3D=3D RESTART_ENTRY_ALLOCATED)
+			return false;
+
+		off =3D le32_to_cpu(*(__le32 *)Add2Ptr(rt, off));
+	}
+
+	return true;
+}
+
+/*
+ * free_rsttbl_idx
+ *
+ * frees a previously allocated index a Restart Table.
+ */
+static inline void free_rsttbl_idx(RESTART_TABLE *rt, u32 off)
+{
+	__le32 *e;
+	u32 lf =3D le32_to_cpu(rt->last_free);
+	__le32 off_le =3D cpu_to_le32(off);
+
+	e =3D Add2Ptr(rt, off);
+
+	if (off < le32_to_cpu(rt->free_goal)) {
+		*e =3D rt->first_free;
+		rt->first_free =3D off_le;
+		if (!lf)
+			rt->last_free =3D off_le;
+	} else {
+		if (lf)
+			*(__le32 *)Add2Ptr(rt, lf) =3D off_le;
+		else
+			rt->first_free =3D off_le;
+
+		rt->last_free =3D off_le;
+		*e =3D 0;
+	}
+
+	le16_sub_cpu(&rt->total, 1);
+}
+
+static inline RESTART_TABLE *init_rsttbl(u16 esize, u16 used)
+{
+	__le32 *e, *last_free;
+	u32 off;
+	u32 bytes =3D esize * used + sizeof(RESTART_TABLE);
+	u32 lf =3D sizeof(RESTART_TABLE) + (used - 1) * esize;
+	RESTART_TABLE *t =3D ntfs_alloc(bytes, 1);
+
+	t->size =3D cpu_to_le16(esize);
+	t->used =3D cpu_to_le16(used);
+	t->free_goal =3D cpu_to_le32(~0u);
+	t->first_free =3D cpu_to_le32(sizeof(RESTART_TABLE));
+	t->last_free =3D cpu_to_le32(lf);
+
+	e =3D (__le32 *)(t + 1);
+	last_free =3D Add2Ptr(t, lf);
+
+	for (off =3D sizeof(RESTART_TABLE) + esize; e < last_free;
+	     e =3D Add2Ptr(e, esize), off +=3D esize) {
+		*e =3D cpu_to_le32(off);
+	}
+	return t;
+}
+
+static inline RESTART_TABLE *extend_rsttbl(RESTART_TABLE *tbl, u32 add,
+					   u32 free_goal)
+{
+	u16 esize =3D le16_to_cpu(tbl->size);
+	__le32 osize =3D cpu_to_le32(bytes_per_rt(tbl));
+	u32 used =3D le16_to_cpu(tbl->used);
+	RESTART_TABLE *rt =3D init_rsttbl(esize, used + add);
+
+	memcpy(rt + 1, tbl + 1, esize * used);
+
+	rt->free_goal =3D
+		free_goal =3D=3D ~0u ?
+			cpu_to_le32(~0u) :
+			cpu_to_le32(sizeof(RESTART_TABLE) + free_goal * esize);
+
+	if (tbl->first_free) {
+		rt->first_free =3D tbl->first_free;
+		*(__le32 *)Add2Ptr(rt, le32_to_cpu(tbl->last_free)) =3D osize;
+	} else
+		rt->first_free =3D osize;
+
+	rt->total =3D tbl->total;
+
+	ntfs_free(tbl);
+	return rt;
+}
+
+/*
+ * alloc_rsttbl_idx
+ *
+ * allocates an index from within a previously initialized Restart Table
+ */
+static inline void *alloc_rsttbl_idx(RESTART_TABLE **tbl)
+{
+	u32 off;
+	__le32 *e;
+	RESTART_TABLE *t =3D *tbl;
+
+	if (!t->first_free)
+		*tbl =3D t =3D extend_rsttbl(t, 16, ~0u);
+
+	off =3D le32_to_cpu(t->first_free);
+
+	/* Dequeue this entry and zero it. */
+	e =3D Add2Ptr(t, off);
+
+	t->first_free =3D *e;
+
+	memset(e, 0, le16_to_cpu(t->size));
+
+	*e =3D RESTART_ENTRY_ALLOCATED_LE;
+
+	/* If list is going empty, then we fix the last_free as well. */
+	if (!t->first_free)
+		t->last_free =3D 0;
+
+	le16_add_cpu(&t->total, 1);
+
+	return Add2Ptr(t, off);
+}
+
+/*
+ * alloc_rsttbl_from_idx
+ *
+ * allocates a specific index from within a previously initialized Restart=
 Table
+ */
+static inline void *alloc_rsttbl_from_idx(RESTART_TABLE **tbl, u32 vbo)
+{
+	u32 off;
+	__le32 *e;
+	RESTART_TABLE *rt =3D *tbl;
+	u32 bytes =3D bytes_per_rt(rt);
+	u16 esize =3D le16_to_cpu(rt->size);
+
+	/* If the entry is not the table, we will have to extend the table */
+	if (vbo >=3D bytes) {
+		/*
+		 * extend the size by computing the number of entries between
+		 * the existing size and the desired index and adding
+		 * 1 to that
+		 */
+		u32 bytes2idx =3D vbo - bytes;
+
+		/* There should always be an integral number of entries being added */
+		/* Now extend the table */
+		*tbl =3D rt =3D extend_rsttbl(rt, bytes2idx / esize + 1, bytes);
+		if (!rt)
+			return NULL;
+	}
+
+	/* see if the entry is already allocated, and just return if it is. */
+	e =3D Add2Ptr(rt, vbo);
+
+	if (*e =3D=3D RESTART_ENTRY_ALLOCATED_LE)
+		return e;
+
+	/*
+	 * Walk through the table, looking for the entry we're
+	 * interested and the previous entry
+	 */
+	off =3D le32_to_cpu(rt->first_free);
+	e =3D Add2Ptr(rt, off);
+
+	if (off =3D=3D vbo) {
+		/* this is a match */
+		rt->first_free =3D *e;
+		goto skip_looking;
+	}
+
+	/*
+	 * need to walk through the list looking for the predecessor of our entry
+	 */
+	for (;;) {
+		/* Remember the entry just found */
+		u32 last_off =3D off;
+		__le32 *last_e =3D e;
+
+		/* should never run of entries. */
+
+		/* Lookup up the next entry the list */
+		off =3D le32_to_cpu(*last_e);
+		e =3D Add2Ptr(rt, off);
+
+		/* If this is our match we are done */
+		if (off =3D=3D vbo) {
+			*last_e =3D *e;
+
+			/* If this was the last entry, we update that the table as well */
+			if (le32_to_cpu(rt->last_free) =3D=3D off)
+				rt->last_free =3D cpu_to_le32(last_off);
+			break;
+		}
+	}
+
+skip_looking:
+	/* If the list is now empty, we fix the last_free as well */
+	if (!rt->first_free)
+		rt->last_free =3D 0;
+
+	/* Zero this entry */
+	memset(e, 0, esize);
+	*e =3D RESTART_ENTRY_ALLOCATED_LE;
+
+	le16_add_cpu(&rt->total, 1);
+
+	return e;
+}
+
+#define RESTART_SINGLE_PAGE_IO cpu_to_le16(0x0001)
+
+#define NTFSLOG_WRAPPED 0x00000001
+#define NTFSLOG_MULTIPLE_PAGE_IO 0x00000002
+#define NTFSLOG_NO_LAST_LSN 0x00000004
+#define NTFSLOG_REUSE_TAIL 0x00000010
+#define NTFSLOG_NO_OLDEST_LSN 0x00000020
+
+/*
+ * Helper struct to work with NTFS $LogFile
+ */
+typedef struct {
+	ntfs_inode *ni;
+
+	u32 l_size;
+	u32 sys_page_size;
+	u32 sys_page_mask;
+	u32 page_size;
+	u32 page_mask; // page_size - 1
+	u8 page_bits;
+	RECORD_PAGE_HDR *one_page_buf;
+
+	RESTART_TABLE *open_attr_tbl;
+	u32 transaction_id;
+	u32 clst_per_page;
+
+	u32 first_page;
+	u32 next_page;
+	u32 ra_off;
+	u32 data_off;
+	u32 restart_size;
+	u32 data_size;
+	u16 record_header_len;
+	u64 seq_num;
+	u32 seq_num_bits;
+	u32 file_data_bits;
+	u32 seq_num_mask; /* (1 << file_data_bits) - 1 */
+
+	RESTART_AREA *ra; /* in-memory image of the next restart area */
+	u32 ra_size; /* the usable size of the restart area */
+
+	/*
+	 * If true, then the in-memory restart area is to be written
+	 * to the first position on the disk
+	 */
+	bool init_ra;
+	bool set_dirty; /* true if we need to set dirty flag */
+
+	u64 oldest_lsn;
+
+	u32 oldest_lsn_off;
+	u64 last_lsn;
+
+	u32 total_avail;
+	u32 total_avail_pages;
+	u32 total_undo_commit;
+	u32 max_current_avail;
+	u32 current_avail;
+	u32 reserved;
+
+	short major_ver;
+	short minor_ver;
+
+	u32 l_flags; /* See NTFSLOG_XXX */
+	u32 current_openlog_count; /* On-disk value for open_log_count */
+
+	CLIENT_ID client_id;
+	u32 client_undo_commit;
+
+} ntfs_log;
+
+static inline u32 lsn_to_vbo(ntfs_log *log, const u64 lsn)
+{
+	u32 vbo =3D (lsn << log->seq_num_bits) >> (log->seq_num_bits - 3);
+
+	return vbo;
+}
+
+/* compute the offset in the log file of the next log page */
+static inline u32 next_page_off(ntfs_log *log, u32 off)
+{
+	off =3D (off & ~log->sys_page_mask) + log->page_size;
+	return off >=3D log->l_size ? log->first_page : off;
+}
+
+static inline u32 lsn_to_page_off(ntfs_log *log, u64 lsn)
+{
+	return (((u32)lsn) << 3) & log->page_mask;
+}
+
+static inline u64 vbo_to_lsn(ntfs_log *log, u32 off, u64 Seq)
+{
+	return (off >> 3) + (Seq << log->file_data_bits);
+}
+
+static inline bool is_lsn_in_file(ntfs_log *log, u64 lsn)
+{
+	return lsn >=3D log->oldest_lsn &&
+	       lsn <=3D le64_to_cpu(log->ra->current_lsn);
+}
+
+static inline u32 hdr_file_off(ntfs_log *log, RECORD_PAGE_HDR *hdr)
+{
+	if (log->major_ver < 2)
+		return le64_to_cpu(hdr->rhdr.lsn);
+
+	return le32_to_cpu(hdr->file_off);
+}
+
+static inline u64 base_lsn(ntfs_log *log, const RECORD_PAGE_HDR *hdr, u64 =
lsn)
+{
+	u64 h_lsn =3D le64_to_cpu(hdr->rhdr.lsn);
+	u64 ret =3D (((h_lsn >> log->file_data_bits) +
+		    (lsn < (lsn_to_vbo(log, h_lsn) & ~log->page_mask) ? 1 : 0))
+		   << log->file_data_bits) +
+		  ((((is_log_record_end(hdr) &&
+		      h_lsn <=3D le64_to_cpu(hdr->record_hdr.last_end_lsn)) ?
+			     le16_to_cpu(hdr->record_hdr.next_record_off) :
+			     log->page_size) +
+		    lsn) >>
+		   3);
+
+	return ret;
+}
+
+static inline bool verify_client_lsn(ntfs_log *log, const CLIENT_REC *clie=
nt,
+				     u64 lsn)
+{
+	return lsn >=3D le64_to_cpu(client->oldest_lsn) &&
+	       lsn <=3D le64_to_cpu(log->ra->current_lsn) && lsn;
+}
+
+typedef struct {
+	u64 last_lsn;
+	RESTART_HDR *r_page;
+	u32 vbo;
+	bool chkdsk_was_run;
+	bool valid_page;
+	bool initialized;
+	bool restart;
+} RESTART_INFO;
+
+static int read_log_page(ntfs_log *log, u32 vbo, RECORD_PAGE_HDR **buffer,
+			 bool allow_errors, bool ignore_usa_error,
+			 bool *usa_error)
+{
+	int err =3D 0;
+	u32 page_idx =3D vbo >> log->page_bits;
+	u32 page_off =3D vbo & log->page_mask;
+	u32 bytes =3D log->page_size - page_off;
+	void *to_free =3D NULL;
+	u32 page_vbo =3D page_idx << log->page_bits;
+	RECORD_PAGE_HDR *page_buf;
+	ntfs_inode *ni =3D log->ni;
+	bool bBAAD;
+
+	if (vbo >=3D log->l_size)
+		return -EINVAL;
+
+	if (!*buffer) {
+		to_free =3D ntfs_alloc(bytes, 0);
+		if (!to_free)
+			return -ENOMEM;
+		*buffer =3D to_free;
+	}
+
+	page_buf =3D page_off ? log->one_page_buf : *buffer;
+
+	err =3D ntfs_read_run_nb(ni->mi.sbi, &ni->file.run, page_vbo, page_buf,
+			       log->page_size, NULL);
+	if (err)
+		goto out;
+
+	if (page_buf->rhdr.sign !=3D NTFS_FFFF_SIGNATURE)
+		ntfs_fix_post_read(&page_buf->rhdr, PAGE_SIZE, false);
+
+	if (page_buf !=3D *buffer)
+		memcpy(*buffer, Add2Ptr(page_buf, page_off), bytes);
+
+	bBAAD =3D page_buf->rhdr.sign =3D=3D NTFS_BAAD_SIGNATURE;
+
+	/* Check that the update sequence array for this page is valid */
+	if (bBAAD) {
+		/* If we don't allow errors, raise an error status */
+		if (!ignore_usa_error) {
+			err =3D -EINVAL;
+			goto out;
+		}
+	}
+
+	if (usa_error)
+		*usa_error =3D bBAAD;
+
+out:
+	if (err && to_free) {
+		ntfs_free(to_free);
+		*buffer =3D NULL;
+	}
+
+	return err;
+}
+
+/*
+ * log_read_rst
+ *
+ * it walks through 512 blocks of the file looking for a valid restart pag=
e header
+ * It will stop the first time we find a valid page header
+ */
+static int log_read_rst(ntfs_log *log, u32 l_size, bool first,
+			RESTART_INFO *info)
+{
+	int err;
+	u32 skip, vbo;
+	RESTART_HDR *r_page =3D ntfs_alloc(DefaultLogPageSize, 0);
+
+	if (!r_page)
+		return -ENOMEM;
+
+	memset(info, 0, sizeof(RESTART_INFO));
+
+	/* Determine which restart area we are looking for */
+	if (first) {
+		vbo =3D 0;
+		skip =3D 512;
+	} else {
+		vbo =3D 512;
+		skip =3D 0;
+	}
+
+	/* loop continuously until we succeed */
+	for (; vbo < l_size; vbo =3D 2 * vbo + skip, skip =3D 0) {
+		bool usa_error;
+		u32 sys_page_size;
+		bool brst, bchk;
+		RESTART_AREA *ra;
+
+		/* Read a page header at the current offset */
+		err =3D read_log_page(log, vbo, (RECORD_PAGE_HDR **)&r_page, true,
+				    true, &usa_error);
+
+		if (err)
+			continue;
+
+		/* exit if the signature is a log record page */
+		if (r_page->rhdr.sign =3D=3D NTFS_RCRD_SIGNATURE) {
+			info->initialized =3D true;
+			break;
+		}
+
+		brst =3D r_page->rhdr.sign =3D=3D NTFS_RSTR_SIGNATURE;
+		bchk =3D r_page->rhdr.sign =3D=3D NTFS_CHKD_SIGNATURE;
+
+		if (!bchk && !brst) {
+			if (r_page->rhdr.sign !=3D NTFS_FFFF_SIGNATURE) {
+				/*
+				 * Remember if the signature does not
+				 * indicate uninitialized file
+				 */
+				info->initialized =3D true;
+			}
+			continue;
+		}
+
+		ra =3D NULL;
+		info->valid_page =3D false;
+		info->initialized =3D true;
+		info->vbo =3D vbo;
+
+		/* Let's check the restart area if this is a valid page */
+		if (!is_rst_page_hdr_valid(vbo, r_page))
+			goto check_result;
+		ra =3D Add2Ptr(r_page, le16_to_cpu(r_page->ra_off));
+
+		if (!is_rst_area_valid(r_page))
+			goto check_result;
+
+		/*
+		 * We have a valid restart page header and restart area.
+		 * If chkdsk was run or we have no clients then we have
+		 * no more checking to do
+		 */
+		if (bchk || ra->client_idx[1] =3D=3D LFS_NO_CLIENT_LE) {
+			info->valid_page =3D true;
+			goto check_result;
+		}
+
+		/* Read the entire restart area */
+		sys_page_size =3D le32_to_cpu(r_page->sys_page_size);
+		if (DefaultLogPageSize !=3D sys_page_size) {
+			ntfs_free(r_page);
+			r_page =3D ntfs_alloc(sys_page_size, 1);
+			if (!r_page)
+				return -ENOMEM;
+
+			err =3D read_log_page(log, vbo,
+					    (RECORD_PAGE_HDR **)&r_page, true,
+					    true, &usa_error);
+
+			if (err) {
+				ntfs_free(r_page);
+				return err;
+			}
+		}
+
+		if (is_client_area_valid(r_page, usa_error)) {
+			info->valid_page =3D true;
+			ra =3D Add2Ptr(r_page, le16_to_cpu(r_page->ra_off));
+		}
+
+check_result:
+		/* If chkdsk was run then update the caller's values and return */
+		if (r_page->rhdr.sign =3D=3D NTFS_CHKD_SIGNATURE) {
+			info->chkdsk_was_run =3D true;
+			info->last_lsn =3D le64_to_cpu(r_page->rhdr.lsn);
+			info->restart =3D true;
+			info->r_page =3D r_page;
+			return 0;
+		}
+
+		/* If we have a valid page then copy the values we need from it */
+		if (info->valid_page) {
+			info->last_lsn =3D le64_to_cpu(ra->current_lsn);
+			info->restart =3D true;
+			info->r_page =3D r_page;
+			return 0;
+		}
+	}
+
+	ntfs_free(r_page);
+
+	return 0;
+}
+
+/*
+ * log_init_pg_hdr
+ *
+ * init "log' from restart page header
+ */
+static void log_init_pg_hdr(ntfs_log *log, u32 sys_page_size, u32 page_siz=
e,
+			    u16 major_ver, u16 minor_ver)
+{
+	log->sys_page_size =3D sys_page_size;
+	log->sys_page_mask =3D sys_page_size - 1;
+	log->page_size =3D page_size;
+	log->page_mask =3D page_size - 1;
+	log->page_bits =3D blksize_bits(page_size);
+
+	log->clst_per_page =3D log->page_size >> log->ni->mi.sbi->cluster_bits;
+	if (!log->clst_per_page)
+		log->clst_per_page =3D 1;
+
+	log->first_page =3D major_ver >=3D 2 ?
+				  0x22 * page_size :
+				  ((sys_page_size << 1) + (page_size << 1));
+	log->major_ver =3D major_ver;
+	log->minor_ver =3D minor_ver;
+}
+
+/*
+ * log_create
+ *
+ * init "log" in cases when we don't have a restart area to use
+ */
+static void log_create(ntfs_log *log, u32 l_size, const u64 last_lsn,
+		       u32 open_log_count, bool wrapped, bool use_multi_page)
+{
+	log->l_size =3D l_size;
+	/* All file offsets must be quadword aligned */
+	log->file_data_bits =3D blksize_bits(l_size) - 3;
+	log->seq_num_mask =3D (8 << log->file_data_bits) - 1;
+	log->seq_num_bits =3D sizeof(u64) * 8 - log->file_data_bits;
+	log->seq_num =3D (last_lsn >> log->file_data_bits) + 2;
+	log->next_page =3D log->first_page;
+	log->oldest_lsn =3D log->seq_num << log->file_data_bits;
+	log->oldest_lsn_off =3D 0;
+	log->last_lsn =3D log->oldest_lsn;
+
+	log->l_flags |=3D NTFSLOG_NO_LAST_LSN | NTFSLOG_NO_OLDEST_LSN;
+
+	/* Set the correct flags for the I/O and indicate if we have wrapped */
+	if (wrapped)
+		log->l_flags |=3D NTFSLOG_WRAPPED;
+
+	if (use_multi_page)
+		log->l_flags |=3D NTFSLOG_MULTIPLE_PAGE_IO;
+
+	/* Compute the log page values */
+	log->data_off =3D QuadAlign(
+		offsetof(RECORD_PAGE_HDR, fixups) +
+		sizeof(short) * ((log->page_size >> SECTOR_SHIFT) + 1));
+	log->data_size =3D log->page_size - log->data_off;
+	log->record_header_len =3D sizeof(LFS_RECORD_HDR);
+
+	/* Remember the different page sizes for reservation */
+	log->reserved =3D log->data_size - log->record_header_len;
+
+	/* Compute the restart page values. */
+	log->ra_off =3D QuadAlign(
+		offsetof(RESTART_HDR, fixups) +
+		sizeof(short) * ((log->sys_page_size >> SECTOR_SHIFT) + 1));
+	log->restart_size =3D log->sys_page_size - log->ra_off;
+	log->ra_size =3D offsetof(RESTART_AREA, clients) + sizeof(CLIENT_REC);
+	log->current_openlog_count =3D open_log_count;
+
+	/*
+	 * The total available log file space is the number of
+	 * log file pages times the space available on each page
+	 */
+	log->total_avail_pages =3D log->l_size - log->first_page;
+	log->total_avail =3D log->total_avail_pages >> log->page_bits;
+
+	/*
+	 * We assume that we can't use the end of the page less than
+	 * the file record size
+	 * Then we won't need to reserve more than the caller asks for
+	 */
+	log->max_current_avail =3D log->total_avail * log->reserved;
+	log->total_avail =3D log->total_avail * log->data_size;
+	log->current_avail =3D log->max_current_avail;
+}
+
+/*
+ * log_create_ra
+ *
+ * This routine is called to fill a restart area from the values stored in=
 'log'
+ */
+static RESTART_AREA *log_create_ra(ntfs_log *log)
+{
+	CLIENT_REC *cr;
+	RESTART_AREA *ra =3D ntfs_alloc(log->restart_size, 1);
+
+	if (!ra)
+		return NULL;
+
+	ra->current_lsn =3D cpu_to_le64(log->last_lsn);
+	ra->log_clients =3D cpu_to_le16(1);
+	ra->client_idx[1] =3D LFS_NO_CLIENT_LE;
+	if (log->l_flags & NTFSLOG_MULTIPLE_PAGE_IO)
+		ra->flags =3D RESTART_SINGLE_PAGE_IO;
+	ra->seq_num_bits =3D cpu_to_le32(log->seq_num_bits);
+	ra->ra_len =3D cpu_to_le16(log->ra_size);
+	ra->client_off =3D cpu_to_le16(offsetof(RESTART_AREA, clients));
+	ra->l_size =3D cpu_to_le64(log->l_size);
+	ra->rec_hdr_len =3D cpu_to_le16(log->record_header_len);
+	ra->data_off =3D cpu_to_le16(log->data_off);
+	ra->open_log_count =3D cpu_to_le32(log->current_openlog_count + 1);
+
+	cr =3D ra->clients;
+
+	cr->prev_client =3D LFS_NO_CLIENT_LE;
+	cr->next_client =3D LFS_NO_CLIENT_LE;
+
+	return ra;
+}
+
+static u32 final_log_off(ntfs_log *log, u64 lsn, u32 data_len)
+{
+	u32 base_vbo =3D lsn << 3;
+	u32 final_log_off =3D (base_vbo & log->seq_num_mask) & ~log->page_mask;
+	u32 page_off =3D base_vbo & log->page_mask;
+	u32 tail =3D log->page_size - page_off;
+
+	page_off -=3D 1;
+
+	/* Add the length of the header */
+	data_len +=3D log->record_header_len;
+
+	/*
+	 * If this lsn is contained this log page we are done
+	 * Otherwise we need to walk through several log pages
+	 */
+	if (data_len > tail) {
+		data_len -=3D tail;
+		tail =3D log->data_size;
+		page_off =3D log->data_off - 1;
+
+		for (;;) {
+			final_log_off =3D next_page_off(log, final_log_off);
+
+			/* We are done if the remaining bytes fit on this page */
+			if (data_len <=3D tail)
+				break;
+			data_len -=3D tail;
+		}
+	}
+
+	/*
+	 * We add the remaining bytes to our starting position on this page
+	 * and then add that value to the file offset of this log page
+	 */
+	return final_log_off + data_len + page_off;
+}
+
+static int next_log_lsn(ntfs_log *log, const LFS_RECORD_HDR *rh, u64 *lsn)
+{
+	int err;
+	u64 this_lsn =3D le64_to_cpu(rh->this_lsn);
+	u32 vbo =3D lsn_to_vbo(log, this_lsn);
+	u32 end =3D
+		final_log_off(log, this_lsn, le32_to_cpu(rh->client_data_len));
+	u32 hdr_off =3D end & ~log->sys_page_mask;
+	u64 seq =3D this_lsn >> log->file_data_bits;
+	RECORD_PAGE_HDR *page =3D NULL;
+
+	/* Remember if we wrapped */
+	if (end <=3D vbo)
+		seq +=3D 1;
+
+	/* log page header for this page */
+	err =3D read_log_page(log, hdr_off, &page, false, false, NULL);
+	if (err)
+		return err;
+
+	/*
+	 * If the lsn we were given was not the last lsn on this page,
+	 * then the starting offset for the next lsn is on a quad word
+	 * boundary following the last file offset for the current lsn
+	 * Otherwise the file offset is the start of the data on the next page
+	 */
+	if (this_lsn =3D=3D le64_to_cpu(page->rhdr.lsn)) {
+		/* If we wrapped, we need to increment the sequence number */
+		hdr_off =3D next_page_off(log, hdr_off);
+		if (hdr_off =3D=3D log->first_page)
+			seq +=3D 1;
+
+		vbo =3D hdr_off + log->data_off;
+	} else {
+		vbo =3D QuadAlign(end);
+	}
+
+	/* Compute the lsn based on the file offset and the sequence count */
+	*lsn =3D vbo_to_lsn(log, vbo, seq);
+
+	/*
+	 * If this lsn is within the legal range for the file, we return true
+	 * Otherwise false indicates that there are no more lsn's
+	 */
+	if (!is_lsn_in_file(log, *lsn))
+		*lsn =3D 0;
+
+	ntfs_free(page);
+
+	return 0;
+}
+
+/*
+ * current_log_avail
+ *
+ * calculate the number of bytes available for log records
+ */
+static u32 current_log_avail(ntfs_log *log)
+{
+	u32 oldest_off, next_free_off, free_bytes;
+
+	if (log->l_flags & NTFSLOG_NO_LAST_LSN) {
+		/* The entire file is available */
+		return log->max_current_avail;
+	}
+
+	/*
+	 * If there is a last lsn the restart area then we know that we will
+	 * have to compute the free range
+	 * If there is no oldest lsn then start at the first page of the file
+	 */
+	oldest_off =3D (log->l_flags & NTFSLOG_NO_OLDEST_LSN) ?
+			     log->first_page :
+			     (log->oldest_lsn_off & ~log->sys_page_mask);
+
+	/*
+	 * We will use the next log page offset to compute the next free page\
+	 * If we are going to reuse this page go to the next page
+	 * If we are at the first page then use the end of the file
+	 */
+	next_free_off =3D (log->l_flags & NTFSLOG_REUSE_TAIL) ?
+				log->next_page + log->page_size :
+				log->next_page =3D=3D log->first_page ?
+				log->l_size :
+				log->next_page;
+
+	/* If the two offsets are the same then there is no available space */
+	if (oldest_off =3D=3D next_free_off)
+		return 0;
+	/*
+	 * If the free offset follows the oldest offset then subtract
+	 * this range from the total available pages
+	 */
+	free_bytes =3D
+		oldest_off < next_free_off ?
+			log->total_avail_pages - (next_free_off - oldest_off) :
+			oldest_off - next_free_off;
+
+	free_bytes >>=3D log->page_bits;
+	return free_bytes * log->reserved;
+}
+
+static bool check_subseq_log_page(ntfs_log *log, const RECORD_PAGE_HDR *rp=
,
+				  u32 vbo, u64 seq)
+{
+	u64 lsn_seq;
+	const NTFS_RECORD_HEADER *rhdr =3D &rp->rhdr;
+	u64 lsn =3D le64_to_cpu(rhdr->lsn);
+
+	if (rhdr->sign =3D=3D NTFS_FFFF_SIGNATURE || !rhdr->sign)
+		return false;
+
+	/*
+	 * If the last lsn on the page occurs was written after the page
+	 * that caused the original error then we have a fatal error
+	 */
+	lsn_seq =3D lsn >> log->file_data_bits;
+
+	/*
+	 * If the sequence number for the lsn the page is equal or greater
+	 * than lsn we expect, then this is a subsequent write
+	 */
+	return lsn_seq >=3D seq ||
+	       (lsn_seq =3D=3D seq - 1 && log->first_page =3D=3D vbo &&
+		vbo !=3D (lsn_to_vbo(log, lsn) & ~log->page_mask));
+}
+
+/*
+ * last_log_lsn
+ *
+ * This routine walks through the log pages for a file, searching for the
+ * last log page written to the file
+ */
+static int last_log_lsn(ntfs_log *log)
+{
+	int err;
+	bool usa_error =3D false;
+	bool replace_page =3D false;
+	bool reuse_page =3D log->l_flags & NTFSLOG_REUSE_TAIL;
+	bool wrapped_file, wrapped;
+
+	u32 page_cnt =3D 1, page_pos =3D 1;
+	u32 page_off =3D 0, page_off1 =3D 0, saved_off =3D 0;
+	u32 final_off, second_off, final_off_prev =3D 0, second_off_prev =3D 0;
+	u32 first_file_off =3D 0, second_file_off =3D 0;
+	u32 part_io_count =3D 0;
+	u32 tails =3D 0;
+	u32 this_off, curpage_off, nextpage_off, remain_pages;
+
+	u64 expected_seq, seq_base =3D 0, lsn_base =3D 0;
+	u64 best_lsn, best_lsn1, best_lsn2;
+	u64 lsn_cur, lsn1, lsn2;
+	u64 last_ok_lsn =3D reuse_page ? log->last_lsn : 0;
+
+	u16 cur_pos, best_page_pos;
+
+	RECORD_PAGE_HDR *page =3D NULL;
+	RECORD_PAGE_HDR *tst_page =3D NULL;
+	RECORD_PAGE_HDR *first_tail =3D NULL;
+	RECORD_PAGE_HDR *second_tail =3D NULL;
+	RECORD_PAGE_HDR *tail_page =3D NULL;
+	RECORD_PAGE_HDR *second_tail_prev =3D NULL, *first_tail_prev =3D NULL;
+	RECORD_PAGE_HDR *page_bufs =3D NULL;
+	RECORD_PAGE_HDR *best_page;
+
+	if (log->major_ver >=3D 2) {
+		final_off =3D 0x02 * log->page_size;
+		second_off =3D 0x12 * log->page_size;
+
+		// 0x10 =3D=3D 0x12 - 0x2
+		page_bufs =3D ntfs_alloc(log->page_size * 0x10, 0);
+		if (!page_bufs)
+			return -ENOMEM;
+	} else {
+		second_off =3D log->first_page - log->page_size;
+		final_off =3D second_off - log->page_size;
+	}
+
+next_tail:
+	/* Read second tail page (at pos 3/0x12000) */
+	if (read_log_page(log, second_off, &second_tail, true, true,
+			  &usa_error) ||
+	    usa_error || second_tail->rhdr.sign !=3D NTFS_RCRD_SIGNATURE) {
+		ntfs_free(second_tail);
+		second_tail =3D NULL;
+		second_file_off =3D 0;
+		lsn2 =3D 0;
+	} else {
+		second_file_off =3D hdr_file_off(log, second_tail);
+		lsn2 =3D le64_to_cpu(second_tail->record_hdr.last_end_lsn);
+	}
+
+	/* Read first tail page (at pos 2/0x2000 ) */
+	if (read_log_page(log, final_off, &first_tail, true, true,
+			  &usa_error) ||
+	    usa_error || first_tail->rhdr.sign !=3D NTFS_RCRD_SIGNATURE) {
+		ntfs_free(first_tail);
+		first_tail =3D NULL;
+		first_file_off =3D 0;
+		lsn1 =3D 0;
+	} else {
+		first_file_off =3D hdr_file_off(log, first_tail);
+		lsn1 =3D le64_to_cpu(first_tail->record_hdr.last_end_lsn);
+	}
+
+	if (log->major_ver < 2) {
+		int best_page;
+
+		first_tail_prev =3D first_tail;
+		final_off_prev =3D first_file_off;
+		second_tail_prev =3D second_tail;
+		second_off_prev =3D second_file_off;
+		tails =3D 1;
+
+		if (!first_tail && !second_tail)
+			goto tail_read;
+
+		if (first_tail && second_tail)
+			best_page =3D lsn1 < lsn2 ? 1 : 0;
+		else if (first_tail)
+			best_page =3D 0;
+		else
+			best_page =3D 1;
+
+		page_off =3D best_page ? second_file_off : first_file_off;
+		seq_base =3D (best_page ? lsn2 : lsn1) >> log->file_data_bits;
+		goto tail_read;
+	}
+
+	best_lsn1 =3D first_tail ? base_lsn(log, first_tail, first_file_off) : 0;
+	best_lsn2 =3D
+		second_tail ? base_lsn(log, second_tail, second_file_off) : 0;
+
+	if (first_tail && second_tail) {
+		if (best_lsn1 > best_lsn2) {
+			best_lsn =3D best_lsn1;
+			best_page =3D first_tail;
+			this_off =3D first_file_off;
+		} else {
+			best_lsn =3D best_lsn2;
+			best_page =3D second_tail;
+			this_off =3D second_file_off;
+		}
+	} else if (first_tail) {
+		best_lsn =3D best_lsn1;
+		best_page =3D first_tail;
+		this_off =3D first_file_off;
+	} else if (second_tail) {
+		best_lsn =3D best_lsn2;
+		best_page =3D second_tail;
+		this_off =3D second_file_off;
+	} else {
+		goto free_and_tail_read;
+	}
+
+	best_page_pos =3D le16_to_cpu(best_page->page_pos);
+
+	if (!tails) {
+		if (best_page_pos =3D=3D page_pos) {
+			seq_base =3D best_lsn >> log->file_data_bits;
+			saved_off =3D page_off =3D le32_to_cpu(best_page->file_off);
+			lsn_base =3D best_lsn;
+
+			memmove(page_bufs, best_page, log->page_size);
+
+			page_cnt =3D le16_to_cpu(best_page->page_count);
+			if (page_cnt > 1)
+				page_pos +=3D 1;
+
+			tails =3D 1;
+		}
+	} else if (seq_base =3D=3D (best_lsn >> log->file_data_bits) &&
+		   saved_off + log->page_size =3D=3D this_off &&
+		   lsn_base < best_lsn &&
+		   (page_pos !=3D page_cnt || best_page_pos =3D=3D page_pos ||
+		    best_page_pos =3D=3D 1) &&
+		   (page_pos >=3D page_cnt || best_page_pos =3D=3D page_pos)) {
+		u16 bppc =3D le16_to_cpu(best_page->page_count);
+
+		saved_off +=3D log->page_size;
+		lsn_base =3D best_lsn;
+
+		memmove(Add2Ptr(page_bufs, tails * log->page_size), best_page,
+			log->page_size);
+
+		tails +=3D 1;
+
+		if (best_page_pos !=3D bppc) {
+			page_cnt =3D bppc;
+			page_pos =3D best_page_pos;
+
+			if (page_cnt > 1)
+				page_pos +=3D 1;
+		} else {
+			page_pos =3D page_cnt =3D 1;
+		}
+	} else {
+free_and_tail_read:
+		ntfs_free(first_tail);
+		ntfs_free(second_tail);
+		goto tail_read;
+	}
+
+	ntfs_free(first_tail_prev);
+	first_tail_prev =3D first_tail;
+	final_off_prev =3D first_file_off;
+	first_tail =3D NULL;
+
+	ntfs_free(second_tail_prev);
+	second_tail_prev =3D second_tail;
+	second_off_prev =3D second_file_off;
+	second_tail =3D NULL;
+
+	final_off +=3D log->page_size;
+	second_off +=3D log->page_size;
+
+	if (tails < 0x10)
+		goto next_tail;
+tail_read:
+	first_tail =3D first_tail_prev;
+	final_off =3D final_off_prev;
+
+	second_tail =3D second_tail_prev;
+	second_off =3D second_off_prev;
+
+	page_cnt =3D page_pos =3D 1;
+
+	curpage_off =3D seq_base =3D=3D log->seq_num ? min(log->next_page, page_o=
ff) :
+						 log->next_page;
+
+	wrapped_file =3D
+		curpage_off =3D=3D log->first_page &&
+		!(log->l_flags & (NTFSLOG_NO_LAST_LSN | NTFSLOG_REUSE_TAIL));
+
+	expected_seq =3D wrapped_file ? (log->seq_num + 1) : log->seq_num;
+
+	nextpage_off =3D curpage_off;
+
+next_page:
+	tail_page =3D NULL;
+	/* Read the next log page, allowing errors */
+	err =3D read_log_page(log, curpage_off, &page, true, true, &usa_error);
+
+	/* Compute the next log page offset the file */
+	nextpage_off =3D next_page_off(log, curpage_off);
+	wrapped =3D nextpage_off =3D=3D log->first_page;
+
+	if (tails > 1) {
+		RECORD_PAGE_HDR *cur_page =3D
+			Add2Ptr(page_bufs, curpage_off - page_off);
+
+		if (curpage_off =3D=3D saved_off) {
+			tail_page =3D cur_page;
+			goto use_tail_page;
+		}
+
+		if (page_off > curpage_off || curpage_off >=3D saved_off)
+			goto use_tail_page;
+
+		if (page_off1)
+			goto use_cur_page;
+
+		if (!err && !usa_error &&
+		    page->rhdr.sign =3D=3D NTFS_RCRD_SIGNATURE &&
+		    cur_page->rhdr.lsn =3D=3D page->rhdr.lsn &&
+		    cur_page->record_hdr.next_record_off =3D=3D
+			    page->record_hdr.next_record_off &&
+		    ((page_pos =3D=3D page_cnt &&
+		      le16_to_cpu(page->page_pos) =3D=3D 1) ||
+		     (page_pos !=3D page_cnt &&
+		      le16_to_cpu(page->page_pos) =3D=3D page_pos + 1 &&
+		      le16_to_cpu(page->page_count) =3D=3D page_cnt))) {
+			cur_page =3D NULL;
+			goto use_tail_page;
+		}
+
+		page_off1 =3D page_off;
+
+use_cur_page:
+
+		lsn_cur =3D le64_to_cpu(cur_page->rhdr.lsn);
+
+		if (last_ok_lsn !=3D
+			    le64_to_cpu(cur_page->record_hdr.last_end_lsn) &&
+		    ((lsn_cur >> log->file_data_bits) +
+		     ((curpage_off <
+		       (lsn_to_vbo(log, lsn_cur) & ~log->page_mask)) ?
+			      1 :
+			      0)) !=3D expected_seq) {
+			goto check_tail;
+		}
+
+		if (!is_log_record_end(cur_page)) {
+			tail_page =3D NULL;
+			last_ok_lsn =3D lsn_cur;
+			goto next_page_1;
+		}
+
+		log->seq_num =3D expected_seq;
+		log->l_flags &=3D ~NTFSLOG_NO_LAST_LSN;
+		log->last_lsn =3D le64_to_cpu(cur_page->record_hdr.last_end_lsn);
+		log->ra->current_lsn =3D cur_page->record_hdr.last_end_lsn;
+
+		if (log->record_header_len <=3D
+		    log->page_size -
+			    le16_to_cpu(cur_page->record_hdr.next_record_off)) {
+			log->l_flags |=3D NTFSLOG_REUSE_TAIL;
+			log->next_page =3D curpage_off;
+		} else {
+			log->l_flags &=3D ~NTFSLOG_REUSE_TAIL;
+			log->next_page =3D nextpage_off;
+		}
+
+		if (wrapped_file)
+			log->l_flags |=3D NTFSLOG_WRAPPED;
+
+		last_ok_lsn =3D le64_to_cpu(cur_page->record_hdr.last_end_lsn);
+		goto next_page_1;
+	}
+
+	/*
+	 * If we are at the expected first page of a transfer check to see
+	 * if either tail copy is at this offset
+	 * If this page is the last page of a transfer, check if we wrote
+	 * a subsequent tail copy
+	 */
+	if (page_cnt =3D=3D page_pos || page_cnt =3D=3D page_pos + 1) {
+		/*
+		 * Check if the offset matches either the first or second
+		 * tail copy. It is possible it will match both
+		 */
+		if (curpage_off =3D=3D final_off)
+			tail_page =3D first_tail;
+
+		/*
+		 * If we already matched on the first page then
+		 * check the ending lsn's.
+		 */
+		if (curpage_off =3D=3D second_off) {
+			if (!tail_page ||
+			    (second_tail &&
+			     le64_to_cpu(second_tail->record_hdr.last_end_lsn) >
+				     le64_to_cpu(first_tail->record_hdr
+							 .last_end_lsn))) {
+				tail_page =3D second_tail;
+			}
+		}
+	}
+
+use_tail_page:
+	if (tail_page) {
+		/* we have a candidate for a tail copy */
+		lsn_cur =3D le64_to_cpu(tail_page->record_hdr.last_end_lsn);
+
+		if (last_ok_lsn < lsn_cur) {
+			/*
+			 * If the sequence number is not expected,
+			 * then don't use the tail copy
+			 */
+			if (expected_seq !=3D (lsn_cur >> log->file_data_bits))
+				tail_page =3D NULL;
+		} else if (last_ok_lsn > lsn_cur) {
+			/*
+			 * If the last lsn is greater than the one on
+			 * this page then forget this tail
+			 */
+			tail_page =3D NULL;
+		}
+	}
+
+	/* If we have an error on the current page, we will break of this loop */
+	if (err || usa_error)
+		goto check_tail;
+
+	/*
+	 * Done if the last lsn on this page doesn't match the previous known
+	 * last lsn or the sequence number is not expected
+	 */
+	lsn_cur =3D le64_to_cpu(page->rhdr.lsn);
+	if (last_ok_lsn !=3D lsn_cur &&
+	    expected_seq !=3D (lsn_cur >> log->file_data_bits)) {
+		goto check_tail;
+	}
+
+	/*
+	 * Check that the page position and page count values are correct
+	 * If this is the first page of a transfer the position must be 1
+	 * and the count will be unknown
+	 */
+	if (page_cnt =3D=3D page_pos) {
+		if (page->page_pos !=3D cpu_to_le16(1) &&
+		    (!reuse_page || page->page_pos !=3D page->page_count)) {
+			/*
+			 * If the current page is the first page we are
+			 * looking at and we are reusing this page then
+			 * it can be either the first or last page of a
+			 * transfer. Otherwise it can only be the first.
+			 */
+			goto check_tail;
+		}
+	} else if (le16_to_cpu(page->page_count) !=3D page_cnt ||
+		   le16_to_cpu(page->page_pos) !=3D page_pos + 1) {
+		/*
+		 * The page position better be 1 more than the last page
+		 * position and the page count better match
+		 */
+		goto check_tail;
+	}
+
+	/*
+	 * We have a valid page the file and may have a valid page
+	 * the tail copy area
+	 * If the tail page was written after the page the file then
+	 * break of the loop
+	 */
+	if (tail_page &&
+	    le64_to_cpu(tail_page->record_hdr.last_end_lsn) > lsn_cur) {
+		/* Remember if we will replace the page */
+		replace_page =3D true;
+		goto check_tail;
+	}
+
+	tail_page =3D NULL;
+
+	if (is_log_record_end(page)) {
+		/*
+		 * Since we have read this page we know the sequence number
+		 * is the same as our expected value
+		 */
+		log->seq_num =3D expected_seq;
+		log->last_lsn =3D le64_to_cpu(page->record_hdr.last_end_lsn);
+		log->ra->current_lsn =3D page->record_hdr.last_end_lsn;
+		log->l_flags &=3D ~NTFSLOG_NO_LAST_LSN;
+
+		/*
+		 * If there is room on this page for another header then
+		 * remember we want to reuse the page
+		 */
+		if (log->record_header_len <=3D
+		    log->page_size -
+			    le16_to_cpu(page->record_hdr.next_record_off)) {
+			log->l_flags |=3D NTFSLOG_REUSE_TAIL;
+			log->next_page =3D curpage_off;
+		} else {
+			log->l_flags &=3D ~NTFSLOG_REUSE_TAIL;
+			log->next_page =3D nextpage_off;
+		}
+
+		/* Remember if we wrapped the log file */
+		if (wrapped_file)
+			log->l_flags |=3D NTFSLOG_WRAPPED;
+	}
+
+	/*
+	 * Remember the last page count and position.
+	 * Also remember the last known lsn
+	 */
+	page_cnt =3D le16_to_cpu(page->page_count);
+	page_pos =3D le16_to_cpu(page->page_pos);
+	last_ok_lsn =3D le64_to_cpu(page->rhdr.lsn);
+
+next_page_1:
+
+	if (wrapped) {
+		expected_seq +=3D 1;
+		wrapped_file =3D 1;
+	}
+
+	curpage_off =3D nextpage_off;
+	ntfs_free(page);
+	page =3D NULL;
+	reuse_page =3D 0;
+	goto next_page;
+
+check_tail:
+	if (tail_page) {
+		log->seq_num =3D expected_seq;
+		log->last_lsn =3D le64_to_cpu(tail_page->record_hdr.last_end_lsn);
+		log->ra->current_lsn =3D tail_page->record_hdr.last_end_lsn;
+		log->l_flags &=3D ~NTFSLOG_NO_LAST_LSN;
+
+		if (log->page_size -
+			    le16_to_cpu(
+				    tail_page->record_hdr.next_record_off) >=3D
+		    log->record_header_len) {
+			log->l_flags |=3D NTFSLOG_REUSE_TAIL;
+			log->next_page =3D curpage_off;
+		} else {
+			log->l_flags &=3D ~NTFSLOG_REUSE_TAIL;
+			log->next_page =3D nextpage_off;
+		}
+
+		if (wrapped)
+			log->l_flags |=3D NTFSLOG_WRAPPED;
+	}
+
+	/* Remember that the partial IO will start at the next page */
+	second_off =3D nextpage_off;
+
+	/*
+	 * If the next page is the first page of the file then update
+	 * the sequence number for log records which begon the next page
+	 */
+	if (wrapped)
+		expected_seq +=3D 1;
+
+	/*
+	 * If we have a tail copy or are performing single page I/O we can
+	 * immediately look at the next page
+	 */
+	if (replace_page || (log->ra->flags & RESTART_SINGLE_PAGE_IO)) {
+		page_cnt =3D 2;
+		page_pos =3D 1;
+		goto check_valid;
+	}
+
+	if (page_pos !=3D page_cnt)
+		goto check_valid;
+	/*
+	 * If the next page causes us to wrap to the beginning of the log
+	 * file then we know which page to check next.
+	 */
+	if (wrapped) {
+		page_cnt =3D 2;
+		page_pos =3D 1;
+		goto check_valid;
+	}
+
+	cur_pos =3D 2;
+
+next_test_page:
+	ntfs_free(tst_page);
+	tst_page =3D NULL;
+
+	/* Walk through the file, reading log pages */
+	err =3D read_log_page(log, nextpage_off, &tst_page, 1, 1, &usa_error);
+
+	/*
+	 * If we get a USA error then assume that we correctly found
+	 * the end of the original transfer
+	 */
+	if (usa_error)
+		goto file_is_valid;
+
+	/*
+	 * If we were able to read the page, we examine it to see if it
+	 * is the same or different Io block
+	 */
+	if (err)
+		goto next_test_page_1;
+
+	if (le16_to_cpu(tst_page->page_pos) =3D=3D cur_pos &&
+	    check_subseq_log_page(log, tst_page, nextpage_off, expected_seq)) {
+		page_cnt =3D le16_to_cpu(tst_page->page_count) + 1;
+		page_pos =3D le16_to_cpu(tst_page->page_pos);
+		goto check_valid;
+	} else {
+		goto file_is_valid;
+	}
+
+next_test_page_1:
+
+	nextpage_off =3D next_page_off(log, curpage_off);
+	wrapped =3D nextpage_off =3D=3D log->first_page;
+
+	if (wrapped) {
+		expected_seq +=3D 1;
+		page_cnt =3D 2;
+		page_pos =3D 1;
+	}
+
+	cur_pos +=3D 1;
+	part_io_count +=3D 1;
+	if (!wrapped)
+		goto next_test_page;
+
+check_valid:
+	/* Skip over the remaining pages this transfer */
+	remain_pages =3D page_cnt - page_pos - 1;
+	part_io_count +=3D remain_pages;
+
+	while (remain_pages--) {
+		nextpage_off =3D next_page_off(log, curpage_off);
+		wrapped =3D nextpage_off =3D=3D log->first_page;
+
+		if (wrapped)
+			expected_seq +=3D 1;
+	}
+
+	/* Call our routine to check this log page */
+	ntfs_free(tst_page);
+	tst_page =3D NULL;
+
+	err =3D read_log_page(log, nextpage_off, &tst_page, true, true,
+			    &usa_error);
+	if (!err && !usa_error &&
+	    check_subseq_log_page(log, tst_page, nextpage_off, expected_seq)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+file_is_valid:
+
+	/* We have a valid file */
+	if (page_off1 || tail_page) {
+		RECORD_PAGE_HDR *tmp_page;
+
+		if (sb_rdonly(log->ni->mi.sbi->sb)) {
+			err =3D -EROFS;
+			goto out;
+		}
+
+		if (page_off1) {
+			tmp_page =3D Add2Ptr(page_bufs, page_off1 - page_off);
+			tails -=3D (page_off1 - page_off) / log->page_size;
+			if (!tail_page)
+				tails -=3D 1;
+		} else {
+			tmp_page =3D tail_page;
+			tails =3D 1;
+		}
+
+		while (tails--) {
+			u64 off =3D hdr_file_off(log, tmp_page);
+
+			if (!page) {
+				page =3D ntfs_alloc(log->page_size, 0);
+				if (!page)
+					return -ENOMEM;
+			}
+
+			/*
+			 * Correct page and copy the data from this page
+			 * into it and flush it to disk
+			 */
+			memcpy(page, tmp_page, log->page_size);
+
+			/* Fill last flushed lsn value flush the page */
+			if (log->major_ver < 2)
+				page->rhdr.lsn =3D page->record_hdr.last_end_lsn;
+			else
+				page->file_off =3D 0;
+
+			page->page_pos =3D page->page_count =3D cpu_to_le16(1);
+
+			ntfs_fix_pre_write(&page->rhdr, log->page_size);
+
+			err =3D ntfs_sb_write_run(log->ni->mi.sbi,
+						&log->ni->file.run, off, page,
+						log->page_size);
+
+			if (err)
+				goto out;
+
+			if (part_io_count && second_off =3D=3D off) {
+				second_off +=3D log->page_size;
+				part_io_count -=3D 1;
+			}
+
+			tmp_page =3D Add2Ptr(tmp_page, log->page_size);
+		}
+	}
+
+	if (part_io_count) {
+		if (sb_rdonly(log->ni->mi.sbi->sb)) {
+			err =3D -EROFS;
+			goto out;
+		}
+	}
+
+out:
+
+	ntfs_free(second_tail);
+	ntfs_free(first_tail);
+	ntfs_free(page);
+	ntfs_free(tst_page);
+	ntfs_free(page_bufs);
+
+	return err;
+}
+
+/*
+ * read_log_rec_buf
+ *
+ * copies a log record from the file to a buffer
+ * The log record may span several log pages and may even wrap the file
+ */
+static int read_log_rec_buf(ntfs_log *log, const LFS_RECORD_HDR *rh,
+			    void *buffer)
+{
+	int err;
+	RECORD_PAGE_HDR *ph =3D NULL;
+	u64 lsn =3D le64_to_cpu(rh->this_lsn);
+	u32 vbo =3D lsn_to_vbo(log, lsn) & ~log->page_mask;
+	u32 off =3D lsn_to_page_off(log, lsn) + log->record_header_len;
+	u32 data_len =3D le32_to_cpu(rh->client_data_len);
+
+	/*
+	 * While there are more bytes to transfer,
+	 * we continue to attempt to perform the read
+	 */
+	for (;;) {
+		u32 tail =3D log->page_size - off;
+
+		if (tail >=3D data_len)
+			tail =3D data_len;
+
+		data_len -=3D tail;
+
+		err =3D read_log_page(log, vbo, &ph, false, true, NULL);
+		if (err)
+			goto out;
+
+		/*
+		 * The last lsn on this page better be greater or equal
+		 * to the lsn we are copying
+		 */
+		if (lsn > le64_to_cpu(ph->rhdr.lsn)) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		memcpy(buffer, Add2Ptr(ph, off), tail);
+
+		/* If there are no more bytes to transfer, we exit the loop */
+		if (!data_len) {
+			if (!is_log_record_end(ph) ||
+			    lsn > le64_to_cpu(ph->record_hdr.last_end_lsn)) {
+				err =3D -EINVAL;
+				goto out;
+			}
+			break;
+		}
+
+		if (ph->rhdr.lsn =3D=3D ph->record_hdr.last_end_lsn ||
+		    lsn > le64_to_cpu(ph->rhdr.lsn)) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		vbo =3D next_page_off(log, vbo);
+		off =3D log->data_off;
+
+		/*
+		 * adjust our pointer the user's buffer to transfer
+		 * the next block to
+		 */
+		buffer =3D Add2Ptr(buffer, tail);
+	}
+
+out:
+	ntfs_free(ph);
+	return err;
+}
+
+static int read_rst_area(ntfs_log *log, NTFS_RESTART **rst_, u64 *lsn)
+{
+	int err;
+	LFS_RECORD_HDR *rh =3D NULL;
+	const CLIENT_REC *cr =3D
+		Add2Ptr(log->ra, le16_to_cpu(log->ra->client_off));
+	u64 lsnr, lsnc =3D le64_to_cpu(cr->restart_lsn);
+	u32 len;
+	NTFS_RESTART *rst;
+
+	*lsn =3D 0;
+	*rst_ =3D NULL;
+
+	/* If the client doesn't have a restart area, go ahead and exit now */
+	if (!lsnc)
+		return 0;
+
+	err =3D read_log_page(log, lsn_to_vbo(log, lsnc), (RECORD_PAGE_HDR **)&rh=
,
+			    false, false, NULL);
+	if (err)
+		return err;
+
+	rst =3D NULL;
+	lsnr =3D le64_to_cpu(rh->this_lsn);
+
+	if (lsnc !=3D lsnr) {
+		/* If the lsn values don't match, then the disk is corrupt */
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	*lsn =3D lsnr;
+	len =3D le32_to_cpu(rh->client_data_len);
+
+	if (!len) {
+		err =3D 0;
+		goto out;
+	}
+
+	if (len < sizeof(NTFS_RESTART)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	rst =3D ntfs_alloc(len, 0);
+	if (!rst) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	/* Copy the data into the 'rst' buffer */
+	err =3D read_log_rec_buf(log, rh, rst);
+	if (err)
+		goto out;
+
+	*rst_ =3D rst;
+	rst =3D NULL;
+
+out:
+	ntfs_free(rh);
+	ntfs_free(rst);
+
+	return err;
+}
+
+static int find_log_rec(ntfs_log *log, u64 lsn, LCB *lcb)
+{
+	int err;
+	LFS_RECORD_HDR *rh =3D lcb->lrh;
+	u32 rec_len, len;
+
+	/* Read the record header for this lsn */
+	if (!rh) {
+		err =3D read_log_page(log, lsn_to_vbo(log, lsn),
+				    (RECORD_PAGE_HDR **)&rh, false, false,
+				    NULL);
+
+		lcb->lrh =3D rh;
+		if (err)
+			return err;
+	}
+
+	/*
+	 * If the lsn the log record doesn't match the desired
+	 * lsn then the disk is corrupt
+	 */
+	if (lsn !=3D le64_to_cpu(rh->this_lsn))
+		return -EINVAL;
+
+	len =3D le32_to_cpu(rh->client_data_len);
+
+	/*
+	 * check that the length field isn't greater than the total
+	 * available space the log file
+	 */
+	rec_len =3D len + log->record_header_len;
+	if (rec_len >=3D log->total_avail)
+		return -EINVAL;
+
+	/*
+	 * If the entire log record is on this log page,
+	 * put a pointer to the log record the context block
+	 */
+	if (rh->flags & LOG_RECORD_MULTI_PAGE) {
+		void *lr =3D ntfs_alloc(len, 0);
+
+		if (!lr)
+			return -ENOMEM;
+
+		lcb->log_rec =3D lr;
+		lcb->alloc =3D true;
+
+		/* Copy the data into the buffer returned */
+		err =3D read_log_rec_buf(log, rh, lr);
+		if (err)
+			return err;
+	} else {
+		/* If beyond the end of the current page -> an error */
+		u32 page_off =3D lsn_to_page_off(log, lsn);
+
+		if (page_off + len + log->record_header_len > log->page_size)
+			return -EINVAL;
+
+		lcb->log_rec =3D Add2Ptr(rh, sizeof(LFS_RECORD_HDR));
+		lcb->alloc =3D false;
+	}
+
+	return 0;
+}
+
+/*
+ * read_log_rec_lcb
+ *
+ * initiates the query operation.
+ */
+static int read_log_rec_lcb(ntfs_log *log, u64 lsn, u32 ctx_mode, LCB **lc=
b_)
+{
+	int err;
+	const CLIENT_REC *cr;
+	LCB *lcb;
+
+	switch (ctx_mode) {
+	case lcb_ctx_undo_next:
+	case lcb_ctx_prev:
+	case lcb_ctx_next:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* check that the given lsn is the legal range for this client */
+	cr =3D Add2Ptr(log->ra, le16_to_cpu(log->ra->client_off));
+
+	if (!verify_client_lsn(log, cr, lsn))
+		return -EINVAL;
+
+	lcb =3D ntfs_alloc(sizeof(LCB), 1);
+	if (!lcb)
+		return -ENOMEM;
+	lcb->client =3D log->client_id;
+	lcb->ctx_mode =3D ctx_mode;
+
+	/* Find the log record indicated by the given lsn */
+	err =3D find_log_rec(log, lsn, lcb);
+	if (err)
+		goto out;
+
+	*lcb_ =3D lcb;
+	return 0;
+
+out:
+	lcb_put(lcb);
+	*lcb_ =3D NULL;
+	return err;
+}
+
+/*
+ * find_client_next_lsn
+ *
+ * attempt to find the next lsn to return to a client based on the context=
 mode.
+ */
+static int find_client_next_lsn(ntfs_log *log, LCB *lcb, u64 *lsn)
+{
+	int err;
+	u64 next_lsn;
+	LFS_RECORD_HDR *hdr;
+
+	hdr =3D lcb->lrh;
+	*lsn =3D 0;
+
+	if (lcb_ctx_next !=3D lcb->ctx_mode)
+		goto check_undo_next;
+
+	/* Loop as long as another lsn can be found */
+	for (;;) {
+		u64 current_lsn;
+
+		err =3D next_log_lsn(log, hdr, &current_lsn);
+		if (err)
+			goto out;
+
+		if (!current_lsn)
+			break;
+
+		if (hdr !=3D lcb->lrh)
+			ntfs_free(hdr);
+
+		hdr =3D NULL;
+		err =3D read_log_page(log, lsn_to_vbo(log, current_lsn),
+				    (RECORD_PAGE_HDR **)&hdr, false, false,
+				    NULL);
+		if (err)
+			goto out;
+
+		if (memcmp(&hdr->client, &lcb->client, sizeof(CLIENT_ID))) {
+			/*err =3D -EINVAL; */
+		} else if (LfsClientRecord =3D=3D hdr->record_type) {
+			ntfs_free(lcb->lrh);
+			lcb->lrh =3D hdr;
+			*lsn =3D current_lsn;
+			return 0;
+		}
+	}
+
+out:
+	if (hdr !=3D lcb->lrh)
+		ntfs_free(hdr);
+	return err;
+
+check_undo_next:
+	if (lcb_ctx_undo_next =3D=3D lcb->ctx_mode)
+		next_lsn =3D le64_to_cpu(hdr->client_undo_next_lsn);
+	else if (lcb_ctx_prev =3D=3D lcb->ctx_mode)
+		next_lsn =3D le64_to_cpu(hdr->client_prev_lsn);
+	else
+		return 0;
+
+	if (!next_lsn)
+		return 0;
+
+	if (!verify_client_lsn(
+		    log, Add2Ptr(log->ra, le16_to_cpu(log->ra->client_off)),
+		    next_lsn))
+		return 0;
+
+	hdr =3D NULL;
+	err =3D read_log_page(log, lsn_to_vbo(log, next_lsn),
+			    (RECORD_PAGE_HDR **)&hdr, false, false, NULL);
+	if (err)
+		return err;
+	ntfs_free(lcb->lrh);
+	lcb->lrh =3D hdr;
+
+	*lsn =3D next_lsn;
+
+	return 0;
+}
+
+static int read_next_log_rec(ntfs_log *log, LCB *lcb, u64 *lsn)
+{
+	int err;
+
+	err =3D find_client_next_lsn(log, lcb, lsn);
+	if (err)
+		return err;
+
+	if (!*lsn)
+		return 0;
+
+	if (lcb->alloc)
+		ntfs_free(lcb->log_rec);
+
+	lcb->log_rec =3D NULL;
+	lcb->alloc =3D false;
+	ntfs_free(lcb->lrh);
+	lcb->lrh =3D NULL;
+
+	return find_log_rec(log, *lsn, lcb);
+}
+
+static inline bool check_index_header(const INDEX_HDR *hdr, size_t bytes)
+{
+	__le16 mask;
+	u32 min_de, de_off, used, total;
+	const NTFS_DE *e;
+
+	if (hdr_has_subnode(hdr)) {
+		min_de =3D sizeof(NTFS_DE) + sizeof(u64);
+		mask =3D NTFS_IE_HAS_SUBNODES;
+	} else {
+		min_de =3D sizeof(NTFS_DE);
+		mask =3D 0;
+	}
+
+	de_off =3D le32_to_cpu(hdr->de_off);
+	used =3D le32_to_cpu(hdr->used);
+	total =3D le32_to_cpu(hdr->total);
+
+	if (de_off > bytes - min_de || used > bytes || total > bytes ||
+	    de_off + min_de > used || used > total) {
+		return false;
+	}
+
+	e =3D Add2Ptr(hdr, de_off);
+	for (;;) {
+		u16 esize =3D le16_to_cpu(e->size);
+		NTFS_DE *next =3D Add2Ptr(e, esize);
+
+		if (esize < min_de || PtrOffset(hdr, next) > used ||
+		    (e->flags & NTFS_IE_HAS_SUBNODES) !=3D mask) {
+			return false;
+		}
+
+		if (de_is_last(e))
+			break;
+
+		e =3D next;
+	}
+
+	return true;
+}
+
+static inline bool check_index_buffer(const INDEX_BUFFER *ib, u32 bytes)
+{
+	u16 fo;
+	const NTFS_RECORD_HEADER *r =3D &ib->rhdr;
+
+	if (r->sign !=3D NTFS_INDX_SIGNATURE)
+		return false;
+
+	fo =3D (SECTOR_SIZE - ((bytes >> SECTOR_SHIFT) + 1) * sizeof(short));
+
+	if (le16_to_cpu(r->fix_off) > fo)
+		return false;
+
+	if ((le16_to_cpu(r->fix_num) - 1) * SECTOR_SIZE !=3D bytes)
+		return false;
+
+	return check_index_header(&ib->ihdr,
+				  bytes - offsetof(INDEX_BUFFER, ihdr));
+}
+
+static inline bool check_index_root(const ATTRIB *attr, ntfs_sb_info *sbi)
+{
+	bool ret;
+	const INDEX_ROOT *root =3D resident_data(attr);
+	u8 index_bits =3D
+		le32_to_cpu(root->index_block_size) >=3D sbi->cluster_size ?
+			sbi->cluster_bits :
+			SECTOR_SHIFT;
+	u8 block_clst =3D root->index_block_clst;
+
+	if (le32_to_cpu(attr->res.data_size) < sizeof(INDEX_ROOT) ||
+	    (root->type !=3D ATTR_NAME && root->type !=3D ATTR_ZERO) ||
+	    (root->type =3D=3D ATTR_NAME &&
+	     root->rule !=3D NTFS_COLLATION_TYPE_FILENAME) ||
+	    (le32_to_cpu(root->index_block_size) !=3D
+	     (block_clst << index_bits)) ||
+	    (block_clst !=3D 1 && block_clst !=3D 2 && block_clst !=3D 4 &&
+	     block_clst !=3D 8 && block_clst !=3D 0x10 && block_clst !=3D 0x20 &&
+	     block_clst !=3D 0x40 && block_clst !=3D 0x80)) {
+		return false;
+	}
+
+	ret =3D check_index_header(&root->ihdr,
+				 le32_to_cpu(attr->res.data_size) -
+					 offsetof(INDEX_ROOT, ihdr));
+	return ret;
+}
+
+static inline bool check_attr(const MFT_REC *rec, const ATTRIB *attr,
+			      ntfs_sb_info *sbi)
+{
+	u32 asize =3D le32_to_cpu(attr->size);
+	u32 rsize =3D 0;
+
+	/* Check the fixed part of the attribute record header */
+	if (asize >=3D sbi->record_size ||
+	    asize + PtrOffset(rec, attr) >=3D sbi->record_size ||
+	    (attr->name_len &&
+	     le16_to_cpu(attr->name_off) + attr->name_len * sizeof(short) >
+		     asize)) {
+		return false;
+	}
+
+	/* Check the attribute fields */
+	if (!attr->non_res) {
+		rsize =3D le32_to_cpu(attr->res.data_size);
+		if (rsize >=3D asize ||
+		    le16_to_cpu(attr->res.data_off) + rsize > asize) {
+			return false;
+		}
+	} else if (attr->non_res =3D=3D 1) {
+		u64 dsize =3D le64_to_cpu(attr->nres.data_size);
+		u64 svcn =3D le64_to_cpu(attr->nres.svcn);
+		u64 evcn =3D le64_to_cpu(attr->nres.evcn);
+		u16 run_off =3D le16_to_cpu(attr->nres.run_off);
+
+		if (svcn > evcn + 1 || run_off >=3D asize ||
+		    le64_to_cpu(attr->nres.valid_size) > dsize ||
+		    dsize > le64_to_cpu(attr->nres.alloc_size)) {
+			return false;
+		}
+
+		if (run_unpack(NULL, sbi, 0, svcn, evcn, Add2Ptr(attr, run_off),
+			       asize - run_off) < 0) {
+			return false;
+		}
+
+		return true;
+	} else {
+		return false;
+	}
+
+	switch (attr->type) {
+	case ATTR_NAME:
+		if (fname_full_size(Add2Ptr(
+			    attr, le16_to_cpu(attr->res.data_off))) > asize) {
+			return false;
+		}
+		break;
+
+	case ATTR_ROOT:
+		return check_index_root(attr, sbi);
+
+	case ATTR_STD:
+		if (rsize < sizeof(ATTR_STD_INFO5) &&
+		    rsize !=3D sizeof(ATTR_STD_INFO)) {
+			return false;
+		}
+		break;
+
+	case ATTR_LIST:
+	case ATTR_ID:
+	case ATTR_SECURE:
+	case ATTR_LABEL:
+	case ATTR_VOL_INFO:
+	case ATTR_DATA:
+	case ATTR_ALLOC:
+	case ATTR_BITMAP:
+	case ATTR_REPARSE:
+	case ATTR_EA_INFO:
+	case ATTR_EA:
+	case ATTR_PROPERTYSET:
+	case ATTR_LOGGED_UTILITY_STREAM:
+		break;
+
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static inline bool check_file_record(const MFT_REC *rec, const MFT_REC *re=
c2,
+				     ntfs_sb_info *sbi)
+{
+	const ATTRIB *attr;
+	u16 fo =3D le16_to_cpu(rec->rhdr.fix_off);
+	u16 fn =3D le16_to_cpu(rec->rhdr.fix_num);
+	u16 ao =3D le16_to_cpu(rec->attr_off);
+	u32 rs =3D sbi->record_size;
+
+	/* check the file record header for consistency */
+	if (rec->rhdr.sign !=3D NTFS_FILE_SIGNATURE ||
+	    fo > (SECTOR_SIZE - ((rs >> SECTOR_SHIFT) + 1) * sizeof(short)) ||
+	    (fn - 1) * SECTOR_SIZE !=3D rs || ao < MFTRECORD_FIXUP_OFFSET_1 ||
+	    ao > sbi->record_size - SIZEOF_RESIDENT || !is_rec_inuse(rec) ||
+	    le32_to_cpu(rec->total) !=3D rs) {
+		return false;
+	}
+
+	/* Loop to check all of the attributes */
+	for (attr =3D Add2Ptr(rec, ao); attr->type !=3D ATTR_END;
+	     attr =3D Add2Ptr(attr, le32_to_cpu(attr->size))) {
+		if (check_attr(rec, attr, sbi))
+			continue;
+		return false;
+	}
+
+	return true;
+}
+
+static inline int check_lsn(const NTFS_RECORD_HEADER *hdr, const u64 *rlsn=
)
+{
+	u64 lsn;
+
+	if (!rlsn)
+		return true;
+
+	lsn =3D le64_to_cpu(hdr->lsn);
+
+	if (hdr->sign =3D=3D NTFS_HOLE_SIGNATURE)
+		return false;
+
+	if (*rlsn > lsn)
+		return true;
+
+	return false;
+}
+
+static inline bool check_if_attr(const MFT_REC *rec, const LOG_REC_HDR *lr=
h)
+{
+	u16 ro =3D le16_to_cpu(lrh->record_off);
+	u16 o =3D le16_to_cpu(rec->attr_off);
+	const ATTRIB *attr =3D Add2Ptr(rec, o);
+
+	while (o < ro) {
+		u32 asize;
+
+		if (attr->type =3D=3D ATTR_END)
+			break;
+
+		asize =3D le32_to_cpu(attr->size);
+		if (!asize)
+			break;
+
+		o +=3D asize;
+		attr =3D Add2Ptr(attr, asize);
+	}
+
+	return o =3D=3D ro;
+}
+
+static inline bool check_if_index_root(const MFT_REC *rec,
+				       const LOG_REC_HDR *lrh)
+{
+	u16 ro =3D le16_to_cpu(lrh->record_off);
+	u16 o =3D le16_to_cpu(rec->attr_off);
+	const ATTRIB *attr =3D Add2Ptr(rec, o);
+
+	while (o < ro) {
+		u32 asize;
+
+		if (attr->type =3D=3D ATTR_END)
+			break;
+
+		asize =3D le32_to_cpu(attr->size);
+		if (!asize)
+			break;
+
+		o +=3D asize;
+		attr =3D Add2Ptr(attr, asize);
+	}
+
+	return o =3D=3D ro && attr->type =3D=3D ATTR_ROOT;
+}
+
+static inline bool check_if_root_index(const ATTRIB *attr, const INDEX_HDR=
 *hdr,
+				       const LOG_REC_HDR *lrh)
+{
+	u16 ao =3D le16_to_cpu(lrh->attr_off);
+	u32 de_off =3D le32_to_cpu(hdr->de_off);
+	u32 o =3D PtrOffset(attr, hdr) + de_off;
+	const NTFS_DE *e =3D Add2Ptr(hdr, de_off);
+	u32 asize =3D le32_to_cpu(attr->size);
+
+	while (o < ao) {
+		u16 esize;
+
+		if (o >=3D asize)
+			break;
+
+		esize =3D le16_to_cpu(e->size);
+		if (!esize)
+			break;
+
+		o +=3D esize;
+		e =3D Add2Ptr(e, esize);
+	}
+
+	return o =3D=3D ao;
+}
+
+static inline bool check_if_alloc_index(const INDEX_HDR *hdr, u32 attr_off=
)
+{
+	u32 de_off =3D le32_to_cpu(hdr->de_off);
+	u32 o =3D offsetof(INDEX_BUFFER, ihdr) + de_off;
+	const NTFS_DE *e =3D Add2Ptr(hdr, de_off);
+	u32 used =3D le32_to_cpu(hdr->used);
+
+	while (o < attr_off) {
+		u16 esize;
+
+		if (de_off >=3D used)
+			break;
+
+		esize =3D le16_to_cpu(e->size);
+		if (!esize)
+			break;
+
+		o +=3D esize;
+		de_off +=3D esize;
+		e =3D Add2Ptr(e, esize);
+	}
+
+	return o =3D=3D attr_off;
+}
+
+static inline void change_attr_size(MFT_REC *rec, ATTRIB *attr, u32 nsize)
+{
+	u32 asize =3D le32_to_cpu(attr->size);
+	int dsize =3D nsize - asize;
+	u8 *next =3D Add2Ptr(attr, asize);
+	u32 used =3D le32_to_cpu(rec->used);
+
+	memmove(Add2Ptr(attr, nsize), next, used - PtrOffset(rec, next));
+
+	rec->used =3D cpu_to_le32(used + dsize);
+	attr->size =3D cpu_to_le32(nsize);
+}
+
+typedef struct {
+	ATTRIB *attr;
+	struct runs_tree *run1;
+	struct runs_tree run0;
+	ntfs_inode *ni;
+	// CLST rno;
+} OpenAttr;
+
+/* Returns 0 if 'attr' has the same type and name */
+static inline int cmp_type_and_name(const ATTRIB *a1, const ATTRIB *a2)
+{
+	return a1->type !=3D a2->type || a1->name_len !=3D a2->name_len ||
+	       (a1->name_len && memcmp(attr_name(a1), attr_name(a2),
+				       a1->name_len * sizeof(short)));
+}
+
+static OpenAttr *find_loaded_attr(ntfs_log *log, const ATTRIB *attr, CLST =
rno)
+{
+	OPEN_ATTR_ENRTY *oe =3D NULL;
+
+	while ((oe =3D enum_rstbl(log->open_attr_tbl, oe))) {
+		OpenAttr *op_attr;
+
+		if (ino_get(&oe->ref) !=3D rno)
+			continue;
+
+		op_attr =3D (OpenAttr *)oe->ptr;
+		if (!cmp_type_and_name(op_attr->attr, attr))
+			return op_attr;
+	}
+	return NULL;
+}
+
+static ATTRIB *attr_create_nonres_log(ntfs_sb_info *sbi, ATTR_TYPE type,
+				      u64 size, const u16 *name,
+				      size_t name_len, __le16 flags)
+{
+	ATTRIB *attr;
+	u32 name_size =3D QuadAlign(name_len * sizeof(short));
+	bool is_ext =3D flags & (ATTR_FLAG_COMPRESSED | ATTR_FLAG_SPARSED);
+	u32 asize =3D name_size +
+		    (is_ext ? SIZEOF_NONRESIDENT_EX : SIZEOF_NONRESIDENT);
+
+	attr =3D ntfs_alloc(asize, 1);
+	if (!attr)
+		return NULL;
+
+	attr->type =3D type;
+	attr->size =3D cpu_to_le32(asize);
+	attr->flags =3D flags;
+	attr->non_res =3D 1;
+	attr->name_len =3D name_len;
+
+	attr->nres.evcn =3D cpu_to_le64((u64)bytes_to_cluster(sbi, size) - 1);
+	attr->nres.alloc_size =3D cpu_to_le64(ntfs_up_cluster(sbi, size));
+	attr->nres.data_size =3D cpu_to_le64(size);
+	attr->nres.valid_size =3D attr->nres.data_size;
+	if (is_ext) {
+		attr->name_off =3D SIZEOF_NONRESIDENT_EX_LE;
+		if (is_attr_compressed(attr))
+			attr->nres.c_unit =3D COMPRESSION_UNIT;
+
+		attr->nres.run_off =3D
+			cpu_to_le16(SIZEOF_NONRESIDENT_EX + name_size);
+		memcpy(Add2Ptr(attr, SIZEOF_NONRESIDENT_EX), name,
+		       name_len * sizeof(short));
+	} else {
+		attr->name_off =3D SIZEOF_NONRESIDENT_LE;
+		attr->nres.run_off =3D
+			cpu_to_le16(SIZEOF_NONRESIDENT + name_size);
+		memcpy(Add2Ptr(attr, SIZEOF_NONRESIDENT), name,
+		       name_len * sizeof(short));
+	}
+
+	return attr;
+}
+
+/*
+ * do_action
+ *
+ * common routine for the Redo and Undo Passes
+ * If rlsn is NULL then undo
+ */
+static int do_action(ntfs_log *log, OPEN_ATTR_ENRTY *oe, const LOG_REC_HDR=
 *lrh,
+		     u32 op, void *data, u32 dlen, u32 rec_len, const u64 *rlsn)
+{
+	int err =3D 0;
+	ntfs_sb_info *sbi =3D log->ni->mi.sbi;
+	struct inode *inode =3D NULL, *inode_parent;
+	mft_inode *mi =3D NULL, *mi2_child =3D NULL;
+	CLST rno =3D 0, rno_base =3D 0;
+	INDEX_BUFFER *ib =3D NULL;
+	MFT_REC *rec =3D NULL;
+	ATTRIB *attr =3D NULL, *attr2;
+	INDEX_HDR *hdr;
+	INDEX_ROOT *root;
+	NTFS_DE *e, *e1, *e2;
+	NEW_ATTRIBUTE_SIZES *new_sz;
+	ATTR_FILE_NAME *fname;
+	OpenAttr *oa, *oa2;
+	u32 nsize, t32, asize, used, esize, bmp_off, bmp_bits;
+	u16 t16, id, id2;
+#ifndef NDEBUG
+	MFT_REC *rec2 =3D NULL;
+#endif
+	u32 record_size =3D sbi->record_size;
+	u64 t64;
+	u64 lco =3D 0;
+	u64 cbo =3D (u64)le16_to_cpu(lrh->cluster_off) << SECTOR_SHIFT;
+	u64 tvo =3D le64_to_cpu(lrh->target_vcn) << sbi->cluster_bits;
+	u64 vbo =3D cbo + tvo;
+	void *buffer_le =3D NULL;
+	u32 bytes =3D 0;
+	bool a_dirty =3D false;
+	u16 data_off;
+
+	oa =3D oe->ptr;
+
+	/* Big switch to prepare */
+	switch (op) {
+	/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	 * Process MFT records, as described by the current log record
+	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	 */
+	case InitializeFileRecordSegment:
+	case DeallocateFileRecordSegment:
+	case WriteEndOfFileRecordSegment:
+	case CreateAttribute:
+	case DeleteAttribute:
+	case UpdateResidentValue:
+	case UpdateMappingPairs:
+	case SetNewAttributeSizes:
+	case AddIndexEntryRoot:
+	case DeleteIndexEntryRoot:
+	case SetIndexEntryVcnRoot:
+	case UpdateFileNameRoot:
+	case UpdateRecordDataRoot:
+	case ZeroEndOfFileRecord:
+
+		rno =3D vbo >> sbi->record_bits;
+
+		inode =3D ilookup(sbi->sb, rno);
+		if (inode) {
+			mi =3D &ntfs_i(inode)->mi;
+		} else if (op =3D=3D InitializeFileRecordSegment) {
+			mi =3D ntfs_alloc(sizeof(mft_inode), 1);
+			if (!mi)
+				return -ENOMEM;
+			err =3D mi_format_new(mi, sbi, rno, 0, false);
+			if (err)
+				goto out;
+		} else {
+			/* read from disk */
+			err =3D mi_get(sbi, rno, &mi);
+			if (err)
+				return err;
+		}
+		rec =3D mi->mrec;
+
+		if (op =3D=3D DeallocateFileRecordSegment)
+			goto skip_load_parent;
+
+		if (InitializeFileRecordSegment !=3D op) {
+			if (rec->rhdr.sign =3D=3D NTFS_BAAD_SIGNATURE)
+				goto dirty_vol;
+			if (!check_lsn(&rec->rhdr, rlsn))
+				goto out;
+			if (!check_file_record(rec, NULL, sbi))
+				goto dirty_vol;
+			attr =3D Add2Ptr(rec, le16_to_cpu(lrh->record_off));
+		}
+
+		if (is_rec_base(rec) || InitializeFileRecordSegment =3D=3D op) {
+			rno_base =3D rno;
+			goto skip_load_parent;
+		}
+
+		rno_base =3D ino_get(&rec->parent_ref);
+
+		inode_parent =3D ntfs_iget5(sbi->sb, &rec->parent_ref, NULL);
+		if (IS_ERR(inode_parent))
+			goto skip_load_parent;
+
+		if (is_bad_inode(inode_parent)) {
+			iput(inode_parent);
+			goto skip_load_parent;
+		}
+
+		if (ni_load_mi_ex(ntfs_i(inode_parent), rno, &mi2_child)) {
+			iput(inode_parent);
+		} else {
+			if (mi2_child->mrec !=3D mi->mrec)
+				memcpy(mi2_child->mrec, mi->mrec,
+				       sbi->record_size);
+
+			if (inode)
+				iput(inode);
+			else if (mi)
+				mi_put(mi);
+
+			inode =3D inode_parent;
+			mi =3D mi2_child;
+			rec =3D mi2_child->mrec;
+			attr =3D Add2Ptr(rec, le16_to_cpu(lrh->record_off));
+		}
+
+skip_load_parent:
+		inode_parent =3D NULL;
+#ifndef NDEBUG
+		rec2 =3D ntfs_memdup(rec, record_size);
+#endif
+		break;
+
+	/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	 * Process attributes, as described by the current log record
+	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	 */
+	case UpdateNonresidentValue:
+	case AddIndexEntryAllocation:
+	case DeleteIndexEntryAllocation:
+	case WriteEndOfIndexBuffer:
+	case SetIndexEntryVcnAllocation:
+	case UpdateFileNameAllocation:
+	case SetBitsInNonresidentBitMap:
+	case ClearBitsInNonresidentBitMap:
+	case UpdateRecordDataAllocation:
+
+		attr =3D oa->attr;
+		bytes =3D UpdateNonresidentValue =3D=3D op ? dlen : 0;
+		lco =3D (u64)le16_to_cpu(lrh->lcns_follow) << sbi->cluster_bits;
+
+		if (attr->type =3D=3D ATTR_ALLOC) {
+			t32 =3D le32_to_cpu(oe->bytes_per_index);
+			if (bytes < t32)
+				bytes =3D t32;
+		}
+
+		if (!bytes)
+			bytes =3D lco - cbo;
+
+		bytes +=3D le16_to_cpu(lrh->record_off);
+		if (attr->type =3D=3D ATTR_ALLOC)
+			bytes =3D (bytes + 511) & ~511; // align
+
+		buffer_le =3D ntfs_alloc(bytes, 0);
+		if (!buffer_le)
+			return -ENOMEM;
+
+		err =3D ntfs_read_run_nb(sbi, oa->run1, vbo, buffer_le, bytes,
+				       NULL);
+		if (err)
+			goto out;
+
+		if (attr->type =3D=3D ATTR_ALLOC && *(int *)buffer_le)
+			ntfs_fix_post_read(buffer_le, bytes, false);
+		break;
+
+	default:
+		WARN_ON(1);
+	}
+
+	/* Big switch to do operation */
+	switch (op) {
+	case InitializeFileRecordSegment:
+		t16 =3D le16_to_cpu(lrh->record_off);
+		if (t16 + dlen > record_size)
+			goto dirty_vol;
+
+		memcpy(Add2Ptr(rec, t16), data, dlen);
+		mi->dirty =3D true;
+		break;
+
+	case DeallocateFileRecordSegment:
+		clear_rec_inuse(rec);
+		le16_add_cpu(&rec->seq, 1);
+		mi->dirty =3D true;
+		break;
+
+	case WriteEndOfFileRecordSegment:
+		attr2 =3D (ATTRIB *)data;
+		t16 =3D le16_to_cpu(lrh->record_off);
+
+		if (!check_if_attr(rec, lrh) || t16 + dlen > record_size)
+			goto dirty_vol;
+
+		memmove(attr, attr2, dlen);
+		rec->used =3D cpu_to_le32(QuadAlign(t16 + dlen));
+
+		mi->dirty =3D true;
+		break;
+
+	case CreateAttribute:
+		attr2 =3D (ATTRIB *)data;
+		asize =3D le32_to_cpu(attr2->size);
+		used =3D le32_to_cpu(rec->used);
+		t16 =3D le16_to_cpu(lrh->record_off);
+
+		if (!check_if_attr(rec, lrh) || dlen < SIZEOF_RESIDENT ||
+		    !IsQuadAligned(asize) ||
+		    Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len) ||
+		    dlen > record_size - used) {
+			goto dirty_vol;
+		}
+
+		memmove(Add2Ptr(attr, asize), attr, used - t16);
+		memcpy(attr, attr2, asize);
+
+		rec->used =3D cpu_to_le32(used + asize);
+		id =3D le16_to_cpu(rec->next_attr_id);
+		id2 =3D le16_to_cpu(attr2->id);
+		if (id <=3D id2)
+			rec->next_attr_id =3D cpu_to_le16(id2 + 1);
+		if (is_attr_indexed(attr))
+			le16_add_cpu(&rec->hard_links, 1);
+
+		oa2 =3D find_loaded_attr(log, attr, rno_base);
+		if (oa2) {
+			void *p2 =3D ntfs_memdup(attr, le32_to_cpu(attr->size));
+
+			if (p2) {
+				// run_close(oa2->run1);
+				ntfs_free(oa2->attr);
+				oa2->attr =3D p2;
+			}
+		}
+
+		mi->dirty =3D true;
+		break;
+
+	case DeleteAttribute:
+		asize =3D le32_to_cpu(attr->size);
+		used =3D le32_to_cpu(rec->used);
+		t16 =3D le16_to_cpu(lrh->record_off);
+
+		if (!check_if_attr(rec, lrh))
+			goto dirty_vol;
+
+		rec->used =3D cpu_to_le32(used - asize);
+		if (is_attr_indexed(attr))
+			le16_add_cpu(&rec->hard_links, -1);
+
+		memmove(attr, Add2Ptr(attr, asize), used - t16);
+
+		mi->dirty =3D true;
+		break;
+
+	case UpdateResidentValue:
+		t16 =3D le16_to_cpu(lrh->attr_off);
+		nsize =3D t16 + dlen;
+
+		if (!check_if_attr(rec, lrh))
+			goto dirty_vol;
+
+		asize =3D le32_to_cpu(attr->size);
+		used =3D le32_to_cpu(rec->used);
+
+		if (lrh->redo_len =3D=3D lrh->undo_len) {
+			if (nsize > asize)
+				goto dirty_vol;
+			goto move_data;
+		}
+
+		if (nsize > asize && nsize - asize > record_size - used)
+			goto dirty_vol;
+
+		nsize =3D QuadAlign(nsize);
+		data_off =3D le16_to_cpu(attr->res.data_off);
+
+		if (nsize < asize) {
+			memmove(Add2Ptr(attr, t16), data, dlen);
+			data =3D NULL; // To skip below memmove
+		}
+
+		memmove(Add2Ptr(attr, nsize), Add2Ptr(attr, asize),
+			used - le16_to_cpu(lrh->record_off) - asize);
+
+		rec->used =3D cpu_to_le32(used + nsize - asize);
+		attr->size =3D cpu_to_le32(nsize);
+		attr->res.data_size =3D cpu_to_le32(t16 + dlen - data_off);
+
+move_data:
+		if (data)
+			memmove(Add2Ptr(attr, t16), data, dlen);
+
+		oa2 =3D find_loaded_attr(log, attr, rno_base);
+		if (oa2) {
+			void *p2 =3D ntfs_memdup(attr, le32_to_cpu(attr->size));
+
+			if (p2) {
+				// run_close(&oa2->run0);
+				oa2->run1 =3D &oa2->run0;
+				ntfs_free(oa2->attr);
+				oa2->attr =3D p2;
+			}
+		}
+
+		mi->dirty =3D true;
+		break;
+
+	case UpdateMappingPairs:
+		t16 =3D le16_to_cpu(lrh->attr_off);
+		nsize =3D t16 + dlen;
+		asize =3D le32_to_cpu(attr->size);
+		used =3D le32_to_cpu(rec->used);
+
+		if (!check_if_attr(rec, lrh) || !attr->non_res ||
+		    t16 < le16_to_cpu(attr->nres.run_off) || t16 > asize ||
+		    (nsize > asize && nsize - asize > record_size - used)) {
+			goto dirty_vol;
+		}
+
+		nsize =3D QuadAlign(nsize);
+
+		memmove(Add2Ptr(attr, nsize), Add2Ptr(attr, asize),
+			used - le16_to_cpu(lrh->record_off) - asize);
+		rec->used =3D cpu_to_le32(used + nsize - asize);
+		attr->size =3D cpu_to_le32(nsize);
+		memmove(Add2Ptr(attr, t16), data, dlen);
+
+		if (run_get_highest_vcn(le64_to_cpu(attr->nres.svcn),
+					attr_run(attr), &t64)) {
+			goto dirty_vol;
+		}
+
+		attr->nres.evcn =3D cpu_to_le64(t64);
+		oa2 =3D find_loaded_attr(log, attr, rno_base);
+		if (oa2 && oa2->attr->non_res)
+			oa2->attr->nres.evcn =3D attr->nres.evcn;
+
+		mi->dirty =3D true;
+		break;
+
+	case SetNewAttributeSizes:
+		new_sz =3D data;
+
+		if (!check_if_attr(rec, lrh) || !attr->non_res)
+			goto dirty_vol;
+
+		attr->nres.alloc_size =3D new_sz->alloc_size;
+		attr->nres.data_size =3D new_sz->data_size;
+		attr->nres.valid_size =3D new_sz->valid_size;
+
+		if (dlen >=3D sizeof(NEW_ATTRIBUTE_SIZES))
+			attr->nres.total_size =3D new_sz->total_size;
+
+		oa2 =3D find_loaded_attr(log, attr, rno_base);
+		if (oa2) {
+			void *p2 =3D ntfs_memdup(attr, le32_to_cpu(attr->size));
+
+			if (p2) {
+				ntfs_free(oa2->attr);
+				oa2->attr =3D p2;
+			}
+		}
+		mi->dirty =3D true;
+		break;
+
+	case AddIndexEntryRoot:
+		e =3D (NTFS_DE *)data;
+		esize =3D le16_to_cpu(e->size);
+		root =3D resident_data(attr);
+		hdr =3D &root->ihdr;
+		used =3D le32_to_cpu(hdr->used);
+
+		if (!check_if_index_root(rec, lrh) ||
+		    !check_if_root_index(attr, hdr, lrh) ||
+		    Add2Ptr(data, esize) > Add2Ptr(lrh, rec_len) ||
+		    esize > le32_to_cpu(rec->total) - le32_to_cpu(rec->used)) {
+			goto dirty_vol;
+		}
+
+		e1 =3D Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
+
+		change_attr_size(rec, attr, le32_to_cpu(attr->size) + esize);
+
+		memmove(Add2Ptr(e1, esize), e1,
+			PtrOffset(e1, Add2Ptr(hdr, used)));
+		memmove(e1, e, esize);
+
+		le32_add_cpu(&attr->res.data_size, esize);
+		hdr->used =3D cpu_to_le32(used + esize);
+		le32_add_cpu(&hdr->total, esize);
+
+		mi->dirty =3D true;
+		break;
+
+	case DeleteIndexEntryRoot:
+		root =3D resident_data(attr);
+		hdr =3D &root->ihdr;
+		used =3D le32_to_cpu(hdr->used);
+
+		if (!check_if_index_root(rec, lrh) ||
+		    !check_if_root_index(attr, hdr, lrh)) {
+			goto dirty_vol;
+		}
+
+		e1 =3D Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
+		esize =3D le16_to_cpu(e1->size);
+		e2 =3D Add2Ptr(e1, esize);
+
+		memmove(e1, e2, PtrOffset(e2, Add2Ptr(hdr, used)));
+
+		le32_sub_cpu(&attr->res.data_size, esize);
+		hdr->used =3D cpu_to_le32(used - esize);
+		le32_sub_cpu(&hdr->total, esize);
+
+		change_attr_size(rec, attr, le32_to_cpu(attr->size) - esize);
+
+		mi->dirty =3D true;
+		break;
+
+	case SetIndexEntryVcnRoot:
+		root =3D resident_data(attr);
+		hdr =3D &root->ihdr;
+
+		if (!check_if_index_root(rec, lrh) ||
+		    !check_if_root_index(attr, hdr, lrh)) {
+			goto dirty_vol;
+		}
+
+		e =3D Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
+
+		de_set_vbn_le(e, *(__le64 *)data);
+		mi->dirty =3D true;
+		break;
+
+	case UpdateFileNameRoot:
+		root =3D resident_data(attr);
+		hdr =3D &root->ihdr;
+
+		if (!check_if_index_root(rec, lrh) ||
+		    !check_if_root_index(attr, hdr, lrh)) {
+			goto dirty_vol;
+		}
+
+		e =3D Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
+		fname =3D (ATTR_FILE_NAME *)(e + 1);
+		memmove(&fname->dup, data, sizeof(fname->dup)); //
+		mi->dirty =3D true;
+		break;
+
+	case UpdateRecordDataRoot:
+		root =3D resident_data(attr);
+		hdr =3D &root->ihdr;
+
+		if (!check_if_index_root(rec, lrh) ||
+		    !check_if_root_index(attr, hdr, lrh)) {
+			goto dirty_vol;
+		}
+
+		e =3D Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
+
+		memmove(Add2Ptr(e, le16_to_cpu(e->View.data_off)), data, dlen);
+
+		mi->dirty =3D true;
+		break;
+
+	case ZeroEndOfFileRecord:
+		t16 =3D le16_to_cpu(lrh->record_off);
+		if (t16 + dlen > record_size)
+			goto dirty_vol;
+
+		memset(attr, 0, dlen);
+		mi->dirty =3D true;
+		break;
+
+	case UpdateNonresidentValue:
+		t16 =3D le16_to_cpu(lrh->record_off);
+
+		if (lco < cbo + t16 + dlen)
+			goto dirty_vol;
+
+		memcpy(Add2Ptr(buffer_le, t16), data, dlen);
+
+		a_dirty =3D true;
+		if (attr->type =3D=3D ATTR_ALLOC)
+			ntfs_fix_pre_write(buffer_le, bytes);
+		break;
+
+	case AddIndexEntryAllocation:
+		t16 =3D le16_to_cpu(lrh->record_off);
+		ib =3D Add2Ptr(buffer_le, t16);
+		hdr =3D &ib->ihdr;
+		e =3D data;
+		esize =3D le16_to_cpu(e->size);
+		t16 =3D le16_to_cpu(lrh->attr_off);
+		e1 =3D Add2Ptr(ib, t16);
+
+		if (is_baad(&ib->rhdr))
+			goto dirty_vol;
+		if (!check_lsn(&ib->rhdr, rlsn))
+			goto out;
+
+		used =3D le32_to_cpu(hdr->used);
+
+		if (!check_index_buffer(ib, bytes) ||
+		    !check_if_alloc_index(hdr, t16) ||
+		    Add2Ptr(e, esize) > Add2Ptr(lrh, rec_len) ||
+		    used + esize > le32_to_cpu(hdr->total)) {
+			goto dirty_vol;
+		}
+
+		memmove(Add2Ptr(e1, esize), e1,
+			PtrOffset(e1, Add2Ptr(hdr, used)));
+		memcpy(e1, e, esize);
+
+		hdr->used =3D cpu_to_le32(used + esize);
+
+		a_dirty =3D true;
+
+		ntfs_fix_pre_write(&ib->rhdr, bytes);
+		break;
+
+	case DeleteIndexEntryAllocation:
+		t16 =3D le16_to_cpu(lrh->record_off);
+		ib =3D Add2Ptr(buffer_le, t16);
+		hdr =3D &ib->ihdr;
+		t16 =3D le16_to_cpu(lrh->attr_off);
+		e =3D Add2Ptr(ib, t16);
+		esize =3D le16_to_cpu(e->size);
+
+		if (is_baad(&ib->rhdr))
+			goto dirty_vol;
+		if (!check_lsn(&ib->rhdr, rlsn))
+			goto out;
+
+		if (!check_index_buffer(ib, bytes) ||
+		    !check_if_alloc_index(hdr, t16)) {
+			goto dirty_vol;
+		}
+
+		e1 =3D Add2Ptr(e, esize);
+		nsize =3D esize;
+		used =3D le32_to_cpu(hdr->used);
+
+		memmove(e, e1, PtrOffset(e1, Add2Ptr(hdr, used)));
+
+		hdr->used =3D cpu_to_le32(used - nsize);
+
+		a_dirty =3D true;
+
+		ntfs_fix_pre_write(&ib->rhdr, bytes);
+		break;
+
+	case WriteEndOfIndexBuffer:
+		t16 =3D le16_to_cpu(lrh->record_off);
+		ib =3D Add2Ptr(buffer_le, t16);
+		hdr =3D &ib->ihdr;
+		t16 =3D le16_to_cpu(lrh->attr_off);
+		e =3D Add2Ptr(ib, t16);
+
+		if (is_baad(&ib->rhdr))
+			goto dirty_vol;
+		if (!check_lsn(&ib->rhdr, rlsn))
+			goto out;
+		if (!check_index_buffer(ib, bytes) ||
+		    !check_if_alloc_index(hdr, t16) ||
+		    t16 + dlen > offsetof(INDEX_BUFFER, ihdr) +
+					 le32_to_cpu(hdr->total)) {
+			goto dirty_vol;
+		}
+
+		hdr->used =3D cpu_to_le32(dlen + PtrOffset(hdr, e));
+		memmove(e, data, dlen);
+
+		a_dirty =3D true;
+		ntfs_fix_pre_write(&ib->rhdr, bytes);
+		break;
+
+	case SetIndexEntryVcnAllocation:
+		t16 =3D le16_to_cpu(lrh->record_off);
+		ib =3D Add2Ptr(buffer_le, t16);
+		hdr =3D &ib->ihdr;
+		t16 =3D le16_to_cpu(lrh->attr_off);
+		e =3D Add2Ptr(ib, t16);
+
+		if (is_baad(&ib->rhdr))
+			goto dirty_vol;
+
+		if (!check_lsn(&ib->rhdr, rlsn))
+			goto out;
+		if (!check_index_buffer(ib, bytes) ||
+		    !check_if_alloc_index(hdr, t16)) {
+			goto dirty_vol;
+		}
+
+		de_set_vbn_le(e, *(__le64 *)data);
+
+		a_dirty =3D true;
+		ntfs_fix_pre_write(&ib->rhdr, bytes);
+		break;
+
+	case UpdateFileNameAllocation:
+		t16 =3D le16_to_cpu(lrh->record_off);
+		ib =3D Add2Ptr(buffer_le, t16);
+		hdr =3D &ib->ihdr;
+		t16 =3D le16_to_cpu(lrh->attr_off);
+		e =3D Add2Ptr(ib, t16);
+
+		if (is_baad(&ib->rhdr))
+			goto dirty_vol;
+
+		if (!check_lsn(&ib->rhdr, rlsn))
+			goto out;
+		if (!check_index_buffer(ib, bytes) ||
+		    !check_if_alloc_index(hdr, t16)) {
+			goto dirty_vol;
+		}
+
+		fname =3D (ATTR_FILE_NAME *)(e + 1);
+
+		memmove(&fname->dup, data, sizeof(fname->dup));
+
+		a_dirty =3D true;
+		ntfs_fix_pre_write(&ib->rhdr, bytes);
+		break;
+
+	case SetBitsInNonresidentBitMap:
+		bmp_off =3D le32_to_cpu(((BITMAP_RANGE *)data)->bitmap_off);
+		bmp_bits =3D le32_to_cpu(((BITMAP_RANGE *)data)->bits);
+		t16 =3D le16_to_cpu(lrh->record_off);
+
+		if (cbo + (bmp_off + 7) / 8 > lco ||
+		    cbo + ((bmp_off + bmp_bits + 7) / 8) > lco) {
+			goto dirty_vol;
+		}
+
+		__bitmap_set(Add2Ptr(buffer_le, t16), bmp_off, bmp_bits);
+		a_dirty =3D true;
+		break;
+
+	case ClearBitsInNonresidentBitMap:
+		bmp_off =3D le32_to_cpu(((BITMAP_RANGE *)data)->bitmap_off);
+		bmp_bits =3D le32_to_cpu(((BITMAP_RANGE *)data)->bits);
+		t16 =3D le16_to_cpu(lrh->record_off);
+
+		if (cbo + (bmp_off + 7) / 8 > lco ||
+		    cbo + ((bmp_off + bmp_bits + 7) / 8) > lco) {
+			goto dirty_vol;
+		}
+
+		__bitmap_clear(Add2Ptr(buffer_le, t16), bmp_off, bmp_bits);
+		a_dirty =3D true;
+		break;
+
+	case UpdateRecordDataAllocation:
+		t16 =3D le16_to_cpu(lrh->record_off);
+		ib =3D Add2Ptr(buffer_le, t16);
+		hdr =3D &ib->ihdr;
+		t16 =3D le16_to_cpu(lrh->attr_off);
+		e =3D Add2Ptr(ib, t16);
+
+		if (is_baad(&ib->rhdr))
+			goto dirty_vol;
+
+		if (!check_lsn(&ib->rhdr, rlsn))
+			goto out;
+		if (!check_index_buffer(ib, bytes) ||
+		    !check_if_alloc_index(hdr, t16)) {
+			goto dirty_vol;
+		}
+
+		memmove(Add2Ptr(e, le16_to_cpu(e->View.data_off)), data, dlen);
+
+		a_dirty =3D true;
+		ntfs_fix_pre_write(&ib->rhdr, bytes);
+		break;
+
+	default:
+		WARN_ON(1);
+	}
+
+	if (rlsn) {
+		__le64 t64 =3D cpu_to_le64(*rlsn);
+
+		if (rec)
+			rec->rhdr.lsn =3D t64;
+		if (ib)
+			ib->rhdr.lsn =3D t64;
+	}
+
+	if (inode)
+		err =3D _ni_write_inode(inode, 0);
+	else if (mi && mi->dirty) {
+		err =3D mi_write(mi, 0);
+		if (err)
+			goto out;
+	}
+
+	if (a_dirty) {
+		attr =3D oa->attr;
+		err =3D ntfs_sb_write_run(sbi, oa->run1, vbo, buffer_le, bytes);
+		if (err)
+			goto out;
+	}
+
+out:
+
+	if (inode)
+		iput(inode);
+	else if (mi !=3D mi2_child)
+		mi_put(mi);
+
+	ntfs_free(buffer_le);
+
+#ifndef NDEBUG
+	ntfs_free(rec2);
+#endif
+	return err;
+
+dirty_vol:
+	log->set_dirty =3D true;
+	goto out;
+}
+
+/*
+ * log_replay
+ *
+ * this function is called during mount operation
+ * it replays log and empties it
+ */
+int log_replay(ntfs_inode *ni)
+{
+	int err;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	ntfs_log *log;
+
+	RESTART_INFO rst_info, rst_info2;
+	u64 rec_lsn, ra_lsn, checkpt_lsn =3D 0, rlsn =3D 0;
+	ATTR_NAME_ENTRY *attr_names =3D NULL;
+	ATTR_NAME_ENTRY *ane;
+	RESTART_TABLE *dptbl =3D NULL;
+	RESTART_TABLE *trtbl =3D NULL;
+	const RESTART_TABLE *rt;
+	RESTART_TABLE *oatbl =3D NULL;
+	struct inode *inode;
+	OpenAttr *oa;
+	ntfs_inode *ni_oe;
+	ATTRIB *attr =3D NULL;
+	u64 size, vcn, undo_next_lsn;
+	CLST rno, lcn, lcn0, len0, clen;
+	void *data;
+	NTFS_RESTART *rst =3D NULL;
+	LCB *lcb =3D NULL;
+	OPEN_ATTR_ENRTY *oe;
+	TRANSACTION_ENTRY *tr;
+	DIR_PAGE_ENTRY *dp;
+	u32 i, bytes_per_attr_entry;
+	u32 l_size =3D ni->vfs_inode.i_size;
+	u32 orig_file_size =3D l_size;
+	u32 page_size, vbo, tail, off, dlen;
+	u32 saved_len, clst_off, rec_len, transact_id;
+	bool use_second_page;
+	RESTART_AREA *ra2, *ra =3D NULL;
+	CLIENT_REC *ca, *cr;
+	__le16 client;
+	RESTART_HDR *rh;
+	const LFS_RECORD_HDR *frh;
+	const LOG_REC_HDR *lrh;
+	bool is_mapped;
+	bool is_ro =3D sb_rdonly(sbi->sb);
+	u64 t64;
+	u16 t16;
+	u32 t32;
+
+	/* Get the size of page. NOTE: To replay we can use default page */
+	page_size =3D norm_file_page(PAGE_SIZE, &l_size,
+				   PAGE_SIZE >=3D DefaultLogPageSize &&
+					   PAGE_SIZE <=3D DefaultLogPageSize * 2);
+	if (!page_size)
+		return -EINVAL;
+
+	log =3D ntfs_alloc(sizeof(ntfs_log), 1);
+	if (!log)
+		return -ENOMEM;
+
+	log->ni =3D ni;
+	log->l_size =3D l_size;
+	log->one_page_buf =3D ntfs_alloc(page_size, 0);
+
+	if (!log->one_page_buf) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	log->page_size =3D page_size;
+	log->page_mask =3D page_size - 1;
+	log->page_bits =3D blksize_bits(page_size);
+
+	/* Look for a restart area on the disk */
+	err =3D log_read_rst(log, l_size, true, &rst_info);
+	if (err)
+		goto out;
+
+	if (!rst_info.restart) {
+		if (rst_info.initialized) {
+			/* no restart area but the file is not initialized */
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		log_init_pg_hdr(log, page_size, page_size, 1, 1);
+		log_create(log, l_size, 0, get_random_int(), false, false);
+
+		log->ra =3D ra;
+
+		ra =3D log_create_ra(log);
+		if (!ra) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+		log->ra =3D ra;
+		log->init_ra =3D true;
+
+		goto process_log;
+	}
+
+	/*
+	 * If the restart offset above wasn't zero then we won't
+	 * look for a second restart
+	 */
+	if (rst_info.vbo)
+		goto check_restart_area;
+
+	err =3D log_read_rst(log, l_size, false, &rst_info2);
+
+	/* Determine which restart area to use */
+	if (!rst_info2.restart || rst_info2.last_lsn <=3D rst_info.last_lsn)
+		goto use_first_page;
+
+	use_second_page =3D true;
+
+	if (rst_info.chkdsk_was_run && page_size !=3D rst_info.vbo) {
+		RECORD_PAGE_HDR *sp =3D NULL;
+
+		if (!read_log_page(log, page_size, &sp, true, true, NULL) &&
+		    sp->rhdr.sign =3D=3D NTFS_CHKD_SIGNATURE) {
+			use_second_page =3D false;
+		}
+		ntfs_free(sp);
+	}
+
+	if (use_second_page) {
+		ntfs_free(rst_info.r_page);
+		memcpy(&rst_info, &rst_info2, sizeof(RESTART_INFO));
+		rst_info2.r_page =3D NULL;
+	}
+
+use_first_page:
+	ntfs_free(rst_info2.r_page);
+
+check_restart_area:
+	/* If the restart area is at offset 0, we want to write the second restar=
t area first */
+	log->init_ra =3D !!rst_info.vbo;
+
+	/* If we have a valid page then grab a pointer to the restart area */
+	ra2 =3D rst_info.valid_page ?
+		      Add2Ptr(rst_info.r_page,
+			      le16_to_cpu(rst_info.r_page->ra_off)) :
+		      NULL;
+
+	if (rst_info.chkdsk_was_run ||
+	    (ra2 && ra2->client_idx[1] =3D=3D LFS_NO_CLIENT_LE)) {
+		bool wrapped =3D false;
+		bool use_multi_page =3D false;
+		bool clear_log =3D true;
+		u32 vbo_to_clear =3D page_size * 2;
+		u32 open_log_count;
+
+		/* Do some checks based on whether we have a valid log page */
+		if (!rst_info.valid_page) {
+			open_log_count =3D get_random_int();
+			goto init_log_instance;
+		}
+		open_log_count =3D le32_to_cpu(ra2->open_log_count);
+
+		/*
+		 * If the restart page size isn't changing then we want to
+		 * check how much work we need to do
+		 */
+		if (page_size !=3D le32_to_cpu(rst_info.r_page->sys_page_size))
+			goto init_log_instance;
+
+		/*
+		 * If the file size is changing we want to remember at which
+		 * point we want to start clearing the file
+		 */
+		t64 =3D le64_to_cpu(ra2->l_size);
+		if (l_size > t64)
+			vbo_to_clear =3D t64;
+		else {
+			if (!(ra2->flags & RESTART_SINGLE_PAGE_IO))
+				use_multi_page =3D wrapped =3D true;
+
+			/*
+			 * If the page is valid we don't need to clear
+			 * the log file or force the data to disk
+			 */
+			clear_log =3D false;
+		}
+
+init_log_instance:
+		log_init_pg_hdr(log, page_size, page_size, 1, 1);
+
+		log_create(log, l_size, rst_info.last_lsn, open_log_count,
+			   wrapped, use_multi_page);
+
+		ra =3D log_create_ra(log);
+		if (!ra) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+		log->ra =3D ra;
+
+		/* Put the restart areas and initialize the log file as required
+		 * if (clear_log) {
+		 *	fill [vbo_to_clear : log->l_size - vbo_to_clear) by -1
+		 * }
+		 */
+		goto process_log;
+	}
+
+	if (!ra2) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * If the log page or the system page sizes have changed, we can't use th=
e log file
+	 * We must use the system page size instead of the default size
+	 * if there is not a clean shutdown
+	 */
+	t32 =3D le32_to_cpu(rst_info.r_page->sys_page_size);
+	if (page_size !=3D t32) {
+		l_size =3D orig_file_size;
+		page_size =3D
+			norm_file_page(t32, &l_size, t32 =3D=3D DefaultLogPageSize);
+	}
+
+	if (page_size !=3D t32 ||
+	    page_size !=3D le32_to_cpu(rst_info.r_page->page_size)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* If the file size has shrunk then we won't mount it */
+	if (l_size < le64_to_cpu(ra2->l_size)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	log_init_pg_hdr(log, page_size, page_size,
+			le16_to_cpu(rst_info.r_page->major_ver),
+			le16_to_cpu(rst_info.r_page->minor_ver));
+
+	log->l_size =3D le64_to_cpu(ra2->l_size);
+	log->seq_num_bits =3D le32_to_cpu(ra2->seq_num_bits);
+	log->file_data_bits =3D sizeof(u64) * 8 - log->seq_num_bits;
+	log->seq_num_mask =3D (8 << log->file_data_bits) - 1;
+	log->last_lsn =3D le64_to_cpu(ra2->current_lsn);
+	log->seq_num =3D log->last_lsn >> log->file_data_bits;
+	log->ra_off =3D le16_to_cpu(rst_info.r_page->ra_off);
+	log->restart_size =3D log->sys_page_size - log->ra_off;
+	log->record_header_len =3D le16_to_cpu(ra2->rec_hdr_len);
+	log->ra_size =3D le16_to_cpu(ra2->ra_len);
+	log->data_off =3D le16_to_cpu(ra2->data_off);
+	log->data_size =3D log->page_size - log->data_off;
+	log->reserved =3D log->data_size - log->record_header_len;
+
+	vbo =3D lsn_to_vbo(log, log->last_lsn);
+
+	if (vbo < log->first_page) {
+		/* This is a pseudo lsn */
+		log->l_flags |=3D NTFSLOG_NO_LAST_LSN;
+		log->next_page =3D log->first_page;
+		goto find_oldest;
+	}
+
+	/* Find the end of this log record */
+	off =3D final_log_off(log, log->last_lsn,
+			    le32_to_cpu(ra2->last_lsn_data_len));
+
+	/* If we wrapped the file then increment the sequence number */
+	if (off <=3D vbo) {
+		log->seq_num +=3D 1;
+		log->l_flags |=3D NTFSLOG_WRAPPED;
+	}
+
+	/* Now compute the next log page to use */
+	vbo &=3D ~log->sys_page_mask;
+	tail =3D log->page_size - (off & log->page_mask) - 1;
+
+	/* If we can fit another log record on the page, move back a page the log=
 file */
+	if (tail >=3D log->record_header_len) {
+		log->l_flags |=3D NTFSLOG_REUSE_TAIL;
+		log->next_page =3D vbo;
+	} else {
+		log->next_page =3D next_page_off(log, vbo);
+	}
+
+find_oldest:
+	/* Find the oldest client lsn. Use the last flushed lsn as a starting poi=
nt */
+	log->oldest_lsn =3D log->last_lsn;
+	oldest_client_lsn(Add2Ptr(ra2, le16_to_cpu(ra2->client_off)),
+			  ra2->client_idx[1], &log->oldest_lsn);
+	log->oldest_lsn_off =3D lsn_to_vbo(log, log->oldest_lsn);
+
+	if (log->oldest_lsn_off < log->first_page)
+		log->l_flags |=3D NTFSLOG_NO_OLDEST_LSN;
+
+	if (!(ra2->flags & RESTART_SINGLE_PAGE_IO))
+		log->l_flags |=3D NTFSLOG_WRAPPED | NTFSLOG_MULTIPLE_PAGE_IO;
+
+	log->current_openlog_count =3D le32_to_cpu(ra2->open_log_count);
+	log->total_avail_pages =3D log->l_size - log->first_page;
+	log->total_avail =3D log->total_avail_pages >> log->page_bits;
+	log->max_current_avail =3D log->total_avail * log->reserved;
+	log->total_avail =3D log->total_avail * log->data_size;
+
+	log->current_avail =3D current_log_avail(log);
+
+	ra =3D ntfs_alloc(log->restart_size, 1);
+	if (!ra) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+	log->ra =3D ra;
+
+	t16 =3D le16_to_cpu(ra2->client_off);
+	if (t16 =3D=3D offsetof(RESTART_AREA, clients))
+		memcpy(ra, ra2, log->ra_size);
+	else {
+		memcpy(ra, ra2, offsetof(RESTART_AREA, clients));
+		memcpy(ra->clients, Add2Ptr(ra2, t16),
+		       le16_to_cpu(ra2->ra_len) - t16);
+
+		log->current_openlog_count =3D get_random_int();
+		ra->open_log_count =3D cpu_to_le32(log->current_openlog_count);
+		log->ra_size =3D
+			offsetof(RESTART_AREA, clients) + sizeof(CLIENT_REC);
+		ra->client_off =3D cpu_to_le16(offsetof(RESTART_AREA, clients));
+		ra->ra_len =3D cpu_to_le16(log->ra_size);
+	}
+
+	le32_add_cpu(&ra->open_log_count, 1);
+
+	/* Now we need to walk through looking for the last lsn */
+	err =3D last_log_lsn(log);
+	if (err =3D=3D -EROFS)
+		goto out;
+
+	if (err)
+		goto out;
+
+	log->current_avail =3D current_log_avail(log);
+
+	/* Remember which restart area to write first */
+	log->init_ra =3D rst_info.vbo;
+
+process_log:
+
+	/* 1.0, 1.1, 2.0 log->major_ver/minor_ver - short values */
+	switch ((log->major_ver << 16) + log->minor_ver) {
+	case 0x10000:
+	case 0x10001:
+	case 0x20000:
+		break;
+	default:
+		ntfs_warning(sbi->sb, "$LogFile version %d.%d is not supported",
+			     log->major_ver, log->minor_ver);
+		err =3D -EOPNOTSUPP;
+		log->set_dirty =3D true;
+		goto out;
+	}
+
+	/* One client "NTFS" per logfile */
+	ca =3D Add2Ptr(ra, le16_to_cpu(ra->client_off));
+
+	for (client =3D ra->client_idx[1];; client =3D cr->next_client) {
+		if (client =3D=3D LFS_NO_CLIENT_LE) {
+			/* Insert "NTFS" client LogFile */
+			client =3D ra->client_idx[0];
+			if (client =3D=3D LFS_NO_CLIENT_LE)
+				return -EINVAL;
+
+			t16 =3D le16_to_cpu(client);
+			cr =3D ca + t16;
+
+			remove_client(ca, cr, &ra->client_idx[0]);
+
+			cr->restart_lsn =3D 0;
+			cr->oldest_lsn =3D cpu_to_le64(log->oldest_lsn);
+			cr->name_bytes =3D cpu_to_le32(8);
+			cr->name[0] =3D cpu_to_le16('N');
+			cr->name[1] =3D cpu_to_le16('T');
+			cr->name[2] =3D cpu_to_le16('F');
+			cr->name[3] =3D cpu_to_le16('S');
+
+			add_client(ca, t16, &ra->client_idx[1]);
+			break;
+		}
+
+		cr =3D ca + le16_to_cpu(client);
+
+		if (cpu_to_le32(8) =3D=3D cr->name_bytes &&
+		    cpu_to_le16('N') =3D=3D cr->name[0] &&
+		    cpu_to_le16('T') =3D=3D cr->name[1] &&
+		    cpu_to_le16('F') =3D=3D cr->name[2] &&
+		    cpu_to_le16('S') =3D=3D cr->name[3])
+			break;
+	}
+
+	/* Update the client handle with the client block information */
+	log->client_id.seq_num =3D cr->seq_num;
+	log->client_id.client_idx =3D client;
+
+	err =3D read_rst_area(log, &rst, &ra_lsn);
+	if (err)
+		goto out;
+
+	if (!rst)
+		goto out;
+
+	bytes_per_attr_entry =3D !rst->major_ver ? 0x2C : 0x28;
+
+	checkpt_lsn =3D le64_to_cpu(rst->check_point_start);
+	if (!checkpt_lsn)
+		checkpt_lsn =3D ra_lsn;
+
+	/* Allocate and Read the Transaction Table */
+	if (!rst->transact_table_len)
+		goto check_dirty_page_table;
+
+	t64 =3D le64_to_cpu(rst->transact_table_lsn);
+
+	err =3D read_log_rec_lcb(log, t64, lcb_ctx_prev, &lcb);
+	if (err)
+		goto out;
+
+	lrh =3D lcb->log_rec;
+	frh =3D lcb->lrh;
+	rec_len =3D le32_to_cpu(frh->client_data_len);
+
+	if (!check_log_rec(lrh, rec_len, le32_to_cpu(frh->transact_id),
+			   bytes_per_attr_entry)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	t16 =3D le16_to_cpu(lrh->redo_off);
+
+	rt =3D Add2Ptr(lrh, t16);
+	t32 =3D rec_len - t16;
+
+	/* Now check that this is a valid restart table */
+	if (!check_rstbl(rt, t32)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	trtbl =3D ntfs_memdup(rt, t32);
+	if (!trtbl) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	lcb_put(lcb);
+	lcb =3D NULL;
+
+check_dirty_page_table:
+	/* The next record back should be the Dirty Pages Table */
+	if (!rst->dirty_pages_len)
+		goto check_attribute_names;
+
+	t64 =3D le64_to_cpu(rst->dirty_pages_table_lsn);
+
+	err =3D read_log_rec_lcb(log, t64, lcb_ctx_prev, &lcb);
+	if (err)
+		goto out;
+
+	lrh =3D lcb->log_rec;
+	frh =3D lcb->lrh;
+	rec_len =3D le32_to_cpu(frh->client_data_len);
+
+	if (!check_log_rec(lrh, rec_len, le32_to_cpu(frh->transact_id),
+			   bytes_per_attr_entry)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	t16 =3D le16_to_cpu(lrh->redo_off);
+
+	rt =3D Add2Ptr(lrh, t16);
+	t32 =3D rec_len - t16;
+
+	/* Now check that this is a valid restart table */
+	if (!check_rstbl(rt, t32)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	dptbl =3D ntfs_memdup(rt, t32);
+	if (!dptbl) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	/* Convert Ra version '0' into version '1' */
+	if (rst->major_ver)
+		goto end_conv_1;
+
+	dp =3D NULL;
+	while ((dp =3D enum_rstbl(dptbl, dp))) {
+		DIR_PAGE_ENTRY_32 *dp0 =3D (DIR_PAGE_ENTRY_32 *)dp;
+		// NOTE: Danger. Check for of boundary
+		memmove(&dp->vcn, &dp0->vcn_low,
+			2 * sizeof(u64) +
+				le32_to_cpu(dp->lcns_follow) * sizeof(u64));
+	}
+
+end_conv_1:
+	lcb_put(lcb);
+	lcb =3D NULL;
+
+	/* Go through the table and remove the duplicates, remembering the oldest=
 lsn values */
+	if (sbi->cluster_size <=3D log->page_size)
+		goto trace_dp_table;
+
+	dp =3D NULL;
+	while ((dp =3D enum_rstbl(dptbl, dp))) {
+		DIR_PAGE_ENTRY *next =3D dp;
+
+		while ((next =3D enum_rstbl(dptbl, next))) {
+			if (next->target_attr =3D=3D dp->target_attr &&
+			    next->vcn =3D=3D dp->vcn) {
+				if (le64_to_cpu(next->oldest_lsn) <
+				    le64_to_cpu(dp->oldest_lsn)) {
+					dp->oldest_lsn =3D next->oldest_lsn;
+				}
+
+				free_rsttbl_idx(dptbl, PtrOffset(dptbl, next));
+			}
+		}
+	}
+trace_dp_table:
+
+check_attribute_names:
+	/* The next record should be the Attribute Names */
+	if (!rst->attr_names_len)
+		goto check_attr_table;
+
+	t64 =3D le64_to_cpu(rst->attr_names_lsn);
+
+	err =3D read_log_rec_lcb(log, t64, lcb_ctx_prev, &lcb);
+	if (err)
+		goto out;
+
+	lrh =3D lcb->log_rec;
+	frh =3D lcb->lrh;
+	rec_len =3D le32_to_cpu(frh->client_data_len);
+
+	if (!check_log_rec(lrh, rec_len, le32_to_cpu(frh->transact_id),
+			   bytes_per_attr_entry)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	t32 =3D lrh_length(lrh);
+	rec_len -=3D t32;
+
+	attr_names =3D ntfs_memdup(Add2Ptr(lrh, t32), rec_len);
+
+	lcb_put(lcb);
+	lcb =3D NULL;
+
+check_attr_table:
+	/* The next record should be the attribute Table */
+	if (!rst->open_attr_len)
+		goto check_attribute_names2;
+
+	t64 =3D le64_to_cpu(rst->open_attr_table_lsn);
+
+	err =3D read_log_rec_lcb(log, t64, lcb_ctx_prev, &lcb);
+	if (err)
+		goto out;
+
+	lrh =3D lcb->log_rec;
+	frh =3D lcb->lrh;
+	rec_len =3D le32_to_cpu(frh->client_data_len);
+
+	if (!check_log_rec(lrh, rec_len, le32_to_cpu(frh->transact_id),
+			   bytes_per_attr_entry)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	t16 =3D le16_to_cpu(lrh->redo_off);
+
+	rt =3D Add2Ptr(lrh, t16);
+	t32 =3D rec_len - t16;
+
+	if (!check_rstbl(rt, t32)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	oatbl =3D ntfs_memdup(rt, t32);
+	if (!oatbl) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	log->open_attr_tbl =3D oatbl;
+
+	/* Clear all of the Attr pointers */
+	oe =3D NULL;
+	while ((oe =3D enum_rstbl(oatbl, oe))) {
+		if (!rst->major_ver) {
+			OPEN_ATTR_ENRTY_32 oe0;
+
+			/* Really 'oe' points to OPEN_ATTR_ENRTY_32 */
+			memcpy(&oe0, oe, SIZEOF_OPENATTRIBUTEENTRY0);
+
+			oe->bytes_per_index =3D oe0.bytes_per_index;
+			oe->type =3D oe0.type;
+			oe->is_dirty_pages =3D oe0.is_dirty_pages;
+			oe->name_len =3D 0;
+			oe->ref =3D oe0.ref;
+			oe->open_record_lsn =3D oe0.open_record_lsn;
+		}
+
+		oe->is_attr_name =3D 0;
+		oe->ptr =3D NULL;
+	}
+
+	lcb_put(lcb);
+	lcb =3D NULL;
+
+check_attribute_names2:
+	if (!rst->attr_names_len)
+		goto trace_attribute_table;
+
+	ane =3D attr_names;
+	if (!oatbl)
+		goto trace_attribute_table;
+	while (ane->off) {
+		/* TODO: Clear table on exit! */
+		oe =3D Add2Ptr(oatbl, le16_to_cpu(ane->off));
+		t16 =3D le16_to_cpu(ane->name_bytes);
+		oe->name_len =3D t16 / sizeof(short);
+		oe->ptr =3D ane->name;
+		oe->is_attr_name =3D 2;
+		ane =3D Add2Ptr(ane, sizeof(ATTR_NAME_ENTRY) + t16);
+	}
+
+trace_attribute_table:
+	/*
+	 * If the checkpt_lsn is zero, then this is a freshly
+	 * formatted disk and we have no work to do
+	 */
+	if (!checkpt_lsn) {
+		err =3D 0;
+		goto out;
+	}
+
+	if (!oatbl) {
+		oatbl =3D init_rsttbl(bytes_per_attr_entry, 8);
+		if (!oatbl) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	}
+
+	log->open_attr_tbl =3D oatbl;
+
+	/* Start the analysis pass from the Checkpoint lsn. */
+	rec_lsn =3D checkpt_lsn;
+
+	/* Read the first lsn */
+	err =3D read_log_rec_lcb(log, checkpt_lsn, lcb_ctx_next, &lcb);
+	if (err)
+		goto out;
+
+	/* Loop to read all subsequent records to the end of the log file */
+next_log_record_analyze:
+	err =3D read_next_log_rec(log, lcb, &rec_lsn);
+	if (err)
+		goto out;
+
+	if (!rec_lsn)
+		goto end_log_records_enumerate;
+
+	frh =3D lcb->lrh;
+	transact_id =3D le32_to_cpu(frh->transact_id);
+	rec_len =3D le32_to_cpu(frh->client_data_len);
+	lrh =3D lcb->log_rec;
+
+	if (!check_log_rec(lrh, rec_len, transact_id, bytes_per_attr_entry)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * The first lsn after the previous lsn remembered
+	 * the checkpoint is the first candidate for the rlsn
+	 */
+	if (!rlsn)
+		rlsn =3D rec_lsn;
+
+	if (LfsClientRecord !=3D frh->record_type)
+		goto next_log_record_analyze;
+
+	/*
+	 * Now update the Transaction Table for this transaction
+	 * If there is no entry present or it is unallocated we allocate the entr=
y
+	 */
+	if (!trtbl) {
+		trtbl =3D init_rsttbl(sizeof(TRANSACTION_ENTRY),
+				    INITIAL_NUMBER_TRANSACTIONS);
+		if (!trtbl) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	}
+
+	tr =3D Add2Ptr(trtbl, transact_id);
+
+	if (transact_id >=3D bytes_per_rt(trtbl) ||
+	    tr->next !=3D RESTART_ENTRY_ALLOCATED_LE) {
+		tr =3D alloc_rsttbl_from_idx(&trtbl, transact_id);
+		if (!tr) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+		tr->transact_state =3D TransactionActive;
+		tr->first_lsn =3D cpu_to_le64(rec_lsn);
+	}
+
+	tr->prev_lsn =3D tr->undo_next_lsn =3D cpu_to_le64(rec_lsn);
+
+	/*
+	 * If this is a compensation log record, then change
+	 * the undo_next_lsn to be the undo_next_lsn of this record
+	 */
+	if (lrh->undo_op =3D=3D cpu_to_le16(CompensationLogRecord))
+		tr->undo_next_lsn =3D frh->client_undo_next_lsn;
+
+	/* Dispatch to handle log record depending on type */
+	switch (le16_to_cpu(lrh->redo_op)) {
+	case InitializeFileRecordSegment:
+	case DeallocateFileRecordSegment:
+	case WriteEndOfFileRecordSegment:
+	case CreateAttribute:
+	case DeleteAttribute:
+	case UpdateResidentValue:
+	case UpdateNonresidentValue:
+	case UpdateMappingPairs:
+	case SetNewAttributeSizes:
+	case AddIndexEntryRoot:
+	case DeleteIndexEntryRoot:
+	case AddIndexEntryAllocation:
+	case DeleteIndexEntryAllocation:
+	case WriteEndOfIndexBuffer:
+	case SetIndexEntryVcnRoot:
+	case SetIndexEntryVcnAllocation:
+	case UpdateFileNameRoot:
+	case UpdateFileNameAllocation:
+	case SetBitsInNonresidentBitMap:
+	case ClearBitsInNonresidentBitMap:
+	case UpdateRecordDataRoot:
+	case UpdateRecordDataAllocation:
+	case ZeroEndOfFileRecord:
+		t16 =3D le16_to_cpu(lrh->target_attr);
+		t64 =3D le64_to_cpu(lrh->target_vcn);
+		dp =3D find_dp(dptbl, t16, t64);
+
+		if (dp)
+			goto copy_lcns;
+
+		/*
+		 * Calculate the number of clusters per page the system
+		 * which wrote the checkpoint, possibly creating the table
+		 */
+		if (dptbl)
+			t32 =3D 1 + (le16_to_cpu(dptbl->size) -
+				   sizeof(DIR_PAGE_ENTRY)) /
+					  sizeof(u64);
+		else {
+			t32 =3D log->clst_per_page;
+			ntfs_free(dptbl);
+			dptbl =3D init_rsttbl(sizeof(DIR_PAGE_ENTRY) +
+						    (t32 - 1) * sizeof(u64),
+					    32);
+			if (!dptbl) {
+				err =3D -ENOMEM;
+				goto out;
+			}
+		}
+
+		dp =3D alloc_rsttbl_idx(&dptbl);
+		dp->target_attr =3D cpu_to_le32(t16);
+		dp->transfer_len =3D cpu_to_le32(t32 << sbi->cluster_bits);
+		dp->lcns_follow =3D cpu_to_le32(t32);
+		dp->vcn =3D cpu_to_le64(t64 & ~((u64)t32 - 1));
+		dp->oldest_lsn =3D cpu_to_le64(rec_lsn);
+
+copy_lcns:
+		/*
+		 * Copy the Lcns from the log record into the Dirty Page Entry
+		 * TODO: for different page size support, must somehow make
+		 * whole routine a loop, case Lcns do not fit below
+		 */
+		t16 =3D le16_to_cpu(lrh->lcns_follow);
+		for (i =3D 0; i < t16; i++) {
+			size_t j =3D (size_t)(le64_to_cpu(lrh->target_vcn) -
+					    le64_to_cpu(dp->vcn));
+			dp->page_lcns[j + i] =3D lrh->page_lcns[i];
+		}
+
+		goto next_log_record_analyze;
+
+	case DeleteDirtyClusters: {
+		u32 range_count =3D
+			le16_to_cpu(lrh->redo_len) / sizeof(LCN_RANGE);
+		const LCN_RANGE *r =3D Add2Ptr(lrh, le16_to_cpu(lrh->redo_off));
+
+		/* Loop through all of the Lcn ranges this log record */
+		for (i =3D 0; i < range_count; i++, r++) {
+			u64 lcn0 =3D le64_to_cpu(r->lcn);
+			u64 lcn_e =3D lcn0 + le64_to_cpu(r->len) - 1;
+
+			dp =3D NULL;
+			while ((dp =3D enum_rstbl(dptbl, dp))) {
+				u32 j;
+
+				t32 =3D le32_to_cpu(dp->lcns_follow);
+				for (j =3D 0; j < t32; j++) {
+					t64 =3D le64_to_cpu(dp->page_lcns[j]);
+					if (t64 >=3D lcn0 && t64 <=3D lcn_e)
+						dp->page_lcns[j] =3D 0;
+				}
+			}
+		}
+		goto next_log_record_analyze;
+		;
+	}
+
+	case OpenNonresidentAttribute:
+		t16 =3D le16_to_cpu(lrh->target_attr);
+		if (t16 >=3D bytes_per_rt(oatbl)) {
+			/*
+			 * Compute how big the table needs to be.
+			 * Add 10 extra entries for some cushion
+			 */
+			u32 new_e =3D t16 / le16_to_cpu(oatbl->size);
+
+			new_e +=3D 10 - le16_to_cpu(oatbl->used);
+
+			oatbl =3D extend_rsttbl(oatbl, new_e, ~0u);
+			log->open_attr_tbl =3D oatbl;
+			if (!oatbl) {
+				err =3D -ENOMEM;
+				goto out;
+			}
+		}
+
+		/* Point to the entry being opened */
+		oe =3D alloc_rsttbl_from_idx(&oatbl, t16);
+		log->open_attr_tbl =3D oatbl;
+		if (!oe) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+
+		/* Initialize this entry from the log record */
+		t16 =3D le16_to_cpu(lrh->redo_off);
+		if (!rst->major_ver) {
+			/* Convert version '0' into version '1' */
+			OPEN_ATTR_ENRTY_32 *oe0 =3D Add2Ptr(lrh, t16);
+
+			oe->bytes_per_index =3D oe0->bytes_per_index;
+			oe->type =3D oe0->type;
+			oe->is_dirty_pages =3D oe0->is_dirty_pages;
+			oe->name_len =3D 0; // oe0.name_len;
+			oe->ref =3D oe0->ref;
+			oe->open_record_lsn =3D oe0->open_record_lsn;
+		} else
+			memcpy(oe, Add2Ptr(lrh, t16), bytes_per_attr_entry);
+
+		t16 =3D le16_to_cpu(lrh->undo_len);
+		if (t16) {
+			oe->ptr =3D ntfs_alloc(t16, 0);
+			if (!oe->ptr) {
+				err =3D -ENOMEM;
+				goto out;
+			}
+			oe->name_len =3D t16 / sizeof(short);
+			memcpy(oe->ptr,
+			       Add2Ptr(lrh, le16_to_cpu(lrh->undo_off)), t16);
+			oe->is_attr_name =3D 1;
+		} else {
+			oe->ptr =3D NULL;
+			oe->is_attr_name =3D 0;
+		}
+
+		goto next_log_record_analyze;
+
+	case HotFix:
+		t16 =3D le16_to_cpu(lrh->target_attr);
+		t64 =3D le64_to_cpu(lrh->target_vcn);
+		dp =3D find_dp(dptbl, t16, t64);
+		if (dp) {
+			size_t j =3D le64_to_cpu(lrh->target_vcn) -
+				   le64_to_cpu(dp->vcn);
+			if (dp->page_lcns[j])
+				dp->page_lcns[j] =3D lrh->page_lcns[0];
+		}
+		goto next_log_record_analyze;
+
+	case EndTopLevelAction:
+		tr =3D Add2Ptr(trtbl, transact_id);
+		tr->prev_lsn =3D cpu_to_le64(rec_lsn);
+		tr->undo_next_lsn =3D frh->client_undo_next_lsn;
+		goto next_log_record_analyze;
+
+	case PrepareTransaction:
+		tr =3D Add2Ptr(trtbl, transact_id);
+		tr->transact_state =3D TransactionPrepared;
+		goto next_log_record_analyze;
+
+	case CommitTransaction:
+		tr =3D Add2Ptr(trtbl, transact_id);
+		tr->transact_state =3D TransactionCommitted;
+		goto next_log_record_analyze;
+
+	case ForgetTransaction:
+		free_rsttbl_idx(trtbl, transact_id);
+		goto next_log_record_analyze;
+
+	case Noop:
+	case OpenAttributeTableDump:
+	case AttributeNamesDump:
+	case DirtyPageTableDump:
+	case TransactionTableDump:
+		/* The following cases require no action the Analysis Pass */
+		goto next_log_record_analyze;
+
+	default:
+		goto next_log_record_analyze;
+	}
+
+end_log_records_enumerate:
+	lcb_put(lcb);
+	lcb =3D NULL;
+
+	/*
+	 * Scan the Dirty Page Table and Transaction Table for
+	 * the lowest lsn, and return it as the Redo lsn
+	 */
+	dp =3D NULL;
+	while ((dp =3D enum_rstbl(dptbl, dp))) {
+		t64 =3D le64_to_cpu(dp->oldest_lsn);
+		if (t64 && t64 < rlsn)
+			rlsn =3D t64;
+	}
+
+	tr =3D NULL;
+	while ((tr =3D enum_rstbl(trtbl, tr))) {
+		t64 =3D le64_to_cpu(tr->first_lsn);
+		if (t64 && t64 < rlsn)
+			rlsn =3D t64;
+	}
+
+	/* Only proceed if the Dirty Page Table or Transaction table are not empt=
y */
+	if ((!dptbl || !dptbl->total) && (!trtbl || !trtbl->total))
+		goto end_reply;
+
+	sbi->flags |=3D NTFS_FLAGS_NEED_REPLAY;
+	if (is_ro)
+		goto out;
+
+	/* Reopen all of the attributes with dirty pages */
+	oe =3D NULL;
+next_open_attribute:
+
+	oe =3D enum_rstbl(oatbl, oe);
+	if (!oe) {
+		err =3D 0;
+		dp =3D NULL;
+		goto next_dirty_page;
+	}
+
+	oa =3D ntfs_alloc(sizeof(OpenAttr), 1);
+	if (!oa) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	inode =3D ntfs_iget5(sbi->sb, &oe->ref, NULL);
+	if (IS_ERR(inode))
+		goto fake_attr;
+
+	if (is_bad_inode(inode)) {
+		iput(inode);
+fake_attr:
+		if (oa->ni) {
+			iput(&oa->ni->vfs_inode);
+			oa->ni =3D NULL;
+		}
+
+		attr =3D attr_create_nonres_log(sbi, oe->type, 0, oe->ptr,
+					      oe->name_len, 0);
+		if (!attr) {
+			ntfs_free(oa);
+			err =3D -ENOMEM;
+			goto out;
+		}
+		oa->attr =3D attr;
+		oa->run1 =3D &oa->run0;
+		goto final_oe;
+	}
+
+	ni_oe =3D ntfs_i(inode);
+	oa->ni =3D ni_oe;
+
+	attr =3D ni_find_attr(ni_oe, NULL, NULL, oe->type, oe->ptr, oe->name_len,
+			    NULL, NULL);
+
+	if (!attr)
+		goto fake_attr;
+
+	t32 =3D le32_to_cpu(attr->size);
+	oa->attr =3D ntfs_memdup(attr, t32);
+	if (!oa->attr)
+		goto fake_attr;
+
+	if (!S_ISDIR(inode->i_mode)) {
+		if (attr->type =3D=3D ATTR_DATA && !attr->name_len) {
+			oa->run1 =3D &ni_oe->file.run;
+			goto final_oe;
+		}
+	} else {
+		if (attr->type =3D=3D ATTR_ALLOC &&
+		    attr->name_len =3D=3D ARRAY_SIZE(I30_NAME) &&
+		    !memcmp(attr_name(attr), I30_NAME, sizeof(I30_NAME))) {
+			oa->run1 =3D &ni_oe->dir.alloc_run;
+			goto final_oe;
+		}
+	}
+
+	if (attr->non_res) {
+		u16 roff =3D le16_to_cpu(attr->nres.run_off);
+
+		err =3D run_unpack(&oa->run0, sbi, inode->i_ino,
+				 le64_to_cpu(attr->nres.svcn),
+				 le64_to_cpu(attr->nres.evcn),
+				 Add2Ptr(attr, roff), t32 - roff);
+		if (err < 0) {
+			ntfs_free(oa->attr);
+			oa->attr =3D NULL;
+			goto fake_attr;
+		}
+		err =3D 0;
+	}
+	oa->run1 =3D &oa->run0;
+	attr =3D oa->attr;
+
+final_oe:
+	if (oe->is_attr_name =3D=3D 1)
+		ntfs_free(oe->ptr);
+	oe->is_attr_name =3D 0;
+	oe->ptr =3D oa;
+	oe->name_len =3D attr->name_len;
+
+	goto next_open_attribute;
+
+	/*
+	 * Now loop through the dirty page table to extract all of the Vcn/Lcn
+	 * Mapping that we have, and insert it into the appropriate run
+	 */
+next_dirty_page:
+	dp =3D enum_rstbl(dptbl, dp);
+	if (!dp)
+		goto do_redo_1;
+
+	oe =3D Add2Ptr(oatbl, le32_to_cpu(dp->target_attr));
+
+	if (oe->next !=3D RESTART_ENTRY_ALLOCATED_LE)
+		goto next_dirty_page;
+
+	oa =3D oe->ptr;
+	if (!oa)
+		goto next_dirty_page;
+
+	i =3D -1;
+next_dirty_page_vcn:
+	i +=3D 1;
+	if (i >=3D le32_to_cpu(dp->lcns_follow))
+		goto next_dirty_page;
+
+	vcn =3D le64_to_cpu(dp->vcn) + i;
+	size =3D (vcn + 1) << sbi->cluster_bits;
+
+	if (!dp->page_lcns[i])
+		goto next_dirty_page_vcn;
+
+	rno =3D ino_get(&oe->ref);
+	if (rno <=3D MFT_REC_MIRR &&
+	    size < (MFT_REC_VOL + 1) * sbi->record_size &&
+	    oe->type =3D=3D ATTR_DATA) {
+		goto next_dirty_page_vcn;
+	}
+
+	lcn =3D le64_to_cpu(dp->page_lcns[i]);
+
+	if ((!run_lookup_entry(oa->run1, vcn, &lcn0, &len0, NULL) ||
+	     lcn0 !=3D lcn) &&
+	    !run_add_entry(oa->run1, vcn, lcn, 1)) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+	attr =3D oa->attr;
+	t64 =3D le64_to_cpu(attr->nres.alloc_size);
+	if (size > t64) {
+		attr->nres.valid_size =3D attr->nres.data_size =3D
+			attr->nres.alloc_size =3D cpu_to_le64(size);
+	}
+	goto next_dirty_page_vcn;
+
+do_redo_1:
+	/*
+	 * Perform the Redo Pass, to restore all of the dirty pages to the same
+	 * contents that they had immediately before the crash
+	 * If the dirty page table is empty, then we can skip the entire Redo Pas=
s
+	 */
+	if (!dptbl || !dptbl->total)
+		goto do_undo_action;
+
+	rec_lsn =3D rlsn;
+
+	/*
+	 * Read the record at the Redo lsn, before falling
+	 * into common code to handle each record
+	 */
+	err =3D read_log_rec_lcb(log, rlsn, lcb_ctx_next, &lcb);
+	if (err)
+		goto out;
+
+	/*
+	 * Now loop to read all of our log records forwards,
+	 * until we hit the end of the file, cleaning up at the end
+	 */
+do_action_next:
+	frh =3D lcb->lrh;
+
+	if (LfsClientRecord !=3D frh->record_type)
+		goto read_next_log_do_action;
+
+	transact_id =3D le32_to_cpu(frh->transact_id);
+	rec_len =3D le32_to_cpu(frh->client_data_len);
+	lrh =3D lcb->log_rec;
+
+	if (!check_log_rec(lrh, rec_len, transact_id, bytes_per_attr_entry)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Ignore log records that do not update pages */
+	if (lrh->lcns_follow)
+		goto find_dirty_page;
+
+	goto read_next_log_do_action;
+
+find_dirty_page:
+	t16 =3D le16_to_cpu(lrh->target_attr);
+	t64 =3D le64_to_cpu(lrh->target_vcn);
+	dp =3D find_dp(dptbl, t16, t64);
+
+	if (!dp)
+		goto read_next_log_do_action;
+
+	if (rec_lsn < le64_to_cpu(dp->oldest_lsn))
+		goto read_next_log_do_action;
+
+	t16 =3D le16_to_cpu(lrh->target_attr);
+	if (t16 >=3D bytes_per_rt(oatbl)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	oe =3D Add2Ptr(oatbl, t16);
+
+	if (oe->next !=3D RESTART_ENTRY_ALLOCATED_LE) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	oa =3D oe->ptr;
+
+	if (!oa) {
+		err =3D -EINVAL;
+		goto out;
+	}
+	attr =3D oa->attr;
+
+	vcn =3D le64_to_cpu(lrh->target_vcn);
+
+	if (!run_lookup_entry(oa->run1, vcn, &lcn, NULL, NULL) ||
+	    lcn =3D=3D SPARSE_LCN) {
+		goto read_next_log_do_action;
+	}
+
+	/* Point to the Redo data and get its length */
+	data =3D Add2Ptr(lrh, le16_to_cpu(lrh->redo_off));
+	dlen =3D le16_to_cpu(lrh->redo_len);
+
+	/* Shorten length by any Lcns which were deleted */
+	saved_len =3D dlen;
+
+	for (i =3D le16_to_cpu(lrh->lcns_follow); i; i--) {
+		size_t j;
+		u32 alen, voff;
+
+		voff =3D le16_to_cpu(lrh->record_off) +
+		       le16_to_cpu(lrh->attr_off);
+		voff +=3D le16_to_cpu(lrh->cluster_off) << SECTOR_SHIFT;
+
+		/* If the Vcn question is allocated, we can just get out.*/
+		j =3D le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn);
+		if (dp->page_lcns[j + i - 1])
+			break;
+
+		if (!saved_len)
+			saved_len =3D 1;
+
+		/*
+		 * Calculate the allocated space left relative to the
+		 * log record Vcn, after removing this unallocated Vcn
+		 */
+		alen =3D (i - 1) << sbi->cluster_bits;
+
+		/*
+		 * If the update described this log record goes beyond
+		 * the allocated space, then we will have to reduce the length
+		 */
+		if (voff >=3D alen)
+			dlen =3D 0;
+		else if (voff + dlen > alen)
+			dlen =3D alen - voff;
+	}
+
+	/* If the resulting dlen from above is now zero, we can skip this log rec=
ord */
+	if (!dlen && saved_len)
+		goto read_next_log_do_action;
+
+	t16 =3D le16_to_cpu(lrh->redo_op);
+	if (can_skip_action(t16))
+		goto read_next_log_do_action;
+
+	/* Apply the Redo operation a common routine */
+	err =3D do_action(log, oe, lrh, t16, data, dlen, rec_len, &rec_lsn);
+	if (err)
+		goto out;
+
+	/* Keep reading and looping back until end of file */
+read_next_log_do_action:
+	err =3D read_next_log_rec(log, lcb, &rec_lsn);
+	if (!err && rec_lsn)
+		goto do_action_next;
+
+	lcb_put(lcb);
+	lcb =3D NULL;
+
+do_undo_action:
+	/* Scan Transaction Table */
+	tr =3D NULL;
+transaction_table_next:
+	tr =3D enum_rstbl(trtbl, tr);
+	if (!tr)
+		goto undo_action_done;
+
+	if (TransactionActive !=3D tr->transact_state || !tr->undo_next_lsn) {
+		free_rsttbl_idx(trtbl, PtrOffset(trtbl, tr));
+		goto transaction_table_next;
+	}
+
+	log->transaction_id =3D PtrOffset(trtbl, tr);
+	undo_next_lsn =3D le64_to_cpu(tr->undo_next_lsn);
+
+	/*
+	 * We only have to do anything if the transaction has
+	 * something its undo_next_lsn field
+	 */
+	if (!undo_next_lsn)
+		goto commit_undo;
+
+	/* Read the first record to be undone by this transaction */
+	err =3D read_log_rec_lcb(log, undo_next_lsn, lcb_ctx_undo_next, &lcb);
+	if (err)
+		goto out;
+
+	/*
+	 * Now loop to read all of our log records forwards,
+	 * until we hit the end of the file, cleaning up at the end
+	 */
+undo_action_next:
+
+	lrh =3D lcb->log_rec;
+	frh =3D lcb->lrh;
+	transact_id =3D le32_to_cpu(frh->transact_id);
+	rec_len =3D le32_to_cpu(frh->client_data_len);
+
+	if (!check_log_rec(lrh, rec_len, transact_id, bytes_per_attr_entry)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (lrh->undo_op =3D=3D cpu_to_le16(Noop))
+		goto read_next_log_undo_action;
+
+	oe =3D Add2Ptr(oatbl, le16_to_cpu(lrh->target_attr));
+	oa =3D oe->ptr;
+
+	t16 =3D le16_to_cpu(lrh->lcns_follow);
+	if (!t16)
+		goto add_allocated_vcns;
+
+	is_mapped =3D run_lookup_entry(oa->run1, le64_to_cpu(lrh->target_vcn),
+				     &lcn, &clen, NULL);
+
+	/*
+	 * If the mapping isn't already the table or the  mapping
+	 * corresponds to a hole the mapping, we need to make sure
+	 * there is no partial page already memory
+	 */
+	if (is_mapped && lcn !=3D SPARSE_LCN && clen >=3D t16)
+		goto add_allocated_vcns;
+
+	vcn =3D le64_to_cpu(lrh->target_vcn);
+	clst_off =3D vcn & (log->clst_per_page - 1);
+	vcn &=3D ~(log->clst_per_page - 1);
+
+add_allocated_vcns:
+	for (i =3D 0, vcn =3D le64_to_cpu(lrh->target_vcn),
+	    size =3D (vcn + 1) << sbi->cluster_bits;
+	     i < t16; i++, vcn +=3D 1, size +=3D sbi->cluster_size) {
+		attr =3D oa->attr;
+		if (!attr->non_res) {
+			if (size > le32_to_cpu(attr->res.data_size))
+				attr->res.data_size =3D cpu_to_le32(size);
+		} else {
+			if (size > le64_to_cpu(attr->nres.data_size))
+				attr->nres.valid_size =3D attr->nres.data_size =3D
+					attr->nres.alloc_size =3D
+						cpu_to_le64(size);
+		}
+	}
+
+	t16 =3D le16_to_cpu(lrh->undo_op);
+	if (can_skip_action(t16))
+		goto read_next_log_undo_action;
+
+	/* Point to the Redo data and get its length */
+	data =3D Add2Ptr(lrh, le16_to_cpu(lrh->undo_off));
+	dlen =3D le16_to_cpu(lrh->undo_len);
+
+	/* it is time to apply the undo action */
+	err =3D do_action(log, oe, lrh, t16, data, dlen, rec_len, NULL);
+
+read_next_log_undo_action:
+	/*
+	 * Keep reading and looping back until we have read the
+	 * last record for this transaction
+	 */
+	err =3D read_next_log_rec(log, lcb, &rec_lsn);
+	if (err)
+		goto out;
+
+	if (rec_lsn)
+		goto undo_action_next;
+
+commit_undo:
+	free_rsttbl_idx(trtbl, log->transaction_id);
+
+	log->transaction_id =3D 0;
+
+	goto transaction_table_next;
+
+undo_action_done:
+
+	ntfs_update_mftmirr(sbi, 0);
+
+	sbi->flags &=3D ~NTFS_FLAGS_NEED_REPLAY;
+
+end_reply:
+
+	err =3D 0;
+	if (is_ro)
+		goto out;
+
+	rh =3D ntfs_alloc(log->page_size, 1);
+	if (!rh) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	rh->rhdr.sign =3D NTFS_RSTR_SIGNATURE;
+	rh->rhdr.fix_off =3D cpu_to_le16(offsetof(RESTART_HDR, fixups));
+	t16 =3D (log->page_size >> SECTOR_SHIFT) + 1;
+	rh->rhdr.fix_num =3D cpu_to_le16(t16);
+	rh->sys_page_size =3D cpu_to_le32(log->page_size);
+	rh->page_size =3D cpu_to_le32(log->page_size);
+
+	t16 =3D QuadAlign(offsetof(RESTART_HDR, fixups) + sizeof(short) * t16);
+	rh->ra_off =3D cpu_to_le16(t16);
+	rh->minor_ver =3D cpu_to_le16(1); // 0x1A:
+	rh->major_ver =3D cpu_to_le16(1); // 0x1C:
+
+	ra2 =3D Add2Ptr(rh, t16);
+	memcpy(ra2, ra, sizeof(RESTART_AREA));
+
+	ra2->client_idx[0] =3D 0;
+	ra2->client_idx[1] =3D LFS_NO_CLIENT_LE;
+	ra2->flags =3D cpu_to_le16(2);
+
+	le32_add_cpu(&ra2->open_log_count, 1);
+
+	ntfs_fix_pre_write(&rh->rhdr, log->page_size);
+
+	err =3D ntfs_sb_write_run(sbi, &ni->file.run, 0, rh, log->page_size);
+	if (!err)
+		err =3D ntfs_sb_write_run(sbi, &log->ni->file.run, log->page_size,
+					rh, log->page_size);
+
+	ntfs_free(rh);
+	if (err)
+		goto out;
+
+out:
+	ntfs_free(rst);
+	if (lcb)
+		lcb_put(lcb);
+
+	/* Scan the Open Attribute Table to close all of the open attributes */
+	oe =3D NULL;
+	while ((oe =3D enum_rstbl(oatbl, oe))) {
+		rno =3D ino_get(&oe->ref);
+
+		if (oe->is_attr_name =3D=3D 1) {
+			ntfs_free(oe->ptr);
+			oe->ptr =3D NULL;
+			continue;
+		}
+
+		if (oe->is_attr_name)
+			continue;
+
+		oa =3D oe->ptr;
+		if (!oa)
+			continue;
+
+		run_close(&oa->run0);
+		ntfs_free(oa->attr);
+		if (oa->ni)
+			iput(&oa->ni->vfs_inode);
+		ntfs_free(oa);
+	}
+
+	ntfs_free(trtbl);
+	ntfs_free(oatbl);
+	ntfs_free(dptbl);
+	ntfs_free(attr_names);
+	ntfs_free(rst_info.r_page);
+
+	ntfs_free(ra);
+	ntfs_free(log->one_page_buf);
+
+	if (err)
+		sbi->flags |=3D NTFS_FLAGS_NEED_REPLAY;
+
+	if (err =3D=3D -EROFS)
+		err =3D 0;
+	else if (log->set_dirty)
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+
+	ntfs_free(log);
+
+	return err;
+}
--=20
2.25.2

