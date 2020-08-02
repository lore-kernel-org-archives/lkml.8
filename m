Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0836AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63DF20759
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596395870;
	bh=8mJPcpXajO5FJPo1cyreA1HnNTrVKzaSbh/fZpZHFCE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tKj3PcPbcZPPCQKuzyze2CZA+g0sIdcOrOznRqhdhJjSLjpuDkKh0dWgIqFCs5pra
	 UnJ6tFh0AhOvL9QRC/umNqAhwKrna5xMGyxxu2FiUkeI/6BxphQRiQl4FrK8TunRTY
	 tFaNUKN1A8cM03QTHP7uYRafcNF6vywZw3j6apNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHBTRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgHBTRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:17:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB7C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 12:17:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so22425190edv.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/MWOv1sSTDG6A9AwuuN7flNVU2nslDeMJdrP9ZxY9+0=;
        b=ejggukgQiz/w02fif0Eg3vB6u/i0XIiY72Y0cEGZlKnHEDIbWu/UwadpIXV/FeBXWO
         KYAcg/CxunoDZj/THTyWHkDe/ZV6rT8FYj2pjTVTFdmR9LKKS81/EDM+hm6i9GRPbhCu
         pjRKPx7TnA3H6C5q+T8i86Dt5qY70ezYU0E2NrQftt266gzlVeWEAegVBaksd277yt3a
         NDaBoGnBNj550ppwlqBj3Kr8Gy3NEyylPPSrrIJcZTwK5AbU8xrNO6hKbWeODwgxuazU
         +YDzVNws7MsY4rgFN/v6xW2ZX+j+yQ5B0PqyGafeo1lOIwQbB+VlbkH+wR8eKTHpCfN2
         /bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=/MWOv1sSTDG6A9AwuuN7flNVU2nslDeMJdrP9ZxY9+0=;
        b=GYMV4vVuUzRgy8i3HU30K0XNi2GKvKQRAenVk66fTmxLMHom/qG7XDvV09rWzCuGGO
         z2n0MQGsOh2/sCP1X+nrcjtK3SRibf6QSjgRKr2iaFYBAMg0eWScsLXhq0dyGKqPiD8k
         5B0pOMEDgkWc2M8Ah8velSsrvsvRL7V8SVXImrgV25+Xm90gIuP1hi+hmNTKeVikO46e
         7e8TixFmkPWsClpJDbMrlKz/vQrw0+xhcknpl9MI+0ERbTFAwcHkCtjgKPbPaL8Gh1sK
         J/tVI7rtDbw2JeXNdY5zftGmEKYI1e70MZ93nGFM0EKEOIWYwKfWfDpUmrTO+cHWds5s
         7a1w==
X-Gm-Message-State: AOAM5321V5gLlGDRdbutPbeYjoalEDip6occhflzwvFo1jFQ/nIhNZ8a
        zVnl8shy8Xg/LHLU92LuFYM=
X-Google-Smtp-Source: ABdhPJzghixCS3l2Ffiw3s44pN2CGdioW+nFVMEc5gPe4xX26MyF1O7XK7vd9d3PgGxDT3eor2JRBQ==
X-Received: by 2002:aa7:c6ce:: with SMTP id b14mr13252741eds.208.1596395867682;
        Sun, 02 Aug 2020 12:17:47 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g6sm14200320ejz.19.2020.08.02.12.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 12:17:47 -0700 (PDT)
Date:   Sun, 2 Aug 2020 21:17:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fix
Message-ID: <20200802191745.GA122326@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-02

   # HEAD: bdd65589593edd79b6a12ce86b3b7a7c6dae5208 x86/i8259: Use printk_deferred() to prevent deadlock

A single fix for a potential deadlock when printing a message about spurious interrupts.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      x86/i8259: Use printk_deferred() to prevent deadlock


 arch/x86/kernel/i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index f3c76252247d..282b4ee1339f 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -207,7 +207,7 @@ static void mask_and_ack_8259A(struct irq_data *data)
 		 * lets ACK and report it. [once per IRQ]
 		 */
 		if (!(spurious_irq_mask & irqmask)) {
-			printk(KERN_DEBUG
+			printk_deferred(KERN_DEBUG
 			       "spurious 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}
