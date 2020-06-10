Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61815C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EF1204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Bp8oohoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgFJLoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgFJLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:44:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9C2C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:44:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x22so1267027lfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/hssy8NpzkrNMQtn9No29urAVcj42qDUd/ExF06dLJg=;
        b=Bp8oohoDLQRa+IMKJyCQ2n8tlr7AMR+oLBy/LF4uKEL83kMjz1Z5Zmq+J5IMupzPwA
         TjfpJ8y5eOsLblwD1ZBZvGGNwv8hRdaFwy0U4HUJPcq94G0a8xqyIOWUsrl2XmLW8lZv
         u4US3oqnCgIV9p/tOtPjey/NCWwj4ekQHw1cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/hssy8NpzkrNMQtn9No29urAVcj42qDUd/ExF06dLJg=;
        b=M9sI5WLsOk/PqupH5Mvs1ZMd0bw+C76vPe9EjJlZ+gzmZlwfEtb7bSgD0NaVWokIt0
         StzsD0xNENDnt+9/U7Mc3/tR6dBUxajUiYHu7t1nuKw5A1nqdmmRt+UAbkalt/aQviNh
         Z6E6J4IAQPH2tSwcEVDJ0dcibz3LU0O5v7EToi/mti1daXq2jLUTnkTawusjaWTPHmt4
         20nVU9cNQwx4DK/0mW9HPBKeXboDwMP9FVdAcqujUXQhNMiw30WYj+yL8XHaehOqLsdT
         fUs9SdIOdf8Y2Z6mZ2Cio7lyVs+Jx+33r7vyP3wHKzpQwRZKFBfcEBhmXUDAtebYT1LT
         dlJA==
X-Gm-Message-State: AOAM530P3Ig92jM6RQrPOQhUgPZkQgho6z8E0sI+Ki6oQhyAy9uYFsR2
        kkkrSpFUrb4SYZbOgPr4lN0uuQ==
X-Google-Smtp-Source: ABdhPJwOz1IDJ+PcISb9vsO1ok55eWQq+zdvReTSOwJ30O/nzF+U3F/uKG9O7EQDK2GUzcpS4EpFFQ==
X-Received: by 2002:a19:8ac3:: with SMTP id m186mr1512013lfd.131.1591789439890;
        Wed, 10 Jun 2020 04:43:59 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-127-38.cgn.fibianet.dk. [5.186.127.38])
        by smtp.gmail.com with ESMTPSA id a9sm4713355ljk.116.2020.06.10.04.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 04:43:58 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: must populate_rootfs be synchronous?
Message-ID: <19574912-44b4-c1dc-44c3-67309968d465@rasmusvillemoes.dk>
Date:   Wed, 10 Jun 2020 13:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have worked on several boards where there is a rather "aggressive"
external (gpio) watchdog, with timeouts between 250 and 800 ms. Combined
with a rather slow CPU and memory, these boards often fail to make it
through populate_rootfs, since unpacking the initramfs is rather
time-consuming, and we haven't gotten to get the watchdog driver handle
the watchdog. [No, GPIO_WATCHDOG_ARCH_INITCALL doesn't help, at least
not for all cases, probably because the device isn't "discovered" until
mpc83xx_declare_of_platform_devices runs, which is at device_initcall time].

So, those boards currently use some rather ugly patches to make them
boot. I'd like to get rid of those.

I assume there's a good reason populate_rootfs runs between fs_initcall
and device_initcalls - perhaps one of the latter wants some firmware or
do a request_module?

But, would it be possible to throw most of populate_rootfs into a work
item, add some globally visible DECLARE_COMPLETION(initramfs_unpacked)
which is complete_all'ed at the end, and then in the (I assume)
relatively few places that might need to look at the filesystem add a
wait_for_completion(initramfs_unpacked) - including of course right
before the console_on_rootfs() call in kernel_init_freeable() (so also
before we start asking whether there is /init or not).

Rasmus


PS: This is the slowness, .7 seconds to unpack 4MB - it got a bit better
when switching to lz4 compression, but still in the few hundreds of
milliseconds range, which is way too much given the external watchdog's
requirements:

 [    0.047970] Trying to unpack rootfs image as initramfs...
 [    0.768516] Freeing initrd memory: 3972K
