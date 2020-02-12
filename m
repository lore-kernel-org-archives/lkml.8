Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC69C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88AA20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 03:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJmZX2RZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBLDEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:04:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40323 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgBLDEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:04:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so468179pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 19:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9+ROEe9uWmoG0JMAqzzVnYSI9Saz27W5dlKTyv5qcfY=;
        b=iJmZX2RZ/wxAjrXPddKP4hLoYxzoUoCOPgHnw51WvCeyrxd87JQqifT/H0H+Hn4wjw
         coR17eeP2g0txCCLTi252rucXv0msl+yLgO9URNvA/PqtbCTH4j9ggB4DfZISxhWMW6b
         2Q/B6KYxzVrQpzgRffigYY6k+zrIry08cIbSatNnvT7AXIgSLy6bDNdmDmZgmgFt46XQ
         46kp3VLilGqsA/sHSc1aeQoVb0TmlFmzezJKlbBC2HW61yKowv38kgSRdAHsTxgxuHxN
         0GfBgKsZN+BCQzhx3NWnrymI6H9+W3Jd9aCVvaPzrpe9rpHWEOOqSWTD50jbkpCIVh3L
         lG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9+ROEe9uWmoG0JMAqzzVnYSI9Saz27W5dlKTyv5qcfY=;
        b=YO7AiZuzwP5kCWrot4+ODH3YUy+3caz/YY/cVOzV0ZutBEoEU1Df09tWtXCpo5+DFk
         AsDGHL+Z/2Gf5tMHuVv7u8M7zbg8/Ld9NVkrZ9l4RRCfavLmxDJDYyfPevO0/HQBlMNA
         ckM+nW67uDMnT8VL8d1hFt+axBK8cD3oHKQLM+MwPBJaF0nzBfC0JcJcLj8sOqiy14vW
         s4O80ev17Vl6r6el4YETTQ78pbW/eTTbtZqDGqJ4Mvp06ZqYSCJDKbv1684CZH7gId2P
         r7T+WWCeVdqZVwmCtYnYoys03k+40QCxAniWDnTKyqU+smOczsov5EZ3jguB/i2xnbPK
         YuMQ==
X-Gm-Message-State: APjAAAVWx897wXbJXrHyed0ZOvdyWkyE1R8sVw711FiS9a0Awvo7iJVn
        9Q7kmysxM3vbgMiwkO9DCRs=
X-Google-Smtp-Source: APXvYqxRRt7P+TBCz+ADgVugIYbkq0VaauGzcxx3XpCD1mhmIlZWG6fYU3EI1TxMW1gPiPJWAKh61A==
X-Received: by 2002:a63:27c4:: with SMTP id n187mr6557727pgn.305.1581476645647;
        Tue, 11 Feb 2020 19:04:05 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id u12sm5654332pgr.3.2020.02.11.19.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 19:04:04 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:04:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
Message-ID: <20200212030403.GC13208@google.com>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
 <20200212011551.GA13208@google.com>
 <20200211214958.5d8f4004@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211214958.5d8f4004@rorschach.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/11 21:49), Steven Rostedt wrote:
> On Wed, 12 Feb 2020 10:15:51 +0900
> Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> 
> > On (20/02/10 12:48), Konstantin Khlebnikov wrote:
> > > 
> > > In NMI context printk() could save messages into per-cpu buffers and
> > > schedule flush by irq_work when IRQ are unblocked. This means message
> > > about hardlockup appears in kernel log only when/if lockup is gone.
> > > 
> > > Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
> > > thus printk() cannot schedule flush work to another cpu.
> > > 
> > > This patch adds simple atomic counter of detected hardlockups and
> > > flushes all per-cpu printk buffers in context softlockup watchdog
> > > at any other cpu when it sees changes of this counter.
> > 
> > Petr, could you remind me, why do we do PRINTK_NMI_DIRECT_CONTEXT_MASK
> > only from ftrace?
> 
> Could it be because its from ftrace_dump() which can spit out millions
> of lines from NMI context?

Oh, yes, ftrace printks a lot. But I sort of forgot why don't we do
the same for "regular" NMIs. So NMIs use per-cpu buffers, expect for
NMIs which involve ftrace dump. I'm missing something here.

	-ss
