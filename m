Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5818C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BC62073B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i66gvCd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgEFDhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 23:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgEFDhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 23:37:53 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB14C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 20:37:52 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id a7so23840uak.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 20:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/K450lb1lXZWNub5l53fuFTH1txZt+evZRmROoeb2I4=;
        b=i66gvCd5ocghenQRtvgyBvO4MQYtXaaIOon567733AdAxnF0DIOSZhuFE+cORJxNdd
         YOiB/UYnx7f7v6JjSC+TJ1pc8vKVmZNfKPXeEWf1v9B6zqt7HP9vcSutGuUvtL76kw/d
         NRnLYDQmjUIKTL4GHRCv/IPLUMcq6VpL0657fCSVZAue++G46gIWtA3FF8w+OKQJJHue
         /HzU8UFrua5SixBKkwyq3ECJrlKVnF0u9b+Fl5xYVE7qUfHT28DpioD8cBUApJROyv92
         r5QixTZ42/4k7N9zgNQp0sQTwpsvIZBVX1BiACbxogmow4WaY9Wp1sXxvIb2yjv6LEZQ
         XM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/K450lb1lXZWNub5l53fuFTH1txZt+evZRmROoeb2I4=;
        b=snN5xgQiRD04hE40BhRwqktstmUpNXZViGOnmsPgaZImghVSwWhiM+qAPsdpAig3iw
         jQnX638SDt+potigkNeRo5XVjJ3A2tesT4J+ZbEoPuDDc0RXUf87+qcvxxC5AugdFx2K
         JxHQfsUNp7ag9gnN2dY9syjUbJKGLHzQy32HIg9aMpUDeCIGTbEYDAlRoYYHA4wIENrH
         mHCcxUb5ezM755SK/vu7IZy92C2ZoLVEGxXgfMeMe8TlNjvz/92Nr1BRPl8CucRFZKyB
         I7N4/m8zpyu1TWnDuKOBD29adNmqX4UIKzP439wLKghY+7NoPmBX4ybBVseEZWo9lyHx
         LcJQ==
X-Gm-Message-State: AGi0PuYEAPZUTb/UkQKsUfGfiuCat2Kq7N9ntMoyYhZj521lDyayyXmC
        z3NOtiQOQb0QghmYhsnWOMxRYUhfpp496HguVHGJDw==
X-Google-Smtp-Source: APiQypJlf5KZKjLajfXJQSqAKZ6We6VVt8fBpwvc1g/C/PnGIfueFpC5UpeqG3DfA9rW0IDxilviVwOXRtieMJ6OVMw=
X-Received: by 2002:a9f:2344:: with SMTP id 62mr5892977uae.7.1588736271638;
 Tue, 05 May 2020 20:37:51 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 5 May 2020 20:37:40 -0700
Message-ID: <CABPqkBQ13AEPrV=pUcF1L6iYOaDgN2dsVanXBa8+AqgUh87kEQ@mail.gmail.com>
Subject: callchain ABI change with commit 6cbc304f2f360
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>, jpoimboe@redhat.com,
        "Liang, Kan" <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have received reports from users who have noticed a change of
behaviour caused by
commit:

6cbc304f2f360 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")

When using PEBS sampling on Intel processors.

Doing simple profiling with:
$ perf record -g -e cycles:pp ...

Before:

1 1595951041120856 0x7f77f8 [0xe8]: PERF_RECORD_SAMPLE(IP, 0x4002):
795385/690513: 0x558aa66a9607 period: 10000019 addr: 0
... FP chain: nr:22
.....  0: fffffffffffffe00
.....  1: 0000558aa66a9607
.....  2: 0000558aa66a8751
.....  3: 0000558a984a3d4f

Entry 1: matches sampled IP 0x558aa66a9607.

After:

3 487420973381085 0x2f797c0 [0x90]: PERF_RECORD_SAMPLE(IP, 0x4002):
349591/146458: 0x559dcd2ef889 period: 10000019 addr: 0
... FP chain: nr:11
.....  0: fffffffffffffe00
.....  1: 0000559dcd2ef88b
.....  2: 0000559dcd19787d
.....  3: 0000559dcd1cf1be

entry 1 does not match sampled IP anymore.

Before the patch the kernel was stashing the sampled IP from PEBS into
the callchain. After the patch it is stashing the interrupted IP, thus
with the skid.

I am trying to understand whether this is an intentional change or not
for the IP.

It seems that stashing the interrupted IP would be more consistent across all
sampling modes, i.e., with and without PEBS. Entry 1: would always be
the interrupted IP.
The changelog talks about ORC unwinder being more happy this the
interrupted machine
state, but not about the ABI expectation here.
Could you clarify?
Thanks.
