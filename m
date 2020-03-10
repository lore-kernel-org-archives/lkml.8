Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C300C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DBD208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845300;
	bh=TCnicF+IulriJkqk77wcgKGaA9yvCkJFj5VIQHJujAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iAbTQheuM/PV8StWIP82P4JU2GuUXoLiQL4SMWFRXE/qn6WZd+EcgcgW3pc2cKECc
	 p4BGOGBMh8nHEqpgRkO9yoy5rc98ixSnTDmRASZgqQvIltIUoOKioKz2cXZyKQiFFr
	 3s5M/Flp1DlX8JyxHJDogLyXDr6C1VnsCM1118jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgCJNBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbgCJNBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B640324649;
        Tue, 10 Mar 2020 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845290;
        bh=TCnicF+IulriJkqk77wcgKGaA9yvCkJFj5VIQHJujAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMDPxwWINuwGmDm+ddn6/Kom31LBjQ28jsVStW2guZTJoWNME613fL+cO5cwF1sNY
         pXim7lZkhS915GoaXeZme6FtypKKW1cYUOo9aiPHYgBxb0E50Ug2VCASD6KLYEfdcw
         EN31TV6jgmSEq4BAX1oFXUOvzh8KYi0njuc9nqqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dragos Tarcatu <dragos_tarcatu@mentor.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 131/189] ASoC: topology: Fix memleak in soc_tplg_manifest_load()
Date:   Tue, 10 Mar 2020 13:39:28 +0100
Message-Id: <20200310123653.062370320@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

commit 242c46c023610dbc0213fc8fb6b71eb836bc5d95 upstream.

In case of ABI version mismatch, _manifest needs to be freed as
it is just a copy of the original topology manifest. However, if
a driver manifest handler is defined, that would get executed and
the cleanup is never reached. Fix that by getting the return status
of manifest() instead of returning directly.

Fixes: 583958fa2e52 ("ASoC: topology: Make manifest backward compatible from ABI v4")
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Link: https://lore.kernel.org/r/20200207185325.22320-3-dragos_tarcatu@mentor.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-topology.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2503,7 +2503,7 @@ static int soc_tplg_manifest_load(struct
 {
 	struct snd_soc_tplg_manifest *manifest, *_manifest;
 	bool abi_match;
-	int err;
+	int ret = 0;
 
 	if (tplg->pass != SOC_TPLG_PASS_MANIFEST)
 		return 0;
@@ -2516,19 +2516,19 @@ static int soc_tplg_manifest_load(struct
 		_manifest = manifest;
 	} else {
 		abi_match = false;
-		err = manifest_new_ver(tplg, manifest, &_manifest);
-		if (err < 0)
-			return err;
+		ret = manifest_new_ver(tplg, manifest, &_manifest);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* pass control to component driver for optional further init */
 	if (tplg->comp && tplg->ops && tplg->ops->manifest)
-		return tplg->ops->manifest(tplg->comp, tplg->index, _manifest);
+		ret = tplg->ops->manifest(tplg->comp, tplg->index, _manifest);
 
 	if (!abi_match)	/* free the duplicated one */
 		kfree(_manifest);
 
-	return 0;
+	return ret;
 }
 
 /* validate header magic, size and type */


