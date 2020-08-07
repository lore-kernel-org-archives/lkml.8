Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F38C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC012086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596806288;
	bh=S2wyd+msyX0RsCyjg1qnONILIrisgL6mcDR+I/3UAgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ncrfx9lyseyEB4Px82Q7WyBmLzZ90quFtzGa9AVmRHlV+T7xMcC+Gpy6r6zs7YEGj
	 roljeocAvjplSW+lmOyVpTmImAEEmf9yl6VyZbXQ6yGLZ1lX/0sdQSNPmnpQBBFi0B
	 lAneHn0Cib9YljRBU4rAV2d2QfOEkZflWOuzgJR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHGNSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGNSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:18:06 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6FE2086A;
        Fri,  7 Aug 2020 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596806285;
        bh=S2wyd+msyX0RsCyjg1qnONILIrisgL6mcDR+I/3UAgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ctg3C11wquOZehuDJvdToTfrZ9PMiDzLTFZgQHAQ27/yFmbckJwSp2Iny/5mlovZj
         8w0OqfXkB6BR11GGwvZaKxh4nEXjOR8I14BWWJvklTPoN5Hqpd2IPGM0kRtl4b27Ak
         mt6g2cPlHsjx2+mynxjbP21+TuxU6rTa4N/j0KF8=
Date:   Fri, 7 Aug 2020 15:18:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] module: Correctly truncate sysfs sections output
Message-ID: <20200807131800.GA10261@linux-8ccs>
References: <20200807063539.2620154-1-keescook@chromium.org>
 <20200807063539.2620154-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200807063539.2620154-2-keescook@chromium.org>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Kees Cook [06/08/20 23:35 -0700]:
>The only-root-readable /sys/module/$module/sections/$section files
>did not truncate their output to the available buffer size. While most
>paths into the kernfs read handlers end up using PAGE_SIZE buffers,
>it's possible to get there through other paths (e.g. splice, sendfile).
>Actually limit the output to the "count" passed into the read function,
>and report it back correctly. *sigh*
>
>Reported-by: kernel test robot <lkp@intel.com>
>Link: https://lore.kernel.org/lkml/20200805002015.GE23458@shao2-debian
>Fixes: ed66f991bb19 ("module: Refactor section attr into bin attribute")
>Cc: stable@vger.kernel.org
>Cc: Jessica Yu <jeyu@kernel.org>
>Signed-off-by: Kees Cook <keescook@chromium.org>

Oof, thanks for fixing this!

Acked-by: Jessica Yu <jeyu@kernel.org>

>---
> kernel/module.c | 22 +++++++++++++++++++---
> 1 file changed, 19 insertions(+), 3 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index aa183c9ac0a2..08c46084d8cc 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1520,18 +1520,34 @@ struct module_sect_attrs {
> 	struct module_sect_attr attrs[];
> };
>
>+#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
> static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
> 				struct bin_attribute *battr,
> 				char *buf, loff_t pos, size_t count)
> {
> 	struct module_sect_attr *sattr =
> 		container_of(battr, struct module_sect_attr, battr);
>+	char bounce[MODULE_SECT_READ_SIZE + 1];
>+	size_t wrote;
>
> 	if (pos != 0)
> 		return -EINVAL;
>
>-	return sprintf(buf, "0x%px\n",
>-		       kallsyms_show_value(file->f_cred) ? (void *)sattr->address : NULL);
>+	/*
>+	 * Since we're a binary read handler, we must account for the
>+	 * trailing NUL byte that sprintf will write: if "buf" is
>+	 * too small to hold the NUL, or the NUL is exactly the last
>+	 * byte, the read will look like it got truncated by one byte.
>+	 * Since there is no way to ask sprintf nicely to not write
>+	 * the NUL, we have to use a bounce buffer.
>+	 */
>+	wrote = scnprintf(bounce, sizeof(bounce), "0x%px\n",
>+			 kallsyms_show_value(file->f_cred)
>+				? (void *)sattr->address : NULL);
>+	count = min(count, wrote);
>+	memcpy(buf, bounce, count);
>+
>+	return count;
> }
>
> static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
>@@ -1580,7 +1596,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
> 			goto out;
> 		sect_attrs->nsections++;
> 		sattr->battr.read = module_sect_read;
>-		sattr->battr.size = 3 /* "0x", "\n" */ + (BITS_PER_LONG / 4);
>+		sattr->battr.size = MODULE_SECT_READ_SIZE;
> 		sattr->battr.attr.mode = 0400;
> 		*(gattr++) = &(sattr++)->battr;
> 	}
>-- 
>2.25.1
>
