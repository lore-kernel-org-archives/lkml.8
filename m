Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EA2C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641BC206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387209;
	bh=X2fDvyENdeVAPEi4xR7NUbVfmUWj1c8mEiQ43bYDMdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s6oN+TVJ6FQ0snY+yfZzbveIF48oBy1tLGg/y3wTjW3AcDo3aV9Q2FPfGHlgzh5U+
	 C6oHaDDpCn1zG0K6yrh8j4Cr8t7xA6+q1/affgJGCjavCjgkgkFEcCbQ235B6GwrY0
	 7hKCTnN2UxDk+ww8J454ud7SYhu1ShQklaVmWGn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgDTMxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgDTMqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D53206E9;
        Mon, 20 Apr 2020 12:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386809;
        bh=X2fDvyENdeVAPEi4xR7NUbVfmUWj1c8mEiQ43bYDMdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFoh7kY/UQ7SpVa614DPzApnhVOwEvo+7gIV9Sm0W1paJp6DCulY7X/Z8DkLtVU77
         BpAYx7snf9yhxk9pC7HTptPTW0rtmESvbyNY4e52UAU1p7xKS3WQ/F1lBVbVpAoMMf
         Aq/NbIeRXNIIQLAAPaCoZcWlNM0DCQb20t8eTTIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 34/60] ASoC: Intel: mrfld: fix incorrect check on p->sink
Date:   Mon, 20 Apr 2020 14:39:12 +0200
Message-Id: <20200420121510.497940721@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit f5e056e1e46fcbb5f74ce560792aeb7d57ce79e6 upstream.

The check on p->sink looks bogus, I believe it should be p->source
since the following code blocks are related to p->source. Fix
this by replacing p->sink with p->source.

Fixes: 24c8d14192cc ("ASoC: Intel: mrfld: add DSP core controls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Addresses-Coverity: ("Copy-paste error")
Link: https://lore.kernel.org/r/20191119113640.166940-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/atom/sst-atom-controls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1333,7 +1333,7 @@ int sst_send_pipe_gains(struct snd_soc_d
 				dai->capture_widget->name);
 		w = dai->capture_widget;
 		snd_soc_dapm_widget_for_each_source_path(w, p) {
-			if (p->connected && !p->connected(w, p->sink))
+			if (p->connected && !p->connected(w, p->source))
 				continue;
 
 			if (p->connect &&  p->source->power &&


