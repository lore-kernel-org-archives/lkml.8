Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE2AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F602074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBg3CJGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgE2TC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2TC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:02:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA3FC08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:02:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x1so3081093ejd.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSM5wNtipsPVAyBr8+6PzZYMH3IzyM52YXRRZsNV0ds=;
        b=aBg3CJGjOr7oPrlE5fYT7GtxFq2q6vcdMm3XANANb9nWk/aAX7glWi//ZkQPS2IukU
         a2dP18yIuxhczm6EvoptY66Tp6XQcKXhk0apsJyd6wGbWHCZKxGokiWzwU+Q3PYLnTtm
         hQKskcqZ/B1L1nGxUS1hCAYlDNOurLWmaz4q7iYCQbjWZo66HVOyNdWXHqX785O3VRyY
         hERd0sB5FD45ffhJZEaLmZCvLI/53uFHuSyT39PsS0TbY5GbsSNtxe+b6qXXJLuyyK7e
         slkm9eutE0k83CRXhg6rD0V0Q+eVU6wOohnHei2iFWm4plfXzLUCDJkQtUzfTlVAW+MA
         cHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSM5wNtipsPVAyBr8+6PzZYMH3IzyM52YXRRZsNV0ds=;
        b=T7rcop4wSDWShTiNYvw6ckcLdZwCpdRw47MrK+p+gIlEDgRTBzGxNTsXXR6oQjbJA6
         ayUO/awyB59dCMalNrlkFvLkWf88fbbVxcqreXum7y1FLaMGMILrxwf3b8GqhllW3wsv
         ZjZpRnSqfE5Cn08vPFtfQa386LZfEUP6HDNs7DQ4EQaZhWPwwi7thbdCKerAM7sKdF8z
         NPOoa/eCqBmpDiSwyzQJXevP0idDm7tpDPg1GUk/mmr50APKdjksTRhQPOzbBql6DWxH
         oJg33Ok29YXmMH033kY6CHKe9eekCtTyjCWjAudLEySEs9Vi0nCNgbiS0cgSLEG4SKLr
         +agw==
X-Gm-Message-State: AOAM532vE090KTG6zrHisdYdgS6IDkCUXCCMxsHGbqNQSU7haAvsCiq/
        je1PfzguYdXMTGfHxJJcmzo=
X-Google-Smtp-Source: ABdhPJzDZ/T+D+93pcaucwxTClLIx9ladIVy0a1Gll1rizB0omfCUI2KNMDokEwiIvAsEaDj5ZzmXg==
X-Received: by 2002:a17:906:1dce:: with SMTP id v14mr173609ejh.46.1590778944488;
        Fri, 29 May 2020 12:02:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:1951:ff2b:10f0:1763])
        by smtp.gmail.com with ESMTPSA id f4sm8166135ejk.17.2020.05.29.12.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:02:23 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/2] fix missing handling of __user in nommu's uaccess()
Date:   Fri, 29 May 2020 21:02:16 +0200
Message-Id: <20200529190218.36560-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I received a bug report for an unrelated patch when used with m68k-nommu.
It appears that the origin of the problem is that __get_user() and
__put_user() doesn't handle correctly __user. These 2 patches fix this.

Note: this is only minimaly tested but is quite straightforward and
      since this only change __user annotation it will not change the
      generated code.


Changes since v1:
* fix typo: s/plan/plain/
* appease checkpatch with better style: s/__force*/__force */
* avoid excessive line length caused by the added cast.

Luc Van Oostenryck (2):
  m68k,nommu: add missing __user in uaccess' __ptr() macro
  m68k,nommu: fix implicit cast from __user in __{get,put}_user_asm()

 arch/m68k/include/asm/uaccess_no.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.26.2

