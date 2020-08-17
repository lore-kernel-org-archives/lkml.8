Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF63C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEB023B1B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678188;
	bh=A5cDiprIgsMvCjnEr/jbEPmBcCQcz0QY9VuRftCkkn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/Hsc9UIMPM17L6b/xnU2Vud20M5EWkAqD+v90YTbfSgJptNmTOToAw8CwHZ8JO72
	 wDW7ckGO3igupIJOprSGC/xlMSPhoy+KIxl2YXfR7NID8OPWBeucaJGHlJdTlfM1iP
	 vC8xC4jpVycDKiEI0jXp5FtDc4Cjt60Fewkq3DT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgHQP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbgHQP1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:27:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F06C23444;
        Mon, 17 Aug 2020 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678059;
        bh=A5cDiprIgsMvCjnEr/jbEPmBcCQcz0QY9VuRftCkkn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTTvxKXgUjw8k4S2ZvvKWefoWl+Jc/5+B5/EL0QdKtUl1/1mD4IvJfgM+7wphhTka
         kM6vr9KUaAdf56t77Z2tGgrCa35tGsmWvAfmp6d+TLQweWWND/jQ667DK6h9m7CpIh
         1iuV3+4AWE58cJZGNHD1ozrw/1c4BiDGdHon06mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 204/464] media: firewire: Using uninitialized values in node_probe()
Date:   Mon, 17 Aug 2020 17:12:37 +0200
Message-Id: <20200817143843.588911288@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 2505a210fc126599013aec2be741df20aaacc490 ]

If fw_csr_string() returns -ENOENT, then "name" is uninitialized.  So
then the "strlen(model_names[i]) <= name_len" is true because strlen()
is unsigned and -ENOENT is type promoted to a very high positive value.
Then the "strncmp(name, model_names[i], name_len)" uses uninitialized
data because "name" is uninitialized.

Fixes: 92374e886c75 ("[media] firedtv: drop obsolete backend abstraction")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/firewire/firedtv-fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/firewire/firedtv-fw.c b/drivers/media/firewire/firedtv-fw.c
index 97144734eb052..3f1ca40b9b987 100644
--- a/drivers/media/firewire/firedtv-fw.c
+++ b/drivers/media/firewire/firedtv-fw.c
@@ -272,6 +272,8 @@ static int node_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	name_len = fw_csr_string(unit->directory, CSR_MODEL,
 				 name, sizeof(name));
+	if (name_len < 0)
+		return name_len;
 	for (i = ARRAY_SIZE(model_names); --i; )
 		if (strlen(model_names[i]) <= name_len &&
 		    strncmp(name, model_names[i], name_len) == 0)
-- 
2.25.1



