Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C0BC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35D4221F7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz+aE0Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgDFMwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:52:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32977 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgDFMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:52:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id d17so7516276pgo.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hIs0vpkpzouRXrFo61lBnYWJ5AeDbk1pbRG9DTvewns=;
        b=Lz+aE0LhkC0d3ydNGLXJ0dfJRBOjmAUllDjkNIRMCoMG3zXNDs31Q5R/5yTPqn13RS
         U2QX7TZ5cUXsuvOdIcZwpwbGBW8jf4d0fhi93cQC+UyQiUOR8NDd1EuHAhcHc0cyimIB
         oZ4V2JRqSMUNH7YrNdv56LIneI3X3yhT2lNSrP8jgWjHs4hrCPD1DL2EpvQf/BnkAAnd
         xRSeV1E1XMSG+9tzMFRvn02OH4reuTWwjz8GoKlcps+UHPBwNoc/A8HBOYBj4sadHHbZ
         RrJbNP/ugVDrSI3b63yQswROCXVbEhPyBorBTjLiPZWhqeHw2DYcOGchtEfLDrxRbYIF
         owpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hIs0vpkpzouRXrFo61lBnYWJ5AeDbk1pbRG9DTvewns=;
        b=YfpcphXipYAX7qeqVg2E9H5vqni1oo05qp4yBtkHKCgj6cVkcSSHc5QO/nVGfj1RKZ
         1yPRvNFinXAkzsHrhfbMBQG4nhYt12+p82MUrJvXV4m3GOmxXOJyb69yceYTNrLSrNMQ
         SJlMEnp4HFppGFCQkWBtlicncLgP+Bw+fU9616yG3l7PR00x988hVc8E46BktahYVju+
         +cHIm9KlfQT7yw4L2nqojDHVEec6H/nP6u4l0y3I3yoJsz05VE48UZljQl80ER/Zdtks
         L/Rlqjw1rDTdRG9L9FSOqmikdeGZ8xukN/Ss2IXPNnFX/EJzPcBJ4We7TMvUk8emsxJr
         IejQ==
X-Gm-Message-State: AGi0PuZIv0udYDW9Q+5WQgfQCQ1xfN51ZrsJZUymQ6i06n9wWxmkFkDs
        bvoDRPJc4GttgAKkQQwBE/g=
X-Google-Smtp-Source: APiQypIQoYolWCbtfisdnAEX/P8gggsuL45FV+q3guCMPla/n3qEQLfA7AYa+k2CllZU7kpCJf7Rtw==
X-Received: by 2002:a62:1757:: with SMTP id 84mr20760636pfx.107.1586177572336;
        Mon, 06 Apr 2020 05:52:52 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id v42sm10938536pgn.6.2020.04.06.05.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 05:52:51 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oohall@gmail.com
Cc:     tglx@linutronix.de, Markus.Elfring@web.de, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v5 0/2] Fix opal_add_one_export
Date:   Mon,  6 Apr 2020 20:52:40 +0800
Message-Id: <20200406125242.4973-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should check the return value of kzalloc, as kzalloc may fail returning NULL.

---
v4->v5:
	Separate the patch into two.
v3->v4:
	Added the information about coccinelle script.
	Added change log.
	Added Oliver's Reviewed-by.
v2->v3:
	Removed redundant assignment to 'attr' and 'name'.
v1->v2:
	Just return -ENOMEM if attr is NULL.

Qiujun Huang (2):
  powerpc/powernv: Remove redundant assignments to attr and name
  powerpc/powernv: Add NULL check after kzalloc in opal_add_one_export

 arch/powerpc/platforms/powernv/opal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.17.1

