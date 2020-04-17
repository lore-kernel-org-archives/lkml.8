Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDEAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020EA21D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microway.com header.i=@microway.com header.b="ozMkwas8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgDQDlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:41:35 -0400
Received: from 50-247-197-57-static.hfc.comcastbusiness.net ([50.247.197.57]:35060
        "EHLO microway.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726105AbgDQDle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:41:34 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2020 23:41:33 EDT
Received: from [10.200.120.6] (openvpn.microway.com [192.168.200.4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by microway.com (Postfix) with ESMTPSA id 628E73004433
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 23:34:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=microway.com;
        s=verified; t=1587094470;
        bh=ywoe/KWhEbobTRp8t8l9tb7jHYngbY9Kh0XrHhm6E/I=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=ozMkwas8l67k5TV4xTD8QaodsCT9I4D8sv/fylFr4sIfb1R4uAsmc/7I5kMMTd2CX
         oy7R8Q7f5qBgp7RSa0H+E1VVU+T+MBXHsvPBFGr8oTxL3TOUTPbeiFL7ejIsQclqNB
         tl1MUPqiBP8FSHVQsMMpgMSXxjsAvBpzvuzW5DT4=
Subject: Re: slow write performance with software RAID on nvme storage
From:   Rick Warner <rick@microway.com>
To:     linux-kernel@vger.kernel.org
References: <0a6373c6-817f-6ead-2a71-7c83c03406be@microway.com>
Message-ID: <adc13d3c-b311-8781-0395-146848821cef@microway.com>
Date:   Thu, 16 Apr 2020 23:34:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0a6373c6-817f-6ead-2a71-7c83c03406be@microway.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional testing with fio has shown near theoretical write speeds if I 
test direct to the /dev/md device instead of using either xfs or ext4.

I've tested different queue settings without significant changes.

Is it possible to get a single XFS or ext4 filesystem performing with 
 >10GB/s write speeds?

On 2019-03-29 16:55, Rick Warner wrote:
> Hi All,
>
> We've been testing a 24 drive NVME software RAID and getting far lower
> write speeds than expected.  The drives are connected with PLX chips
> such that 12 drives are on 1 x16 connection and the other 12 drives use
> another x16 link  The system is a Supermicro 2029U-TN24R4T.  The drives
> are Intel DC P4500 1TB.
>
> We're testing with fio using 8 jobs.
>
> Using all defaults with RAID0 I can only get 4 or 5 GB/s write speeds
> but can hit ~24GB/s read speeds.  The drives have over 1GB/s write speed
> each, so we should be able to hit at least 20GB/s write speed.
>
> Testing with RAID6 and defaults got significantly lower (down around
> 1.5GB/s).  Using a 64k chunk and increasing the group_thread_cnt
> increased the results to ~4GB/s.
>
> dmesg shows the RAID parity calc speed being ~40GB/s:
> [    4.215386] raid6: using algorithm avx512x2 gen() 41397 MB/s
>
>
> I've played around with filesystem queue choices and tuning but haven't
> seen any significant improvements.
>
> What is the bottleneck here? If it's not known, what should I do to
> determine it?
>
> I've done a variety of other tests with this system and am happy to
> elaborate further if any other information is needed.
>
> Thanks,
> Rick Warner

