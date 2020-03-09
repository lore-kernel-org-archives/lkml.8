Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31746C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B037220675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ngs.ru header.i=@ngs.ru header.b="abrOxibQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgCIGyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 02:54:49 -0400
Received: from smtpout242.gw-m11.ngs.ru ([195.19.220.242]:46505 "EHLO
        smtpout.ngs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIGyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 02:54:49 -0400
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 02:54:46 EDT
Received: from smtpout.ngs.ru (mc-spool1 [172.16.113.66])
        by mc-spool2.in.ngs.ru (fallback) with ESMTP id EE9FF200A98
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 13:43:49 +0700 (+07)
Received: from [192.168.159.205] (b-internet.87.103.241.5.snt.ru [87.103.241.5])
        (Authenticated sender: jack_solovey@ngs.ru)
        by mail.ngs.ru (smtp) with ESMTPA id 9A8801818E9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 13:43:40 +0700 (+07)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ngs.ru; s=mail1;
        t=1583736221; bh=eGURF93INSWaOEf43BU4XF4l9dauTTKTjIBcck/5w64=;
        l=499;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=abrOxibQSHFIOT2T5GDwtuewB0LxpAGHL2mHSXELtJQOGcFXjhmJXvli3DU/5dB+e
         jVu+ib2T1eSKoumGldjJq/trfcxsmmxkNLXgQgZERJ9v9a+4idVHeHu/qh2GsyC9tz
         wWxoaqsSwrOTZvb5wriV38JVGiCI/sy6k0xP6rdc=
To:     linux-kernel@vger.kernel.org
From:   "jack_solovey@ngs.ru" <jack_solovey@ngs.ru>
Subject: error fn f7
Message-ID: <625e12e1-aee0-8b3c-8a4d-98e74739153c@ngs.ru>
Date:   Mon, 9 Mar 2020 13:43:40 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 139415 [May 13 2019]
X-KLMS-AntiSpam-Version: 5.8.14.0
X-KLMS-AntiSpam-Envelope-From: jack_solovey@ngs.ru
X-KLMS-AntiSpam-Rate: 15
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 270 270 6c51353dd3ca3e23ee775cfa699b78fb2292d8a9, {rep_avail}, 87.103.241.5:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;ngs.ru:7.1.1, Auth:dmarc=fail header.from=ngs.ru policy=reject;spf=softfail smtp.mailfrom=ngs.ru;dkim=none, dmarc_local_policy_1, ApMailHostAddress: 87.103.241.5
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: not scanned, disabled by settings
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.705, not scanned, license restriction
X-Virus-Scanned: clamav-milter 0.98.6 at mc-filter2
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, sorry this machine translation.

Laptop  Asus N56V
Prior to kernel 5, the FN+F7 buttons turned off the laptop screen.
Starting with kernel 5, these buttons turn on standby mode.
I have to use core 4.18

Linux Asus-N56VB 4.18.0-25-generic #26~18.04.1-Ubuntu SMP Thu Jun 27 
07:28:31 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

Whether it is planned to return the legacy function to the fn+f7 buttons 
to disable the main monitor.

-- 
___________________
Sincerely,
Solovey Evgeny

