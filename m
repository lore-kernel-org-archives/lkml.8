Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB932076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046812;
	bh=1c08XC1B6rSTFGUlvN4qhU6O/IY9IRqHTGMA58kStOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxT5X83AIJG6uKjbdDFAQ+Ij7J/G4baJ8+++J01ZWgBkQWHyZoqDzGYr4VAoHMEK4
	 lUDpdJkjv1dsKUVzziV4sSCqT5mb+qVHcpO/3d9rrJ6i2zoz0CeYqIg5PPBE+NeEe6
	 c1h1rh6B0wUYelZ5Txfuk5SbzT7+3YpAKLbURvgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393967AbgDPOUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898845AbgDPNyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:54:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DAA20786;
        Thu, 16 Apr 2020 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045271;
        bh=1c08XC1B6rSTFGUlvN4qhU6O/IY9IRqHTGMA58kStOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbpfQsiU9EtbT+TSDevuZ/4GF0nydOUeChXz52hsNe8PY1Boa2wOrrvmbsDM/fvyY
         Ct98wOjEICEsPxGysLRcMppZdo8qBCg1/CF5sLuSmJeGGTUaRczTQ976MKW37Xurzo
         sxa9b0gLLuEUvIJPv6wG552q7vwi6Ce/lNVIYMlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.6 067/254] ASoC: dapm: connect virtual mux with default value
Date:   Thu, 16 Apr 2020 15:22:36 +0200
Message-Id: <20200416131334.275495011@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 이경택 <gt82.lee@samsung.com>

commit 3bbbb7728fc853d71dbce4073fef9f281fbfb4dd upstream.

Since a virtual mixer has no backing registers
to decide which path to connect,
it will try to match with initial state.
This is to ensure that the default mixer choice will be
correctly powered up during initialization.
Invert flag is used to select initial state of the virtual switch.
Since actual hardware can't be disconnected by virtual switch,
connected is better choice as initial state in many cases.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
Link: https://lore.kernel.org/r/01a301d60731$b724ea10$256ebe30$@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-dapm.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -802,7 +802,13 @@ static void dapm_set_mixer_path_status(s
 			val = max - val;
 		p->connect = !!val;
 	} else {
-		p->connect = 0;
+		/* since a virtual mixer has no backing registers to
+		 * decide which path to connect, it will try to match
+		 * with initial state.  This is to ensure
+		 * that the default mixer choice will be
+		 * correctly powered up during initialization.
+		 */
+		p->connect = invert;
 	}
 }
 


