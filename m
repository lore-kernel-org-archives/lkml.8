Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF1C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921952071B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QOHtPyva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgH1JAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:00:05 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32285 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728754AbgH1I76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:59:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598605198; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=fotnpsF0EYIr+SiKtcUih+0Uan6DLmURDNPjSJ8hGBA=; b=QOHtPyva4sAaE1tLEW3Xpr8zBasIuBJ6Uh1YQ3j/MGPR/brNG/vvvwI+8bC0hJqlMs3wu1zc
 JNsm6D97uYec+C/m32PBBxeCplEItJHjjCQVAgUakwjLLa31n4NIzIzZScFKih8y3vGtXja+
 meu32aUCLe6NzUnEpNYnDL36/P8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f48c78112acec35e2f3fbc4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 08:59:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EEEC5C433C6; Fri, 28 Aug 2020 08:59:44 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 101C9C433CB;
        Fri, 28 Aug 2020 08:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 101C9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lee Jones <lee.jones@linaro.org>, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Reed <breed@users.sourceforge.net>,
        Javier Achirica <achirica@users.sourceforge.net>,
        Jean Tourrilhes <jt@hpl.hp.com>,
        "Fabrice Bellet" <fabrice@bellet.info>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 12/30] net: wireless: cisco: airo: Fix a myriad of coding style issues
References: <20200814113933.1903438-1-lee.jones@linaro.org>
        <202008172335.02988.linux@zary.sk> <87v9h4le9z.fsf@codeaurora.org>
        <202008272223.57461.linux@zary.sk>
Date:   Fri, 28 Aug 2020 11:59:37 +0300
In-Reply-To: <202008272223.57461.linux@zary.sk> (Ondrej Zary's message of
        "Thu, 27 Aug 2020 22:23:57 +0200")
Message-ID: <87lfhz9mdi.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Zary <linux@zary.sk> writes:

> On Thursday 27 August 2020 09:49:12 Kalle Valo wrote:
>> Ondrej Zary <linux@zary.sk> writes:
>> 
>> > On Monday 17 August 2020 20:27:06 Jesse Brandeburg wrote:
>> >> On Mon, 17 Aug 2020 16:27:01 +0300
>> >> Kalle Valo <kvalo@codeaurora.org> wrote:
>> >> 
>> >> > I was surprised to see that someone was using this driver in 2015, so
>> >> > I'm not sure anymore what to do. Of course we could still just remove
>> >> > it and later revert if someone steps up and claims the driver is still
>> >> > usable. Hmm. Does anyone any users of this driver?
>> >> 
>> >> What about moving the driver over into staging, which is generally the
>> >> way I understood to move a driver slowly out of the kernel?
>> >
>> > Please don't remove random drivers.
>> 
>> We don't want to waste time on obsolete drivers and instead prefer to
>> use our time on more productive tasks. For us wireless maintainers it's
>> really hard to know if old drivers are still in use or if they are just
>> broken.
>> 
>> > I still have the Aironet PCMCIA card and can test the driver.
>> 
>> Great. Do you know if the airo driver still works with recent kernels?
>
> Yes, it does.

Nice, I'm very surprised that so old and unmaintained driver still
works. Thanks for testing.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
