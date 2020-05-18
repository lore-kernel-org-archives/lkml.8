Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D955F207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh8nh5l/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgERTVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgERTVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:21:06 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:21:05 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d26so9108716otc.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rcEDr+6fG66dv1/hXLkkZjCfS8T1ynKA/WGu4jgXbJg=;
        b=qh8nh5l/TDw4IKfIEpeZes87n2oPS5ChN6CvDKb82ZmvCFwx4b+BpykTnO+Wat1CfB
         eenMGnTQf0usWew0hx+F+Y3/GySIoJ50nS38m4NnaKSxWIPL3AjEegH7KFcFd5sGtwif
         wRmKDVPxaS/UmKTdW7Y3xLX6goHQwVAamTQhxGIj1oZUgt+YZCDgpMNOe+InURgfHVhm
         kmX2WaXFjI+In4hWO6+x4tn3gtVAjyyDo1g3V/BXkEVmft6M/7fGbzQQuHHJ4N+m2LeV
         xrLvFsO3WA0mEVPOGRbqTXdAOuxonqY+eOJLMqscxGeTyk5vkalQC43E1n0wXlbTXT4v
         HW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=rcEDr+6fG66dv1/hXLkkZjCfS8T1ynKA/WGu4jgXbJg=;
        b=UYxwIeTRS4Z8rbHFXsfa8y0NqCwcDsFR+1Or5bF7OumZpfrAxg/m5Fg08GipLitXd8
         +g2D1PD+ts1eQVsnd+ojTQop51B4TvnS9/F/mftW4F/2N8FdPTH44rNcZb5MM9FO+KL7
         ycDuWLsINpMTVvfd2IDkeTpvgOjzWE8c/13yZougpPaSdrEWv0emlLANWsvBKQT5Gpqy
         hSdEcf92mrkax9o7JuUX3zYX3z0PQsnpcDWFQch96SuCyMuiZ4Ik/2tfxfw612CM0fci
         4FrqXwdh3ekLLnAkPz33u2X0rNmimI03QaLM2UXpP2CRkaLfAZ28ma5Phn1wZy8RBWV0
         Aexg==
X-Gm-Message-State: AOAM533CwprV9KSc079/J4CxIxP/MUkS235PNQ+ZY+MPxMuTqTFHubBO
        u/u57vzIB7oqG1/WmBJilKoL2wl2
X-Google-Smtp-Source: ABdhPJxJohjWoyUYrwKDNDY1WdIW9jOk/28nyhXa4CBArE3BYBLcMkCBLgCSGhdKS6HbLUpDrSvU9w==
X-Received: by 2002:a05:6830:1353:: with SMTP id r19mr13204140otq.248.1589829665202;
        Mon, 18 May 2020 12:21:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t24sm958048otp.69.2020.05.18.12.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 12:21:04 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Indicated kmemleak in msr_build_context() for Kernel 5.7.0-rc5
Message-ID: <9f1bb619-c4ee-21c4-a251-870bd4db04fa@lwfinger.net>
Date:   Mon, 18 May 2020 14:21:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with an AMD FX-8320E Eight-Core Processor running kernel 5.7.0-rc5, 
I am seeing the following memory leak:

localhost:~ # cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff88840ca02540 (size 64):
   comm "swapper/0", pid 1, jiffies 4294892775 (age 138786.084s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 04 10 01 c0 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000005004530>] msr_build_context.constprop.0+0x32/0xbe
     [<00000000bb4e1265>] msr_save_cpuid_features+0x28/0x2c
     [<0000000011ec0f08>] pm_check_save_msr+0x2e/0x40
     [<000000000cd50945>] do_one_initcall+0x46/0x220
     [<00000000fd0d2fc9>] kernel_init_freeable+0x1c6/0x23f
     [<000000009f9b95ca>] kernel_init+0xa/0xfc
     [<000000000a571fca>] ret_from_fork+0x22/0x40

This is a "family 0x15" AMD CPU, thus MSR saving is needed during suspending. I 
believe this to be a false positive.

The indicated memory allocation has been in the kernel since v4.5.0. Should a 
patch be sent to clear this false memory leak indication for systems with AMD 
processors?

Larry
