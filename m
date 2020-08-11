Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0095C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC432076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRQHYwT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHKUre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKUrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:47:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D35CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:47:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e12so250363ybc.18
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r8gYlqSbI+Ik5DLK6J7LWCZwkVU3Amrw/VZwnuIEubI=;
        b=FRQHYwT5k//luW6AQ08bA5OhB8nJu9cp+5uM/VpysnJEzt9eJgNXOPhoSu7Z4Z39n0
         RuhjUaBJ+5/iRO8Ld91/VAW5lemNLj/pzhlHYk+O9GHYTSBAtf+LXI3X8iZXMBazKgeK
         KdCo4/g3Ju8I+gEZsOdQOf4xUfshOONrSgEsirxSSfHYD+Pv4AUqnjpZl5oM7fasHD+h
         R09gufo3gu0YE/bM6Q9wlpVEquuuUltu0VI6FDA2Kt7dcjhl00zExMKQY+v3yeih0rut
         wTFeZn+ZfMSKdBikKFJ+ZdiL9GwnYHqJGIizvN20pVuor2FI50rXhTXqPQJUWIYk4TRQ
         1pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r8gYlqSbI+Ik5DLK6J7LWCZwkVU3Amrw/VZwnuIEubI=;
        b=bf8dPnDiZ4T3SRAQDOIO6A3BGjfz9EPop2umqeOJNYEuLBeAguraMCYZOWL+HPl3Ht
         OO+8bR4v4Q4rfdt98sgA3hFxIDtZts1F/ZUk31q7F3Q+SltX1L2xHgF9jjdMsg/CW84V
         mkOnCU1IopMr6vXADrKo5Nj43cGEjol/jvuPhuCIAQIAde5NDoFgqg7342q5Zu1nxWlY
         maJcTB+Wj9paTFIi1IXOo5uh8zHX3kf++lSqUhqh7Wfpvj4nuT3oJatot3qtJkefTcK3
         KKpGYYgx8rp8Maa2lNdzEMAC5N3ZkRH/KF8KmQZiOZPOC4+7aVM9yZ8Y6DPr7dX0t0ng
         eMqQ==
X-Gm-Message-State: AOAM530cD42SJRrXcZX4DtS11ugS1OSatvDvdrKbexu1uheDoDIzmA+H
        4mfnwIas7cTowQnHo/cg6rFZc+4X/jDGbY3lPiU=
X-Google-Smtp-Source: ABdhPJzEcn9+Qc5vcmkRmRfLSjc8AZtny1q5E8p7GGrkm83WUh8X5sFdf9DdBGBh+pz8PGTcDitYUFecQNPAFWWCjVc=
X-Received: by 2002:a25:880e:: with SMTP id c14mr52104683ybl.181.1597178850843;
 Tue, 11 Aug 2020 13:47:30 -0700 (PDT)
Date:   Tue, 11 Aug 2020 13:47:29 -0700
In-Reply-To: <20200709132344.760-5-john.ogness@linutronix.de>
Message-Id: <20200811204729.1116341-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200709132344.760-5-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     john.ogness@linutronix.de
Cc:     gregkh@linuxfoundation.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, parri.andrea@gmail.com,
        paulmck@kernel.org, peterz@infradead.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky.work@gmail.com,
        sergey.senozhatsky@gmail.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From what I can tell, I think this patch ("printk: use the lockless
ringbuffer") breaks lx-dmesg in CONFIG_GDB_SCRIPTS.

(gdb) lx-dmesg
Python Exception <class 'gdb.error'> No symbol "log_first_idx" in specified context.: 
Error occurred in Python: No symbol "log_first_idx" in specified context.

This command is used to dump the printk log buffer.

It looks like the only places left in the kernel that reference are:

- Documentation/admin-guide/kdump/gdbmacros.txt
- Documentation/admin-guide/kdump/vmcoreinfo.rst
- scripts/gdb/linux/dmesg.py

I believe this commit removed log_first_idx, so all of the above probably need
to be fixed up, too.

~ Nick
