Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46940C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236FB20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdVncMUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgHCPmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgHCPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:42:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A04C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:42:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so29573573wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLXMroI9RZKFZ/jbE2T9kC6SWd2fACmZd1CP7cneKVM=;
        b=OdVncMUe7vse9R2wbxQY1D5HUGHp3kUEjL9lIul4+4jUpyj7NUhPm3dIY25SZkfDWU
         TBnBtFJBB+04cazx6KTj4ZYiMgLbCB8J/xWZUH6FE/5tqZIB/T6QJo74kzHdOPLfn3ws
         RTnn1wWKM9Bmhb8a2tPmpSh77XV4XFJ//4ABySZ/UkE8AcWDE35YemtaeZfLjM8amaut
         xU7qB7ygXSeoEeYcckTt8OcRb34gg6zDo5f6AJcPz6bdp1mX0+t9zRFboEnP+nK2fbzE
         HHhajtdxcJFAkW+JBB4RG8yfCWsUUbtOVbUXah8oZyaxeONuzthTPfyZkF0yp9FtvtA5
         H0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLXMroI9RZKFZ/jbE2T9kC6SWd2fACmZd1CP7cneKVM=;
        b=XplvXpLTZb4/3/o/1RrvwoeAajN2zs/nF/d3Xy3UVVOtuMPOFVzSqiFhyJlryNPAEo
         xRsMUuHV3VsqRn4pBgUVfVmtMEASdlPAfgrMSwpCTFQDHNQoCZtQZ/S5R5qxF7EKvRcL
         2zAuR+dmroKFmfwfGTfOkKAJFhFk1d5MVZzW7BhuWKepdWi4Xt1pFAbSWMS/hWD1V9Z0
         RWT951Ppcq5tDbxjwu5sKw0NpawdpSAkSCn9+OczCKiP7yx8Q2640poUbabmyQWG82BH
         luGeYWQZ78HNZqD5fh3Sfi8K4xid6qZ0KuhZ3KFOgy7LdoMW2ivpP46jaxEMNTGLiFry
         O6eA==
X-Gm-Message-State: AOAM533DspmYg7mx/d9cEAiJV2x7yDNrXKuOQlLZy7tSAMNX1OAXRKQS
        O4pOGJsQHUmDbMbm5VxwaMfww9Wv7LUszGVCMO8qCQ==
X-Google-Smtp-Source: ABdhPJxys/xHIYQ42TEBs0qm6F/uMXQud1OI7PztcXotRLsUXd8i9YvqD9CnjKyTI6JekBgx1fU0BmnjuD7xKr9c1Xk=
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr15023161wrr.48.1596469329582;
 Mon, 03 Aug 2020 08:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200731114214.25654-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20200731114214.25654-1-bobo.shaobowang@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Aug 2020 08:41:58 -0700
Message-ID: <CAP-5=fWuKDt1piqnbefhungwm8tmZMFecrAqyoaq74qLP6V28w@mail.gmail.com>
Subject: Re: [PATCH v2 -next] tools build: Check return value of
 fwrite_unlocked in jvmti_agent.c
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Li Bin <huawei.libin@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 4:42 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Function jvmti_write_code called by compiled_method_load_cb may return
> error in using fwrite_unlocked, this failure should be captured and
> warned.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

Thanks, looks good now!

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/jvmti/jvmti_agent.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index 88108598d6e9..dfb6cb8564cb 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
>         struct jr_code_load rec;
>         size_t sym_len;
>         FILE *fp = agent;
> -       int ret = -1;
> +       int sret;
>
>         /* don't care about 0 length function, no samples */
>         if (size == 0)
> @@ -400,17 +400,24 @@ jvmti_write_code(void *agent, char const *sym,
>          */
>         rec.code_index = code_generation++;
>
> -       ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
> -       fwrite_unlocked(sym, sym_len, 1, fp);
> +       sret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
> +       if (sret != 1)
> +               goto error;
> +       sret = fwrite_unlocked(sym, sym_len, 1, fp);
> +       if (sret != 1)
> +               goto error;
>
> -       if (code)
> -               fwrite_unlocked(code, size, 1, fp);
> +       if (code) {
> +               sret = fwrite_unlocked(code, size, 1, fp);
> +               if (sret != 1)
> +                       goto error;
> +       }
>
>         funlockfile(fp);
> -
> -       ret = 0;
> -
> -       return ret;
> +       return 0;
> +error:
> +       funlockfile(fp);
> +       return -1;
>  }
>
>  int
> --
> 2.25.1
>
