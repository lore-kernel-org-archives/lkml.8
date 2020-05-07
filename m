Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025CDC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C830C2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEWXKfPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgEGHqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:46:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E80C061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 00:46:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u22so1741996plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g//hkau5l+bLowjOvo7e0hcIp3RjLdYp2Jyffr/gTyw=;
        b=OEWXKfPeaEZYnERDF88WoSa12XsXSpfjkMHzHwiqtrFuCfl4U71VXHPuzQu4d86KBu
         Tev9ydj1y1n+vZL8NVMuFY8Pv64h6eX7sLVc2YVna2rkvGqO+tHpiyUuhY4tX+Dxb/9m
         tPewUr0l9J95NwnCOl8L/F75XwxR+rN2nlBTskOjDGTRzv41bEw1qC722oLsIj7ffhXI
         WGA6hRYv7zHc/zHo5Gms+EqfFbSZkvumtpv8qgSKaofbtRTDRhHEVexq+jUaeNEhXa+6
         hkcr9dtzgPvUwUQfF2lgrSYdbSvDP8hS6mwaiW548kzi6PsEEFSPlFUxixGhhnU/66MQ
         ib1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g//hkau5l+bLowjOvo7e0hcIp3RjLdYp2Jyffr/gTyw=;
        b=PvgGVsAT01n+4CzmiIG7Xcv5R45OoA6fQsbUZRMLjKLX3LWW+LxIfdBMggJmE/PtcF
         TzEZEzwc1eAE1iUhilN6l7q4O+TLNTxM0vxS83+lTH6IVem4fGWulAzDdxhv6bD7kTn0
         RzbXc5qxThuEvlHX+VBF9pdMorNdqqlMzhHeQ6e6qJ8zU/D3nt9u0J9FdA/8AKwG6M/3
         9asv0gsVP3qjaOtQq2sA7ozTkKoS0aVBQR2QWm3fwcI8OtjdWkSvt7UWJOcr5/W39Q9C
         4Rb5k8QBQjrgj1cmGLHzn88/XYGmtFsrP0ktbxsEGtsqhFKsF5dm8tfF8Bp0KCrnvz9X
         +IXA==
X-Gm-Message-State: AGi0PuZIjNBghPRF7ecxHs62iiljqLtU8e1pURnc+D5E1cjfuHa3SY7D
        EvK2UVLNwYJjxHACmBK7RRoCElyTaio=
X-Google-Smtp-Source: APiQypJvEVCt/Jd3X2vWX+7Q6sS368OiB9k8npMHbxsQtpKwLew6tu2l8fY2D9YMeRRXMdz5VolWsA==
X-Received: by 2002:a17:902:c282:: with SMTP id i2mr11789866pld.175.1588837611397;
        Thu, 07 May 2020 00:46:51 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id r26sm4127943pfq.75.2020.05.07.00.46.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 00:46:51 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: 
Date:   Thu,  7 May 2020 15:46:42 +0800
Message-Id: <1588837603-14206-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset enable the stmpe811 touch screen on stm32f429-disco
board, tested with ts_print. as sdram memory shortage on this disco
board, so i didn't test ts_calibrate (kernel crashed at mmap in
open framebuffer)
