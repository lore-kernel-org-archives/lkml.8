Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88549C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6530E20801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DIdCEE0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgEKMRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:17:24 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:50866 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728531AbgEKMRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:17:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589199443; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LJkqkksPCoqKwanmP1G5QFQXBwL68pGeFkXkb/IEhLI=; b=DIdCEE0ZnbYYA6EdDGH6m1PXu8s23lHjiROXcwJNEzur51nqqUOSYyTXir3cXNmIqLQgVsO3
 h4T9tlGCBT6GPgSXl5GlxXfEs5YSNq7tomINhpr7MB6FeHbvAVQ7IabxAb7WmBc+RLtz5kb+
 FYjm3B0TdU01Ov34w0pH5y22Mlk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb9424f.7ff7e8760b58-smtp-out-n05;
 Mon, 11 May 2020 12:17:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBA01C432C2; Mon, 11 May 2020 12:17:17 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2C65C433F2;
        Mon, 11 May 2020 12:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2C65C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 2/2] ath10k: fix ath10k_pci struct layout
References: <20200509120707.188595-1-arnd@arndb.de>
        <20200509120707.188595-2-arnd@arndb.de>
        <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
Date:   Mon, 11 May 2020 15:17:12 +0300
In-Reply-To: <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Mon, 11 May 2020 15:05:01 +0300")
Message-ID: <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Arnd Bergmann <arnd@arndb.de> writes:
>
>> gcc-10 correctly points out a bug with a zero-length array in
>> struct ath10k_pci:
>>
>> drivers/net/wireless/ath/ath10k/ahb.c: In function 'ath10k_ahb_remove':
>> drivers/net/wireless/ath/ath10k/ahb.c:30:9: error: array subscript 0
>> is outside the bounds of an interior zero-length array 'struct
>> ath10k_ahb[0]' [-Werror=zero-length-bounds]
>>    30 |  return &((struct ath10k_pci *)ar->drv_priv)->ahb[0];
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from drivers/net/wireless/ath/ath10k/ahb.c:13:
>> drivers/net/wireless/ath/ath10k/pci.h:185:20: note: while referencing 'ahb'
>>   185 |  struct ath10k_ahb ahb[0];
>>       |                    ^~~
>>
>> The last addition to the struct ignored the comments and added
>> new members behind the array that must remain last.
>>
>> Change it to a flexible-array member and move it last again to
>> make it work correctly, prevent the same thing from happening
>> again (all compilers warn about flexible-array members in the
>> middle of a struct) and get it to build without warnings.
>
> Very good find, thanks! This bug would cause all sort of strange memory
> corruption issues.

This motivated me to switch to using GCC 10.x and I noticed that you had
already upgraded crosstool so it was a trivial thing to do, awesome :)

https://mirrors.edge.kernel.org/pub/tools/crosstool/

I use crosstool like this using GNUmakefile:

CROSS_COMPILE=/opt/cross/gcc-10.1.0-nolibc/x86_64-linux/bin/x86_64-linux-
include Makefile

I think it's handy trick and would be good to mention that in the
crosstool main page. That way I could just point people to the crosstool
main page when they are using ancient compilers and would need to
upgrade.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
