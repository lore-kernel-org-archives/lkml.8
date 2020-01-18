Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F8C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF192469C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 16:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1x6Nbh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgARQ1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 11:27:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33847 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgARQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 11:27:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so25489941wrr.1;
        Sat, 18 Jan 2020 08:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvyJZhjuEWk4u+yzEdqQAWT6LP9lOv1PQ2DraIeccKk=;
        b=N1x6Nbh3OhmkDZXDXDeime7JMrIjFiEOFhRN15H8BCZ0Vq4ZOL01bCuDdPlFMQboDc
         wNJsbTRdaohlpWnJ5k7ukKpaNhbQY18oYqEesbN5KTPYWfjUPOR3CCWY0IsweJbHkVvt
         lBL11LT94IOYcX76nVwxcvC1BG4kOm8hAUQULoo9X8V+MHx3uXDnwvuez8xbKms61Sc4
         NyGCL26FCPAGygatFekP9QMn0LxvOC0iIozpEzqYTNjXu05RlWV2LHmSdcrethI/wJYH
         aM3KzF4p4qck8SDM3un/adaFufGklDqygn8BUZISaLvGZqRLFMtUotvUWh0J0f9qTSuD
         DWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvyJZhjuEWk4u+yzEdqQAWT6LP9lOv1PQ2DraIeccKk=;
        b=DLSOhWqb53tdjepz/PfbZqxZA8G1mbz/A3VTnEz7uQLfIJmF9IJ0A+o1kOdqipqQhV
         874I2bj8LP21PmvGvDwRjla3PdHpyQ5AMDfvLsDhIvsdz/8rh2ImgBJY35zPa4C8tYeh
         56QP38RI2XHHmjCiayQ9QSWmZYl6nAF8D9xYYWA4JWzRpOqsppA75BEyNJPfojCfXfUx
         01lOWVFoiviOE3G4bOb8Ov7xXM1qYW6IbJGxxaYR8gteJ/t/vusX78y4IfQ2gMC5dHWq
         HQaLCmLMrNfBC8pFlzEVQ7ahKcsdFYTG2o1GWG6JsS0MjmeBUYJfE+1iW4WuMMSoxtor
         nxgg==
X-Gm-Message-State: APjAAAVuNEAFJ5vMvFzE/F+p67VkuW4SJMuaYHtnKLRdrnxlMp+GqQ6H
        z97H9ShvAPVHg+TkcoVQFuLNj/3pyxw=
X-Google-Smtp-Source: APXvYqz3DT77tuB0Y8CR0Y/go8fzOV5YjVFGqP+cMmn+tU0j1sdTtph1GauXmRFjqTm3XX1HhR5ESQ==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr8761158wrt.381.1579364871435;
        Sat, 18 Jan 2020 08:27:51 -0800 (PST)
Received: from localhost.localdomain (bzq-109-66-195-69.red.bezeqint.net. [109.66.195.69])
        by smtp.googlemail.com with ESMTPSA id c4sm14509849wml.7.2020.01.18.08.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 08:27:50 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     carmeli.tamir@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/binfmt_script: Use existing functions to clarify the code
Date:   Sat, 18 Jan 2020 11:27:22 -0500
Message-Id: <20200118162723.21463-1-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies the  recently defined 'spacetab', 'next_non_spacetab'
and 'next_terminator' functions to more places in the code, improving 
its readability and reducing code duplication.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/binfmt_script.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index e9e6a6f4a35f..fc1c4a214690 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -88,19 +88,18 @@ static int load_script(struct linux_binprm *bprm)
 	*cp = '\0';
 	while (cp > bprm->buf) {
 		cp--;
-		if ((*cp == ' ') || (*cp == '\t'))
+		if (spacetab(*cp))
 			*cp = '\0';
 		else
 			break;
 	}
-	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
+	cp = next_non_spacetab(bprm->buf+2, buf_end);
 	if (*cp == '\0')
 		return -ENOEXEC; /* No interpreter name found */
 	i_name = cp;
 	i_arg = NULL;
-	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
-		/* nothing */ ;
-	while ((*cp == ' ') || (*cp == '\t'))
+	cp = next_terminator(cp, buf_end);
+	while (spacetab(*cp))
 		*cp++ = '\0';
 	if (*cp)
 		i_arg = cp;
-- 
2.19.1

