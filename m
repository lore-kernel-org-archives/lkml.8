Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CCEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 18:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8E9206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 18:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ea74ul+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFLSfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgFLSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 14:35:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7688FC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 11:35:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t7so4510614pgt.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8/1IyDwgaYKXdI9dp4YmKReEuS3zredW9XpaRoJ5Ww=;
        b=ea74ul+pjDI83LXshbpVoH4wVDxcw27fp6LlmZZj2Ta1WJJ8tvGq3/u6u+qkhM3jjM
         3ka7mObye2pcNqMktQNqFpiGjZoZwAtYheNn5Q5XUHcGy0vB70NwtcsV4nks2C7Zyzas
         1FfWgykVawtL/lp0r26LIbVny/SB+c7wK96IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8/1IyDwgaYKXdI9dp4YmKReEuS3zredW9XpaRoJ5Ww=;
        b=eZtOs+HadKHN3e6YWx36O/84Nzj3awa6yG0pF3QQDMvXDqd6C3gvSdUwCbdAs5KX/B
         HxGZPry47CXG75ivMwpH/NQykwUrbns65Pis5djn80lhXbDXPOH5nmuY7MXaxphx1Taw
         ODlk5uyn9uWrm7MqrP/IniIX8z2498idSg22kp6nH17YnK6Kx1dyHmeAzYC5PMweMaj0
         SDa3IApdAhfFaPWHAZT8dxvm3ShW+PfbMzgEllH8jAhpXR4+5XgWcw1XcpQu3OKht3Wq
         lc8uJgkTu5ibQkyqrgDEKjA/RfVrK/JhPFggeke8FC+KykOKLMg18dVQv97g3cUAaa1J
         FsRA==
X-Gm-Message-State: AOAM530AOInuVciwhikvsBD8mN1eGckP942uEgSfrok+P2x1Bahj8K9d
        jidCyiZ3NMZblEI3Xz7iBBtaZQ==
X-Google-Smtp-Source: ABdhPJwbK0m4NUSki8u8yVXlyQrFMj4o0oTxfll03vHnYvjrBR9V8sprSlMS0rp5CHtuTGbEOSV/nw==
X-Received: by 2002:a63:531d:: with SMTP id h29mr8596670pgb.282.1591986904084;
        Fri, 12 Jun 2020 11:35:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm6785624pfi.183.2020.06.12.11.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:35:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, David Howells <dhowells@redhat.com>,
        shakeelb@google.com, James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
Date:   Fri, 12 Jun 2020 11:34:47 -0700
Message-Id: <20200612183450.4189588-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series was never applied[1], and was recently pointed out as
missing[2]. If someone has a tree for this, please take it. Otherwise,
please Ack and I'll send it to Linus.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20190306110549.7628-1-elena.reshetova@intel.com/
[2] https://lore.kernel.org/lkml/1591957695-118312-1-git-send-email-nixiaoming@huawei.com/

Elena Reshetova (3):
  nsproxy: convert nsproxy.count to refcount_t
  groups: convert group_info.usage to refcount_t
  creds: convert cred.usage to refcount_t

 include/linux/cred.h    | 15 +++++++-------
 include/linux/nsproxy.h |  7 +++----
 kernel/cred.c           | 44 ++++++++++++++++++++---------------------
 kernel/groups.c         |  2 +-
 kernel/nsproxy.c        |  6 +++---
 net/sunrpc/auth.c       |  2 +-
 6 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.25.1

