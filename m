Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBE3C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633D32076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046070;
	bh=1c08XC1B6rSTFGUlvN4qhU6O/IY9IRqHTGMA58kStOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DYVM5mpmI+VBC4oydxSWF5iYA5MxksLo584voCK1Ixw2+qGzgri3bqC1e3ePEOQsD
	 QujeKNlkR9wvQr0gRtCNVNGwLZGudFIEszw4jvwFeaUsQ504eAY+iaIgDtNiVOP0yT
	 k6mRjCi6bYQB+ceZpvf6kNvTDqIzKbOr/9lNqDxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbgDPOHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898484AbgDPNpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:45:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602C720732;
        Thu, 16 Apr 2020 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044710;
        bh=1c08XC1B6rSTFGUlvN4qhU6O/IY9IRqHTGMA58kStOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ohie3RPSQ61ivJx85zBI8rutV/fJsA+WcqYevpnDjaSoAY6DV1BH0zPFtFtAmkk6/
         GGlbeHKYkA8CYIIg7iVu8omqHHVphZSn/YdF/ktLqC3CkMuF+/WwjEzstth0vBnU+A
         Kx3LIhl4w7wE8izg2vBh/oUkTcS4LWd2F48abNQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 070/232] ASoC: dapm: connect virtual mux with default value
Date:   Thu, 16 Apr 2020 15:22:44 +0200
Message-Id: <20200416131324.125466105@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
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
 


