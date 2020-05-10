Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B3EC47257
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09E221582
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="ZLFGU6FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgEJCP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbgEJCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 22:15:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30905C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 19:15:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so6034939pjd.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 19:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zZO7z1uZ3JyTfUHXZIjNKa9uIQjs+v1jCyQprPMHpc4=;
        b=ZLFGU6FEzQhtgASCJHB/bfuc3jyfJSNipYcQ4b7l0ISyMWnoOomEmfrEWSIwVUYvYi
         e/n6HWL/Qt0VA6GtuW0ukDqyDBLmfdTIh7j0te43fTx528dvK2q4t5d/P5/A0yJd47Fi
         ysfr/xFuXR3u0pRmH2tLwHZXGCuVtaWPwFBTIXN+DPuwa2yHdh4m5Q9+G4D4DG/37Wn0
         +YL79k2rmRLg7jj5huQ/L+DekguFUgjWkPZBfLFs5A5ClSqKSNFv/B0G9mkdDuCgCjlH
         j/MUUC90P/no78ohrdGmIUCaomJeQYQiLZlfus7QdLU8fVE84e9fTWA9psdZuwISTprG
         /ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zZO7z1uZ3JyTfUHXZIjNKa9uIQjs+v1jCyQprPMHpc4=;
        b=lNj3S2308MQsu+dmEYaKtqX7+K2gi8sowUJwrJ3EiPNRSNNu4otNeBdYcxhS4W6kbq
         Q+StmGehHgZ3WlGzN1jqy3lXo0IFRHKzZzqMNyPaqjIEBpE7iOLe7GMYR4kCIcEsaelS
         oJgByqV4XI/KXHFEGXEYLbx4NrLxIw1O9dd6Krd0RqBJoYkVzkCe+ceZzLlli86tSEV6
         N/CCbb8ueIDrmJ9Ieu8CLJSRyyEa7341USlL2t2QOwueiy68l4uh1d9MRjsqXURxVQpS
         kd0bcvzX7EboiCbommAx2WUZxZnHYDk0p7AAA36TlVmOVzNzz5mvBO8fuwhXQQc8HvUL
         XZsQ==
X-Gm-Message-State: AGi0PuacApzgHxgbdMrxBdUQlnczvSXWqiRQOws4rShqYDhcsGG7WJeE
        9ODtLo+1TUf3Fz1EyOjFRy0cgjGO7Qw=
X-Google-Smtp-Source: APiQypJeav85RT0wp05J4UqOb9EM/2pf5CqJCJWwI9iA9IvGikOmBGWCXV3L9Jpzy/shx0cGXmXNBw==
X-Received: by 2002:a17:90a:343:: with SMTP id 3mr10850397pjf.224.1589076926192;
        Sat, 09 May 2020 19:15:26 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id c15sm5652524pfp.34.2020.05.09.19.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 19:15:25 -0700 (PDT)
Subject: Re: [PATCH 00/15] net: taint when the device driver firmware crashes
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, jeyu@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200509043552.8745-1-mcgrof@kernel.org>
 <1e097eb0-6132-f549-8069-d13b678183f5@pensando.io>
 <20200510015814.GE362499@lunn.ch>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <01831b19-5890-e7e0-3801-068dfab5c92a@pensando.io>
Date:   Sat, 9 May 2020 19:15:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200510015814.GE362499@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/20 6:58 PM, Andrew Lunn wrote:
> On Sat, May 09, 2020 at 06:01:51PM -0700, Shannon Nelson wrote:
>> On 5/8/20 9:35 PM, Luis Chamberlain wrote:
>>> Device driver firmware can crash, and sometimes, this can leave your
>>> system in a state which makes the device or subsystem completely
>>> useless. Detecting this by inspecting /proc/sys/kernel/tainted instead
>>> of scraping some magical words from the kernel log, which is driver
>>> specific, is much easier. So instead this series provides a helper which
>>> lets drivers annotate this and shows how to use this on networking
>>> drivers.
>>>
>> If the driver is able to detect that the device firmware has come back
>> alive, through user intervention or whatever, should there be a way to
>> "untaint" the kernel?  Or would you expect it to remain tainted?
> Hi Shannon
>
> In general, you don't want to be able to untained. Say a non-GPL
> licenced module is loaded, which taints the kernel. It might then try
> to untaint the kernel to hide its.

Yeah, obviously we don't want this to be abuseable.  I was just 
wondering about reversing this particular status if the broken device 
could get itself fixed.

>
> As for firmware, how much damage can the firmware do as it crashed? If
> it is a DMA master, it could of splattered stuff through
> memory. Restarting the firmware is not going to reverse the damage it
> has done.
>
True, and tho' the driver might get the thing restarted, it wouldn't 
necessarily know what kind of damage had ensued.

Carry on,
sln

