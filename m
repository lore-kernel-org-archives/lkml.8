Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8932083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596060752;
	bh=uuWR9RWRb4B0cH6RJkoUD/WtjpUMu5kNVDOG1H0bw2A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vxMiHtCTxCTSj+nbxBxAuaBQsV3yuXXFlfzK9guWCx8mvvOnAbgoGDyMcvWYlso3/
	 SnJi8JVIj8JuleQPhvEo9DnAAclqIRmZZit1FICSuBCjy6daVSm3TzLC6tmlS+0PXf
	 jeKg2UNCjKYiay9LlVQxCrrfyz0noqRrkxOg0YLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgG2WMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgG2WMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:12:31 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A212075D;
        Wed, 29 Jul 2020 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596060750;
        bh=uuWR9RWRb4B0cH6RJkoUD/WtjpUMu5kNVDOG1H0bw2A=;
        h=Date:From:To:Cc:Subject:From;
        b=ja3dDLHmzZ18TqbJR1kw1hok45YfyoAI24ku9snZTjIk8Jn3IFFUt3ts6co3e8EV/
         0Cq710zV2Hds7hx3wXtFxzEVHGmGyDaZt9iRhRiKZRpWCNAqZ/v+RZMYal8A18ufxO
         b2BU4E8xuNogYO8vdvOpEYRYLYNgiYnQqUQa+55s=
Date:   Wed, 29 Jul 2020 17:18:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] ALSA: vmaster: Use flex_array_size() helper in memcpy()
Message-ID: <20200729221829.GA10623@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the flex_array_size() helper to calculate the size of a
flexible array member within an enclosing structure.

This helper offers defense-in-depth against potential integer overflows
and makes it explicitly clear that we are dealing with a flexible array
member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/core/vmaster.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index ab36f9898711..21ce4082cb5f 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -262,7 +262,8 @@ int _snd_ctl_add_follower(struct snd_kcontrol *master,
 		return -ENOMEM;
 	srec->kctl = follower;
 	srec->follower = *follower;
-	memcpy(srec->follower.vd, follower->vd, follower->count * sizeof(*follower->vd));
+	memcpy(srec->follower.vd, follower->vd, flex_array_size(srec, follower.vd,
+								srec->follower.count));
 	srec->master = master_link;
 	srec->flags = flags;
 
-- 
2.27.0

