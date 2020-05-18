Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D650AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD56320715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825515;
	bh=PL0ZmeWqc8FMIxU1IoNlidUEHrZGToEEtWQh6ygb26A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=duDAhjCwurDLIA+vTHdkEmkLThkV8U7RSr88WSaauqWm2ZgOAgoj4AzL2C/Cr8Dbz
	 hFZhakubVr+2ZE75hZ9dKamk1amxy0E9gRlAoIJEEGleh5sR9V/99JpVuVa6uO8pSo
	 XcMJcG21tdi2ySCDdwCz/yRcdg2PJnffdKfwBBMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbgERSLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732742AbgERSEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:04:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE3F207D3;
        Mon, 18 May 2020 18:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825048;
        bh=PL0ZmeWqc8FMIxU1IoNlidUEHrZGToEEtWQh6ygb26A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqGwkfj0fIPc4Flsn8eKLfqNo28LsXlGk4a4Byyuv3DyIgjRvl/o0CMrYotNQLnSH
         oUfcEDSovy1y9TK8VHW9Wg5QU8yh+UryaDyzrLjU7XHHL5LYkKXHk3JycYwPdooACq
         O++CbT+CYerK6lkeHOeDwc90Qe7hS1HvHWxXROcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 081/194] ALSA: firewire-lib: fix function sizeof not defined error of tracepoints format
Date:   Mon, 18 May 2020 19:36:11 +0200
Message-Id: <20200518173538.508531112@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit 1034872123a06b759aba772b1c99612ccb8e632a ]

The snd-firewire-lib.ko has 'amdtp-packet' event of tracepoints. Current
printk format for the event includes 'sizeof(u8)' macro expected to be
extended in compilation time. However, this is not done. As a result,
perf tools cannot parse the event for printing:

$ mount -l -t debugfs
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
$ cat /sys/kernel/debug/tracing/events/snd_firewire_lib/amdtp_packet/format
...
print fmt: "%02u %04u %04x %04x %02d %03u %02u %03u %02u %01u %02u %s",
  REC->second, REC->cycle, REC->src, REC->dest, REC->channel,
  REC->payload_quadlets, REC->data_blocks, REC->data_block_counter,
  REC->packet_index, REC->irq, REC->index,
  __print_array(__get_dynamic_array(cip_header),
                __get_dynamic_array_len(cip_header),
                sizeof(u8))

$ sudo perf record -e snd_firewire_lib:amdtp_packet
  [snd_firewire_lib:amdtp_packet] function sizeof not defined
  Error: expected type 5 but read 0

This commit fixes it by obsoleting the macro with actual size.

Cc: <stable@vger.kernel.org>
Fixes: bde2bbdb307a ("ALSA: firewire-lib: use dynamic array for CIP header of tracing events")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20200503045718.86337-1-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/amdtp-stream-trace.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 16c7f6605511e..26e7cb555d3c5 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -66,8 +66,7 @@ TRACE_EVENT(amdtp_packet,
 		__entry->irq,
 		__entry->index,
 		__print_array(__get_dynamic_array(cip_header),
-			      __get_dynamic_array_len(cip_header),
-			      sizeof(u8)))
+			      __get_dynamic_array_len(cip_header), 1))
 );
 
 #endif
-- 
2.20.1



