Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6341C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF5C206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgFBMlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:41:46 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:50335 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgFBMlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:41:45 -0400
Received: by mail-il1-f199.google.com with SMTP id u4so11601302ilq.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=tAlIbuV2NmJbjQsrEd8aARaADyAiwp04Ya0IbnrBnn0=;
        b=agzrugfBOR9Kgi4QhKvIVPEycHE+U+QIWEC9EeWgUDjafZta683hkUMfmD25SE7P/H
         GbsXCX/4QVi0Sdwo+GBH7UDWxyLEQY1ifCuFIokdJNZNAPUF7FvIQpo0g5mVYEbCkxy9
         tVftpyRP2hfzFKqMwm5fgdaxz7m6Pzva3dQYvjaegUPZWc1AugKk47k7v2epA6FEpgo6
         uPRFIHwimYPXtDq17Db0gqY//R2T2bqssbfVniU8GCFN11Z7AYC+sCr/ceQF3CNOysJx
         Jc564Z+U7sbmIilH3E0JeLiAqP9tN37Bo/x/QT+soV1goM6t645+gvVd6dglYoUsplVL
         rTXg==
X-Gm-Message-State: AOAM532Oe4f/sm3Ed4TTk+5ow6A9GSOGlsCAfPQOWwOm7JAqcqKhDxu0
        9HMGXc5H7vr8dt7TBKQ04rpOETuh4KXWfKpQbVjo8gFeGAMA
X-Google-Smtp-Source: ABdhPJy0duXvd9nJwf4jJ+gZCXXpt1+wEmsQ8/kmPREsBEIwiOWpnsvild1FxcJtKuX5Yj6pRJyHODOemxR+emeQ45aoT2uGgm3p
MIME-Version: 1.0
X-Received: by 2002:a02:ce56:: with SMTP id y22mr25228557jar.18.1591101704812;
 Tue, 02 Jun 2020 05:41:44 -0700 (PDT)
Date:   Tue, 02 Jun 2020 05:41:44 -0700
In-Reply-To: <20200602124130.256274203F@d06av24.portsmouth.uk.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eabc7505a7193b6a@google.com>
Subject: Re: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: syz-fuzzer/6792
From:   syzbot <syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        riteshh@linux.ibm.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: 

This crash does not have a reproducer. I cannot test it.

> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
> 0e21d4620dd047da7952f44a2e1ac777ded2d57e
