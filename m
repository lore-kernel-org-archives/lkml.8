Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A162C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCED020758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y6UNTuC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgGTFn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTFn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:43:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D917C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 22:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wsw8+GZRXil4kU2zK21Y94R9+/rr2HFNiXIhdlvuwUY=; b=Y6UNTuC8A2uYkyQ0k2IRGq1zcJ
        5P/7Nqf9Q6KFGKyMXzq8SSUfvaAAkmMTtQ+I8HvfNf08g/Own3BZm4AuXQ9Jc0gzVw4KiSpON4//p
        2GhyWsLXWnCe1ZQc8p9O6MbnyzmQwdTzjdRPNCSUDJ1bEKy+aKAlbaW/0SJTySPtvsJiEa3tZF+r3
        UTAKtDZo+lJTCIyec5IJWu7bDkLSe5HKMmvPiSx5mPdsSmzzbeExcJWCBFDqsfr95XKXomsjAgFxI
        cp+E0HbdYes4azEesT+XuoX4MMXyOw+Ry23xsxxxbPOvlJ6I3PuvqnUiuNoDzMuOkNSGG/p7pAK8F
        +IqS6EAA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxOaA-0004q5-UP; Mon, 20 Jul 2020 05:43:25 +0000
Subject: Re: [PATCH] platform_data: cros_ec_commands.h: drop a duplicated word
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <20200719003053.20899-1-rdunlap@infradead.org>
 <CA+Px+wVL09UepuyfXrdGiesJb=Bn0S_TuYS3oX52DWBK-QVnMQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f5446d37-af95-274d-690e-4d98553922aa@infradead.org>
Date:   Sun, 19 Jul 2020 22:43:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+Px+wVL09UepuyfXrdGiesJb=Bn0S_TuYS3oX52DWBK-QVnMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 9:42 PM, Tzung-Bi Shih wrote:
> On Sun, Jul 19, 2020 at 8:30 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Drop the repeated word "using" in a comment.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Tzung-Bi Shih <tzungbi@google.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> ---
> 
> I guess you didn't include the maintainers:
> Benson Leung <bleung@chromium.org> (maintainer:CHROMEOS EC SUBDRIVERS)
> Enric Balletbo i Serra <enric.balletbo@collabora.com>
> (maintainer:CHROMEOS EC SUBDRIVERS)
> Guenter Roeck <groeck@chromium.org> (reviewer:CHROMEOS EC SUBDRIVERS)
> 

Thanks. I'll add them and resend the patch.

-- 
~Randy

