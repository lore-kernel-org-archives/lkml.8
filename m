Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F218AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1357207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590512648;
	bh=AuFDlGZ/rFo60Evf91roy2vYjYwcToc0s7UD6ERFQKs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=of11WMIoG2h3pxieIWJ6wMHeL9rZqOuUDL0i9d4O2+U7Ukog3/WFFiZLGfNNLAPLx
	 7T4up79nGwx4D0vQkcQc0Idi0I0Lp0e27Xhg6fLpik5J6bKS43+fhYrK1A5Jagvp1m
	 JSHUZKVmQz3NQ4X3pENWZUa00TmzjAN390dZfLe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgEZREH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgEZREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:04:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB9C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:04:03 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h7so16912352otr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=idqAGq8yEwBR+jLINoFt7Pcxj9d16RoO05tTkFIy7FU=;
        b=GqPRtdYD4DGriNYt3Mu6pzmG4m69ZL5CVNo+NeMzIyWs8tzYNWssDmrg/ZfvbrCSHl
         9oy+eFrp1nZVqRx97rWIQa4J/FBUM31MClVlprO+qNitxzUdogorF+vkmuDwAvpP8TnJ
         nfFlcU6Rwdpphcy+NfTRgAJiG3qgdRXmsfn+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=idqAGq8yEwBR+jLINoFt7Pcxj9d16RoO05tTkFIy7FU=;
        b=Bh4N2H79Wj/+G/8pvsLPzSayF0JzifOLkqzf79gb6PQ625ETIocRClPpMOZy/1H2fW
         JjNDjY3WRZ8QMkDdU45kdWCVQNDJJSWaLRCkA1YUtlNSuiG6/YNgySSyIqviuDIz4anT
         6k+HWj9IRcMyIfNQHKDpIyP6YtLLN7L74wxW/0Xqdlk++5K4oRgIxB2lpXQc1CtOyF1V
         MP/2kJVOdJitZDOqC2UdQwKl/HiA3tFWEPzSNEmr86HZVtjeOQ7rK93hcCQkS06Kl0Pm
         xj0hM2AnLCj/scOexcPE4CEYsSAXrD7dWssEmQUsKejrHD5jbb83Y9G+Ii8yiESdNO6j
         vIAw==
X-Gm-Message-State: AOAM531htBAlPMsO25CgMdgogxWB36HhuaGG9BxKtcbrjKG5qMQVWKqM
        V6S0+kB86NMub3oqfDHVat2yEtib1x4=
X-Google-Smtp-Source: ABdhPJzzrk9mKNTRt6RMN9+LJdY6+6Z5gBxWLmvGvngAcgjcT0nDemnBCIl0wVvAzwRRzbX5Ug5p1g==
X-Received: by 2002:a9d:2f07:: with SMTP id h7mr1520572otb.32.1590512642774;
        Tue, 26 May 2020 10:04:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g6sm86463otj.6.2020.05.26.10.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 10:04:02 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
To:     Joe Perches <joe@perches.com>, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
 <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <661f53a3-b15c-76b0-f220-0d292b0843d5@linuxfoundation.org>
Date:   Tue, 26 May 2020 11:04:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 8:26 PM, Joe Perches wrote:
> On Fri, 2020-05-22 at 20:19 -0600, Shuah Khan wrote:
>> get_maintainer.pl picks only the first email address found in the file.
>> Reorder my email addresses so it finds my linuxfoundation.org email.
> 
> OK.
> 
> btw:  --noremove-duplicates is also an option.  For instance:
> 
> $ ./scripts/get_maintainer.pl -f Documentation/usb/usbip_protocol.rst
> Valentina Manea <valentina.manea.m@gmail.com> (maintainer:USB OVER IP DRIVER)
> Shuah Khan <shuah@kernel.org> (maintainer:USB OVER IP DRIVER)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> linux-usb@vger.kernel.org (open list:USB OVER IP DRIVER)
> linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> linux-kernel@vger.kernel.org (open list)
> 
> vs:
> 
> $ ./scripts/get_maintainer.pl --noremove-duplicates -f Documentation/usb/usbip_protocol.rst
> Valentina Manea <valentina.manea.m@gmail.com> (maintainer:USB OVER IP DRIVER)
> Shuah Khan <shuah@kernel.org> (maintainer:USB OVER IP DRIVER)
> Shuah Khan <skhan@linuxfoundation.org> (maintainer:USB OVER IP DRIVER)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> linux-usb@vger.kernel.org (open list:USB OVER IP DRIVER)
> linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> linux-kernel@vger.kernel.org (open list)
> 

Sadly, people that don't run get_maintainer.pl, leave alone running it
with --noremove-duplicates option. So your suggestion doesn't really
help me.

My preference is to get patches to both Inboxes if possible which isn't
possible unless -noremove-duplicate is default. Having this option as
default probably will annoy lot of people . So I am not asking for
that.

That being said, I don't understand your comment. Are you recommending
using just one email in these entries?

thanks,
-- Shuah
