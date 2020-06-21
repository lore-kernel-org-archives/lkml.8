Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46044C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC112490C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alh45zcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgFUNhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbgFUNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:37:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CD0C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 06:37:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so16334928lji.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tkH8QeToW+8a6ShjGaQW1Fds8XY8tcuZxETlCNYIRM=;
        b=alh45zcraetkOFPQltefTOxLaVWUXT5ZyQoB3Jn4Oi76e0qR5hKeSD1ylRN0pmmDeu
         0+F5JJ7s797Oyv++n9YuHyS2liRyDXFh0H35h4cpkN5meAyToWMvlTT/Ow6A98sU76O1
         pXxW/xdOnlzIE9Td4bogP1viY8jCyJSSE9ldljU8/SvOJFDxrosrKiuu42zM6uUKnoZE
         bSTZ3kkiNhSZxNlRUdN1wg6mmXvw1QnisZlgO2r3IFGxB+gxXMqyhWVYt9j2U/Umk360
         cwffW+iz3nbcK/6qKsTbABx6DE/TlTYYN2IkGXZ8bG67Z/GSqbNnMYaiNHktv8D7YIwX
         s9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tkH8QeToW+8a6ShjGaQW1Fds8XY8tcuZxETlCNYIRM=;
        b=DI4VTgbKMndkp6gU89z8X9VCZVAqYQ0iKTGsKDfVRqwc4xaxs9/+2cjHaz97j3wH9P
         evIzLF5KAUXZ9sDqi0IGXZ4mc7bVS1zz39x1cnW6m/4w+1N8SSzKuvnC4zaxJTI2hkgt
         eHpViWlXTVMq3qS47O2DsJXBQsF63OROYKOPtzZ9jXt6gOFWPOTJ8/dRI6gLBGmLVFwH
         6CKzQMMsx0S9pztQxixNGC0hhsktJ4jv2YzOJqY9+MOXuev2p7wQaqvnqDRc2nSOR1CL
         vR4/zFi3OHoCDb1TZfi8EIU7fPsPjTea2LdsxkILydMBADEAkt/VKiY07Ar4Tf7Y4556
         N+cA==
X-Gm-Message-State: AOAM531/nk9RTS+N2NGo/dut2MB9UpZNLSVWSa1+fmiCrbyx0lfZofWH
        SN7fwqx0UJlzhS/nPdtqDucPEN5BOlRdUA==
X-Google-Smtp-Source: ABdhPJy5VtDEZFw+Pys9lrwg38HnAV34E9veIAbH6PiAKpfbncN/X0QcESAhCX4lfoIce4yihvmcog==
X-Received: by 2002:a2e:92cf:: with SMTP id k15mr6465154ljh.333.1592746632626;
        Sun, 21 Jun 2020 06:37:12 -0700 (PDT)
Received: from pc-sasha.localdomain ([146.120.244.6])
        by smtp.gmail.com with ESMTPSA id w20sm2165077ljo.68.2020.06.21.06.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 06:37:12 -0700 (PDT)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     christian.brauner@ubuntu.com, oleg@redhat.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        liuzhiqiang26@huawei.com, joel@joelfernandes.org,
        paulmck@linux.vnet.ibm.com, asmadeus@codewreck.org,
        alexander.kapshuk@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Date:   Sun, 21 Jun 2020 16:37:04 +0300
Message-Id: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export symbol __lock_task_sighand, so it is accessible from code compiled
as modules.
This fixes the following modpost error:
ERROR: modpost: "__lock_task_sighand" [net/9p/9pnet.ko] undefined!

Where __lock_task_sighand is called via lock_task_sighand in net/9p/client.c
See https://lore.kernel.org/lkml/20200620201456.14304-1-alexander.kapshuk@gmail.com/.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/TMTLPYU6A522JH2VCN3PNZVAP6EE5MDF/
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 5ca48cc5da76..2612b9098cbd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1396,6 +1396,7 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,

 	return sighand;
 }
+EXPORT_SYMBOL(__lock_task_sighand);

 /*
  * send signal info to all the members of a group
--
2.27.0

