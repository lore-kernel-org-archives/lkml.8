Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9869AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE222070C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWqXTSOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgAUNrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:47:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43850 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgAUNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:47:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so3231874wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 05:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GlVSvFefthhvDndxHquihB1g9N3pysqIKkyZHPQ+LOQ=;
        b=gWqXTSOR7c3TA7dwjaF4xYiCZIGscmbPPMzPaK//HkoFkOPNoFymt3z3u6KM3fEdJo
         YdpnAcVFZ2kRZHa3fL5p8xP9qWPKL4baQ6IbaO03oLZxR+yb0uQEQY21sWxcUupxqrWG
         OSLv6wjpHspDdc6KPDJtJ57aDFgM088BwF6iY0b7XYd/e2m1jikcBKO6sMpTafb0s33D
         HkaSpCRuNxe84bWRJ3Gd3AT/ZgGU/BQ/YCMGczMY8g9FymMb9JfrIRVa831npeV1d5Gv
         Uds0sYJ9LXBRLiha54LT8le77VzIwPA20s1Xw/Xx+4YBG/4QP1b9x6amWyftIdn7F06l
         lBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GlVSvFefthhvDndxHquihB1g9N3pysqIKkyZHPQ+LOQ=;
        b=PKIE/aitB0QCRhghnyaHAkbSNZ0OjtfYA/QA8PSZRZNcKhtbt0gOqgN3yz23LIOHoc
         kbhdaA9l48Uu4Cn3PkCyxYhGHZyjZPOfZXziIXVKZj2zGGgYErmx08lSFk561eUjRX0c
         uD4sGoLnj2/Q6h7B3mtf2ONQrMkh7tqRmHXA8xLlRw//KAjDu1BPbf23Fd9H4gv6mTKe
         2G7KUyPy/TvPohMbroL3C5IPutVyVVt6fGcd/uPnlKDa4nbYbE/o4jfnafVZ9QaN1zy3
         Us9cHndHcL3iVDG7N6yZXJAyeDVnA8fisccY+KASFTN9z1xSnHnLYPWUfaRS/EEdz2b2
         RecA==
X-Gm-Message-State: APjAAAWzKBFeNN5bdu4mStKBngRjoUbiqqygOf5BXqfz+FjT6mIBQxte
        Ck5AWXggePRdx8aJjPkXmNvDKCZZGYk=
X-Google-Smtp-Source: APXvYqw9ozq/43cGjkx6h7pBZMO6XPg/SApSBU9iRuCkRi8YdUpV7oxeAri8PTODt89gXFbTc2u3Bg==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr5150884wrf.385.1579614426236;
        Tue, 21 Jan 2020 05:47:06 -0800 (PST)
Received: from linux ([62.96.18.94])
        by smtp.gmail.com with ESMTPSA id u8sm3870475wmm.15.2020.01.21.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:47:05 -0800 (PST)
Date:   Tue, 21 Jan 2020 14:47:05 +0100
From:   Sandesh Kenjana Ashok <sandeshkenjanaashok@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pinctrl: Align to fix warnings of line over
 80 characters
Message-ID: <20200121134705.GA28240@SandeshPC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue found by checkpatch.

Signed-off-by: Sandesh Kenjana Ashok <sandeshkenjanaashok@gmail.com>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index d0f06790d38f..df5da5fce630 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -159,7 +159,8 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
 }
 
 static int rt2880_pmx_group_gpio_request_enable(struct pinctrl_dev *pctrldev,
-						struct pinctrl_gpio_range *range,
+						struct pinctrl_gpio_range
+						*range,
 						unsigned int pin)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
@@ -218,10 +219,10 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
 	p->func_count++;
 
 	/* allocate our function and group mapping index buffers */
-	f = p->func = devm_kcalloc(p->dev,
-				   p->func_count,
-				   sizeof(struct rt2880_pmx_func),
-				   GFP_KERNEL);
+	f = p->func;
+	p->func =  devm_kcalloc(p->dev, p->func_count,
+				sizeof(struct rt2880_pmx_func), GFP_KERNEL);
+
 	gpio_func.groups = devm_kcalloc(p->dev, p->group_count, sizeof(int),
 					GFP_KERNEL);
 	if (!f || !gpio_func.groups)
-- 
2.17.1

