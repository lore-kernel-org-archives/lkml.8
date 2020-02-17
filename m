Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC148C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9138C21D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581957377;
	bh=NCQqIN5Kmoitt0UNkCbypXgsb9gcydB2SYQaWeUgi8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IDJ0lQ9kiMQz26WGQFRGw5Z4m54ubtL+nNhrNK4a9qnq171a4db476LA22Qk1oCpr
	 R3U/oh+6uEyr+8OLjyGkWyN0rQuou4Xe2kjR3A7optMi142sekXPVsT+4p5Z6SjYeF
	 9S+rVxTLUJk5QYemkzBbuuPg6nFQ9MlEKrJfTZjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgBQQgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgBQQgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:36:16 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65502072C;
        Mon, 17 Feb 2020 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581957375;
        bh=NCQqIN5Kmoitt0UNkCbypXgsb9gcydB2SYQaWeUgi8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1sUl7c1cQL7SlIRcLudZhge4mF+BDZc6o7m5VLqDNq0T0hxuocdzMotgj0eMPRes
         ZuCGMChm96eImIzUmk7ef9dvIaMDu9A2ZVhkEwEzmg1FSYy0fiDVruRT2uuKwHAZDt
         1Q5XR0ArLVmiXxm6SMbc0EIL/ebp9xkb1e869b5w=
Date:   Mon, 17 Feb 2020 17:36:11 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: module: Replace zero-length array with
 flexible-array member
Message-ID: <20200217163610.GA16560@linux-8ccs>
References: <20200213151409.GA30541@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200213151409.GA30541@embeddedor>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Gustavo A. R. Silva [13/02/20 09:14 -0600]:
>The current codebase makes use of the zero-length array language
>extension to the C90 standard, but the preferred mechanism to declare
>variable-length types such as these ones is a flexible array member[1][2],
>introduced in C99:
>
>struct foo {
>        int stuff;
>        struct boo array[];
>};
>
>By making use of the mechanism above, we will get a compiler warning
>in case the flexible array does not occur last in the structure, which
>will help us prevent some kind of undefined behavior bugs from being
>inadvertently introduced[3] to the codebase from now on.
>
>Also, notice that, dynamic memory allocations won't be affected by
>this change:
>
>"Flexible array members have incomplete type, and so the sizeof operator
>may not be applied. As a quirk of the original implementation of
>zero-length arrays, sizeof evaluates to zero."[1]
>
>This issue was found with the help of Coccinelle.
>
>[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>[2] https://github.com/KSPP/linux/issues/21
>[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thanks Gustavo!

Jessica

>---
> kernel/module.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 33569a01d6e1..b88ec9cd2a7f 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1515,7 +1515,7 @@ struct module_sect_attr {
> struct module_sect_attrs {
> 	struct attribute_group grp;
> 	unsigned int nsections;
>-	struct module_sect_attr attrs[0];
>+	struct module_sect_attr attrs[];
> };
>
> static ssize_t module_sect_show(struct module_attribute *mattr,
>@@ -1608,7 +1608,7 @@ static void remove_sect_attrs(struct module *mod)
> struct module_notes_attrs {
> 	struct kobject *dir;
> 	unsigned int notes;
>-	struct bin_attribute attrs[0];
>+	struct bin_attribute attrs[];
> };
>
> static ssize_t module_notes_read(struct file *filp, struct kobject *kobj,
>-- 
>2.25.0
>
