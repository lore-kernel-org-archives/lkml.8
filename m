Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AEAC4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75082074D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgCNDgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 23:36:03 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:52755 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgCNDgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:36:02 -0400
Received: by mail-il1-f198.google.com with SMTP id d2so8496798ilf.19
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 20:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dmWkzx0+VTdDKgiZu8md+VCLESddm4UQfDH67bvRGgw=;
        b=QgW1u3ONCDZnXcj4YtIDXLcKFBdMOMhnS2bZsApR1fXPvxZUHJhO2luHXRBle8X/kZ
         42UqjpWxGrP+pv2w5fx0WphozPKOpQ7nXLNdliwxXr6E/EoyE3BKTiO7xSZ9o19Cnvce
         5zBkXml892Nh4bTO/m+ZgY3zMvGSPwre+X7rKCLwWsPD04m4RdCfcJ83qoF3D9uM/kpQ
         pcWUb8Jg3Tgz0K2vN5URE56XXaJyv2KA4rufKlaYws+VqDX3JaQt/MEO4QaHJbxPz44k
         y/DKHAw75C253L9FP1jI+D6Ou48twVCOKBtu5nkIy/1XtpbGjRVzFICAjvKj4QXr/0C5
         cZxg==
X-Gm-Message-State: ANhLgQ2GKh7PcEGf8W3V3JqRte+vgTBYTOUuMOnCId3JGWY4NZ7xsN6i
        yzLLuATBygBG92oVttCP6lqu0kBNGDJuMmQBEaanheqbQhjB
X-Google-Smtp-Source: ADFU+vvBMXHPEVzZfO8YFe9kW6MIFkbIJ7hF8kO6rAHH2jV/E0B4uqVQ3pZEgaiV4qVxTOWqsAwD5nlb/2zaCBCJjKUTD8jHWswW
MIME-Version: 1.0
X-Received: by 2002:a02:7b13:: with SMTP id q19mr16145948jac.73.1584156961742;
 Fri, 13 Mar 2020 20:36:01 -0700 (PDT)
Date:   Fri, 13 Mar 2020 20:36:01 -0700
In-Reply-To: <CAM_iQpUBL=P6xvnyZckwVPUnmxReFDXJpfTA-ZtMqeAnh-4XVA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9286d05a0c848b3@google.com>
Subject: Re: WARNING: ODEBUG bug in route4_change
From:   syzbot <syzbot+f9b32aaacd60305d9687@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+f9b32aaacd60305d9687@syzkaller.appspotmail.com

Tested on:

commit:         29311b74 cls_route: remove the old filter from hashtable
git tree:       https://github.com/congwang/linux.git tcindex
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=f9b32aaacd60305d9687
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
