Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A44FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A6120658
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dra6Xs1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgHPRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHPRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:22:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86115C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:22:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so12656136wrm.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XLquzJ4Zpz4GTbTovMw+SxCIL1JgsFNaSaKJHhRL954=;
        b=dra6Xs1FfI0Lb1mG/3mE38cZQ8j4WyS/0LX3/RQ3O+LfuIo1ev7JuXgB6aZbK7gCCF
         ZD+sVZVwOBVyfS9gYnU0ZHRITB9XSOBELQ8CUdgsHKGx75ZrFnwdlt3rIn2BhfIT0z1S
         nU2YHVsyUREph4Hp23fZbuxQVuw0FVjp2BvOLrz8Fd/bO3Tp/eW6IIXO0FVGZf660Fni
         LolLmA7SQCB9pRRtBnmp6/Bf+NVCHGisnh+/A0HG8J1aAlhr4HcTx4D6tGOO2dPIUeM3
         QDj2GiFpeRn1NGYDJN2/kLH1OYRmCi9csKf5xIv4rUQbSBOsYYJOe9FyM8SJlrYj2WTd
         VgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XLquzJ4Zpz4GTbTovMw+SxCIL1JgsFNaSaKJHhRL954=;
        b=fzlzHId9JRld4jDrEuSOMJP7s0N9FgRmSt2ulbZ0ix4qVFEsLpJ8xblIWmHxzg74fh
         mzMU2W1KMmdJwSBadjSJpxfQSCv6WCQJVIzkVMu9YFc0BfCJDtcXLqKBcmyLyM88OpDv
         vdVpnCDiKDIUVn91m1dHxMKFK4IMZ9qnX0teNxB2T/6ILwVEOuVaWopgY7OvGSj3S9cC
         yVoXtXddtMySoa3TF2BZQBI8hPhZB+FjUrYhF2dCZdsPUMb64jC3i99i8brgWLRQDvii
         N8bhnPlOkCAsfksDNmOqCWyqH8bHysMQKhRUaucJcr2kZkfNl2YEiCjV5fAg6InPuwcE
         6zzQ==
X-Gm-Message-State: AOAM532g9C7kQ/FGXZe/Nkds7NCe+dn1Jxn/b0ibjZMRPc5lXmV7Ga6I
        Tu03wetsK3y+N5EGmNu07KY=
X-Google-Smtp-Source: ABdhPJxR11i5f+Cs3K/ILM8AxeiIikHgTcvQ0euuo39kYeEg/xSCd7R/0LV7+ANNg/+PE9OC3o6s/A==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr11842768wrt.191.1597598565525;
        Sun, 16 Aug 2020 10:22:45 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id y142sm28540563wmd.3.2020.08.16.10.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 10:22:45 -0700 (PDT)
Date:   Sun, 16 Aug 2020 20:22:41 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: androind: Convert BUG() to WARN()
Message-ID: <8df6206000524d4a0043a7a1df97b2be2d277995.1597597955.git.tomersamara98@gmail.com>
References: <cover.1597597955.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597597955.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace BUG() with WARN() at ion_sytem_heap.c, this
fix the following checkpatch issue:
Avoid crashing the kernel - try using WARN_ON &
recovery code ratherthan BUG() or BUG_ON().

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index eac0632ab4e8..37065a59ca69 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -30,7 +30,8 @@ static int order_to_index(unsigned int order)
 	for (i = 0; i < NUM_ORDERS; i++)
 		if (order == orders[i])
 			return i;
-	BUG();
+
+	WARN(1, "%s: Did not found index to order %d", __FUNCTION__, order);
 	return -1;
 }
 
-- 
2.25.1

