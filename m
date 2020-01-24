Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550FCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8F12071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag5VQjaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391183AbgAXUJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:09:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35315 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgAXUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:09:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so3495876wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pmMv0e1ipy/mmadM3tMkpkKH9Ht+YA21gUnOiVe810U=;
        b=ag5VQjaCbMqVXUUqABJnv9Q7B87NLXXN9QMOrYT+HBkrCzaj9sZSiKT7w0oIh2pGwe
         ckwwC9iYxggjpnF+lg71fIVu0abGufngHaHcsYTaExmBNefOTvRr1GYgbdVKk5nbYG7k
         VC99p+FcomDTEu3c/HoOm35KXOFynW7JWpQrsql/TaBQidV/diTzmMDJH6nEMROumTpX
         FDi4q/yNek+I+TpAFXGINS1W9GVmCkkK/2zOQFA1c/OCjMPzem50CQa9SHS+EgSzbrnj
         gblMqO+cwdGsypdyClAy1G+/dOQI+75TmV/4NvB1kdfr2RkcxqmFZtrpa5So+5/ReMFA
         +aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmMv0e1ipy/mmadM3tMkpkKH9Ht+YA21gUnOiVe810U=;
        b=BtjRjyTN820pSNSkS/Pb1x8BIo/A1Dw/paW9MCwCGWB/STHDuuReK3tPGVLjz3TJ/3
         nukdKpzH7QF2mY+y71mrWNHuz0mSZB2JjDEkKADKyzdIIHXJ6mRjXBtVIXwK1j5rWcuo
         T8tK632IGNPtxnnyghMzBhhD0BW5+mJawlim0y8TggSaA2OKABcQitoadqCE/W/MAEhC
         TMnLJSyjHbj+cHG87rygj94ly2O93GRh7G7ixmAAfbQfyQPVdiBJ6g1orfVKKKeD664j
         5QAd+yk4biHhXhjnpWbetJaruSmOgRktQlMj1sPzvZBZcQ51zL7EA97t9a1kMmrENRqP
         FKXA==
X-Gm-Message-State: APjAAAVk7CbY9P7Sw6lYkPsCX/0J4YqKOteH5n48fJDtbvB1PHu+FvKF
        GXQRkhN3jEw9GgLr4uOefA==
X-Google-Smtp-Source: APXvYqzDdQwOXqgq63BAmN/jQHZqKgMj0Fm0OWR/WKFbabnIBCgUubKq+Iu3rVYQWKK1x1tM/MwLZw==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr6089094wra.8.1579896570826;
        Fri, 24 Jan 2020 12:09:30 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-87.as43234.net. [92.15.174.87])
        by smtp.googlemail.com with ESMTPSA id u1sm7689785wmc.5.2020.01.24.12.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:09:30 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, will@kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 0/3] Lock warning cleanup
Date:   Fri, 24 Jan 2020 20:08:59 +0000
Message-Id: <cover.1579893447.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/3>
References: <0/3>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. TIME subsytem : patch 1, an __acquires(timer) annotation is added. as
the function despite having a nested lock the outer one allows entry to
critical section only.
2. Within futex.c file or path 2, a __releases() annotation is added. as the
function releases the lock at exit.
3. MUTEX subsystem : patch 3, __acquires(lock) and __releases(lock) are
added to mutex_lock() and mutex_unlock() to fix issues raised in other
files. 

Jules Irenge (3):
  time: Add missing annotation to lock_hrtimer_base()
  futex: Add missing annotation for wake_futex_pi()
  mutex: Add missing annotations

 include/linux/mutex.h | 4 ++--
 kernel/futex.c        | 1 +
 kernel/time/hrtimer.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.24.1

