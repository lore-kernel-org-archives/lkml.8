Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E3EC35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1152083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 02:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQi49PDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgA0C3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 21:29:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38560 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0C3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 21:29:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so400862wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 18:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:hrtimer:futex
         :content-transfer-encoding;
        bh=SqoyRqDjiVkb2YBf+PqYPuWH4dMHp96KDVNP9O1ktP0=;
        b=qQi49PDyKXYluiDlJWkzyaLWj/2Mw4vq5M9xpRA/sOm+U4Ab0ugUJ108dLW1l81N0I
         nK539lXrJPskl6O/TAJyfujc+yXJTPS2XV1JNa1n4GjHoJQ2buVfcRvNPdM5xV84XHgB
         ra6s/F4Z5+E58ZdD9UvyCRDLbMo0RDhDpS5uV/N36A4K1mb6sbYypdj32Vuo78Gh9+XP
         1Sh95UVuES1QA31CKc1nfqzR7uH0/s2AP2664Bjjnifck+X3RSiDoyABQbJXI78tQGU4
         Z6oONq/YTUu0jPLeUmnvN7O6hz2J6ZSUVld4YjBNO3C7ICDSSKmHDeUcLkNcyCggYN+I
         3M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :hrtimer:futex:content-transfer-encoding;
        bh=SqoyRqDjiVkb2YBf+PqYPuWH4dMHp96KDVNP9O1ktP0=;
        b=l6mruFXwB2+mS2T/uEsv8LRPGe7jA2ITm5+1meYc4re3J6qRSx4OtEnrThKdotKhQ0
         HcsZNmxwir646kNSx3QR3tCCV/Tjh4+IPF2uS0kSpD+Q93kU2GCcpSZ4ynJgN9A/5Gf9
         PL46HlQq6KWy1tpJYDD+gfIlNpveymk4Kg8hJoygbdWnAmQ4/qWGFhVeUCTYr7NF8bak
         SEh3lorFYm6Yh0JOEP9caoE4gHBxIxE3rNqaycPgKqGbAxTvaSaZCGLe5gVqvKy1YdSd
         BW9Z2/T3SgKQSu46DnEVWl8jCAY1ivjcbtcfx+0re1GfixXKMb+otrJ/eWXst8cJV1kf
         3njA==
X-Gm-Message-State: APjAAAVZFnAsd4lxhjNwSjLfqYWZtmPltC2f/7RSlr579j/M4SDbubSn
        xqTmGNDT0lz+QHhUEkR0rQ==
X-Google-Smtp-Source: APXvYqxj4LSvzcDrVBJ3IhE49djU/4fmdZk8eyaBK8hOdu4PULDWO9RqDU1H08zLugOAxyIkZJXC4g==
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr10678246wme.23.1580092173244;
        Sun, 26 Jan 2020 18:29:33 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id c9sm16825743wmc.47.2020.01.26.18.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:29:32 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v2 0/2] Lock warning clean up
Date:   Mon, 27 Jan 2020 02:29:16 +0000
Message-Id: <20200127022916.87063-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
hrtimer: Add missing annotation for lock_hrtimer_base()
futex:  Add missing annotation for wake_futex_pi()
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jules Irenge (2):
  hrtimer subsystem: in patch 1, an __acquires() annotation is added to lock_hrtimer_base()
		     as the function acquires but does not release the outer lock at the exit 
  futex subsystem: in patch 2, a __releases() annotation is added to wake_futex_pi()
		     as the function releases lock at exit.

 kernel/futex.c        | 3 ++-
 kernel/time/hrtimer.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
Changes since v2
- improves on commit log 
- improves on patch title to designate subsystem where change is made
- drop leading '|' 
- ensure patch does not produce any extra warning.

2.24.1

