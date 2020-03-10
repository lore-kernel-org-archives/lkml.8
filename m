Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4554DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CDD24693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844794;
	bh=n5PxpcwKOAKXVaitGWLMCi94hjn3AKV+v4ghTxz5N6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2feBDsFvMH7AEv6LcALdvZlmg2x49Trgnitvhw4uj4jrC9gozJXTV+0FGj2MYFPFa
	 qkeOvDrR4b964CQoAzWEyifs/A/YZ9PKU9A5DvmiqnfMAjSe1PSmtaUW86Q2chJwck
	 QUJBSdPpKcuw1FZnsqSf4e+KdIjTCxR2TSSRaZtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgCJMxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbgCJMxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA2924692;
        Tue, 10 Mar 2020 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844786;
        bh=n5PxpcwKOAKXVaitGWLMCi94hjn3AKV+v4ghTxz5N6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHhCAtMPSOzpj5cmPDO4jNFW1C47DQtGDVbotJI6bfIGUjAnwUZmSucxiay/nqK96
         t/ogYLmp6ehg8OMw1DxwmxZHp69Nn/KZFp0IlHchVXVnIDIK6qesR1enbSDUihafR/
         n573WIecmbXS7LMBfUqrufNUku2ISPcCDJtZBo4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 119/168] ASoC: SOF: Fix snd_sof_ipc_stream_posn()
Date:   Tue, 10 Mar 2020 13:39:25 +0100
Message-Id: <20200310123647.456032798@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 613cea5935e83cb5a7d182ee3f98d54620e102e2 upstream.

We're passing "&posn" instead of "posn" so it ends up corrupting
memory instead of doing something useful.

Fixes: 53e0c72d98ba ("ASoC: SOF: Add support for IPC IO between DSP and Host")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200303101858.ytehbrivocyp3cnf@kili.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/sof/ipc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -497,7 +497,7 @@ int snd_sof_ipc_stream_posn(struct snd_s
 
 	/* send IPC to the DSP */
 	err = sof_ipc_tx_message(sdev->ipc,
-				 stream.hdr.cmd, &stream, sizeof(stream), &posn,
+				 stream.hdr.cmd, &stream, sizeof(stream), posn,
 				 sizeof(*posn));
 	if (err < 0) {
 		dev_err(sdev->dev, "error: failed to get stream %d position\n",


