Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A57C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9F1207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/gNbcrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgGPUcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:32:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AF3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:32:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so8445636wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6BBl5BUFM3oiIHSrILloKC9MrcWgF9ThT+XuvJnmT8=;
        b=U/gNbcrlPwAlWDZJfubKr3mmM5yEZVrnnCpM0ZNBsilq09nBJI7R6k8/+VFy2ozYSg
         RdAsSBpGA6597te+J31NFbppwDHFgzaqizCUzWGyXP+hd/yDM8QHOga2FoHd0qQwWCYN
         8cFuBpQP+DX5jEmuoKqYCH1oiRFzE76db61oWlnDEzxdp5WCF0+WkAnOEUt79RLn56t/
         6XQ1IuKJU37Ey86UsCKLH1wVVNwOzR5EaaL7I0WJYI5h/TeAaGXT9LdxAruUcMfNxo35
         S42aFYQD74hRHgS88ASHuB32LFsjmjGAmUDyq0JFxSJJldJ9iqVurTbb0EPhQxMSb43k
         kDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6BBl5BUFM3oiIHSrILloKC9MrcWgF9ThT+XuvJnmT8=;
        b=GmKh6ax9zAfLcJoTG5PjpCzvR6dQbTpcICj6+DlN4RuEwtdbo8oguCGifG7CyZ7VU0
         62/zVX75gW7yRQteoUCuz9vWexsYZt4Npy+LIvFmCsYvYU9U3TNcsi679QO/glTQjSYu
         bWAQ6cA/oQj42XeAjm+eYAFhmJSW/MnHftAfGzihiC+YaC1ldRblGbXuGcPSxwT83BNe
         A8PLCogj4AkN6/kahr44Z+BdTmUIZCslwJPBy0Ze09qFpbmftNzUvixng3Rb8+OX14Xl
         Zw/MdZ6PRigpkvn9aNkMYdSDKmrt0eSSvxNJZUYoaj9kl87HcA1kCpBeaH1UMFu8XT9U
         +ohQ==
X-Gm-Message-State: AOAM532BctCcy1eGOZoAcAMh1f4gO9l6K8qb3uDFQdVuHeBQPYaPa2g9
        e3PFO7ixX7zp4jZK5FWWrCg=
X-Google-Smtp-Source: ABdhPJxMXgzz6yxZzhsCLg4fnfW3I5zn36+cHjxqG5Xyci3xiDk5im82bTc41E93B6iEwcivUAvM+A==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr6281416wrn.94.1594931520166;
        Thu, 16 Jul 2020 13:32:00 -0700 (PDT)
Received: from garrit-VirtualBox.fritz.box ([94.31.102.44])
        by smtp.gmail.com with ESMTPSA id p25sm9656416wmg.39.2020.07.16.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:31:59 -0700 (PDT)
From:   Garrit Franke <garritfranke@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Garrit Franke <garritfranke@gmail.com>
Subject: [PATCH v3] kobject: remove unused KOBJ_MAX action
Date:   Thu, 16 Jul 2020 22:31:01 +0200
Message-Id: <20200716203100.7959-1-garritfranke@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715153216.GB749262@kroah.com>
References: <20200715153216.GB749262@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loop in libb/kobj_uevent.c that checked for KOBBJ_MAX is no longer
present, we do a much more sane ARRAY_SIZE() check instead. See
5c5daf657cb5 ("Driver core: exclude kobject_uevent.c for
!CONFIG_HOTPLUG").

Signed-off-by: Garrit Franke <garritfranke@gmail.com>
---
 include/linux/kobject.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 6cba088bee24..ea30529fba08 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -59,7 +59,6 @@ enum kobject_action {
 	KOBJ_OFFLINE,
 	KOBJ_BIND,
 	KOBJ_UNBIND,
-	KOBJ_MAX
 };
 
 struct kobject {
-- 
2.25.1

