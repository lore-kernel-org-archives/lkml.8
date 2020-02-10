Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C6DC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E4D20658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uImQGabY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgBJPCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:02:06 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42972 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgBJPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:02:06 -0500
Received: by mail-io1-f65.google.com with SMTP id s6so7863722iol.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhMwZCYROirrJMoN5ENbQVM31GkKgHRjbPr+9bhi68s=;
        b=uImQGabY9dxOZONqTfKUL5gE1YbSZdXoJ8AWTRjzEHCFO7x8127xTjm4QQwIjpWIVB
         jrgOeGxFcmfdngVwXgLzHMvbmpZbQNeRyYmkCFDRMKzM8yppUhFMHb6WLK9qQl8oLhqC
         jNa0HenIjQLy+ohapkQQ4ci3ZGTupit7jPRweeMsjyZkln1gQs1JgJcRvbKK+2xWXd6D
         x8m8WVAGeEHODeM99C8aGyHwmXTOgXyZ5yqPEgOjVu+ClX9bF+98A6FaNy163TZRr5IJ
         P9U9+arKycX7zzDMFgbkc64HfLZUPPjzIBaJPoIWQLLooOvdcn00Nw69bs1OiUB4OjTQ
         4VXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhMwZCYROirrJMoN5ENbQVM31GkKgHRjbPr+9bhi68s=;
        b=QVQ8lBwYv/y1I/TkgUE/tBYEGr/KeLOn1o0P5+ir9TB31S1oYt7YobiE8FEnXU84SG
         WYQVVfvcxI488dqGnrQ/QYi+F9Zc0ui7TtS+Z9n1ppSmc3QDGuhqlmIdB4C2pcMn8fwb
         8KmhV95DkfZwCQ9AQHzQwnB6poEDLs5zedfgXNvteK8b5XOdh3KlCA8+rBqz2vxUvhKe
         IP6eIDkFVopOPFdpmSXmR9nT2Ow9mC791UPFw6e0IFPctsJhrf7anLEiDRVeFqJjKKoE
         +LpfTrF/cVi2TCq/Mnz0fCJPzoCDo4xUu28nuWQrHlCfFh8X+KRWYgJDTNCpabacpdJA
         v2aQ==
X-Gm-Message-State: APjAAAV04xsxtv7L+x0pUFPu8Y9cpRlyKbkjr0ztzHLNXycqlNOpqxd0
        Gh72IAWk0TIUe3sswvRVHQw/Y3FxgAOpWG5sWnMyDA==
X-Google-Smtp-Source: APXvYqyPnVtT5nH7L0EYMs6xaLx+NOHB7rwRvqU4Z1bh2gtYeyUtXSbA9kAV3MDESOSvEfpVZfpbl96NqCLZcY0b05Q=
X-Received: by 2002:a02:8525:: with SMTP id g34mr10179487jai.72.1581346925348;
 Mon, 10 Feb 2020 07:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20200209105901.1620958-1-gregkh@linuxfoundation.org> <20200209105901.1620958-6-gregkh@linuxfoundation.org>
In-Reply-To: <20200209105901.1620958-6-gregkh@linuxfoundation.org>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 11 Feb 2020 02:01:53 +1100
Message-ID: <CAOSf1CEKwjDkp-=SMjmJfQirxdGCkadougZbdDS6FK1muNNCZw@mail.gmail.com>
Subject: Re: [PATCH 6/6] powerpc: powernv: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:12 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

