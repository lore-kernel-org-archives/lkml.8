Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC4C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 07:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EB32072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 07:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCVHSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 03:18:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53888 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCVHSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 03:18:05 -0400
Received: by mail-io1-f71.google.com with SMTP id q24so8576873iot.20
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 00:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8H+ZxvVVLEf1sn4M+jADRlnacqoZ3lSMMd7kp5U9RKI=;
        b=lSCNtHYz/nJKgJcHv/jnIe6GlMq7cqXqe4cutMZnmjt5Uc3elskCyFSgEl3+8BM7+0
         7RNYD6K8CpPwd7g9Hx/lpA6F3Ca+dT6+22HmNYQHi04hLKIFEg2tkYoNThDyuWe8IALb
         SPYhla/qwhnoRXXMJZdLactdPqpwZTu92/w4RCcDsp5aBSQ9YOZYHjBPSzh5uo4d5dqw
         zWlm/mdzGYYjWi9WdNJfJ3/YUFXsyrxSHy5fOkfgNJV+Rhl79GNuSHV7RWKs0qCm8/a9
         X+hwTYz6nKWvREEY82Vl9odlayFP/JQwJjaAa2qUd6xx5DZVx4IK8qv7WCh0b0vdfs17
         jhwA==
X-Gm-Message-State: ANhLgQ0ycVnsG9koQwLGune63oLII0fZAPS3I39RUr6zWB1R+zysj+sl
        vIwIJnhrcPnalUgIJNk4SvH/WszKGOhruGPCkAzV3UkoF49M
X-Google-Smtp-Source: ADFU+vvIFTtvKwJU396waC62o4+9tlw5aZYfAr7eL4DgL4YwSOJjDROpLIdkgAFOw9HEhlZhSWC/8N4NpyRvDPpo0+fwEiVh790Z
MIME-Version: 1.0
X-Received: by 2002:a92:8dc3:: with SMTP id w64mr14333976ill.68.1584861484221;
 Sun, 22 Mar 2020 00:18:04 -0700 (PDT)
Date:   Sun, 22 Mar 2020 00:18:04 -0700
In-Reply-To: <CADG63jCpZWBjtJH_rjzBjTyTfYV0z9SHf1CzT9ic0-VY5C4AiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c909b405a16c5105@google.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com

Tested on:

commit:         573a2520 datamsg_list
git tree:       https://github.com/hqj/hqjagain_test.git datamsg_list
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dfa02302d6db985
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
