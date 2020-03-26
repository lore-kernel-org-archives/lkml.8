Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EC5C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA14D206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+ZoYPXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCZOof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:44:35 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:47981 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgCZOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:44:31 -0400
Received: by mail-wr1-f74.google.com with SMTP id u16so133995wrp.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oIpcXbs7HMCH2rBdnqz+HP+vStesLvB5cyCR3m0rGWo=;
        b=c+ZoYPXGUoJs2G/uhQEnUj77jkFvWpTLdmamQD3MFPVB+Nyp1lAOyNuUnkqGWydMmL
         JEXdgJz2J5z6gJX9UXQc8YCtsYAlAjK7Rc7rnUrRpn2cewG+nI9vSf6ICvIzne7/xjnn
         3i0HXX0N3RzFw76sJh65Jo7hxW/ZgaOUoNqQG54kuyWQKDSlsAfh4lQjv7qwtTptSE2v
         0AeEGs3c/EbHErb+uqqFf6ZL50ELe0IXS504Gf1x3Y7wipHS4p4HCYR8U/5TY15M3Xp3
         /6ZOMckWYP2cn9jw89fGsDMXP6uPCmTf+Af6Zno2subsLnKKVjEh9WfuL+scknGp+ujF
         1RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oIpcXbs7HMCH2rBdnqz+HP+vStesLvB5cyCR3m0rGWo=;
        b=AmPRbnfUc0srpmdXKlfxGYmQsHJAoFsVh0MXIn4nWvuDkYexQJdH2OISM4PPQUXAfu
         qc9bV2Dc3CiXtLzobXpNv4b8snfHpJXmGRr2KyJvCM7Txs+5eoN3zdpU1K+Y9g4yyGrV
         0QvqbAV0lwkL3MUrLCmRpwdi8qFkUFHKP4mZEjbXhByx69zQnFGt8ILylq2KkmzraCnR
         AgXxwj52mCE3tUVzfMm/5vln1NBASdtl5i6QffKzK9Bpa0q8M8L1W9LrKLvMP/kwgKql
         Z5zyh/Ccj//M+aBghY0X1mj1ttDWvT4aWBLJiOEldAJvTw7Yccr6n5slf0f7rc7bgExS
         fHsA==
X-Gm-Message-State: ANhLgQ2F7aFD+yg8nIuL8VqUsJs9c600UHNNdulUcyiRO/bzq99NyNHW
        2O3YtbenCdEhQ/Atf8+i1t31A6ock9c340lB
X-Google-Smtp-Source: ADFU+vvDk8YRsGM5M4gwKzl2NX7plDCaSAsdBkDdkcig7hV0LfODIkqeS2n63I7L68P82vgp9GsW1K9wbg6Gp0wl
X-Received: by 2002:adf:a490:: with SMTP id g16mr9721097wrb.42.1585233868532;
 Thu, 26 Mar 2020 07:44:28 -0700 (PDT)
Date:   Thu, 26 Mar 2020 15:44:04 +0100
In-Reply-To: <cover.1585233617.git.andreyknvl@google.com>
Message-Id: <f70377945d1d8e6e4916cbce871a12303d6186b4.1585233617.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v4 5/7] kcov: use t->kcov_mode as enabled indicator
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kcov_remote_start() and kcov_remote_stop() check t->kcov to
find out whether the coverage is already being collected by the
current task. Use t->kcov_mode for that instead. This doesn't change
the overall behavior in any way, but serves as a preparation for the
following softirq coverage collection support patch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/kcov.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index b985b7a72870..e43f06b5b2e4 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -746,26 +746,33 @@ static const struct file_operations kcov_fops = {
  * In turns kcov_remote_stop() clears those pointers from task_struct to stop
  * collecting coverage and copies all collected coverage into the kcov area.
  */
+
+static inline bool kcov_mode_enabled(unsigned int mode)
+{
+	return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
+}
+
 void kcov_remote_start(u64 handle)
 {
+	struct task_struct *t = current;
 	struct kcov_remote *remote;
 	struct kcov *kcov;
+	unsigned int mode;
 	void *area;
-	struct task_struct *t;
 	unsigned int size;
-	enum kcov_mode mode;
 	int sequence;
 
 	if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
 		return;
 	if (WARN_ON(!in_task()))
 		return;
-	t = current;
+
 	/*
 	 * Check that kcov_remote_start is not called twice
 	 * nor called by user tasks (with enabled kcov).
 	 */
-	if (WARN_ON(t->kcov))
+	mode = READ_ONCE(t->kcov_mode);
+	if (WARN_ON(kcov_mode_enabled(mode)))
 		return;
 
 	kcov_debug("handle = %llx\n", handle);
@@ -863,13 +870,20 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
 void kcov_remote_stop(void)
 {
 	struct task_struct *t = current;
-	struct kcov *kcov = t->kcov;
-	void *area = t->kcov_area;
-	unsigned int size = t->kcov_size;
-	int sequence = t->kcov_sequence;
+	struct kcov *kcov;
+	unsigned int mode;
+	void *area;
+	unsigned int size;
+	int sequence;
 
-	if (!kcov)
+	mode = READ_ONCE(t->kcov_mode);
+	barrier();
+	if (!kcov_mode_enabled(mode))
 		return;
+	kcov = t->kcov;
+	area = t->kcov_area;
+	size = t->kcov_size;
+	sequence = t->kcov_sequence;
 
 	kcov_stop(t);
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

