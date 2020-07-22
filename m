Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08373C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA6E20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595441401;
	bh=NmBDYRLXE7yLQ1W+FnfOFlvtKPX0dfdhfwoZ8FHxDT8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=i6sGbhQQRUuYy17Ltl1HAXJTBYfD4bmoEAO26ORUeLxDSljW1vYLUKjtjp5Sr/K3r
	 59LHV3FwXDNoaR/jEBh8Hfel38nbrvt7mEI6SLmN6VGPcqXpquQWXafcM3pngwanzR
	 s54yDswiKPw4L4kUJhxnrzfr9nqXtV6KKX5NYOJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgGVSKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGVSKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:10:00 -0400
Received: from embeddedor (unknown [201.162.161.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5556820787;
        Wed, 22 Jul 2020 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595441399;
        bh=NmBDYRLXE7yLQ1W+FnfOFlvtKPX0dfdhfwoZ8FHxDT8=;
        h=Date:From:To:Cc:Subject:From;
        b=iYVbcMsE8a7W1Haau6s6tTXgFjXgPMpVvTDvGoDTQ/dz8fhA6nyAWpXmz7iDBWBqw
         GxmT9dleWu7/T82+SNsyX4P3Ijv+Tn3KL0VDu3vX9o6zKApBdYkdhO7OTaxzhPE71r
         qZoWTJ1H9pXPj9bYXH6AaJke5ycpJ77sRlRUixmw=
Date:   Wed, 22 Jul 2020 13:15:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] mei: hdcp: Replace one-element array with
 flexible-array member
Message-ID: <20200722181534.GA31357@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

Also, make use of the array_size() helper instead of the open-coded
version in memcpy(). These sorts of multiplication factors need to
be wrapped in array_size().

And while there, use the preferred form for passing a size of a struct.
The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the pointer variable type is
changed but the corresponding sizeof that is passed as argument is not.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://github.com/KSPP/linux/issues/79

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
 drivers/misc/mei/hdcp/mei_hdcp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index e6c3dc595617..d1d3e025ca0e 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -572,7 +572,7 @@ static int mei_hdcp_verify_mprime(struct device *dev,
 	       HDCP_2_2_MPRIME_LEN);
 	drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data->seq_num_m);
 	memcpy(verify_mprime_in.streams, data->streams,
-	       (data->k * sizeof(struct hdcp2_streamid_type)));
+	       array_size(data->k, sizeof(*data->streams)));
 
 	verify_mprime_in.k = cpu_to_be16(data->k);
 
diff --git a/drivers/misc/mei/hdcp/mei_hdcp.h b/drivers/misc/mei/hdcp/mei_hdcp.h
index 18ffc773fa18..834757f5e072 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.h
+++ b/drivers/misc/mei/hdcp/mei_hdcp.h
@@ -358,7 +358,7 @@ struct wired_cmd_repeater_auth_stream_req_in {
 	u8				seq_num_m[HDCP_2_2_SEQ_NUM_LEN];
 	u8				m_prime[HDCP_2_2_MPRIME_LEN];
 	__be16				k;
-	struct hdcp2_streamid_type	streams[1];
+	struct hdcp2_streamid_type	streams[];
 } __packed;
 
 struct wired_cmd_repeater_auth_stream_req_out {
-- 
2.27.0

