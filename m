Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80CEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823AE20656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZynGCI6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgFJSdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgFJSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:33:10 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B262C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:33:10 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id c9so1192676uao.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGyy3CO8by6rtbdLVnfCEmk/inhvOgbRGBcLBUPWXjg=;
        b=ZynGCI6UZvGi1T1Lo6Nhhh/Zb77Vo/06xc1iPkoeYqXl0v0Divn5OlgSdLmC6cakks
         TUR3Or9Ci3LXrrFic5hJx/o/z5pjQpdczHomgInozaiU4IHEisKNQC11phbUeU3tqzgV
         lAJMasMquH4aaO7yUyEVXShGcrMXqxjfhVtJ5lIITOFReXXc1XBcwMR/uGxmjiMvaSwm
         ErKreBlPKYGUD3GmhVDhWYWlg15Fws6LfXe9DvNGNMdgq7IbQDbzaEBVgsy+W0l2wQhO
         oLbnFWWODYz/0PMb8vGiCWi2Z3LIeemf5QCuk5n/m5KdNJCPp9dOVNf7r9Xab2b4hEWV
         ixJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGyy3CO8by6rtbdLVnfCEmk/inhvOgbRGBcLBUPWXjg=;
        b=E7oWs2dj49ZP05VZeF/5FqR2R+XTILr5Ok5HfTk21v2XSUeDEDi5rpxQMBNlve7BPQ
         p6ec1ZHq+S/Lyqyrri0iHpsnqNwCxbS6C2F0jou45wUNXXrsGSS1aV1duyGeFNTZiMTg
         LGqYFjCzpBpcztIauapo+GzLsC/UTMUAyIw+dDBjwm/V5ALH5uSheI/h6ylpz9iIKkdz
         uCAHDqvwNaoyJFncWNRdjiEix9Mw2EOuopdQE62PqBi1fJmPOYTKTCR7Akdr/5KLhNri
         iHT1gkbMVWYY90884ekB+kTz2nQ1Luy0BGgJ/pcnDobPsh8BNw/e3DI7j+2XmjnU8usK
         9d+A==
X-Gm-Message-State: AOAM531rSxKZcr+kiMPWyjDGUFMt8HjWWcOJf9CnkbHBxhY7D81w9LOt
        yNgxg20bxjbFB/iIw8PfBWJ4PkgS1TZWcXMX4vk=
X-Google-Smtp-Source: ABdhPJxbJcRW+B+d7Iw9itG/HDC/fcaNfAvvsVjm8DV1enjLKdTP0iSISXIaw5Zs2qTYz7Q6asJyvTiXTwV49JPfjPg=
X-Received: by 2002:a9f:31cb:: with SMTP id w11mr3631980uad.128.1591813988984;
 Wed, 10 Jun 2020 11:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org> <20200609104604.1594-7-stanimir.varbanov@linaro.org>
In-Reply-To: <20200609104604.1594-7-stanimir.varbanov@linaro.org>
From:   jim.cromie@gmail.com
Date:   Wed, 10 Jun 2020 12:32:42 -0600
Message-ID: <CAJfuBxzxwoyXbDrgQzb=BZJ8ZQ5hHo32Zr1uo6Od=7+q13+GXQ@mail.gmail.com>
Subject: WIP generic module->debug_flags and dynamic_debug
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so Ive got a WIP / broken / partial approach to giving all modules a
u32 flagset,
and enabling pr_debug based upon it.  I leave out the "pr_debug_typed(
bitpos )" for now.  For Stanimir, bits 1,2,3 could be high, middle,
low.

ATM its broken on my lack of container_of() skills.

Im trying to use it to get a struct module* using its name value thats
been copied
into a ddebug_table member.

Im relying on
cdf6d006968  dynamic_debug: don't duplicate modname in ddebug_add_module
to have the same value in both structs

but Im clearly missing a few things
besides the likely future trouble with .rodata builtin modules
(after compile prob solved)

It seems container_of wants me to use struct ddebug_table instead,
but I dont want a *ddebug_table.
Ive blindly guessed at adding & and * to 1st param, w/o understanding.

can anyone diagnose my problem ?


[jimc@frodo build-virtme]$ git diff
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a5d76f8f6b40..2bfd1aa083b3 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -20,6 +20,7 @@ struct _ddebug {
        const char *function;
        const char *filename;
        const char *format;
+       u32 reqd_flags; /*misleading name todo, probly should hold
just a single type-bit */
        unsigned int lineno:18;
        /*
         * The flags field controls the behaviour at the callsite.
diff --git a/include/linux/module.h b/include/linux/module.h
index 1ad393e62bef..06eeef438fd3 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -429,6 +429,7 @@ struct module {
        struct mod_arch_specific arch;

        unsigned long taints;   /* same bits as kernel:taint_flags */
+       u32 debugflags;

 #ifdef CONFIG_GENERIC_BUG
        /* Support for BUG */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 63ae6f77a0e4..965ee96630b5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -202,6 +202,20 @@ static int ddebug_change(const struct ddebug_query *query,
                        if ((~dp->flags & filter->mask) != filter->mask)
                                continue;

+                       /* screen on module->debugflags */
+                       if (query->module) {
+                               /* dt->modname is known == module->name */
+                               struct module *m =
+                                       container_of((&(dt->mod_name)),
+                                                    struct module, name);
+                               if (m->debugflags &&
+                                   ((m->debugflags & dp->reqd_flags)
+                                    != dp->reqd_flags))
+                                       continue;
+                               vpr_info("%s module-debugflags: 0x%x\n",
+                                        dt->mod_name, dp->reqd_flags);
+                       }
+
                        nfound++;

                        newflags = (dp->flags & mods->mask) | mods->flags;
(END)
