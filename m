Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9DAC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3157B20726
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 12:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkf1xa7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgBHM5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 07:57:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40562 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBHM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 07:57:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so1959816otr.7;
        Sat, 08 Feb 2020 04:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jAAF9lIe2xGP+2h6TNe8EwAWXReyZL3mgZUzeJxyr5E=;
        b=Xkf1xa7CYDTO58Bab0NHJOsIhSlbTqFuzR2rloKD87v1ih+PxUWyOYzxpH2fYJmC06
         76fVeklzK9MEYgKbvVdLVmfYjDuQJo0ghGrYnfvb2TqCmrAUkh/ZGN+9UlIB+t/LBfO8
         GA01fNNXZrEY725o44FYTHGcRwQ/KgzVcFjzmOLQbA/ZXCeDC3a5ysPVgfbrRQV7EqDo
         JLz3iezbYnjuY7DilFxowLP9G/ROIiKM+jfBOleBmwYe/K1EncOa2tyu6scaFmS+8raE
         8pjmGX8R3Lx3JApgoupKqhKJQv5zKfO43JbT9Mhja5HRd7WsmsZ5ZGIGK5WFOx3qwx6w
         5fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jAAF9lIe2xGP+2h6TNe8EwAWXReyZL3mgZUzeJxyr5E=;
        b=UjKIshnBjBH8+bCN/TXReZdTRGrPpuL9LJm+tmakAjPX+lXEwYHiRpn2klhAoXmeTo
         rIJeYRHOxRgbAzJYdv16eLqz1l5GwIpmj9hVVKHvWnhyx4EwaE6eoGQZgBAOhd1x3iLe
         bc4q3uxNWBK+W6kxhh5+3lV7OsBJzctS3OoG7laJjxy0NCy8OjEecHftdXRiAV/u0eFj
         dAnoUCOCO2ASXAqJ2GXA6SQjw0xcDwwYflq9jYBLuetOk/QUbVu16l8mSSfxsywLoPEs
         kBOuXrR6bCM+e2LYDsrJvYY1GEp+IPRVRtMsUj8Wj5HV9MwpPJkNeSlgz8orXxR7Y8dt
         vxzA==
X-Gm-Message-State: APjAAAWLb03v+9EC+b8xakv0c+ZgQ8jz2tQfqzXfN0Mf2VbvDI0hKBKO
        OAheDCtWajh6vXNvI0a5Hp8=
X-Google-Smtp-Source: APXvYqy6WjQRyqz5RPdnEzhGyAboWpvu3nuOK9/zXM3z0b1HGTAEvTqegmCHmuk/9TMjVjtYm/seTw==
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr3137323otq.1.1581166636560;
        Sat, 08 Feb 2020 04:57:16 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g5sm2262251otp.10.2020.02.08.04.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Feb 2020 04:57:15 -0800 (PST)
Date:   Sat, 8 Feb 2020 05:57:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: -Wtautological-constant-compare in arch/s390/include/asm/page.h
Message-ID: <20200208125714.GA9164@ubuntu-x2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We noticed that you all added support for building s390 with clang,
which is great! I have noticed a few warnings for which I will send
patches but this one has me stumped.

In file included from ../lib/crypto/sha256.c:16:
In file included from ../include/linux/module.h:13:
In file included from ../include/linux/stat.h:19:
In file included from ../include/linux/time.h:6:
In file included from ../include/linux/seqlock.h:36:
In file included from ../include/linux/spinlock.h:51:
In file included from ../include/linux/preempt.h:78:
In file included from ../arch/s390/include/asm/preempt.h:6:
In file included from ../include/linux/thread_info.h:38:
In file included from ../arch/s390/include/asm/thread_info.h:26:
../arch/s390/include/asm/page.h:45:6: warning: converting the result of '<<' to a boolean always evaluates to false [-Wtautological-constant-compare]
        if (PAGE_DEFAULT_KEY)
            ^
../arch/s390/include/asm/page.h:23:44: note: expanded from macro 'PAGE_DEFAULT_KEY'
#define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
                                                  ^
1 warning generated.

PAGE_DEFAULT_PAGE is always 0, meaning this function never does what it
is supposed to. Is this intentional? It seems that commit 0b642ede4796
("[PATCH] s390: default storage key") added this and it mentions that it
can be overwritten at build time but I do not see any infrastructure for
doing that. Any clarification that you can give so we can solve this
warning would be much appreciated!

Cheers,
Nathan
