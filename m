Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54713C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E66E206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="C0VsSiJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgEDWpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:45:05 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43560 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEDWpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:45:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49GHlY26MWz9vCBX
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 22:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J92l3B3uyESh for <linux-kernel@vger.kernel.org>;
        Mon,  4 May 2020 17:36:41 -0500 (CDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49GHlY0vbmz9vC7n
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 17:36:41 -0500 (CDT)
Received: by mail-ot1-f69.google.com with SMTP id t24so198674otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=64urMlieBPhteKCakD46TmqveQT9kT5oO4nkAodHJ9Y=;
        b=C0VsSiJfDQGikGjlrABXcdLHwAIpGiBKuCYmcslbNcRcnJHD+4qMjhDaCjHVyEzaI9
         3Cxg/SnMMZUXX7fC069f7tQFyvC/+O2z128JM/bbYAGq0+L40ZcdtcMgorsv3/NEUVkA
         HqSTKkc4T2Xj4iDxf7m1CpJumBDKkn8b1c88czpBREMcs5KDvEIJxytJX+V6r11qEL11
         JQqPCPTLORUjkeQoXSRiHYGKTQ2vX9A0ck5DQ9WpCRehnzRfO9vnAT38H6oa6qqoOr4S
         4BBU+ZSoyV79+MLSxu+g7OMkvi9okgAtxn8jWuq0JgVTOV29oTn5X/q8v/LE15AgyCno
         7Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=64urMlieBPhteKCakD46TmqveQT9kT5oO4nkAodHJ9Y=;
        b=fGkvK5L1p9L1khXsqdtA4lccoEmLojW7qwNIWr6jL6HIjn5fiwrAaQkxAO7ZQkN2IL
         gi5Nb/5rQYbfFMCQzsd5hREUjfr0s1rlcNsjriLD7bYJgamnYRp0n4TUu91thrCA2EKb
         LWlDmC1C/RcpKW/504pnmhoZwQIhHGEor0m/wuLXO4FYQC4HQG3iNXPQ1AWxI+ms8FjD
         iah5sGgBDwm+ihWJovaV8HawTS1D8mq/jSz5ZWeLJUquI1KF/nu6WRmKzVXLPbv0kV96
         ZmsS1EN/IeV+RBsWRpDB7rXzi7NwcyvxNnT/HhEvIsGqnoZiUt0Vw8VAUeJJ0Fcju/bG
         HFhA==
X-Gm-Message-State: AGi0PuZGbfjVnQRJepZvSudMw+1E+s0txSo/hyU1cCePDH3u0nZqcmwX
        gx+8F2PkVLtvmqWcH31dXg1SG6y6QM8tlY+bgWeheztf48Z3oELufx4whzwJtNsIfuY0fIeOnHj
        HYtGOOhI1L2n+DM2BcRDb0dD8J32eYrE2PzUe0Pwdk1gw
X-Received: by 2002:a54:4115:: with SMTP id l21mr462892oic.15.1588631800516;
        Mon, 04 May 2020 15:36:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypLhs2soxclb524UwzekmnX0fUXn6jRkl1yJQEuxf2en1z1zVxNicRVUvSslUbXitlUpnydFzs6wwWDi6ZC8Wy4=
X-Received: by 2002:a54:4115:: with SMTP id l21mr462862oic.15.1588631800122;
 Mon, 04 May 2020 15:36:40 -0700 (PDT)
MIME-Version: 1.0
From:   Navid Emamdoost <emamd001@umn.edu>
Date:   Mon, 4 May 2020 17:36:29 -0500
Message-ID: <CAJ7L_GoCA0e0npN5amfAjK4KJKxg0fTXo94VqzMMB65y4LRMMA@mail.gmail.com>
Subject: Potential Race Condition in tls_hw_hash() and alike
To:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen McCamant <mccamant@cs.umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering if a race condition in net/tls/tls_main.c may lead to
a UAF or not?

The scenario can be like this:
1) device is initialized and registered via chtls_register_dev()
2) while tls_hw_hash() is executed in one thread, the device gets
detached (CPU2), and another thread tries to acquire the pointer
(CPU3):

        CPU1:  tls_hw_hash()
        CPU2: chtls_uld_state_change()
                  CPU3: can be tls_hw_hash() or tls_hw_unhash()
        //<assume kref == 1>
        spin_lock_bh(&device_spinlock);
        list_for_each_entry(dev, &device_list, dev_list) {
                if (dev->hash) {
                        kref_get(&dev->kref);  //kref == 2
                        spin_unlock_bh(&device_spinlock);
 kref_put(&cdev->tlsdev.kref, cdev->tlsdev.release); //kref == 1
                        err |= dev->hash(dev, sk);


spin_lock_bh(&device_spinlock);
                        kref_put(&dev->kref, dev->release);   //kref
== 0, release
                         kref_get(&dev->kref);  //BUG: kref 0 to 1!




Basically, the problem comes from the fact that kref_put is not lock protected.
Do you agree that such a race condition may happen? If yes, then is
moving kref_put inside the lock a practical solution?

Thank you,
--
Navid.
