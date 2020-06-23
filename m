Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8216C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED3B2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948707;
	bh=c9yhaVZFte8aBxpo53S69FcOzc9qCJlyf9/NVLNDsxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fv8lkrDRXolZvqDPT/zR8xokiQfW7/+Pe086ulJTKjZOEyV9ezF2kL2CRhGBa/59k
	 4apGG+RcbHAPxU9PypiIPYpRUMeDh6gyNlsx2kbJLNUye1OM/1A6aiiDavar67Q9d2
	 2/NPP9TS+Gr/WNuNbBLWKqCl+bLh0RFwoPi2dPV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393905AbgFWVo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387721AbgFWUBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:01:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACB42082F;
        Tue, 23 Jun 2020 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942514;
        bh=c9yhaVZFte8aBxpo53S69FcOzc9qCJlyf9/NVLNDsxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFlZNJeQWrVxF+mrLQIgiO7F0egdpHRWuThkqIHtWTlaJDpWzVu5inuzOoegjSAqq
         3zL/uJ7KFbvV+dvwF+SDkONdx4iv0pdj4vL4wbR3OTLbiMfHc3WZ2TnPrxnlZ3koA6
         eE5xfNzmEOuDNPyffG2px2aAql/smoRKNSdj7aFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Bolshakov <r.bolshakov@yadro.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Viacheslav Dubeyko <v.dubeiko@yadro.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 028/477] scsi: qla2xxx: Fix issue with adapters stopping state
Date:   Tue, 23 Jun 2020 21:50:25 +0200
Message-Id: <20200623195408.933391595@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viacheslav Dubeyko <v.dubeiko@yadro.com>

[ Upstream commit 803e45550b11c8e43d89812356fe6f105adebdf9 ]

The goal of the following command sequence is to restart the adapter.
However, the tgt_stop flag remains set, indicating that the adapter is
still in stopping state even after re-enabling it.

echo 0x7fffffff > /sys/module/qla2xxx/parameters/logging
modprobe target_core_mod
modprobe tcm_qla2xxx
mkdir /sys/kernel/config/target/qla2xxx
mkdir /sys/kernel/config/target/qla2xxx/<port-name>
mkdir /sys/kernel/config/target/qla2xxx/<port-name>/tpgt_1
echo 1 > /sys/kernel/config/target/qla2xxx/<port-name>/tpgt_1/enable
echo 0 > /sys/kernel/config/target/qla2xxx/<port-name>/tpgt_1/enable
echo 1 > /sys/kernel/config/target/qla2xxx/<port-name>/tpgt_1/enable

kernel: PID 1396:qla_target.c:1555 qlt_stop_phase1(): tgt_stop 0x0, tgt_stopped 0x0
kernel: qla2xxx [0001:00:02.0]-e803:1: PID 1396:qla_target.c:1567: Stopping target for host 1(c0000000033557e8)
kernel: PID 1396:qla_target.c:1579 qlt_stop_phase1(): tgt_stop 0x1, tgt_stopped 0x0
kernel: PID 1396:qla_target.c:1266 qlt_schedule_sess_for_deletion(): tgt_stop 0x1, tgt_stopped 0x0
kernel: qla2xxx [0001:00:02.0]-e801:1: PID 1396:qla_target.c:1316: Scheduling sess c00000002d5cd800 for deletion 21:00:00:24:ff:7f:35:c7
<skipped>
kernel: qla2xxx [0001:00:02.0]-290a:1: PID 340:qla_target.c:1187: qlt_unreg_sess sess c00000002d5cd800 for deletion 21:00:00:24:ff:7f:35:c7
<skipped>
kernel: qla2xxx [0001:00:02.0]-f801:1: PID 340:qla_target.c:1145: Unregistration of sess c00000002d5cd800 21:00:00:24:ff:7f:35:c7 finished fcp_cnt 0
kernel: PID 340:qla_target.c:1155 qlt_free_session_done(): tgt_stop 0x1, tgt_stopped 0x0
kernel: qla2xxx [0001:00:02.0]-4807:1: PID 346:qla_os.c:6329: ISP abort scheduled.
<skipped>
kernel: qla2xxx [0001:00:02.0]-28f1:1: PID 346:qla_os.c:3956: Mark all dev lost
kernel: PID 346:qla_target.c:1266 qlt_schedule_sess_for_deletion(): tgt_stop 0x1, tgt_stopped 0x0
kernel: qla2xxx [0001:00:02.0]-4808:1: PID 346:qla_os.c:6338: ISP abort end.
<skipped>
kernel: PID 1396:qla_target.c:6812 qlt_enable_vha(): tgt_stop 0x1, tgt_stopped 0x0
<skipped>
kernel: qla2xxx [0001:00:02.0]-4807:1: PID 346:qla_os.c:6329: ISP abort scheduled.
<skipped>
kernel: qla2xxx [0001:00:02.0]-4808:1: PID 346:qla_os.c:6338: ISP abort end.

qlt_handle_cmd_for_atio() rejects the request to send commands because the
adapter is in the stopping state:

kernel: PID 0:qla_target.c:4442 qlt_handle_cmd_for_atio(): tgt_stop 0x1, tgt_stopped 0x0
kernel: qla2xxx [0001:00:02.0]-3861:1: PID 0:qla_target.c:4447: New command while device c000000005314600 is shutting down
kernel: qla2xxx [0001:00:02.0]-e85f:1: PID 0:qla_target.c:5728: qla_target: Unable to send command to target

This patch calls qla_stop_phase2() in addition to qlt_stop_phase1() in
tcm_qla2xxx_tpg_enable_store() and tcm_qla2xxx_npiv_tpg_enable_store(). The
qlt_stop_phase1() marks adapter as stopping (tgt_stop == 0x1, tgt_stopped
== 0x0) but qlt_stop_phase2() marks adapter as stopped (tgt_stop == 0x0,
tgt_stopped == 0x1).

Link: https://lore.kernel.org/r/52be1e8a3537f6c5407eae3edd4c8e08a9545ea5.camel@yadro.com
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Viacheslav Dubeyko <v.dubeiko@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 1f0a185b2a957..bf00ae16b4873 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -949,6 +949,7 @@ static ssize_t tcm_qla2xxx_tpg_enable_store(struct config_item *item,
 
 		atomic_set(&tpg->lport_tpg_enabled, 0);
 		qlt_stop_phase1(vha->vha_tgt.qla_tgt);
+		qlt_stop_phase2(vha->vha_tgt.qla_tgt);
 	}
 
 	return count;
@@ -1111,6 +1112,7 @@ static ssize_t tcm_qla2xxx_npiv_tpg_enable_store(struct config_item *item,
 
 		atomic_set(&tpg->lport_tpg_enabled, 0);
 		qlt_stop_phase1(vha->vha_tgt.qla_tgt);
+		qlt_stop_phase2(vha->vha_tgt.qla_tgt);
 	}
 
 	return count;
-- 
2.25.1



