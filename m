Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF6F206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VGQmwQxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFBUTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:19:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:37013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFBUTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591129154;
        bh=rOL99K4bTvQJpwB9BYhwvGi5jUxpfE3SqW3LEbxB3wQ=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=VGQmwQxwXONsfwyoYSUCEdRY9jIaRopNzPhAGdAruif6ljtTpIRivjIRzT/SQ9FgK
         0nt8tvgPjk564DEPCh1u2iBR64+evNCCgkGadxsIlNL1Kmz3ROV03e4zwehjb2mAew
         SmAyKA0gr03HtnPRwvnrVqEa+rOZ57HEd5c0WMS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.43.192] ([80.187.97.103]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1jbnX80Lqa-004Ug8; Tue, 02
 Jun 2020 22:19:14 +0200
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>
From:   Helge Deller <deller@gmx.de>
Subject: [GIT PULL] parisc architecture updates for kernel v5.8-rc1
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <21135f7a-203c-3b7d-3dd3-88f8aaebdabf@gmx.de>
Date:   Tue, 2 Jun 2020 22:19:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BleGqe+LTUA95wYH1yRrkJsqVnAJ7mHXVNcBsY7D+P5rnbX0kAe
 9wh+knWtf2BcinIKe0EtmREJPtzhWxWgQN5W51kRmxVaJ7kBhYBGl7Lmp2AN2lMEKydORHJ
 /AXpiG+XyRejj8m5ssbP7Akva8s6d3VO/KY0EoQVHY/14IM5zGg8t+YytJ2RjGoZfd8+bOH
 t8jAVan/lPy5mJwA+M+wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mQu/0uozhUE=:qMk/+aGJUlSV7In5yxNRO2
 +22y6dqNh+QPHi0/hzuDYnFmbXfVUoQI9afOJuKAe2sLK4JDmxCddvqanI3r6axmBUNZC+gsR
 O8o3zUzD0FD4n1Mau0i7NfXvgxp5Cyi0p0WcM0mpDBh1OqqzJGdfGQqxh2d7cU08tLN/ugrDF
 2XhpRjpFi42jPq3ntNiwEMtcxblqA3G+hCDEdHDZ3/hM/xEmrZoUWWKz7T7QnRB8oCjdhROf7
 BYRfQ7X+XNaoErWk1JHYIWAD5fZ99a+z/+YBhg9yrDI+LruGTkndgwCE4/wYUL8bYIOlz8rIv
 9XYUbLOCJOORc1R3AeQtbdwMkYRoI8OKAsKJosu2IAeINLHgqQPevZrSJF3EIg8LD6BJ6wlWp
 f10pHik771Tk5iojtCLH2HCluFwmK/lU87RXOHBTdLluMex0GmKLLOYTVHGRAd+f4vWhCLPU6
 24J5bAHpjytxod3IdimHFturuD8iaqDpV7uJa3x3W+K50oqEenAr6JbRW9Ry6ECcOpJnPc3e3
 ouIKHfsbHT2hw/LfvrJY98N9GpEXcBiIjoyUDndKtnM08xoCI49C/TyRuSCAnto9QDxrzezno
 fZhI9tX0f3qgIn3q/dWVsfNO7XnLTLdM0PYx9NngYYO7DlvZbQ6LBOjPczqXWnDeXZGY5yK61
 7moKsAbekl+eIK4Z4aS9cJ7/DgS5lkYPKbX6YoaTAImRSvn07LIP3L3hVkQ+/aeiwb+gWt+Io
 jwy6xwRzAV1plcuXk4gLWAxgw3nAZqvB6keWBWid6G9QvvtEpDf3I1H5Y23UEYZQhSrrNsrNp
 krTb2+X7/YzhR03aHVSjF5PECBYWM/OvADK7I/Ml7KS2ACpPnshEos3rGR2H3pFtT0akJgRaI
 7dW8GU5BbhqW/IhM1wExBKxTPLsPvp1oe4u1qBI9CpBnHJthbafEp69fOHDqhUjAiGraXXQHg
 e/tKI4c8oTOTV0n8SQCxN2d9nwTPwKb/LvjkRdXzTVWFeicvOD0QoYtUI65VPDu1h1lOU9CQC
 5Cshm9xcqZ5Jd425rmuQMzPBZl7kpOk9SPC4FnLSEyBJuqikIQ8GZDpswBafaZW4gsBmhhpfv
 n2L+Li2A+yo02Z3E/CPSfG6lyqiqQtBsXfWTnSbP/n+JKNcjPk15QzZjIdWuM1Xd4H44xLX1g
 OOOD8+QaX+Dh7zACCSzpgA4j2p76mGJn7YKsDZg92iYl6ajO1LLA3c/gBrcu9AsDm3jBYZbZH
 D/ZJ1P4uORLuwkAeK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for kernel 5.8-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.8-1

Enable the sysctl file interface for panic_on_stackoverflow for parisc,
a warning fix and a bunch of documentation updates since the parisc website is
now at https://parisc.wiki.kernel.org

Thanks,
Helge

----------------------------------------------------------------
Arnd Bergmann (1):
      parisc: use -fno-strict-aliasing for decompressor

Helge Deller (6):
      parisc: suppress error messages for 'make clean'
      parisc: Kconfig: Update references to parisc website
      parisc: firmware: Update references to parisc website
      parisc: hardware: Update references to parisc website
      parisc: module: Update references to parisc website
      parisc: MAINTAINERS: Update references to parisc website

Xiaoming Ni (1):
      parisc: add sysctl file interface panic_on_stackoverflow

 MAINTAINERS                          |  2 +-
 arch/parisc/Kconfig                  |  2 +-
 arch/parisc/Makefile                 |  4 ++--
 arch/parisc/boot/compressed/Makefile |  1 +
 arch/parisc/kernel/firmware.c        |  3 ++-
 arch/parisc/kernel/hardware.c        |  3 ++-
 arch/parisc/kernel/module.c          |  4 ++--
 kernel/sysctl.c                      | 20 +++++++++++---------
 8 files changed, 22 insertions(+), 17 deletions(-)
