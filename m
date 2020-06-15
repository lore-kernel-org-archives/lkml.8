Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C28C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4462080D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJDUo22t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgFOSMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:12:38 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B991C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:12:37 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t24so14669046qtj.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qo/ijuM+ow8dAc5wZ5WE1a+KxROlqopnh8Kv9W50dgE=;
        b=LJDUo22t6hXKapYyqN9R7tj7xlwtHlZqlpX2Kvnahx4equE7eFy9ZeqZs8yzrvSvLU
         toYaZ870Rz0SA+eygx4eP7sJZWNNCXwHsN9dJiyRLNxLnhidBaxqDouSATPVQjsHXjka
         wQ2EMOeZp4bKP46wfk1reLheh6nthxQ1Q9jIIQ+0x1kQIqc7Ld7Npcx25QHHzTA4LwNs
         4fU28+zWRzWNw7TjboUaX1yed+Ql5EwJ8R7QzN7+26TSYQwfCqdW2I2+78qEUCGWJJuA
         wnGwrKwfOAQuATJRUovlEtAwFw8vg3yKlOkUpnJrz9QettVnlE7IVTo7lpyKgLoqdZQy
         DVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qo/ijuM+ow8dAc5wZ5WE1a+KxROlqopnh8Kv9W50dgE=;
        b=mVPIKqvgYH/T3Lkv//S1bQipIVVlw13aCtvIKgyKRHrLSudPt8EZEBRkxXpKpQtpQf
         Nc6twzWlF/aG4RGqtQYNjZFe5LrprXaojGY1KmN+fNe3MiRJx4FMT3+WjIY8UhWDewIS
         GdFhkj0M43WCnSPn9JXIqUbV/HXY1BlAsaG8K8xyvf7JxHNBKXVDM+lD3lcmp1+84Zvb
         fRYXS1rPdcM40J2Qfft4xVXnWnx36juTDt7xWGchLohq0z/7HWID3K/TswvHZmfiGeZD
         LO/35NKG01RRhlR+oWyRoqgeeqsnRVyORknHhU65UsdP5l0wdxFu3z6gEFKIWu4l7JIA
         hj9g==
X-Gm-Message-State: AOAM531/NKtR6kNNSDpNvdmhl8Aci89qSySoy2dYUD5D7CdjJz0b5i+N
        cJ9WCOUjmyMfiUzHM3MAukkTkEZW1ulcc+xJQI8=
X-Google-Smtp-Source: ABdhPJxQb4G9Cz605Z31vyYjmIjI52702EV7OleU8dKDQt9aEVVuVlDnNTCy6qMEKEPGvEGr60ypoxJJqB4nM5ufuSc=
X-Received: by 2002:a0c:b712:: with SMTP id t18mr25455456qvd.245.1592244756513;
 Mon, 15 Jun 2020 11:12:36 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:12:32 -0700
Message-Id: <20200615181232.119491-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] security: fix the key_permission LSM hook function type
From:   Sami Tolvanen <samitolvanen@google.com>
To:     David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than
a mask") changed the type of the key_permission callback functions, but
didn't change the type of the hook, which trips indirect call checking with
Control-Flow Integrity (CFI). This change fixes the issue by changing the
hook type to match the functions.

Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6791813cd439..24f6683f1cfc 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -360,7 +360,7 @@ LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
 	 unsigned long flags)
 LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
 LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
-	 unsigned perm)
+	 enum key_need_perm need_perm)
 LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **_buffer)
 #endif /* CONFIG_KEYS */
 

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.27.0.290.gba653c62da-goog

