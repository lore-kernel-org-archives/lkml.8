Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BEBC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E15D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jkUs4hzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBJOgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:36:32 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44880 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbgBJOgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:36:32 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so3234900qvg.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sw8aLoMN7edQi9tCuvhNl/iVTODc75PkGH73eAqI96U=;
        b=jkUs4hzNPVCxprNaYv/MX6zJKcph8mNHMTtg4GPspg617lRSe8FqvFZb+o6DjOVQrr
         37PLeSeLutY7XJ9bF9R8p8fkpRVR1+dbJ/xoFkZpdtBhUjgQ8XP3/erYccm80CSIsQOt
         HdrE0hqNGzxMN1RMnvutju/NJGpV26qWRmjJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sw8aLoMN7edQi9tCuvhNl/iVTODc75PkGH73eAqI96U=;
        b=GZXvwHtcbScpDKEf0BVO1E2gSTu3952LhQx7OktedyQ5gqoH0Vh7ZScruIUzKsfAiO
         k2pKFBrblGOXYPFjA8cfBnKAsSRCigZHGAx+qdtl0vrZFhwyxSlF3FPYiH52Y6arjJiu
         gMvBzaaItBk67WRaWTc8s5GbbQ2wTYgCpm2pILfwC97C+NXujhG/YGZ/LkJa5AvO2Fy3
         ABLRk700kVVCx4E+kuzI9cknSRzjmBsvyS3Owvy2xRlSaCK+G8XebL1j6zWd0a9MAOj1
         XJa5NAJJ2q8qSLpXBKb+JDPcHPvxUX1wtKwvo++tWOcUOfwnru6cfVzMrBtIMEQXjoMP
         4ijQ==
X-Gm-Message-State: APjAAAXuSXFHrGqaWV0TK5hK16NpRoYK+J4ECF+vFENN0sLiPA1qDDwl
        zMekwtkdZCs4ptySVUacTVSKmptefsGNQBQMz7IQpw==
X-Google-Smtp-Source: APXvYqwRHxH3WegeUNyf9KYF23HojSS4aZrwxB1WWUB6IVN0BNlAXwRaNtfCrRRaOByrQcK4G1XSGw2HvfkGNzkvMhQ=
X-Received: by 2002:a0c:f685:: with SMTP id p5mr10354179qvn.44.1581345391131;
 Mon, 10 Feb 2020 06:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20200210122423.695146547@linuxfoundation.org> <20200210122438.674498788@linuxfoundation.org>
In-Reply-To: <20200210122438.674498788@linuxfoundation.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 10 Feb 2020 06:36:20 -0800
Message-ID: <CAEXW_YSPDHcuLiM4B8uXvw-0ei2Gj0x=QE1h+NMqzRiBph1oNw@mail.gmail.com>
Subject: Re: [PATCH 5.5 150/367] tracing: Annotate ftrace_graph_hash pointer
 with __rcu
To:     Amol Grover <frextrite@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 4:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Amol Grover <frextrite@gmail.com>
>
> [ Upstream commit 24a9729f831462b1d9d61dc85ecc91c59037243f ]

Amol, can you send a follow-up patch to annotate
ftrace_graph_notrace_hash as well?

- Joel

>
> Fix following instances of sparse error
> kernel/trace/ftrace.c:5664:29: error: incompatible types in comparison
> kernel/trace/ftrace.c:5785:21: error: incompatible types in comparison
> kernel/trace/ftrace.c:5864:36: error: incompatible types in comparison
> kernel/trace/ftrace.c:5866:25: error: incompatible types in comparison
>
> Use rcu_dereference_protected to access the __rcu annotated pointer.
>
> Link: http://lkml.kernel.org/r/20200201072703.17330-1-frextrite@gmail.com
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  kernel/trace/trace.h  | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 9bf1f2cd515ef..959ded08dc13f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5596,7 +5596,7 @@ static const struct file_operations ftrace_notrace_fops = {
>
>  static DEFINE_MUTEX(graph_lock);
>
> -struct ftrace_hash *ftrace_graph_hash = EMPTY_HASH;
> +struct ftrace_hash __rcu *ftrace_graph_hash = EMPTY_HASH;
>  struct ftrace_hash *ftrace_graph_notrace_hash = EMPTY_HASH;
>
>  enum graph_filter_type {
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 63bf60f793987..97dad33260208 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -950,22 +950,25 @@ extern void __trace_graph_return(struct trace_array *tr,
>                                  unsigned long flags, int pc);
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
> -extern struct ftrace_hash *ftrace_graph_hash;
> +extern struct ftrace_hash __rcu *ftrace_graph_hash;
>  extern struct ftrace_hash *ftrace_graph_notrace_hash;
>
>  static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
>  {
>         unsigned long addr = trace->func;
>         int ret = 0;
> +       struct ftrace_hash *hash;
>
>         preempt_disable_notrace();
>
> -       if (ftrace_hash_empty(ftrace_graph_hash)) {
> +       hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
> +
> +       if (ftrace_hash_empty(hash)) {
>                 ret = 1;
>                 goto out;
>         }
>
> -       if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
> +       if (ftrace_lookup_ip(hash, addr)) {
>
>                 /*
>                  * This needs to be cleared on the return functions
> --
> 2.20.1
>
>
>
