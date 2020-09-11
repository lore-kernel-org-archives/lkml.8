Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B745DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9E720731
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="aowX1kkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgIKQPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:15:13 -0400
Received: from ale.deltatee.com ([204.191.154.188]:35644 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgIKQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MwrdSe8WFHXr29NOm/NiXpeNHwXZYZQa5mCvsCZ9j68=; b=aowX1kkdsr5U5Csum1KHk6yTp8
        2VG0op7gcgZpd5VO7EXE1bRDVSaYGpz+SC57u/bqwv0nLMH5GBcH+xn3TN05tgvDhTARVywdR3WKH
        OkislVwCqPfjFN0A0V3q3BOfAIGpu9ZxMF+/9LzVS3f/eWcgwLXZp3K0p/qdEvX26n5vaMSZbF0pw
        EWXUba0PdX5Imh0zgUDxQMBkQIObtG3A3TAuG7Bhohx3SIBVuxdb2M9Y+zr5eKGiEjqRE52AxEpKP
        0gFPmq/4BcM/oZMOl2gmQyVwEoyjF1gtly9ndGgjvR5+5CC1HuCrx6HUuOQ3n7KqHPdVjOKbXHqLe
        cGI1B0MQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kGlhF-0001q3-UN; Fri, 11 Sep 2020 10:14:46 -0600
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Borislav Petkov <bp@alien8.de>
References: <c0ba7077-7977-0155-d7be-d4133ebaee5c@deltatee.com>
 <20200911160053.w66xit3imcqsn33g@treble>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5a66f512-960b-7f24-068a-01c043ca9877@deltatee.com>
Date:   Fri, 11 Sep 2020 10:14:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911160053.w66xit3imcqsn33g@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bp@alien8.de, naresh.kamboju@linaro.org, luto@kernel.org, mingo@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: WARNING: Kernel stack regs has bad 'bp' value
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-09-11 10:00 a.m., Josh Poimboeuf wrote:
> Hi Logan,
> 
> Thanks for the bug report.  (Sorry I missed the first one, Naresh.)
> 
> The problem is that ret_from_fork() is no longer in .entry.text, so the
> following check in the FP unwinder doesn't work when ret_from_fork()
> gets interrupted.
> 
> 	/*
> 	 * Don't warn if the unwinder got lost due to an interrupt in entry
> 	 * code or in the C handler before the first frame pointer got set up:
> 	 */
> 	if (state->got_irq && in_entry_code(state->ip))
> 		goto the_end;
> 
> If you have the ability to recreate, can you try the following patch?

Sorry, but I can not reliably hit this bug. I hit it randomly twice last
week however, despite doing a bunch more runs this week, I haven't hit
it again.

I can add the patch to my testing next week but I ca not give you a
definitive answer on whether this fixes the bug.

Perhaps Naresh's test is a better reproducer.

Thanks!

Logan

