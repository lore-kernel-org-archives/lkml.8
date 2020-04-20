Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC89C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D980E2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383902;
	bh=gpdluPeLo7CGG3nY3aVKpk6zHZ0E1zPD2glqhe/J7t0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=furolOMsWo3acu2HbjBf54C2KuKEdxsIbHn6vFO6LTelm5KPw/vss9je8FyS4Q4Z0
	 pHWorYhYSTbmzK7hAHj2XcusPS7EppGCj+jsLpGDy3WpKO9l2RLUNhKLUQm0Dbdpg6
	 9Y6Bd29y93jJKHEzjd3MO/Etayh27SkF3hjtXxTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDTL6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgDTL6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:58:21 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 627172072B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383900;
        bh=gpdluPeLo7CGG3nY3aVKpk6zHZ0E1zPD2glqhe/J7t0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tJf8qnli5ZQBL197jAHU6WnJ9E99SV8P7Mp3wBiaQI3TFW5+gBRQzt+NGrziggOM/
         ecUVWzJxCGEfJoT2MMxrQkpChKbEJ2ZBbeYBP+ExUbxSTcJqhYBnBbNQB0kUE5tyMo
         TblI1fYwJhMDdz8asUZGJp7zwcqG7ls/xJO+WE5w=
Received: by mail-il1-f178.google.com with SMTP id x2so8110078ilp.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:58:20 -0700 (PDT)
X-Gm-Message-State: AGi0PuZQQ1b/B1e74c0+h9Cq+QgmsrBXv2rv0R0FbokTiQWc4xg/4C+Z
        uypdv8UOn8M9ey+v4yAwUm7rNH7V/Wb7cj1CVi4=
X-Google-Smtp-Source: APiQypK+G8IQY4CVi3k9HiSAYgjQ6r4L4Ty55qjm9OY85VkznbQHJ6GHa0SyPkjAIQ77w1RqrgV8Q+98Sz62EMVvMQY=
X-Received: by 2002:a92:991c:: with SMTP id p28mr15785948ili.258.1587383899723;
 Mon, 20 Apr 2020 04:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210452.27436-1-kristen@linux.intel.com> <20200415210452.27436-9-kristen@linux.intel.com>
In-Reply-To: <20200415210452.27436-9-kristen@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Apr 2020 13:58:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGyQbdmeAwVBy5YPGKeksNq0KkBe-wmZZG=xkGY4Ds0Rg@mail.gmail.com>
Message-ID: <CAMj1kXGyQbdmeAwVBy5YPGKeksNq0KkBe-wmZZG=xkGY4Ds0Rg@mail.gmail.com>
Subject: Re: [PATCH 8/9] kallsyms: hide layout
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, arjan@linux.intel.com, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, rick.p.edgecomb@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 at 23:06, Kristen Carlson Accardi
<kristen@linux.intel.com> wrote:
>
> To support finer grained kaslr (fgkaslr), we need to hide our sorted
> list of symbols, since this will give away our new layout.
> This patch makes /proc/kallsyms only visible to priviledged users.
>

Does it?

> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  kernel/kallsyms.c | 138 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 16c8c605f4b0..861972b6a879 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -25,6 +25,7 @@
>  #include <linux/filter.h>
>  #include <linux/ftrace.h>
>  #include <linux/compiler.h>
> +#include <linux/list_sort.h>
>
>  /*
>   * These will be re-linked against their real values
> @@ -446,6 +447,11 @@ struct kallsym_iter {
>         int show_value;
>  };
>
> +struct kallsyms_iter_list {
> +       struct kallsym_iter iter;
> +       struct list_head next;
> +};
> +
>  int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
>                             char *type, char *name)
>  {
> @@ -660,6 +666,121 @@ int kallsyms_show_value(void)
>         }
>  }
>
> +static int sorted_show(struct seq_file *m, void *p)
> +{
> +       struct list_head *list = m->private;
> +       struct kallsyms_iter_list *iter;
> +       int rc;
> +
> +       if (list_empty(list))
> +               return 0;
> +
> +       iter = list_first_entry(list, struct kallsyms_iter_list, next);
> +
> +       m->private = iter;
> +       rc = s_show(m, p);
> +       m->private = list;
> +
> +       list_del(&iter->next);
> +       kfree(iter);
> +
> +       return rc;
> +}
> +
> +static void *sorted_start(struct seq_file *m, loff_t *pos)
> +{
> +       return m->private;
> +}
> +
> +static void *sorted_next(struct seq_file *m, void *p, loff_t *pos)
> +{
> +       struct list_head *list = m->private;
> +
> +       (*pos)++;
> +
> +       if (list_empty(list))
> +               return NULL;
> +
> +       return p;
> +}
> +
> +static const struct seq_operations kallsyms_sorted_op = {
> +       .start = sorted_start,
> +       .next = sorted_next,
> +       .stop = s_stop,
> +       .show = sorted_show
> +};
> +
> +static int kallsyms_list_cmp(void *priv, struct list_head *a,
> +                               struct list_head *b)
> +{
> +       struct kallsyms_iter_list *iter_a, *iter_b;
> +
> +       iter_a = list_entry(a, struct kallsyms_iter_list, next);
> +       iter_b = list_entry(b, struct kallsyms_iter_list, next);
> +
> +       return strcmp(iter_a->iter.name, iter_b->iter.name);
> +}
> +
> +int get_all_symbol_name(void *data, const char *name, struct module *mod,
> +                       unsigned long addr)
> +{
> +       unsigned long sym_pos;
> +       struct kallsyms_iter_list *node, *last;
> +       struct list_head *head = (struct list_head *)data;
> +
> +       node = kmalloc(sizeof(*node), GFP_KERNEL);
> +       if (!node)
> +               return -ENOMEM;
> +
> +       if (list_empty(head)) {
> +               sym_pos = 0;
> +               memset(node, 0, sizeof(*node));
> +               reset_iter(&node->iter, 0);
> +               node->iter.show_value = kallsyms_show_value();
> +       } else {
> +               last = list_first_entry(head, struct kallsyms_iter_list, next);
> +               memcpy(node, last, sizeof(*node));
> +               sym_pos = last->iter.pos;
> +       }
> +
> +       INIT_LIST_HEAD(&node->next);
> +       list_add(&node->next, head);
> +
> +       /*
> +        * update_iter returns false when at end of file
> +        * which in this case we don't care about and can
> +        * safely ignore. update_iter() will increment
> +        * the value of iter->pos, for ksymbol_core.
> +        */
> +       if (sym_pos >= kallsyms_num_syms)
> +               sym_pos++;
> +
> +       (void) update_iter(&node->iter, sym_pos);
> +
> +       return 0;
> +}
> +
> +static int kallsyms_sorted_open(struct inode *inode, struct file *file)
> +{
> +       int ret;
> +       struct list_head *list;
> +
> +       list = __seq_open_private(file, &kallsyms_sorted_op, sizeof(*list));
> +       if (!list)
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(list);
> +
> +       ret = kallsyms_on_each_symbol(get_all_symbol_name, list);
> +       if (ret != 0)
> +               return ret;
> +
> +       list_sort(NULL, list, kallsyms_list_cmp);
> +

Could we do the sort at init time rather than open time?

> +       return 0;
> +}
> +
>  static int kallsyms_open(struct inode *inode, struct file *file)
>  {
>         /*
> @@ -704,9 +825,24 @@ static const struct proc_ops kallsyms_proc_ops = {
>         .proc_release   = seq_release_private,
>  };
>
> +static const struct proc_ops kallsyms_sorted_proc_ops = {
> +       .proc_open = kallsyms_sorted_open,
> +       .proc_read = seq_read,
> +       .proc_lseek = seq_lseek,
> +       .proc_release = seq_release_private,
> +};
> +
>  static int __init kallsyms_init(void)
>  {
> -       proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> +       /*
> +        * When fine grained kaslr is enabled, we need to
> +        * print out the symbols sorted by name rather than by
> +        * by address, because this reveals the randomization order.
> +        */
> +       if (!IS_ENABLED(CONFIG_FG_KASLR))
> +               proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> +       else
> +               proc_create("kallsyms", 0444, NULL, &kallsyms_sorted_proc_ops);

Can we just switch to the sorted version unconditionally instead? Or
is the output order of /proc/kallsyms considered kernel ABI?

>         return 0;
>  }
>  device_initcall(kallsyms_init);
> --
> 2.20.1
>
