Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA5C76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 08:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806232086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 08:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo0WTi+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgBPIPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 03:15:31 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55865 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgBPIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 03:15:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so5820938pjz.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 00:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IPq1zpwSVUc2BwMNSiorah9vIooglTMZdPMTCQ22xoc=;
        b=Oo0WTi+hQqvm1VHEf/nIVRrxg2LZMeWpjZ7dyqm6rbTfNnn2DMDppbQBIbkEURDkFC
         icrBsguuCHsETDnY1uLiclZk+gmXueTdeVmwv6NMHUfJUkYeYW7CwVPt8oe7zfCKxjbf
         dqmfhkmK/SeRP1Z64TlSzv0sYrxdaQMaXylQahVkW1bS1Ylsyr5cnH7K7lFJnlrST77u
         cbn6Kl8PmU/RpuwODNq9v269K06gNWiMdzsMWST15eSiZUveFJgwQvgOPBs5aT49k42b
         xO/X18v+AGw04Vz/hv2QwT9f7ND0XW6XikXnUUXqo1VUCUNYYpBpPczo81p3DvHsziXc
         G6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IPq1zpwSVUc2BwMNSiorah9vIooglTMZdPMTCQ22xoc=;
        b=cTVLcbisqpz82aXp6ZMfdsO6N4ZEvSI/MqJWK994k1I8ONHv3HMFDnWpO0BJL0wEvy
         YO3gYyio57TWbLAHjK9KfQNI4WCSfxuYQMwPRH4/9koiyKA7FZOQPk8Ma6Vs9UU+WWu+
         MteMx0wuScWlcUsd8fAU4r2M3QOeMAckm06whlGh9rjrkLwVZiO4nI2aKEk/V6rDZMfW
         0oKh6UH/Py2JiBAWLPaWpO1cS84QVcKeNh+sJ7wHzwdL49mw3hutkmbDYhJo2og28A29
         3SNx6KuowyT/M0sFtolukzOSuINpHeLIqwmZ0zbExPdt/f/L7FJ1jnTdKLSQIRdOLulE
         bF/w==
X-Gm-Message-State: APjAAAX4zuVdVW7WSEJBYHdCFc9opBvUMVKGl6rSC4DfDPygG0yTrHON
        nsVF66jUAvVDBpvwoUqgp9DiH5vGo4E=
X-Google-Smtp-Source: APXvYqzvyMehH+mrAJXZmiw69LuUF8vusZsGHy4/DN1NAam4f7aZYfm5AmQqbwcX1sfmh7nAnRM/Ng==
X-Received: by 2002:a17:90a:c697:: with SMTP id n23mr12920806pjt.37.1581840929179;
        Sun, 16 Feb 2020 00:15:29 -0800 (PST)
Received: from SunnyPranay.localdomain ([106.51.196.103])
        by smtp.gmail.com with ESMTPSA id r14sm12226616pfh.10.2020.02.16.00.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 00:15:28 -0800 (PST)
From:   sunnypranay <mpranay2017@gmail.com>
To:     abbotti@mev.co.uk
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        sunnypranay <mpranay2017@gmail.com>
Subject: [PATCH] Staging: comedi: drivers: fixed errors warning coding style issue
Date:   Sun, 16 Feb 2020 13:45:18 +0530
Message-Id: <20200216081518.3516-1-mpranay2017@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: sunnypranay <mpranay2017@gmail.com>
---
 drivers/staging/comedi/drivers.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index 750a6ff3c03c..76395de100a6 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(comedi_alloc_subdevices);
  * On success, @s->readback points to the first element of the array, which
  * is zero-filled.  The low-level driver is responsible for updating its
  * contents.  @s->insn_read will be set to comedi_readback_insn_read()
- * unless it is already non-NULL.
+ * Unless it is already non-NULL.
  *
  * Returns 0 on success, -EINVAL if the subdevice has no channels, or
  * -ENOMEM on allocation failure.
@@ -282,8 +282,20 @@ EXPORT_SYMBOL_GPL(comedi_readback_insn_read);
  * continue waiting or some other value to stop waiting (generally 0 if the
  * condition occurred, or some error value).
  *
- * Returns -ETIMEDOUT if timed out, otherwise the return value from the
- * callback function.
+ * Redback_insn_read() - A generic (*insn_read) for subdevice readback.
+ * @dev: COMEDI device.
+ * @s: COMEDI subdevice.
+ * @insn: COMEDI instruction.
+ * @data: Pointer to return the readback data.
+ * Handles the %INSN_READ instruction for subdevices that use the readback
+ * array allocated by comedi_alloc_subdev_readback().  It may be used
+ * directly as the subdevice's handler (@s->insn_read) or called via a
+ * wrapper.
+ * @insn->n is normally 1, which will read a single value.  If higher, the
+ * same element of the readback array will be read multiple times.
+ * Returns @insn->n on success,
+ * or -EINVAL if @s->readback is NULL.turns -ETIMEDOUT if timed out,
+ * otherwise the return value from the callback function.
  */
 int comedi_timeout(struct comedi_device *dev,
 		   struct comedi_subdevice *s,
-- 
2.17.1

