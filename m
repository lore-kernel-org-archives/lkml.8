Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22322C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2D02075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZO8oZyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgESHx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgESHx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:53:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7E0C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:53:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n15so2916467pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=90JtBfQaO8CnvkM0ghj/tqXgttRAyyfAqTnngOdG3VI=;
        b=QZO8oZykFmocOOl7aFZ5ZbeTmoRkpjI18Td4wZGWrZ/LXrDrQpu266ulbaz9sRnBBh
         vwwADHvaUzikHT6Wla/j3q6OMfJpjv+OUkbs/Sk8R4r/bMNZJ0MGxdGMQFsPq3xbjf9p
         ZiVE6fug3h4OnadEuedJpLkeDkU3wUBJKKP+kQif3MbbOfixbBpfbVFhlyhrnA6255Xl
         xHNMQRMbBX8zdkzwBtsAR0mmoG8c8r4hviMLnjSemk0ByePhYHr7UWoh4VPaHwaQrDLg
         bqsYj2TV1NnfCu8v+CARZCLzBbN+hD2tUIuTT88HnqtSQElGwld4hBhTh0W1dpwr0wh/
         Dedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=90JtBfQaO8CnvkM0ghj/tqXgttRAyyfAqTnngOdG3VI=;
        b=REJF2BkoesrJhWm5Qo0fGUcYxuzPrcApJvGxpqVFgbduYLMpj6NntDaG50imwtqDoG
         0vMjDR9oLMCmijTP7F3AdBHh74jPFrO6uQlbjFyayYo7BG2F0awA5OD/JdqmNSUf8UnM
         IB4QBYcACJjKonj5lp3bFCcohdTx3AaZFjq+RHY4aAA9HEiDlLXKYxI4CvG2w6mxefuI
         6OhMznIBaoDKX1ScG09jW+vD4uGJBc69Jisz+34yG4ofOGk+bl1EKcxNVn1jKeJnGvIT
         dfjTv6X/kFrDXuxG1o7tGLld/YFWfO2aurRFh3fDus5GAK4S+BUmDa3cBpbOEXjJMNop
         e1gA==
X-Gm-Message-State: AOAM530D/yTTPhdjJwncPJGRCRhO5oX98TWZltg7jvw0t9n3FObF14CK
        wjGNzcm0k9tncfDTksCbXFO+YieM5ss6qgWJ
X-Google-Smtp-Source: ABdhPJxMXA/j3m1VvlI5LVe0U7oVHJU9KIkdRwb3MBlxteaI8UdHaYhfylaqH+Ww2/HL4gxrdhjs4g==
X-Received: by 2002:a62:3006:: with SMTP id w6mr20807466pfw.29.1589874835786;
        Tue, 19 May 2020 00:53:55 -0700 (PDT)
Received: from gmail.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id mn19sm1432158pjb.8.2020.05.19.00.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 00:53:55 -0700 (PDT)
Date:   Tue, 19 May 2020 13:23:49 +0530
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 5/6] staging: greybus: audio: Add helper APIs for
 dynamic audio modules
Message-ID: <20200519075347.GA18002@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
 <c1339e4d57c8b39bd25197d4514fabd868b829b1.1589734179.git.vaibhav.sr@gmail.com>
 <20200517173706.GB34497@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517173706.GB34497@piout.net>
User-Agent: Mutt/1.10.1+3 (f9293d646485) (2018-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 07:37:06PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 17/05/2020 22:47:20+0530, Vaibhav Agarwal wrote:
> > Greybus Codec driver allows modules to be dynamically added and removed,
> > which further requires updating the DAPM configurations as well.
> > 
> > With current snd_soc architecture, dynamic audio modules is not yet
> > supported. This patch provides helper APIs to update DAPM configurations
> > in response to modules which are dynamically added or removed. The
> > source is primarily based on snd_dapm.c
> > 
> 
> I really think you should send this patch series to the ASoC
> maintainers, especially this patch. The main goal shouldn't be to simply
> fix compilation issues but to try to get the driver out of staging else,
> the current situation will happen again.

Agree Alexandre. I'll share this with ASoC maintainers as well.

Also, I'm seeking opinion regarding the scope of pushing GB Audio out of 
staging tree. I'm keen to make the relevant changes and work actively 
for the same. However, I don't have a real device to test the latest 
code and thus not sure if the changes can be pushed to sound soc tree.
GB maintainers, kindly share your opinion.

--
Regards,
Vaibhav
