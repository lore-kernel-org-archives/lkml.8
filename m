Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7CCC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C2721D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifY/Bd7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgCBNEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:04:46 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:52712 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgCBNEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:04:45 -0500
Received: by mail-wr1-f73.google.com with SMTP id n12so5758472wrp.19
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JEYVQ/93cUIIc6BO5V/NQlPPY1ArQwYADsRJbFdijd8=;
        b=ifY/Bd7g+2OhtayWGvfN9k47hFCAyCdcGk5ycHkoHFt8uMYtYWW/iEampGrQfd00jA
         NhMrguaHSkQJVtHIyOtncYN4AdA6RkzmuDiqALK2XONIpaXftSzaORyPsma/X0e67210
         2dp05VBpxYq6vTcF0b1otLbf7BCFz9tusGS262gHtr0F/jJohXRbyDV4UjhwEi8yQLym
         vy/+nvRVT/VDr3kOvQvqK7WXNln1+VG7JUtD4IYmrtd+F2GzFBp2099skMDQBOZBaCnR
         c7Z3ayvTiUb+Azio8W+ZoGneaD7wE3R3dm0UcEJD5Ab5vt3Cd9s+PflF5vkgxSCgRqk2
         R2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JEYVQ/93cUIIc6BO5V/NQlPPY1ArQwYADsRJbFdijd8=;
        b=X9F9glRE/6R7FxDWEPqHfwnTQA906EivAJwv4GX+aV3WvxGS5u3QM6NR36rx2Fg4nm
         kTwUflhvSmgra+IrwOPTbMsM9LuRshenlf5eiJ2DMK+4hWyYVNHJKElO5fOX0TYBUB7+
         qnEyAdkERz85EF256o9qCGHJX66s6df98paTJIdxYxYlA7aRGt3uxyqlmPdIzBiaO5k9
         u8eMC7SNGu6NXJss0wjeT4wa/8FTKVNQeN6X/pCRp5eoqu9OgbGA+C5sEoczcg/ll/Rv
         iA6RTFgN4cVsRYUnOWnsLH808CL+E2gN0LcI/WJ19SMxbMS3Fe6KLnKLbHDIML1MQajh
         buLw==
X-Gm-Message-State: APjAAAUd6iSyTpYU/E9F1XYFxab8kXSdDh16mD0HBEFv0gQDAd0huh+V
        amGk3QII7wAZTD1N8giOkNq/Rh8mXjQ=
X-Google-Smtp-Source: APXvYqylIVXtOKiOFEzyHNHRqhYhFLw9Oy4b+pL2He/Fq3tNdkrsSiy4aLsLJ5pp9R9QUaRQhrSKuXkn2FM=
X-Received: by 2002:a5d:5286:: with SMTP id c6mr15916314wrv.418.1583154283684;
 Mon, 02 Mar 2020 05:04:43 -0800 (PST)
Date:   Mon,  2 Mar 2020 14:04:29 +0100
In-Reply-To: <20200302130430.201037-1-glider@google.com>
Message-Id: <20200302130430.201037-2-glider@google.com>
Mime-Version: 1.0
References: <20200302130430.201037-1-glider@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 2/3] binder: do not initialize locals passed to copy_from_user()
From:   glider@google.com
To:     tkjos@google.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, arve@android.com, mingo@redhat.com
Cc:     dvyukov@google.com, jannh@google.com, devel@driverdev.osuosl.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain copy_from_user() invocations in binder.c are known to
unconditionally initialize locals before their first use, like e.g. in
the following case:

	struct binder_transaction_data tr;
	if (copy_from_user(&tr, ptr, sizeof(tr)))
		return -EFAULT;

In such cases enabling CONFIG_INIT_STACK_ALL leads to insertion of
redundant locals initialization that the compiler fails to remove.
To work around this problem till Clang can deal with it, we apply
__no_initialize to local Binder structures.

This patch was generated using the following Coccinelle script:

  @match@
  type T;
  identifier var;
  position p0, p1;
  @@
  T var@p0;
  ...
  copy_from_user(&var,..., sizeof(var))@p1

  @escapes depends on match@
  type match.T;
  identifier match.var;
  position match.p0,match.p1;
  @@
  T var@p0;
  ... var ...
  copy_from_user(&var,..., sizeof(var))@p1

  @local_inited_by_cfu depends on !escapes@
  type T;
  identifier var;
  position match.p0,match.p1;
  fresh identifier var_noinit = var##" __no_initialize";
  @@
  -T var@p0;
  +T var_noinit;
  ...
  copy_from_user(&var,..., sizeof(var))@p1

Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
 v2:
  - changed __do_not_initialize to __no_initialize as requested by Kees
    Cook
  - wrote a Coccinelle script to generate the patch
---
 drivers/android/binder.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a6b2082c24f8f..a59871532ff6b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
 
 		case BC_TRANSACTION_SG:
 		case BC_REPLY_SG: {
-			struct binder_transaction_data_sg tr;
+			struct binder_transaction_data_sg tr __no_initialize;
 
 			if (copy_from_user(&tr, ptr, sizeof(tr)))
 				return -EFAULT;
@@ -3799,7 +3799,7 @@ static int binder_thread_write(struct binder_proc *proc,
 		}
 		case BC_TRANSACTION:
 		case BC_REPLY: {
-			struct binder_transaction_data tr;
+			struct binder_transaction_data tr __no_initialize;
 
 			if (copy_from_user(&tr, ptr, sizeof(tr)))
 				return -EFAULT;
@@ -4827,7 +4827,7 @@ static int binder_ioctl_write_read(struct file *filp,
 	struct binder_proc *proc = filp->private_data;
 	unsigned int size = _IOC_SIZE(cmd);
 	void __user *ubuf = (void __user *)arg;
-	struct binder_write_read bwr;
+	struct binder_write_read bwr __no_initialize;
 
 	if (size != sizeof(struct binder_write_read)) {
 		ret = -EINVAL;
@@ -5039,7 +5039,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case BINDER_SET_CONTEXT_MGR_EXT: {
-		struct flat_binder_object fbo;
+		struct flat_binder_object fbo __no_initialize;
 
 		if (copy_from_user(&fbo, ubuf, sizeof(fbo))) {
 			ret = -EINVAL;
@@ -5076,7 +5076,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case BINDER_GET_NODE_INFO_FOR_REF: {
-		struct binder_node_info_for_ref info;
+		struct binder_node_info_for_ref info __no_initialize;
 
 		if (copy_from_user(&info, ubuf, sizeof(info))) {
 			ret = -EFAULT;
@@ -5095,7 +5095,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case BINDER_GET_NODE_DEBUG_INFO: {
-		struct binder_node_debug_info info;
+		struct binder_node_debug_info info __no_initialize;
 
 		if (copy_from_user(&info, ubuf, sizeof(info))) {
 			ret = -EFAULT;
-- 
2.25.0.265.gbab2e86ba0-goog

