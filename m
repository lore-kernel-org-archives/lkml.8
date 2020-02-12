Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B49C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8012082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaGrnndt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBLBPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:15:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38401 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgBLBPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:15:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so349077pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zs2uXKiapbKvXm/3vVnKQqNu+eXxLR7F2u80au+zcLs=;
        b=JaGrnndtC+dYroweNUvFOG2Er2265+S0P6bNeXBYxMhbYubJmQzaieSbazFXVP51mC
         6YOJEOjEA9m7+jH3e+4SEmdRVV2AtoXtzFbIQmjylDSUGzJ8ev5+2ymYGq9PK86i8Fvq
         CrDFbLgwxoeIlNrb6zJDr9Qw7Gj04wNzB8CHZexJGLBMF0M1d8IzJIAZVIhC+AWJGVay
         B7JrQao++g3FJGdMqc1cZHG04YyW+q7PXYirfd1Gxp3mxYxHFYx8U9E9pZrCyu/HH5/s
         VrOHm97Uxtb+dJmOAVWgHY7GKUOdw6h1VgFa4vDP0SUpGmJlvTkEXgKsXVevEem2m64p
         lh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zs2uXKiapbKvXm/3vVnKQqNu+eXxLR7F2u80au+zcLs=;
        b=rHvIZ3uU85j/dq0qgi1QQRS7vboxDuZS5P5FQwplKrXtX2Lg3s6jWfmZmgVXO/xYuK
         PAfag5b2L06VkiRxy5jDoKmIMUJlc5lzbJZQDPZcVvqRpIKoNLdZiM1g35sFZpWtVi+B
         m+IFmcpK2IUkVG4GnPvWZVs82o7Y0aEUPDL2wzuMVVl8p23Z7GLsms1ItBrvlB7aNp1M
         dlOCqhC13OGlqGczo/gjqmQisofVL/2AEg1/17R5gt6QT0IkTHVjsVNn4tHSSkNfwexc
         bqCXWWMkYckf90Anqy0DhmXhxRv1vE2Uqu23Gnt7w5otLF/QssJX2XtTWgFjPcAapY05
         8BIA==
X-Gm-Message-State: APjAAAUcfm2TIkbG0WsMfRedgQN1PviZk6gpSNSReOsv/P2gdEPx9sx2
        oXph4Gc9VoG4g+7xeObDS+c=
X-Google-Smtp-Source: APXvYqzhs3hyyL5VBYuiOkdga0BqSZ6nYoXujdfEkcbeg1ErCyFfh6wCqnsHg83z+2tKv2rN/zLJwQ==
X-Received: by 2002:a63:61d3:: with SMTP id v202mr10154054pgb.184.1581470154642;
        Tue, 11 Feb 2020 17:15:54 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id w26sm5634967pfj.119.2020.02.11.17.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 17:15:53 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:15:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
Message-ID: <20200212011551.GA13208@google.com>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158132813726.1980.17382047082627699898.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/10 12:48), Konstantin Khlebnikov wrote:
> 
> In NMI context printk() could save messages into per-cpu buffers and
> schedule flush by irq_work when IRQ are unblocked. This means message
> about hardlockup appears in kernel log only when/if lockup is gone.
> 
> Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
> thus printk() cannot schedule flush work to another cpu.
> 
> This patch adds simple atomic counter of detected hardlockups and
> flushes all per-cpu printk buffers in context softlockup watchdog
> at any other cpu when it sees changes of this counter.

Petr, could you remind me, why do we do PRINTK_NMI_DIRECT_CONTEXT_MASK
only from ftrace?

	-ss
