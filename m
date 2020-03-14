Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_24_48,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDE9C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 05:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B70320722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 05:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgCOFPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 01:15:17 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70]:52406 "EHLO
        mail-pj1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgCOFPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 01:15:16 -0400
Received: by mail-pj1-f70.google.com with SMTP id hg14so4542712pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 22:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/CZuM0+mbO6NyqR+mLDX0oKlbyLZj3NtZHFhJDcGVng=;
        b=HGgcsCquxH8cxMR4OGyivFDVMm+XTBlYjrq/iGY6nt5DRop4mPDZyt7NZRIy+3VZdw
         l4o4cdwAo2w7fdtIMhURwhSXRC3nisBlwi4Bz/Mo+KR5/xpFaw08tO6j9nZioSW29KhT
         4Pmi+yeFWu5fOo+HS52rbHKrAKzqaEuI3SzriaEy5z6KDQP2d6ipflTj1EQlXl3w2gyi
         zfp4m++/6jWUyQg5+lO196NVbjJ9hel7p+5vlBM2urEHs5bmwVwawZfO2FhJihmZV3qZ
         u1x/RujylRCHylf+hJ3qy4RkbROvJOndhpQHl4Q3/ebR/DqW+PmjAWL5V/HAfLZ8s8dm
         YlnQ==
X-Gm-Message-State: ANhLgQ2ksD1Zj194mz2ZZ1XZ1/C6MGUNQyIl5oNhp5OuKq0XKkETQcp4
        O3b9JLapxAJtz3zZufE3DPNOTjvsLfFpJ7z53goZmejsYbCW
X-Google-Smtp-Source: ADFU+vsd7B6zM7k661+N9RLASlT7wDY115i+NOnn4ChlOdfINGGNLgluD9/L+k0eJ+9HakWUkF332HYt3wzwxnDAhQKyCHW7keRq
MIME-Version: 1.0
X-Received: by 2002:a92:79cf:: with SMTP id u198mr2189717ilc.23.1584158642104;
 Fri, 13 Mar 2020 21:04:02 -0700 (PDT)
Date:   Fri, 13 Mar 2020 21:04:02 -0700
In-Reply-To: <CADG63jCSHu7dQ118GEuhXBi0H4CW3cBqB5F2qKiyeVzNb0U+wg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021721505a0c8ad76@google.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
From:   syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
To:     anenbupt@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to checkout kernel repo https://github.com/hqj/hqjagain_test.git/scup_wfree: failed to run ["git" "fetch" "https://github.com/hqj/hqjagain_test.git" "scup_wfree"]: exit status 128
fatal: couldn't find remote ref scup_wfree



Tested on:

commit:         [unknown 
git tree:       https://github.com/hqj/hqjagain_test.git scup_wfree
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

