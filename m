Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F4DC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1932073E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYYUwR6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgECHXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 03:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbgECHXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 03:23:50 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADAFC061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 00:23:50 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id w4so9047192ioc.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=b4mG499CkMqZjFhS8bYtPVw3fyP4aI1ovdFZN6rNyPk=;
        b=JYYUwR6YCiGSJ79XpBwNe1deCLuCPWkhcZDttDeo7xCElu3sEF0crkon3i/YoXxd4h
         P5eve46cmE+G3vAiqhsQ/5rMixqJfdgjkXCaV10scwb/XW2EQI/Zq1IpGtf9QLGUdUif
         bZaT/9E81YDrVMBRnUlF7rZX0QCYQxEwIkGmZS9NeuNaH8PAh9A0VLmBn0cmoLyGlvsX
         NjSh3rFAZ9yL3EQ5jZHsIYzDLtXJaWPdeGdL7fAAKdnfBKJtmVYu90+VdoLo8kkV9CY0
         nXLHmaBOWFskfTRMwrmdYkB9Oy1ZUyZd6s66Op/+mFEgpWDixNA7OhWFuoSrGdFNGVbm
         3awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=b4mG499CkMqZjFhS8bYtPVw3fyP4aI1ovdFZN6rNyPk=;
        b=brQ03peR/6TMZHwfMNC6S7COxZcZfP1KGkmTuPG3PK2WsUlvpjsdvAMDqSIQmWCT9y
         T9KuzH1RPgV/+zY+agmbICiqRXPEBdbeoaKIQ5ZRQm7NZGbSOOIFoVPK0mFGfK1t7DCS
         1aTeujExN7lG+Pe245x9wIHedoPBhjvbNU9ib8DG6zdoX+BV4vU09OpVIyK9EUphMeRX
         YoCyo/QP5LyA91LnlBN847Fi2IwadUH5yrrriE/I2BBkkN+9ywf6FSkdbYp9bcdx3AWQ
         G8rFe10IIM1auROa+c2MPbzAjXHamQkc7dnV5xPHTGqJlIaaLQnGb/neCTdR8p6S3UjI
         SKUw==
X-Gm-Message-State: AGi0PuaFlsgfXooPsj1OuCc9Gz9y1MHRHa9IWKC56NnqxHrRXgmdoeQo
        MMXt6IjD1Mr8/IwtsxbuajE1iNbsapHo4l5TofH13ra0wds=
X-Google-Smtp-Source: APiQypJ9J1yBHTNvuOAa1/O+BR2seoGwG3iwhM1PD7YyHzC25jlgFvl70IWCqzhl2l3fkZh4HKcpCPwtpULsrvc+QB0=
X-Received: by 2002:a5d:9c09:: with SMTP id 9mr10954250ioe.26.1588490629077;
 Sun, 03 May 2020 00:23:49 -0700 (PDT)
MIME-Version: 1.0
From:   Dongyang Zhan <zdyzztq@gmail.com>
Date:   Sun, 3 May 2020 15:23:37 +0800
Message-ID: <CAFSR4csKYu95qak02h_sAH6Rpa13PUtHUZ+7Z7Vd7tmBQCNaqg@mail.gmail.com>
Subject: Possible memory leak in unxz()
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a security researcher, my name is Dongyang Zhan. I found a potential bug.

I hope you can help me to confirm it.

Thank you.

Possible memory leak in Linux 4.10.17. The function unxz() in
/lib/decompress_unxz.c forgets to free the pointer 'in', when  the
statement if (fill == NULL && flush == NULL) is true.

Source code and comments:

if (in == NULL) {
must_free_in = true;
in = malloc(XZ_IOBUF_SIZE);
if (in == NULL)
goto error_alloc_in;
}

b.in = in;
b.in_pos = 0;
b.in_size = in_size;
b.out_pos = 0;

if (fill == NULL && flush == NULL) {
ret = xz_dec_run(s, &b); // When this statement is true, it will jumps
to the switch statement. But the allocated 'in' is not freed before
return.
} else {
.....
}
.....
switch (ret) {
case XZ_STREAM_END:
return 0;

case XZ_MEM_ERROR:
/* This can occur only in multi-call mode. */
error("XZ decompressor ran out of memory");
break;

case XZ_FORMAT_ERROR:
error("Input is not in the XZ format (wrong magic bytes)");
break;

case XZ_OPTIONS_ERROR:
error("Input was encoded with settings that are not "
"supported by this XZ decoder");
break;

case XZ_DATA_ERROR:
case XZ_BUF_ERROR:
error("XZ-compressed data is corrupt");
break;

default:
error("Bug in the XZ decompressor");
break;
}

return -1;
....
