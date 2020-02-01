Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C4C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074BC20722
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4+Txhv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBAAEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:04:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53515 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgBAAEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:04:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so9894094wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 16:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tc3pF0prdx+PrgXPWVPN/NQPxTxNbfBegE4BXATD60o=;
        b=T4+Txhv3PAy5i83KRT7obVpRGXzdaNE79qftWN4ldmeSP6l5d/Q3OiNoAypJuN+Pbi
         i6nDLZzPJq0aeiC4DFJGKCSmCtJGzJwhzyN+m27fG6craIr0blr4olGWl886hjxTTSvG
         w+1iWeGxTdBbKv6Oj6XdRNUmV/pjuZ3+rqrUPjja9wF3R8ptoIqJG/1qBtZlZpmnXyDX
         8m1uJPedlB8pLKHFIfbyDs9kkDS25VUol5sTn/Zn9I73fbO5VODrgA+jPAG161AEAWKg
         N1XyPED2ktN/QwttQjo7BBZOu+RsA+HiS4wvuwqiFkc1rQ03n0nQjYXDPNbX4MVmZa9x
         fZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tc3pF0prdx+PrgXPWVPN/NQPxTxNbfBegE4BXATD60o=;
        b=XWmLN//5qOXkGMkIuGb/Myj0ZP72HrqwKuFY8tVBjji3LgeOTEMDE0URb2dFtNf70W
         VTnwc4o0W7sh38W8+MIlIHOaErx9w2vvqYnN8VAik6X+3NrAhvje3HqleQqxYQpB0p8i
         5gLoX6FjEjk1cBtmbz5Z3REyfzaqleKYJ1wi59U2RWLGMtQRB5bgZlIX9CaBuK8QTSgJ
         WygVxILSoG0qPCAi1S9p8m8L2S1hbp7uCwABZS3FD7VXyMns7zaPfHRp+URhEV4xC8BM
         MrRGAhrsJjZ92M+5bvelRsd7gGa0y/Zo7Nyu0zASKTF6kV0X71xchkmAYKLnyyFDpHL6
         vM+w==
X-Gm-Message-State: APjAAAUlUE7ywa2jJzj7kmW/4mKfDpDIANlD6mBIsjjpDBfqVk1I3iDe
        4yay+ZPcenrxKh57xoce3Q==
X-Google-Smtp-Source: APXvYqxtD5HNUVeuPTCTDyu+No5ig5vVtVraeFbo8r+vekjkuOhqAm0mCZclBuGjA75Y8nqjEr8fXQ==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr14439213wmi.101.1580515482855;
        Fri, 31 Jan 2020 16:04:42 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id n10sm13694048wrt.14.2020.01.31.16.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 16:04:42 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 0/3] Lock warning cleanups
Date:   Sat,  1 Feb 2020 00:04:13 +0000
Message-Id: <20200201000416.91900-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/3>
References: <0/3>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds missing annotations to functions that register
warnings of context imbalance when built with Sparse tool.
The adds fix these warnings and give insight on what the functions are
actually doing.

1. futex: a __must_hold(q->lock_ptr) is added as fixup_pi_state_owner() hold the
             lock at entry and exit.

2. futex: a __releases(&pi_state->pi_mutex.wait_lock) is added as
             wake_futex_pi() releases the lock at exit.

3. hrtimer: an __acquires() annotation is added as lock_hrtimer_base does actually call READ_ONCE().
            This add fixes the warning on other functions that call lock_hrtimer_base()

Jules Irenge (3):
  hrtimer: Add missing annotation to lock_hrtimer_base()
  futex: Add missing annotation for wake_futex_pi()
  futex: Add missing annotation for fixup_pi_state_owner()

 kernel/futex.c        | 2 ++
 kernel/time/hrtimer.c | 1 +
 2 files changed, 3 insertions(+)

-- 
2.24.1

