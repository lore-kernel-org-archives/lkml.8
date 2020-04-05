Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A5C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261242063A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iteKvEt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDERjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:39:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38396 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgDERjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:39:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id c21so6380521pfo.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SJLldAv3wlUP4miD08seoyhihcDWqt7hytUNGP3czOo=;
        b=iteKvEt6fzqQ72SzgAUxNop5XMhKa7ojicLFPFZ13w/lv3jIlFKgTJXcUg2ncdoeyH
         MuDNqPAPNZK87zDND/T0yKCCIYhzXhlRZPpPT7TMzas9F6Tlc+RFKUpq9cwUkHHPRp2g
         Gs73uNkl7wj+1nDEzhNvg659/C/7XJgdpxpqS5q82TIJzbY2FxaCrnpuGcLsT9q7BI/5
         4jwzhYtfdZLV/I8FptlpWqL36bD9X60XpKbTCgezYYkioqw/Y/y4VAgXz5SRM+SX3J2i
         gcHA0/JdqQIyy7VozXrVgj/QrADXAwPRxxjgHo5txccKY4jckLtllYsAtXYJ7ErurlZ4
         zM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SJLldAv3wlUP4miD08seoyhihcDWqt7hytUNGP3czOo=;
        b=d0P+ciF1J9lACyvVN/0Xe9F7krHanv/v32r+AXTNrAPl0uhR6wm6KnmmJ/TFW9EXkk
         rEqQeVMSENXTi12RDuv3jCN4VOF2iVCXOpGzJHBG7Shkhqqn4Y7DFH5OOhh934auNu4F
         4AWzB5XARWEjPx9zVdvF0QZliWjDXt09xCz5wLAtks71P+HUv2JwZnKCZubELF6gFmDg
         SnAd7bGc8IMFyA3gNJi3RHQChV1GbBBT6prVXj74HMfnGb1WAycppENACO84vDJeVcAi
         AaP6kUFLieygVLXaKcUKtCwOZ+1QpDcguo3TiIIfDko07UXTqJe/YhOzbgrsc1ciUass
         H9jw==
X-Gm-Message-State: AGi0PubAxIgsH1JVcGe4m/i30CmUE01kEl5fkDKfzLGpEepMhY5ed+Lo
        A6UIeOkgqHndy6LWBApoDd2OqKMt
X-Google-Smtp-Source: APiQypI0lN9WxXoBvcx/0GYJJHBidJ00O61KjrXMp7XF31x5bO/b0DTJGR84Qi4ARayTEZoTa3rccA==
X-Received: by 2002:aa7:8f22:: with SMTP id y2mr18358153pfr.300.1586108357885;
        Sun, 05 Apr 2020 10:39:17 -0700 (PDT)
Received: from cslab.localdomain (c-73-222-199-61.hsd1.ca.comcast.net. [73.222.199.61])
        by smtp.gmail.com with ESMTPSA id 185sm9786288pfz.119.2020.04.05.10.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:39:17 -0700 (PDT)
Date:   Sun, 5 Apr 2020 10:39:21 -0700
From:   Hill Ma <maahiuzeon@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/reboot/quirks: Add MacBook6,1 reboot quirk
Message-ID: <20200405173921.GA3453@cslab.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MacBook6,1 reboot would hang unless parameter reboot=pci is added.
This makes it automatic.

Signed-off-by: Hill Ma <maahiuzeon@gmail.com>
---
 arch/x86/kernel/reboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 3ca43be4f..8b8cebfd3 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -197,6 +197,14 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook5"),
 		},
 	},
+	{	/* Handle problems with rebooting on Apple MacBook6,1 */
+		.callback = set_pci_reboot,
+		.ident = "Apple MacBook6,1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook6,1"),
+		},
+	},
 	{	/* Handle problems with rebooting on Apple MacBookPro5 */
 		.callback = set_pci_reboot,
 		.ident = "Apple MacBookPro5",
-- 
2.26.0

