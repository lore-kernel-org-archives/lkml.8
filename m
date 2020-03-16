Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2213C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73115206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI8t9dM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgCPSm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:42:56 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41279 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbgCPSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:42:56 -0400
Received: by mail-oi1-f176.google.com with SMTP id b17so3983099oic.8;
        Mon, 16 Mar 2020 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD9qGn/FmD1rIVTC9XP6vGVct8WmBBkX3v6FBswGPLo=;
        b=XI8t9dM9SBCy99PStJprX8CeSlVdn5oyjmZj/wZnqd629GJnrQsss03VE1qmZCdg81
         7YqI3itfJc+jJNFISJ32ZULvVFYh2mATytvJHvs7fyi1N3XqcqXJnAd/S4NQMVb3m6t1
         5ZicQOPA1pZuw49o6Jm1M4hNjJRAxrDBC29HGj0nLkpevv5wkckwwjjR5DGFkfhLzCke
         8gnhFXMFufF6nW+IK9J9kDCm95YqgEmsDQxrwXqNjQDhClf5AHzAVrLG5jgs9Gc/W5s6
         bsYFZMyGGaYg7nY5iXwWyhvEunemfZUOe+INQrPcUrNUjp0++cAFhfsY/wJMJEiS55uK
         VZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD9qGn/FmD1rIVTC9XP6vGVct8WmBBkX3v6FBswGPLo=;
        b=PfUIrqf9GATtLIu4DdbX5CFc9ROPkeibtmjR4totHKfu0ZerCc+F8OkN2RFeJ1JFN8
         QJiMbkpsI8qQYXuP7qytYYRA0FNy3dbU/g/kJsV+t40baetmH7c3Uu7hevGd8vJ+OQZ3
         Qsiih1a/B0AOjfGk55Xe0RhqhFGFmi4UZkHA0QT3+Vsqe4rJfyQNp2gfpu8lCHo2Bnod
         v+KghVoQL8TROqqGYqRiRzjNFiE4cXG+ihQ9YKAU3h/Q6I1zxhmkIlxc4Ul3Z4eQP+1Z
         OJRl9hzpG/0B4LV+THFc2Ahj1zUrjdZpViaIYo6io/g0JGn/MfRNjYu+4jsN/RXx+R1e
         ofVw==
X-Gm-Message-State: ANhLgQ2WZ9Su15zwmYHsDZw0Ed0oYHFgpWV3bNw6AchNHYbvjIYrwh7W
        ppXXOkxlCzNP48LNLmONSEv4MZMyPdTvdy4CfhQ=
X-Google-Smtp-Source: ADFU+vuvb+iudfElL7iqgteVX5oixLgqXX+gx0BuzbeTEuVTUoqkSESaTZnyMdlAzQ8HVijmDnFZ1k+5NzkfsKbcx1E=
X-Received: by 2002:a54:440d:: with SMTP id k13mr425693oiw.72.1584384175324;
 Mon, 16 Mar 2020 11:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bf5ff105a01fef33@google.com>
In-Reply-To: <000000000000bf5ff105a01fef33@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 16 Mar 2020 11:42:44 -0700
Message-ID: <CAM_iQpWFsQm1qR4_jb0r6B9MuAjW2t5CZhAuaFDt4Ay+ugbT+w@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in tcf_queue_work
To:     syzbot <syzbot+9c2df9fd5e9445b74e01@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: net_sched: cls_route: remove the right filter from hashtable
