Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A78C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEDE2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aW1/vwIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbgAQBlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:41:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37686 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgAQBli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:41:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so21277023qky.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pm7yctWXySy9C2T/6qcfkqKUjJL7wyLsf2MlCGo4DDQ=;
        b=aW1/vwIHnbtPolixVhPtJ9ZF9h4AE0pAFamuTUfIg+YMrLZEZeXxEqeN3ifNrHy+3L
         qZ+QqF6yNzBwDl56eOQPl3I0kgtSaz6aS4/TokHXPfJfDPgDGm86vMnCobzJS08FjByK
         UMeNB9Y/3bjctgZQ0A3BFUK4/mCafSK81/xmf7QF9C+BboatiLXcORLDW/vXbLaSVEYF
         uoVQJifS6qHdY0go14ympv5N+lsHpt0Bt0G0Z4z6877QEzi4PsLAAXMRN8W5FRLOyGwu
         woF6U5O3w4DsH4GUbJXO0t/z5QEVw3XMERbLh0eqvrJ416HaCx5aUtF8BEefTfotw/wu
         OLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pm7yctWXySy9C2T/6qcfkqKUjJL7wyLsf2MlCGo4DDQ=;
        b=KvA44w5RwAYELbOkVSaEfqsk13DkUutK4yNOIoXpWfnUH4jbWV8PThtreX1tM6dZM2
         j6iQ5s6fG6NBvw81+rn32ASTWiGf2ecJIyCeLOgd4pQPbSls7AkH0DnKx4xnZQtONa8e
         3PaHWJdeexg04E1nE7614Idcwr8oTEhQN3B3dXKEkKASRMVsa1mGSs6QYJ5MO5d7aORP
         PsrtaAnkFphtJ2/rY2tHPBPQ0KYSM03057EBpqyO5Zo7LvmM9qRCfcFOZ6QH9amkKZPH
         T7fTnH0jEoo3zF/nBtKCDgHM2E+ZErA6i52Ys80gRTqJc0f9DvJQVduZETG+BxuBtyWW
         gYKg==
X-Gm-Message-State: APjAAAXzRKqkndkVoNq4kmUTjYB2TyeQzE9a+L33JSYp20+Sy41MXzWs
        fHKbj3AVujEgN4MqlCyEI96IYjP1TnE7w89YlfLunw==
X-Google-Smtp-Source: APXvYqy93c0rjMp3z5HO/Aioj9jo57FOQ2CfYytzcdPbEjn07awjXiE2aB4AsYbBkCETGemxFXSxIZrGXnu+vagIDWk=
X-Received: by 2002:a37:8ac4:: with SMTP id m187mr31316626qkd.277.1579225295498;
 Thu, 16 Jan 2020 17:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20200116145300.59056-1-yuehaibing@huawei.com>
In-Reply-To: <20200116145300.59056-1-yuehaibing@huawei.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Thu, 16 Jan 2020 17:41:24 -0800
Message-ID: <CAMzD94T3TowoygCu3mAtd3WaZtSk1m1AVVpUHYB_bPAyE9QS3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Remove set but not used variable 'first_key'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        songliubraving@fb.com, Yonghong Song <yhs@fb.com>, andriin@fb.com,
        Linux NetDev <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 5:38 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> kernel/bpf/syscall.c: In function generic_map_lookup_batch:
> kernel/bpf/syscall.c:1339:7: warning: variable first_key set but not used [-Wunused-but-set-variable]
>
> It is never used, so remove it.

Previous logic was using it but I forgot to delete it. Thanks for fixing it!

Acked-by: Brian Vazquez <brianvv@google.com>

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/bpf/syscall.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0d94d36..c26a714 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1336,7 +1336,6 @@ int generic_map_lookup_batch(struct bpf_map *map,
>         void *buf, *buf_prevkey, *prev_key, *key, *value;
>         int err, retry = MAP_LOOKUP_RETRIES;
>         u32 value_size, cp, max_count;
> -       bool first_key = false;
>
>         if (attr->batch.elem_flags & ~BPF_F_LOCK)
>                 return -EINVAL;
> @@ -1365,7 +1364,6 @@ int generic_map_lookup_batch(struct bpf_map *map,
>         }
>
>         err = -EFAULT;
> -       first_key = false;
>         prev_key = NULL;
>         if (ubatch && copy_from_user(buf_prevkey, ubatch, map->key_size))
>                 goto free_buf;
> --
> 2.7.4
>
>