For memtrace debugfs is the only way to actually use the feature. It'd
be nice if it still printed out *something* if it failed to create the
files rather than just being mysteriously absent, but maybe debugfs
itself does that. Looks fine otherwise.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c  |  7 ----
>  arch/powerpc/platforms/powernv/opal-imc.c  | 24 ++++----------
>  arch/powerpc/platforms/powernv/pci-ioda.c  |  5 ---
>  arch/powerpc/platforms/powernv/vas-debug.c | 37 ++--------------------
>  4 files changed, 10 insertions(+), 63 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index eb2e75dac369..d6d64f8718e6 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -187,11 +187,6 @@ static int memtrace_init_debugfs(void)
>
>                 snprintf(ent->name, 16, "%08x", ent->nid);
>                 dir = debugfs_create_dir(ent->name, memtrace_debugfs_dir);
> -               if (!dir) {
> -                       pr_err("Failed to create debugfs directory for node %d\n",
> -                               ent->nid);
> -                       return -1;
> -               }
>
>                 ent->dir = dir;
>                 debugfs_create_file("trace", 0400, dir, ent, &memtrace_fops);
> @@ -314,8 +309,6 @@ static int memtrace_init(void)
>  {
>         memtrace_debugfs_dir = debugfs_create_dir("memtrace",
>                                                   powerpc_debugfs_root);
> -       if (!memtrace_debugfs_dir)
> -               return -1;
>
>         debugfs_create_file("enable", 0600, memtrace_debugfs_dir,
>                             NULL, &memtrace_init_fops);
> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> index 000b350d4060..968b9a4d1cd9 100644
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -35,11 +35,10 @@ static int imc_mem_set(void *data, u64 val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_imc_x64, imc_mem_get, imc_mem_set, "0x%016llx\n");
>
> -static struct dentry *imc_debugfs_create_x64(const char *name, umode_t mode,
> -                                            struct dentry *parent, u64  *value)
> +static void imc_debugfs_create_x64(const char *name, umode_t mode,
> +                                  struct dentry *parent, u64  *value)
>  {
> -       return debugfs_create_file_unsafe(name, mode, parent,
> -                                         value, &fops_imc_x64);
> +       debugfs_create_file_unsafe(name, mode, parent, value, &fops_imc_x64);
>  }
>
>  /*
> @@ -59,9 +58,6 @@ static void export_imc_mode_and_cmd(struct device_node *node,
>
>         imc_debugfs_parent = debugfs_create_dir("imc", powerpc_debugfs_root);
>
> -       if (!imc_debugfs_parent)
> -               return;
> -
>         if (of_property_read_u32(node, "cb_offset", &cb_offset))
>                 cb_offset = IMC_CNTL_BLK_OFFSET;
>
> @@ -69,21 +65,15 @@ static void export_imc_mode_and_cmd(struct device_node *node,
>                 loc = (u64)(ptr->vbase) + cb_offset;
>                 imc_mode_addr = (u64 *)(loc + IMC_CNTL_BLK_MODE_OFFSET);
>                 sprintf(mode, "imc_mode_%d", (u32)(ptr->id));
> -               if (!imc_debugfs_create_x64(mode, 0600, imc_debugfs_parent,
> -                                           imc_mode_addr))
> -                       goto err;
> +               imc_debugfs_create_x64(mode, 0600, imc_debugfs_parent,
> +                                      imc_mode_addr);
>
>                 imc_cmd_addr = (u64 *)(loc + IMC_CNTL_BLK_CMD_OFFSET);
>                 sprintf(cmd, "imc_cmd_%d", (u32)(ptr->id));
> -               if (!imc_debugfs_create_x64(cmd, 0600, imc_debugfs_parent,
> -                                           imc_cmd_addr))
> -                       goto err;
> +               imc_debugfs_create_x64(cmd, 0600, imc_debugfs_parent,
> +                                      imc_cmd_addr);
>                 ptr++;
>         }
> -       return;
> -
> -err:
> -       debugfs_remove_recursive(imc_debugfs_parent);
>  }
>
>  /*
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 22c22cd7bd82..57d3a6af1d52 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3174,11 +3174,6 @@ static void pnv_pci_ioda_create_dbgfs(void)
>
>                 sprintf(name, "PCI%04x", hose->global_number);
>                 phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
> -               if (!phb->dbgfs) {
> -                       pr_warn("%s: Error on creating debugfs on PHB#%x\n",
> -                               __func__, hose->global_number);
> -                       continue;
> -               }
>
>                 debugfs_create_file_unsafe("dump_diag_regs", 0200, phb->dbgfs,
>                                            phb, &pnv_pci_diag_data_fops);
> diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
> index 09e63df53c30..44035a3d6414 100644
> --- a/arch/powerpc/platforms/powernv/vas-debug.c
> +++ b/arch/powerpc/platforms/powernv/vas-debug.c
> @@ -115,7 +115,7 @@ void vas_window_free_dbgdir(struct vas_window *window)
>
>  void vas_window_init_dbgdir(struct vas_window *window)
>  {
> -       struct dentry *f, *d;
> +       struct dentry *d;
>
>         if (!window->vinst->dbgdir)
>                 return;
> @@ -127,28 +127,10 @@ void vas_window_init_dbgdir(struct vas_window *window)
>         snprintf(window->dbgname, 16, "w%d", window->winid);
>
>         d = debugfs_create_dir(window->dbgname, window->vinst->dbgdir);
> -       if (IS_ERR(d))
> -               goto free_name;
> -
>         window->dbgdir = d;
>
> -       f = debugfs_create_file("info", 0444, d, window, &info_fops);
> -       if (IS_ERR(f))
> -               goto remove_dir;
> -
> -       f = debugfs_create_file("hvwc", 0444, d, window, &hvwc_fops);
> -       if (IS_ERR(f))
> -               goto remove_dir;
> -
> -       return;
> -
> -remove_dir:
> -       debugfs_remove_recursive(window->dbgdir);
> -       window->dbgdir = NULL;
> -
> -free_name:
> -       kfree(window->dbgname);
> -       window->dbgname = NULL;
> +       debugfs_create_file("info", 0444, d, window, &info_fops);
> +       debugfs_create_file("hvwc", 0444, d, window, &hvwc_fops);
>  }
>
>  void vas_instance_init_dbgdir(struct vas_instance *vinst)
> @@ -156,8 +138,6 @@ void vas_instance_init_dbgdir(struct vas_instance *vinst)
>         struct dentry *d;
>
>         vas_init_dbgdir();
> -       if (!vas_debugfs)
> -               return;
>
>         vinst->dbgname = kzalloc(16, GFP_KERNEL);
>         if (!vinst->dbgname)
> @@ -166,16 +146,7 @@ void vas_instance_init_dbgdir(struct vas_instance *vinst)
>         snprintf(vinst->dbgname, 16, "v%d", vinst->vas_id);
>
>         d = debugfs_create_dir(vinst->dbgname, vas_debugfs);
> -       if (IS_ERR(d))
> -               goto free_name;
> -
>         vinst->dbgdir = d;
> -       return;
> -
> -free_name:
> -       kfree(vinst->dbgname);
> -       vinst->dbgname = NULL;
> -       vinst->dbgdir = NULL;
>  }
>
>  /*
> @@ -191,6 +162,4 @@ void vas_init_dbgdir(void)
>
>         first_time = false;
>         vas_debugfs = debugfs_create_dir("vas", NULL);
> -       if (IS_ERR(vas_debugfs))
> -               vas_debugfs = NULL;
>  }
> --
> 2.25.0
>
