Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17360C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 03:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A112078D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 03:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLO7mD0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHWDEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 23:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgHWDEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 23:04:46 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCCCC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 20:04:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id a65so4623610otc.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 20:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xdOhuRPyHmGb42SW1WfbT0nPnZuZK1f+Z0JejkjbzUI=;
        b=BLO7mD0IjKwI0lAGO9cahPnrTvxw+NInISYyJYWBeuKJCN2aTalyborUXS/RNcBrOz
         OL2+a4C/g7VQksddaH1MnIbLJp2ZSdEtL6ne2XrROAWQXN1gOsNRxqycNbU/htWyVJHp
         GXWXOOJ+HKNtlfqo9MlsmOgOWjv1UTVl4u2lRvJhn/TUdj44kDSX7BE0ht57fdXWxlqj
         jrSSMUdlo1vxUyjBdmCK5vU2KdvAuqFPHStFNjqzlfAmwqRmLmKLwztJNI5m/PYX7XhA
         +/FjzcSEg6/w+0JyjDiUJBIDoEXkygRXPk8qsb7Yia1ZEiOpfnRjXjCsk/cjo5TLKFJ4
         REQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xdOhuRPyHmGb42SW1WfbT0nPnZuZK1f+Z0JejkjbzUI=;
        b=uRT6dgLdPz/dCfZEhx3AjZt5Kk6uoda5GgouZfhaHJ1sGVqGjlUYaR0r4npbQeYKA3
         qHm6HvPmOcnjWapKqGemT34Qa/HCxRG+PHy95uOKoxT3/yYJZj1+NtP6sOESs9GMY9RH
         bvAx56sWR/BKY7CrNmdBe7kfpSpNcbGV1LDxjgPQOH5iWQj353j4BA7YQx1/3T4VZGt2
         l0MtDWRrv+RP5+7/D48y96lUNHlOhzF0X1u8KJ916P8cqBWuTQ970Xbpfw39qm3osJo3
         ljBn0ooeHgitDb6kDjpKQSVfEt0ljWmwpQbz4bcmD8J4h2Hi57uJVYkPxcbDTluZYiLV
         1lKg==
X-Gm-Message-State: AOAM532SkCGbnjf+MdyUQ2xsov4wa4vtuaev7y4c0dgoirkBthIABkOU
        3tmtmh+OYzX3VFJl+2gBgDqzYRB68ZTudCxfMP5eHwnH304=
X-Google-Smtp-Source: ABdhPJzU+MdQzTJQkFDkHjHCqTT0JVG2mtQ5qsp4ooFB2bCnVHWO65jzWdfIRI+MjQVXiH4KS+OS/v7jDUZZBYst494=
X-Received: by 2002:a9d:6e19:: with SMTP id e25mr139461otr.198.1598151885516;
 Sat, 22 Aug 2020 20:04:45 -0700 (PDT)
MIME-Version: 1.0
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Sun, 23 Aug 2020 11:04:34 +0800
Message-ID: <CAJNi4rPKTarta5rfhNWSsLqa+Z6qo=FGFygfmT7kuZi11sr3VQ@mail.gmail.com>
Subject: Why KASAN doesn't detect this stack oob fault?
To:     linux-kernel@vger.kernel.org
Cc:     andreyknvl@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I ins a kmod with below code in a KASAN enabled kernel (
5.7.0,
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y):

static int kmod_init(void)
{
    int i;
    int arr[4];

    for (i = 0; i < 20; i++) {
        arr[i] = i;
        printk("arr[%d] = %d\n", i, arr[i]);
    }
    return 0;
}

The output is after insmod:

[ 1511.800683] arr[0] = 0
[ 1511.800685] arr[1] = 1
[ 1511.800686] arr[2] = 2
[ 1511.800687] arr[3] = 3
[ 1511.800688] arr[4] = 4
[ 1511.800690] arr[5] = 5
[ 1511.800691] arr[6] = 6
[ 1511.800692] arr[7] = 7
[ 1511.800693] arr[8] = 8
[ 1511.800694] arr[9] = 9
[ 1511.800695] arr[10] = 10
[ 1511.800696] arr[11] = 11
[ 1511.800697] arr[12] = 12
[ 1511.800699] arr[13] = 13
[ 1511.800700] arr[14] = 14
[ 1511.800701] arr[15] = 15
[ 1511.800702] arr[16] = 16
[ 1511.800704] arr[17] = 17
[ 1511.800705] arr[18] = 18
[ 1511.800706] arr[19] = 19

The kernel is not tainted and the gcc version is 7.5 used to build the kernel.
The question is:
1. Why the stack out-of-bound can work?
2. Why the KASAN doesn't detect this?
