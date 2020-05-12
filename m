Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B27C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE02206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbIhMlki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbgELU3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:29:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FA8C061A0C;
        Tue, 12 May 2020 13:29:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so17487248wrn.6;
        Tue, 12 May 2020 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hj9oLR6epPx2P7OTgcVV89Q5gnN8De7ZEoi4iCaFpls=;
        b=PbIhMlkiv+0EJ1IWuEDTuu6sTgYOiQH+dgGbu8dShMqnJC8TqE5spRyGL7iH5wvcuw
         IOFjlLOa6tM5bg/tf+9DFsP/WI0p3PRNhpA3Ln73pRrYUkzMNyT9uJwb3yU++rybhq44
         Tse34Rejr7Nn7CDT42ynduXF8nFPzUpqrpDqfCskWNvNjGZZ7YSp9fgcR87vAq/KgYOk
         l1ZuT6qMtOmdCj35pIsNdGfARo+E4daiRmb9jFE0NZ7fqQ4Et0Pxb4V2Eu/d+LFczSGj
         mp7w6xg/kHZabilVSJPk29isNQLy2McYScGlW325nLskpwezYfbuxOQjI9DBpTsNAbd8
         RW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hj9oLR6epPx2P7OTgcVV89Q5gnN8De7ZEoi4iCaFpls=;
        b=Z1Yv8m8VeuXtYUv3fGM+AlsRljSp+vTwYxEob0vwKjUUs21rNDWmygd0S9WLynTlkB
         0dCj8usznYH8Q3/MpaowBo8L2O08x9CPzBM/pJIMg1uC0BkW4b5SbqW8rRjQhVzISXul
         B/JvfEyWyZV256GLR2THwRhrDbJmp+khqWGgJseQeZCsbRsbX3TxUuz9qVX4qZmWmyl9
         K0JPtJhlWzb4B8SsP1NmEj8K+RSQsnX53S/oVOPpjbrgdyuTAstchlswLjvVdCz6kwAd
         6G4a316dlBuKOURphrgxuzTQLzVf3isrV4qMPW6ZUBwqOBtrh+KxDNx6UTJdWrsg5TEW
         mu4w==
X-Gm-Message-State: AGi0PuZnxUpWdfu/xVxJQw2oA9Wz8xbez6t4XWYKkYuy9xFnoa+deHiu
        ep+N+j+TwDlbT5y2dqF7wFs4CeTx
X-Google-Smtp-Source: APiQypLp1SW7rRRIFz0yl7+YFwI3Hvq6ReSgeUhLPwHtCaEHDZ7E1AmVj9RCFvmy5n6Zte6GMLhMhA==
X-Received: by 2002:a5d:408b:: with SMTP id o11mr25401159wrp.97.1589315349701;
        Tue, 12 May 2020 13:29:09 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z7sm24359351wrl.88.2020.05.12.13.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 13:29:08 -0700 (PDT)
Subject: Re: stable/linux-4.4.y bisection: baseline.login on
 at91-sama5d4_xplained
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <5eb8399a.1c69fb81.c5a60.8316@mx.google.com>
 <2db7e52e-86ae-7c87-1782-8c0cafcbadd8@collabora.com>
 <20200512111059.GA34497@piout.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <980597f7-5170-72f2-ec2f-efc64f5e27eb@gmail.com>
Date:   Tue, 12 May 2020 13:29:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512111059.GA34497@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2020 4:10 AM, Alexandre Belloni wrote:
> Hi,
> 
> On 12/05/2020 06:54:29+0100, Guillaume Tucker wrote:
>> Please see the bisection report below about a boot failure.
>>
>> Reports aren't automatically sent to the public while we're
>> trialing new bisection features on kernelci.org but this one
>> looks valid.
>>
>> It appears to be due to the fact that the network interface is
>> failing to get brought up:
>>
>> [  114.385000] Waiting up to 10 more seconds for network.
>> [  124.355000] Sending DHCP requests ...#
>> ..#
>> .#
>>  timed out!
>> [  212.355000] IP-Config: Reopening network devices...
>> [  212.365000] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> #
>>
>>
>> I guess the board would boot fine without network if it didn't
>> have ip=dhcp in the command line, so it's not strictly a kernel
>> boot failure but still an ethernet issue.
>>
> 
> I think the resolution of this issue is
> 99f81afc139c6edd14d77a91ee91685a414a1c66. If this is taken, then I think
> f5aba91d7f186cba84af966a741a0346de603cd4 should also be backported.

Agreed.
-- 
Florian
