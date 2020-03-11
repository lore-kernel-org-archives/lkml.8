Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DCEC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261002146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgCKJMw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:12:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46735 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgCKJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:12:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so1507796wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 02:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=DjVadGIIur79/OuZIKT94tQZE5zzLHXHVbjho/zrSHw=;
        b=hpSr4oM+pdZbXPQuOFGeVbIYLembHKbDuBywdcC9W0Csv+yYQdcvGxx0Ojj2x4ffkq
         +qH36o1p+6ofEtOxIbWjhyjiBGRgy1omL77oRt5ky7OkYaQJKkvj8XukUknXUXAPxcb+
         nKFVlJJmQfZK7yoTCMg/eBcqAXWrDlGlGlc2mjSfCxuHVlwkSWf+agSE7k/buvRtHhHY
         uBOPDA175fGPsO3UeCYOcjs2+Pu0am/N+Q0wlw1s+CdpcciGFYH0uHiareGVU3lC/2da
         nTCbAnWYxkhE3kJdZIbrcDpU5oRxGropPeX8DA2AA2SI5p/fx5KfGyOhrHc5t43BQGv2
         P9Bw==
X-Gm-Message-State: ANhLgQ3QMoPSBcQRNOJPP7/oHqwoOFa4/Yr99X/HAfBQpyo5mUl30a2R
        SolJBwDP35i7vB+oMr9twcB9Ew==
X-Google-Smtp-Source: ADFU+vuDpI2JRPXpT7JNNMSexbsuj8A1c5B6CChe1t0n69G3u0BdAObvAUcr85rIrdmKlq5+/Fasfg==
X-Received: by 2002:adf:ee48:: with SMTP id w8mr3259969wro.290.1583917970100;
        Wed, 11 Mar 2020 02:12:50 -0700 (PDT)
Received: from Google-Pixel-3a.fritz.box (ip5f5bf7ec.dynamic.kabel-deutschland.de. [95.91.247.236])
        by smtp.gmail.com with ESMTPSA id 133sm8119781wmd.5.2020.03.11.02.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 02:12:49 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:12:48 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <1583914756-45674-1-git-send-email-tangbin@cmss.chinamobile.com>
References: <1583914756-45674-1-git-send-email-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] pid:fix a return value in alloc_pid
To:     tangbin <tangbin@cmss.chinamobile.com>
CC:     oleg@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <AB48A556-E570-42B7-A7C2-5CCEA7AD6696@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 11, 2020 9:19:16 AM GMT+01:00, tangbin <tangbin@cmss.chinamobile.com> wrote:
>When I doing a make about linux-next in X86 right now,it prompts a 
>warning about "‘retval’ may be used uninitialized in this function
>[-Wmaybe-uninitialized]". So I found that undefined 'retval' initially
>in alloc_pid(),so the return ERR_PTR(retval) was an uncertain value.
>Kmem_cache_alloc() is for sapce,so it will return ERR_PTR(-ENOMEM) if 
>unsuccessful.
>
>Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
>---
> kernel/pid.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/pid.c b/kernel/pid.c
>index ff6cd67..f214094 100644
>--- a/kernel/pid.c
>+++ b/kernel/pid.c
>@@ -177,7 +177,7 @@ struct pid *alloc_pid(struct pid_namespace *ns,
>pid_t *set_tid,
> 
> 	pid = kmem_cache_alloc(ns->pid_cachep, GFP_KERNEL);
> 	if (!pid)
>-		return ERR_PTR(retval);
>+		return ERR_PTR(-ENOMEM);
> 
> 	tmp = ns;
> 	pid->level = ns->level;

There's already a fixed version in my tree for this.
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fixes&id=10dab84caf400f2f5f8b010ebb0c7c4272ec5093

Thanks!
Christian
