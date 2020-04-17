Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1C7C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25AA02078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587143888;
	bh=VCLkhpZJoywZlpzhEBTJApIPKcECQYX7x276NlVZDFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ltV6i9HYkjQ0rqdhNXQA59jpY7Sl/YXZyfbEXLHh/cvJ0tL5E9lS0RkWoxjhNQICO
	 999dMLI3NwRmNPIuYWBmecUvN2XoiNfMEYYr+/mjiSyQeJL9RNtqsE34BY6GKhtOC4
	 pzaSICacKJL5jhIcX5KHm/76vc8trRwBxtOG06Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgDQRSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbgDQRSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:18:05 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF28E2078E;
        Fri, 17 Apr 2020 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587143884;
        bh=VCLkhpZJoywZlpzhEBTJApIPKcECQYX7x276NlVZDFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsGs/zvgF2wpjZPqw2JjueIJwPsTS669phOeZa3g2G7oUW7m24hEsCUKZIqpQW7p1
         HMDAgXmY5CqbA6VqKhXAMZvErC87iS5sQxO+iJxou6sn7f6iPx0lDTd5XUiWVgrxQM
         PYkGWJmT0LtYJyUrPzMv/Cz1YFzNKrc1fWE4G1Jk=
Date:   Fri, 17 Apr 2020 13:18:02 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH AUTOSEL 5.4 095/108] ARM: shmobile: Enable
 ARM_GLOBAL_TIMER on Cortex-A9 MPCore SoCs
Message-ID: <20200417171802.GV1068@sasha-vm>
References: <20200411230943.24951-1-sashal@kernel.org>
 <20200411230943.24951-95-sashal@kernel.org>
 <CAMuHMdVrp25m_SDKSC=ntNWxsumcw4JKvHNDeFZT_JnpfQmCxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMuHMdVrp25m_SDKSC=ntNWxsumcw4JKvHNDeFZT_JnpfQmCxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:44:01AM +0200, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>On Sun, Apr 12, 2020 at 1:11 AM Sasha Levin <sashal@kernel.org> wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> [ Upstream commit 408324a3c5383716939eea8096a0f999a0665f7e ]
>>
>> SH-Mobile AG5 and R-Car H1 SoCs are based on the Cortex-A9 MPCore, which
>> includes a global timer.
>>
>> Enable the ARM global timer on these SoCs, which will be used for:
>>   - the scheduler clock, improving scheduler accuracy from 10 ms to 3 or
>>     4 ns,
>>   - delay loops, allowing removal of calls to shmobile_init_delay() from
>>     the corresponding machine vectors.
>>
>> Note that when using an old DTB lacking the global timer, the kernel
>> will still work.  However, loops-per-jiffies will no longer be preset,
>> and the delay loop will need to be calibrated during boot.
>
>I.e. to avoid this delay, this patch is best backported after backporting
>8443ffd1bbd5be74 ("ARM: dts: r8a7779: Add device node for ARM global timer"),
>df1a0aac0a533e6f ("ARM: dts: sh73a0: Add device node for ARM global timer").
>
>While the former has been backported to v5.[45]-stable, the latter hasn't,
>probably because it depends on
>61b58e3f6e518c51 ("ARM: dts: sh73a0: Rename twd clock to periph clock")
>
>So please backport the last two commits first.

Done, thanks!

-- 
Thanks,
Sasha
