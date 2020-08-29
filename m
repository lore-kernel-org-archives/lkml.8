Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD96BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DCB20776
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 23:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl5h0HME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgH2Xi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 19:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgH2Xi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 19:38:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89EFC061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 16:38:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so2496680wrm.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gj4kMjF+BVVySY1Z3/gJN1XChIJ6+ZasIovs9NkaJ2M=;
        b=Pl5h0HMEkNGxMzTjRHQvNgFMRKsyudujSsrjt3hfa9KYFg/L9eD7vQAxmkIyKi03yO
         1gORL/bE1pBZ54gPlnJjdrKe/rm6EEE11JHyEPdbtZZuM/NxuC+ozyvhl113KhdL/iO+
         FPrQM9LWVnKSVnqND6hXPWc+cd8EYEyLHlVQROSlbT4kz51p3sr2brG4YL2+8d1nMrHQ
         6oq0UOwHYtYuSsEHLBp4xpflM/kbtJFbCyzBKVo9hRSlv8IUtgSZH3Q1z7COpMyYFXVC
         N1TBUe/5bh3tfYi/Vb2BWFcR8/Bhawm2RoP/kB2YFRXVRp26dtMzQC35AiRxhqpS7sWW
         oYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gj4kMjF+BVVySY1Z3/gJN1XChIJ6+ZasIovs9NkaJ2M=;
        b=Q3QRWBCYSPA/LhPPk2tpCQLqornFedfbYuv1N9ykxlXQ9l7/LCNo5+Vz8KJeiPK6ou
         k0ETTIFaHoCizIvvOmwDHVfucnI5LEmnHNbj0vXegzP66HoCsHaH8dbmyM9x3xgZKvqC
         pCZZV1OdzzXv5MfUe6hSHmPasJa4EXhzeq3FoGRL4C1OfpHjoGK+xuuW1NynGLuu6arB
         WU+pxz+YXAGbOSgtzdhUkS0bPSAPB6FpZkSioPJMQwf4RqrBhRiLsnAnpF2XZ9AuGVi+
         jAzk9G7dZFJedep9NMiHzEgL1oUq2Igd8PURoRlzF+JdMq+QK4xYksMKp+dh7VfBENub
         LMOw==
X-Gm-Message-State: AOAM531jnVijkls1Hnp6fntBT5n/QIstHn92tO3OCwy5WgDSAcA1OHAa
        QDYgpwdLg8WsRuB0dfBh8k8=
X-Google-Smtp-Source: ABdhPJyCq1u+d4qw5UiGBY1jDknu8N02C7KAKFCmmx0rNSepaogAifa4HwBexz0ZtNx49jdIYtSuKw==
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr5278383wrf.206.1598744304319;
        Sat, 29 Aug 2020 16:38:24 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id t13sm5253878wru.65.2020.08.29.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 16:38:23 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] simple sysfs wrappers for single values
Date:   Sun, 30 Aug 2020 00:37:15 +0100
Message-Id: <20200829233720.42640-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've noticed there seems to have been a fair amount of discussion around
the subject of possible helper methods for use in the context of sysfs
show methods (which I haven't had a chance to go through in detail yet
-- sorry!), so I thought I'd send out a couple of patches I've been
working on for this, in case it's of any interest to anyone.

My idea was to have a few simple wrappers for returning single values
via sysfs, as in theory that's how sysfs should be being used. This
isn't going to be usable for more complicated cases, but at least by
doing this we should be able to make it easier to direct the attention
of code checkers (either automated or the flesh-and-blood kind) towards
the potentially more problematic cases. Hopefully we should be able to
convert over many of the more trivial cases to these helpers using
Coccinelle.

For the number helper (sysfs_sprinti), I opted to go for a macro which
can handle short, int, ULL etc., though equally we could go for
differently named inline functions instead. Either way, I think
enforcing the type of input arguments and not allowing users to pass
format strings is the way to go. Even for e.g. "sprintf(buf, "%llu\n",
my_number)", there is the possibility that my_number could be of type
int and so mishandle negative values. Let's make it easy for maintainers
to review at a glance, without having to remember what type my_number
was declared as.

With the string helpers we can make sure that we aren't overflowing the
destination buffer, but I've also put in a check so that we don't read
beyond the end of the source buffer either, in the case that it's a
fixed-size array. So if we do have an automated changeover with
Coccinelle then we should make things safer too :-)

Anyway, I'm off to bed now but I'll check for messages in the morning.
Any feedback gratefully received!

Best,
Alex



