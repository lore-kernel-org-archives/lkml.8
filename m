Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5CCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844B220658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693677;
	bh=8W+7jwLj8l+bpUwYU6QTJexa6n0bhJcPmzX46pZ5JNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j1M2rqY7YowRM6l2hvkI4nGR5tK577dz5WmhMpny8MsA0qwd1RwfIXRacxhUQcTSu
	 6h6w089GNw89xhsjH6YSHUPz5/7ToeYWP1bC3injuFI0aNSjyM2yaiEHYGBRZQXqXD
	 /yOM8FUY9fmZq1kii2jweh742kzYHqRpQr//kXRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbgHQTr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbgHQPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:20:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF912065C;
        Mon, 17 Aug 2020 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677627;
        bh=8W+7jwLj8l+bpUwYU6QTJexa6n0bhJcPmzX46pZ5JNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kq/4R9VOlCx6FvvCXKNj2/gkAfpMok/xTyqUZTyTYhe+3bbCBpPkd+Uk+u31PgIH5
         xTmCQkVSxGv2nXl1COysmspGlF0P66ZBrye6eGud7S2Cy5Z29YoMrhOKpz8BHRnVfV
         drhhA/RhmzhNTB26guBAWaWqqOxHnMvjCNbhEGkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 049/464] tpm: Require that all digests are present in TCG_PCR_EVENT2 structures
Date:   Mon, 17 Aug 2020 17:10:02 +0200
Message-Id: <20200817143836.108125215@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Hicks <tyhicks@linux.microsoft.com>

[ Upstream commit 7f3d176f5f7e3f0477bf82df0f600fcddcdcc4e4 ]

Require that the TCG_PCR_EVENT2.digests.count value strictly matches the
value of TCG_EfiSpecIdEvent.numberOfAlgorithms in the event field of the
TCG_PCClientPCREvent event log header. Also require that
TCG_EfiSpecIdEvent.numberOfAlgorithms is non-zero.

The TCG PC Client Platform Firmware Profile Specification section 9.1
(Family "2.0", Level 00 Revision 1.04) states:

 For each Hash algorithm enumerated in the TCG_PCClientPCREvent entry,
 there SHALL be a corresponding digest in all TCG_PCR_EVENT2 structures.
 Note: This includes EV_NO_ACTION events which do not extend the PCR.

Section 9.4.5.1 provides this description of
TCG_EfiSpecIdEvent.numberOfAlgorithms:

 The number of Hash algorithms in the digestSizes field. This field MUST
 be set to a value of 0x01 or greater.

Enforce these restrictions, as required by the above specification, in
order to better identify and ignore invalid sequences of bytes at the
end of an otherwise valid TPM2 event log. Firmware doesn't always have
the means necessary to inform the kernel of the actual event log size so
the kernel's event log parsing code should be stringent when parsing the
event log for resiliency against firmware bugs. This is true, for
example, when firmware passes the event log to the kernel via a reserved
memory region described in device tree.

POWER and some ARM systems use the "linux,sml-base" and "linux,sml-size"
device tree properties to describe the memory region used to pass the
event log from firmware to the kernel. Unfortunately, the
"linux,sml-size" property describes the size of the entire reserved
memory region rather than the size of the event long within the memory
region and the event log format does not include information describing
the size of the event log.

tpm_read_log_of(), in drivers/char/tpm/eventlog/of.c, is where the
"linux,sml-size" property is used. At the end of that function,
log->bios_event_log_end is pointing at the end of the reserved memory
region. That's typically 0x10000 bytes offset from "linux,sml-base",
depending on what's defined in the device tree source.

The firmware event log only fills a portion of those 0x10000 bytes and
the rest of the memory region should be zeroed out by firmware. Even in
the case of a properly zeroed bytes in the remainder of the memory
region, the only thing allowing the kernel's event log parser to detect
the end of the event log is the following conditional in
__calc_tpm2_event_size():

        if (event_type == 0 && event_field->event_size == 0)
                size = 0;

If that wasn't there, __calc_tpm2_event_size() would think that a 16
byte sequence of zeroes, following an otherwise valid event log, was
a valid event.

However, problems can occur if a single bit is set in the offset
corresponding to either the TCG_PCR_EVENT2.eventType or
TCG_PCR_EVENT2.eventSize fields, after the last valid event log entry.
This could confuse the parser into thinking that an additional entry is
present in the event log and exposing this invalid entry to userspace in
the /sys/kernel/security/tpm0/binary_bios_measurements file. Such
problems have been seen if firmware does not fully zero the memory
region upon a warm reboot.

This patch significantly raises the bar on how difficult it is for
stale/invalid memory to confuse the kernel's event log parser but
there's still, ultimately, a reliance on firmware to properly initialize
the remainder of the memory region reserved for the event log as the
parser cannot be expected to detect a stale but otherwise properly
formatted firmware event log entry.

Fixes: fd5c78694f3f ("tpm: fix handling of the TPM 2.0 event logs")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tpm_eventlog.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 64356b199e945..739ba9a03ec16 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -211,9 +211,16 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
-	/* Check if event is malformed. */
+	/*
+	 * Perform validation of the event in order to identify malformed
+	 * events. This function may be asked to parse arbitrary byte sequences
+	 * immediately following a valid event log. The caller expects this
+	 * function to recognize that the byte sequence is not a valid event
+	 * and to return an event size of 0.
+	 */
 	if (memcmp(efispecid->signature, TCG_SPECID_SIG,
-		   sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
+		   sizeof(TCG_SPECID_SIG)) ||
+	    !efispecid->num_algs || count != efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
-- 
2.25.1



