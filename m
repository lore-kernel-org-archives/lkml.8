Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502F1C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8B320705
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCFWfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:35:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:35709 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFWfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:35:04 -0500
Received: by mail-io1-f71.google.com with SMTP id w16so2481423iot.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KjWtQPcKIxIvEZPVuieJJ01SWtPnm/mBaTh4nN8Yq4A=;
        b=tLt9tlMP/lfD2YT/IJGrPjMXcGGo0WObH8hSvi7pLss1fRy6vq0BFdNQKqLdDi+H/O
         UEHSDVvVSW6w8Qde3uCES6BpqjSIdijyaJ+pbmXYw92/Y4xYV1QTgopD73vTrgUXMgxH
         H+e0d0KJadKRfBHLZeD4S5LkDNLsjf56nQfQLPujRoChqMpaW9GvYDe8ZVM3VdGueFGi
         aI2lrmCU5stVs0OYypczTmOV7hZEurUvlMdFhBQmoPbtDhaI7ULbS/jvSmkfFWoJXLm3
         FM9GQ5X7c6utFb3QjPgBECAufAMKas8zEl4PNWyLxJKZFci2IXj/4GfOvUVhqp+qyLS0
         jX9w==
X-Gm-Message-State: ANhLgQ2Ne8tjIJEL6U5V/EzkfJC5/zAgTx0UuEPxq/TKrtJWZMQNah5z
        kgUXRmb8OzUsqCpNMjRTitSdXAQYPnvMf1WJTTU21iRkvr76
X-Google-Smtp-Source: ADFU+vs7TshTiXpJBBMMnK/klWxSkYQHop7Wk8LLzdT9LXsKtgaTBMKEykjWuXsgmj46xLIUaiFxMyYWPjhUHv97DMUt54UvAjhF
MIME-Version: 1.0
X-Received: by 2002:a6b:5a06:: with SMTP id o6mr4907893iob.54.1583534102612;
 Fri, 06 Mar 2020 14:35:02 -0800 (PST)
Date:   Fri, 06 Mar 2020 14:35:02 -0800
In-Reply-To: <CAOQ4uxirc1WwQOzE4Qq=k2R0ntGNTGYsot1b63DPkwCbUYjyZA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad0f2c05a0374382@google.com>
Subject: Re: WARNING: bad unlock balance in ovl_llseek
From:   syzbot <syzbot+66a9752fa927f745385e@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+66a9752fa927f745385e@syzkaller.appspotmail.com

Tested on:

commit:         13944050 ovl: fix lock in ovl_llseek()
git tree:       https://github.com/amir73il/linux.git ovl-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=31018567b8f0fc70
dashboard link: https://syzkaller.appspot.com/bug?extid=66a9752fa927f745385e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
