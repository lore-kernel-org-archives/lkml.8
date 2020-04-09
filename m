Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64884C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B05C20730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vluwa6jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDIJeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:34:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45560 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDIJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:34:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id v5so11101492wrp.12;
        Thu, 09 Apr 2020 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vFKY58EHDI35uWqTXFRcYlKrXpE9AmTqUd0lTuoZycc=;
        b=Vluwa6jv99EFa0y3quZjb49M0cgeiVocOWBa7QIiBKYvYGJY7V0w2GjxOzU0DvqBB2
         Nb+5jY6WzMvAFVr7+8Ys8cs/E8W+eSH7gVqp9SXwjXmeXK/fsM9P8X0pxGVa8CRje2WC
         g3y3AHexyE7aae+UXl275caZKdGy3bXMWW3dOX0pxx/kD46g0wwTIx60fxsbAA7dgI1x
         3xFzJ3zU4lMTfDFv0mkxtk/La2DIonGAbNbfo5hjR4wtvI44ZywsUdkq4FmMJmN3jx1p
         DfoQ6ycgEdCR5XR/YjooLFM2As21WdGwPk7QuF5UpUfyNAWu7GlOOrJdpnAnF0PHtHfj
         JPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vFKY58EHDI35uWqTXFRcYlKrXpE9AmTqUd0lTuoZycc=;
        b=OhMDXk93e7IuqQjxcvXPjaPxXYEilIIZlfTEdycrrQYrJkRPNEppBa60kthOvDGmTw
         rsim4XB4zY1DXaS2dcaLYy8UqhHW2kCd1j2DkjHpI5e0buDsNa3I2fc3e8vUikJyMnSW
         jomr+Ft+0axJEMuvZ7dmbc8CeSm6qPiHma5z7SO6e708T3VUf6SLbFP3aZkou5tAPcaF
         geK5ewnPqdRnBhUjymrO1iKKvfmZMkTjNHb/kT/e1KUP1s3ioZeEnUjpI7AVEiyuuubU
         nBsgnbcVABuVw08+lEV/vGn31w3IpLYv3MLDGa5B161WRw3+ejs1TVa+CMdcuj1m8iMx
         2kdQ==
X-Gm-Message-State: AGi0PubY5+IgboKAkxcqnBc6Zh8rRW5imifpOw9w9Ttg8PBiM7iB2Haq
        J3y8VSs+e5F4pqv415SU0nlE73PKSv4=
X-Google-Smtp-Source: APiQypKHK/kvsaEcZ/Cmzl/YN983+vE0TBvst1peF9mlnQUhbLlkLuwefhysx3YSl6P6fBAQtjQu9w==
X-Received: by 2002:adf:904e:: with SMTP id h72mr12881868wrh.367.1586424848253;
        Thu, 09 Apr 2020 02:34:08 -0700 (PDT)
Received: from localhost (ip1f115f16.dynamic.kabel-deutschland.de. [31.17.95.22])
        by smtp.gmail.com with ESMTPSA id h2sm1916942wmf.34.2020.04.09.02.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 02:34:07 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     oliver.graute@gmail.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] staging: fbtft: fb_st7789v: enabled inversion
Date:   Thu,  9 Apr 2020 11:24:05 +0200
Message-Id: <1586424250-25897-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Patchwork-Bot: notify
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Graute <oliver.graute@kococonnector.com>

Enable inversion mode

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 3c3f387936e8..84c5af2dc9a0 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -120,6 +120,10 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, PWCTRL1, 0xA4, 0xA1);
 
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
+
+	/* enable inversion mode */
+	write_reg(par, 0x21);
+
 	return 0;
 }
 
-- 
2.17.1

