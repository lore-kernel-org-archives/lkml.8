Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5238C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B82214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TJDqBje/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgAaDSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:18:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45094 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgAaDSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:18:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so6170153edw.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 19:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buSrMaq3P1kBcoQzppNWiz8mxz8CGYk6xzumXwp47Gw=;
        b=TJDqBje/4kovhxVoa7fJhxwtKvZu96ba4Fazph6w0MgqLiH+B86Unk3FQHMvj+szhb
         B+Fwi7Ht3cclOtcdVriI0tXdtSDQBCAFStUdJgnbkt4+vZrvpw+EROax34d0/bRsfeW6
         ROE2KlfQBnuFt7v8hN2PDQ+BARCWXMOkI/Gt9Bz8UFhqL8QMsjDG/xQrc3UFr5a1bFaS
         iLokGwwI0n+mG7MPo+eH/zIhgjWSNhi6URIfdKGDRMmYeB958FCJJPksr3lcnOymGzJ0
         s7oMAFx+LdZvIuYbpYr4i08c47RbFsxOT15G6EYtBdMhhskmV0O3Pp1facwCw8noaoZU
         Kpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buSrMaq3P1kBcoQzppNWiz8mxz8CGYk6xzumXwp47Gw=;
        b=Ui24WOX83E42L5kdBxIRnsVSMNR+EoSuneDis4CB84UUjm1vmHtWNC5X/s7o32MA6d
         s1i48ZoIkBDAK4d7AEDB7+Amb0oCI2EqZuf3aryvtZ5HsqPkyFNnGIdTtrAR6lcYQKHw
         LIRsKjwa4P5IH/oGADiJa65NcGeyjfFeYjtRy9b0xd1AZgHwky9HHFW+JT3I1k3Up8/I
         NCEB0tNIOgqkviGYRZai+dDOAYjBsdmnLXKzv8V5XSkhIYUBFALm+OFKq3L11ORVXVoT
         IFIChPzpyAn39S9YrldtfyE9nF2LEPl3RAFnW2Rea43hwbo/A7+oUBHi8O2moWfLhPtj
         g3TQ==
X-Gm-Message-State: APjAAAWV4rXAwigDLfHOxLve2HbbcDAKWGYEUkWYiKJ54stdUxS4fkRX
        lm/l0pFWsir/v4w/Tduy7kPck1ZT8SLGi7f3bh5x
X-Google-Smtp-Source: APXvYqxQTQi2ruXUw7RGKVRL/KdRLdKxHLUtihlr0JephRf2b1FHU4WCfGPUlVGABO7BBYiOcz2IgCKd3oA1Edxrbc4=
X-Received: by 2002:a17:906:198b:: with SMTP id g11mr6985931ejd.271.1580440730598;
 Thu, 30 Jan 2020 19:18:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577830902.git.rgb@redhat.com> <65974a7254dffe53b5084bedfd60c95a29a41e08.1577830902.git.rgb@redhat.com>
In-Reply-To: <65974a7254dffe53b5084bedfd60c95a29a41e08.1577830902.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 22:18:39 -0500
Message-ID: <CAHC9VhSSxfBLM5gpcmR-4BXctc-iKwvtcuYDkBesVttnWsNmmQ@mail.gmail.com>
Subject: Re: [PATCH ghak25 v2 9/9] netfilter: audit table unregister actions
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        omosnace@redhat.com, fw@strlen.de, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 1:56 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Audit the action of unregistering ebtables and x_tables.
>
> See: https://github.com/linux-audit/audit-kernel/issues/44
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c                | 3 ++-
>  net/bridge/netfilter/ebtables.c | 3 +++
>  net/netfilter/x_tables.c        | 4 +++-
>  3 files changed, 8 insertions(+), 2 deletions(-)

... and in keeping with an ongoing theme for this patchset, please
squash this patch too.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 999ac184246b..2644130a9e66 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2557,7 +2557,8 @@ void __audit_nf_cfg(const char *name, u8 af, int nentries, int op)
>                 return; /* audit_panic or being filtered */
>         audit_log_format(ab, "table=%s family=%u entries=%u op=%s",
>                          name, af, nentries,
> -                        op ? "replace" : "register");
> +                        op == 1 ? "replace" :
> +                                  (op ? "unregister" : "register"));
>         audit_log_end(ab);
>  }
>  EXPORT_SYMBOL_GPL(__audit_nf_cfg);
> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
> index baff2f05af43..3dd4eb5b13fd 100644
> --- a/net/bridge/netfilter/ebtables.c
> +++ b/net/bridge/netfilter/ebtables.c
> @@ -1126,6 +1126,9 @@ static void __ebt_unregister_table(struct net *net, struct ebt_table *table)
>         mutex_lock(&ebt_mutex);
>         list_del(&table->list);
>         mutex_unlock(&ebt_mutex);
> +       if (audit_enabled)
> +               audit_nf_cfg(table->name, AF_BRIDGE, table->private->nentries,
> +                            2);
>         EBT_ENTRY_ITERATE(table->private->entries, table->private->entries_size,
>                           ebt_cleanup_entry, net, NULL);
>         if (table->private->nentries)
> diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
> index 4ae4f7bf8946..e4852a0cb62f 100644
> --- a/net/netfilter/x_tables.c
> +++ b/net/netfilter/x_tables.c
> @@ -1403,7 +1403,7 @@ struct xt_table_info *xt_replace_table(struct xt_table *table,
>
>         if (audit_enabled)
>                 audit_nf_cfg(table->name, table->af, private->number,
> -                            private->number);
> +                            !!private->number);
>
>         return private;
>  }
> @@ -1466,6 +1466,8 @@ void *xt_unregister_table(struct xt_table *table)
>         private = table->private;
>         list_del(&table->list);
>         mutex_unlock(&xt[table->af].mutex);
> +       if (audit_enabled)
> +               audit_nf_cfg(table->name, table->af, private->number, 2);
>         kfree(table);
>
>         return private;
> --
> 1.8.3.1

--
paul moore
www.paul-moore.com
