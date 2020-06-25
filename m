Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB08C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B57207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijpRbZi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407332AbgFYV4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407008AbgFYVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:55:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD2AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:55:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g17so3390320plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0m/FjnJjhgS6jJ3qtD918zPfVsmhOjKw+gYA5VHiyF8=;
        b=ijpRbZi5KWXy1QJfiK+kH/xmCCdXzkyMtiBcMDE8+0t2IRtgthrC21C5qS4cttL01A
         3i3MliAcoduo97dXTSQx5vWXZNi1PhQSuiBkD60JAuRJKcwo7gEy/CA5qzWuyzfgF8zs
         F4tyjhy6HZ2ru1OcRfl7lifzHGEtksolhc5EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0m/FjnJjhgS6jJ3qtD918zPfVsmhOjKw+gYA5VHiyF8=;
        b=KEpvS71Hpngyg6PSAdO9VWEb78f8LF1xtd9itcEJWVowC9DJK6B4sxpddYj7HiBvHy
         AOiHP5K8Gm4wnXgSUwwmdKjutoir/Ldr9nM80h7/SiZVXVwOfU219h9xJgTvq9t9GymU
         vKRhLeGj51qOe0vQtcQl/MJOvwidj+IqNnk/XuF0VuTZ815qKoONBuax2etLL9Wdayj+
         tg8dPUMsNqgZd7hEnNG719T8N7V/haGYQp5GvbPGgtfKxh4xYaTD49GyJ3kP/07XppVo
         RzjSZggdMg1sPE852fXip3dqsD9JcpDqVJbjNrcqLtHAiMZpkgQ800XO1CiFnoaUjkw6
         Vjiw==
X-Gm-Message-State: AOAM53309DGUQmpK77YPdHAknAD7NcSN49+CKSRf0xDUxho+1KNN8rfb
        3PmsV8JWqFMoQ2AP7KVeeKVQqg==
X-Google-Smtp-Source: ABdhPJxi/2Ma6HSILRYA7Y1E/CT0c1EJHDOltwfRrPCpupY/Zo7Fl065ULNhVeZT5wFT7tzA2VCQvA==
X-Received: by 2002:a17:90a:898a:: with SMTP id v10mr32887pjn.95.1593122159009;
        Thu, 25 Jun 2020 14:55:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m136sm9584245pfd.218.2020.06.25.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:55:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Lameter <cl@linux.com>,
        Alexander Popov <alex.popov@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, vinmenon@codeaurora.org,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm: Expand CONFIG_SLAB_FREELIST_HARDENED to include SLAB
Date:   Thu, 25 Jun 2020 14:55:46 -0700
Message-Id: <20200625215548.389774-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In reviewing Vlastimil Babka's latest slub debug series, I realized[1]
that several checks under CONFIG_SLAB_FREELIST_HARDENED weren't being
applied to SLAB. Fix this by expanding the Kconfig coverage, and
adding a simple double-free test for SLAB.

v2:
- rebase to -mmots
- drop SLOB support (willy)
v1: https://lore.kernel.org/lkml/20200617195349.3471794-1-keescook@chromium.org/

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/202006171039.FBDF2D7F4A@keescook/

Kees Cook (2):
  mm: Expand CONFIG_SLAB_FREELIST_HARDENED to include SLAB
  slab: Add naive detection of double free

 init/Kconfig |  9 +++++----
 mm/slab.c    | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.25.1
