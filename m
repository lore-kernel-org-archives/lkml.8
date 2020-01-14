Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C607C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A6D24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QJCtwaWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgANO5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:57:08 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:15057 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbgANO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:57:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579013827; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=/wDQzX9drwe6MnLxKEd1wgdmQ0ROFJy34Icy9JXF50Q=; b=QJCtwaWyhz8NxuKFgQID9vjN+t+e1K3ysfYSiiSWH6kHI5jn8ymiuXaYQRjVlV9e4CRPsADe
 gTfl2H6ghWXxns3Lbast6UomutGHo2qXDmqHUVM9XP0CnzGImWOG5PcYsLHDVnWwPrlAQOlD
 pTREJ5s2WaKrt+eRgmTBNfeiqwM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1dd6be.7fba760c6f48-smtp-out-n01;
 Tue, 14 Jan 2020 14:57:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 655D2C4479F; Tue, 14 Jan 2020 14:57:01 +0000 (UTC)
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2370AC43383;
        Tue, 14 Jan 2020 14:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2370AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        stable <stable@vger.kernel.org>, huangwen <huangwenabc@gmail.com>
Subject: Re: [PATCH] mwifiex: fix unbalanced locking in mwifiex_process_country_ie()
References: <20200106224212.189763-1-briannorris@chromium.org>
        <CA+ASDXNN5=97nhN99rPneLGSQAmQ4ULS6Kim1oxCzKWNtPkWFw@mail.gmail.com>
Date:   Tue, 14 Jan 2020 16:56:54 +0200
In-Reply-To: <CA+ASDXNN5=97nhN99rPneLGSQAmQ4ULS6Kim1oxCzKWNtPkWFw@mail.gmail.com>
        (Brian Norris's message of "Mon, 6 Jan 2020 14:51:02 -0800")
Message-ID: <87imle13yh.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Mon, Jan 6, 2020 at 2:43 PM Brian Norris <briannorris@chromium.org> wrote:
>>
>> We called rcu_read_lock(), so we need to call rcu_read_unlock() before
>> we return.
>>
>> Fixes: 3d94a4a8373b ("mwifiex: fix possible heap overflow in mwifiex_process_country_ie()")
>> Cc: stable@vger.kernel.org
>> Cc: huangwen <huangwenabc@gmail.com>
>> Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>
> I probably should have mentioned somewhere here: the bug is currently
> in 5.5-rc and is being ported to -stable already (I'll try to head
> that off). So this probably should have said [PATCH 5.5]. Sorry about
> that.

Ok, I'll queue this to v5.5.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
