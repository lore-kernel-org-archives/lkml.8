Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D70DC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E89520880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="accRnb7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBWXRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:17:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46583 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgBWXRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:17:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id g4so1880615wro.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZgBbz79hmqX3go7ROSzEjM0UpKrjbRuPfObyg90ozQ=;
        b=accRnb7YPBpVPrrT3402sunXt6zcrpzUvR3P97NL9ptYD2H+bDJ5CD5t19bHvQcv+x
         gH9LiJHj0DmN2toqcGBhlWZqkWlZwhuvFuEd4hvCAokbWZq1IzbuDiIrsEyzL+/5k2PV
         rYluJm+kwydz79JKXhD45f+nmYRk3k8+qDcbU7UsbLdbummfG0rLhsJZFOAnCdn3hJWQ
         MUrIRKgW6opZQVzz+CmdrvzujzRiTkORFno1QTfo2xkkmxMLZDD0fS+eamHMvFx1aFvy
         OggQuWVDDvUw4XAoiiLQJssj7wPz9G9gcpZARA21h73swYIu79dEUSVcIDiqWTn2G932
         dijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZgBbz79hmqX3go7ROSzEjM0UpKrjbRuPfObyg90ozQ=;
        b=Tbnal5TePLND94WhBnG7VgJwTteOmfkXfowL6aa0gvr1ByjMSE+IYgmrpeYpLj76DX
         YVci2fVcc/wJrA9ke0jQYmOOEREFXvd6V37yzaaUmWrHwTUvcKDssMU3Ri1KicOaNQko
         jsiB85eDVUkwkEK8XCLPcjU62bAmSwdtBd0Y8vnjh6KbrT0VEK1xbJ4uWyHNdAr1Sxjx
         pJzpne6VtiO6ESDVlHoxMtSZ1h6jV52zkXmUxEai4lc5yoxa2yR+HTiIneNf7ALLcl53
         OzkopdPvP1ZbHn6VGDpzrkFVzEeTRoHQb2JwZLdRVYbENxKl7yPSrqWK11w9rsHIiryl
         TlYQ==
X-Gm-Message-State: APjAAAU7eEtn/At+ltKdNSqNgIiUfE5tEFh5IEb5Jwp8/W6Puubg6Dve
        jHdppUMdbxWmji1udL+n7g==
X-Google-Smtp-Source: APXvYqyNxVW28RSL6CwK86oMcDuKnijKUNx5elk9KZ8y0Eite7fkrEdmQi021hqZPcmISoJRXb6IiQ==
X-Received: by 2002:adf:e746:: with SMTP id c6mr59555131wrn.323.1582499873385;
        Sun, 23 Feb 2020 15:17:53 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:17:52 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 00/30] Lock warning cleanups  
Date:   Sun, 23 Feb 2020 23:16:41 +0000
Message-Id: <20200223231711.157699-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/30>
References: <0/30>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds missing annotations to various functions,
that register warnings of context imbalance when built with Sparse tool.
The adds fix the warnings, improve on readability odf the code
and give better insight or directive on what the functions are actually doing.

Jules Irenge (30):
  btrfs: Add missing annotation for release_extent_buffer()
  dax: Add missing annotations ofr dax_read_lock() and dax_read_unlock()
  xfs: Add missing annotation to xfs_ail_check()
  sctp: Add missing annotation for sctp_err_finish()
  sctp: Add missing annotation for sctp_transport_walk_start()
  sctp: Add missing annotation for sctp_transport_walk_stop()
  net: Add missing annotation for llc_seq_start()
  netrom: Add missing annotation for nr_info_start()
  netrom: Add missing annotation for nr_info_stop()
  net: netrom: Add missing annotation for nr_node_start()
  net: netrom: Add missing annotation for nr_node_stop()
  net: netrom: Add missing annotation for nr_neigh_start()
  net: netrom: Add missing annotation for nr_neigh_stop()
  dccp: Add missing annotation for dccp_child_process()
  af_unix: Add missing annotation for unix_wait_for_peer()
  proc: Add missing annotation for close_pdeo()
  mm/zsmalloc: Add missing annotation for zs_map_object()
  mm/zsmalloc: Add missing annotation for zs_unmap_object()
  mm/zsmalloc: Add missing annotation for migrate_write_lock()
  mm/zsmalloc: Add missing annotation for migrate_write_unlock()
  scsi: csiostor: Add missing annotation for csio_scsi_cleanup_io_q()
  ACPI: OSL: Add missing annotation for acpi_os_acquire_lock()
  ACPI: OSL: Add missing annotation for acpi_os_release_lock()
  dmaengine: mic_x100_dma: Add missing annotation for
    mic_dma_tx_submit_unlock()
  zram: Add missing annotatin for zram_slot_lock()
  zram: Add missing annotatin for zram_slot_unlock()
  habanalabs: Add missing annotation for goya_hw_queues_lock()
  habanalabs: Add missing annotation for goya_hw_queues_unlock()
  sgi-xp: Add missing annotation for xpc_disconnect_channel()
  sgi-xp: Add missing annotation for ocfs2_inode_cache_lock() and
    ocfs2_inode_cache_unlock()

 drivers/acpi/osl.c                  | 2 ++
 drivers/block/zram/zram_drv.c       | 2 ++
 drivers/dax/super.c                 | 4 ++--
 drivers/dma/mic_x100_dma.c          | 1 +
 drivers/misc/habanalabs/goya/goya.c | 2 ++
 drivers/misc/sgi-xp/xpc_channel.c   | 1 +
 drivers/scsi/csiostor/csio_scsi.c   | 1 +
 fs/btrfs/extent_io.c                | 1 +
 fs/ocfs2/inode.c                    | 2 ++
 fs/proc/inode.c                     | 1 +
 fs/xfs/xfs_trans_ail.c              | 1 +
 mm/zsmalloc.c                       | 4 ++++
 net/dccp/minisocks.c                | 1 +
 net/llc/llc_proc.c                  | 2 +-
 net/netrom/af_netrom.c              | 2 ++
 net/netrom/nr_route.c               | 4 ++++
 net/sctp/input.c                    | 1 +
 net/sctp/socket.c                   | 4 ++--
 net/unix/af_unix.c                  | 1 +
 19 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.24.1

