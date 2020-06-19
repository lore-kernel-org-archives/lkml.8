Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54C0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A576021707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584037;
	bh=2XIXSXOLf1PgbSfEZzyX74dHJNMxOrXjFNQAdwEwl90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpRcoF0kdurbxS418yDYqXf4SGeHazmZma2zkl4S0EyyEgPJGpswZ7SUCkHCEx1Sw
	 aJeWg6IoREJyQ5CN6VyTIsRs7MEcxyVTeH+b56Ed6WvuzzlPFOjdT2TfC4mJo32Jkh
	 l7+qyk2eBKDHb35BYK0n7Jp9lGHQ98NQs+l+iSmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbgFSO4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390021AbgFSO4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:56:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA8B206F7;
        Fri, 19 Jun 2020 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578562;
        bh=2XIXSXOLf1PgbSfEZzyX74dHJNMxOrXjFNQAdwEwl90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMkocnPXtpiiogABbbkdrpBGvM15caHd/6vuiBmhDJuVufJmZkPccaRxmcXabf91m
         lZQYH+eQmH/j+64nXwe9hDFp2ECdyhgTBRsrmhJI5APe6ejYCOSZQXizEsetZYU+se
         ZXi1UwJGQVIRualA+LmBtarp9s7Pt0Y2lUTK9+yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>,
        Antonino Daplas <adaplas@pol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4.19 070/267] video: fbdev: w100fb: Fix a potential double free.
Date:   Fri, 19 Jun 2020 16:30:55 +0200
Message-Id: <20200619141652.255904241@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 18722d48a6bb9c2e8d046214c0a5fd19d0a7c9f6 upstream.

Some memory is vmalloc'ed in the 'w100fb_save_vidmem' function and freed in
the 'w100fb_restore_vidmem' function. (these functions are called
respectively from the 'suspend' and the 'resume' functions)

However, it is also freed in the 'remove' function.

In order to avoid a potential double free, set the corresponding pointer
to NULL once freed in the 'w100fb_restore_vidmem' function.

Fixes: aac51f09d96a ("[PATCH] w100fb: Rewrite for platform independence")
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Antonino Daplas <adaplas@pol.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: <stable@vger.kernel.org> # v2.6.14+
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200506181902.193290-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/w100fb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -583,6 +583,7 @@ static void w100fb_restore_vidmem(struct
 		memsize=par->mach->mem->size;
 		memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_extmem, memsize);
 		vfree(par->saved_extmem);
+		par->saved_extmem = NULL;
 	}
 	if (par->saved_intmem) {
 		memsize=MEM_INT_SIZE;
@@ -591,6 +592,7 @@ static void w100fb_restore_vidmem(struct
 		else
 			memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_intmem, memsize);
 		vfree(par->saved_intmem);
+		par->saved_intmem = NULL;
 	}
 }
 


