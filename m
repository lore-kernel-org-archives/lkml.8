Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD4C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4E2206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpPEQIvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCLRJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:09:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44343 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgCLRJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:09:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id l18so8435307wru.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEESwEEJWVk/Eaie2wY+AKo8HU4RSekgrz+DHvxmm5E=;
        b=dpPEQIvpVfuOgU6AmC+A57NwArmXTZaDNTHjN8QoeqJuHN8YX4WC4af9BgX2fC2YHo
         waxiAFjkmisGXMJrpZ2Lp0WwhGWQluI9ZqrVlsoimGCJ0cOkjl/7V69uZU/IjmS3z4zP
         F0okTfOQ0LxnKIaVSKhA5WEHd1va+aUSR0a5sfPQ7MBEUbTJgmzkRwV7TJrXZ9DyT7uZ
         6Yh+RvsFaX41Nl0Ze/H6x3mQWBquZcDQWCBe5LLw5P3ScIaT8lvLMlV0BQc2oTV8nZOR
         1k1rPUtZwHnZPlmV9fS38zIDKg87G+5Q6pK8b/KtTqLgIR/ucwK0e5Ozene0MDaHRo2G
         r/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEESwEEJWVk/Eaie2wY+AKo8HU4RSekgrz+DHvxmm5E=;
        b=MsUkDLL01EU+6C4ZO5pEFgqJn9PEBqA+YP6LwHYThQAlnK2gvmKRt1X0AL2HCMEZsb
         1rQhsWdmzQ0toL1i+RMz9dSLVFggZCzFSoKu5gpbh/qmFPy6y+FkWYyAp5HhtdTCe3qa
         YhAG3YO/RcUNyyuVApwhtcMNV8Gsdr4MZk5ADuUFjjCWIRojRCtuYY0Y6x1KbGuoeG+Z
         c3FPsp4ll2lp2qKt3vbsu0v1EplZU1rg32UXBmTS7njMZUkrF2ZZHta0ITY5rXUTOVck
         S6N4d0+WihDlnmS1VWLtqCmf7pbhLqfBEH+AzeNxM70dzTjQ8Cc0zZI3yUaYsg5cCBq3
         JTdw==
X-Gm-Message-State: ANhLgQ2myMHHkitnLEOoRis4MCfZy8ufDmM2E4TbBhxgMeybpeIVfwIN
        fPwM36Es6VHafCeB84TlEA==
X-Google-Smtp-Source: ADFU+vsscIblCfkyjI7U5u1LcYlZrU/edQsOnnaoqZAKPyti+cuA4nnArYjtbW9q9ubdiiVC7GJ/pg==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr11889324wrn.230.1584032984978;
        Thu, 12 Mar 2020 10:09:44 -0700 (PDT)
Received: from avx2 ([46.53.253.3])
        by smtp.gmail.com with ESMTPSA id d1sm13661714wrw.52.2020.03.12.10.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:09:44 -0700 (PDT)
Date:   Thu, 12 Mar 2020 20:09:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched: make nr_running() return "unsigned int"
Message-ID: <20200312170942.GA7151@avx2>
References: <20200311210608.GA4517@avx2>
 <20200312104427.GR12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312104427.GR12561@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:44:27AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 12, 2020 at 12:06:08AM +0300, Alexey Dobriyan wrote:
> > I don't anyone have been crazy enough to spawn 2^32 threads.
> > It'd require absurd amounts of physical memory.
> 
> And we're going to 5 level page-tables because 48 bits physical isn't
> enough. 57 bits of physical is plenty space to spawn that many tasks and
> still have some left over.
> 
> Now 32 bit tasks is indeed insane, but memory isn't the problem. The
> actual limit is the pid-space, which is 30 bits.

Indeed, pid space limit is even better!
