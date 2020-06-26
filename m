Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1E920775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWtBfBfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgFZEmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgFZEmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:42:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFDBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:42:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ev7so3672105pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5M813YvuJieEDP4a9Z2+gybtWlsFlkFhEJWEismxLNs=;
        b=NWtBfBfPK9k34yyIX9HDNylkri3oVVAfHP7KxyiHdgrwgc/YxOIe5vX8AqDQLdieHB
         t+3fUwET34a1JXvPmviLu3Th1qmrBYMJInH9/UM+O7FKN4lbCa6+MWAsDB+RudYJjL9c
         3PVTQQSHKsWTZW2yMP1QknGAb9nN0f6urnq2r30l8ocdFxC+CK931jylbENEF1WkdwuA
         Bf9yyMJhBZuQOjrF3152Rr41ZDLoVmRJo0LHjPoCNig1mVMVFnGfw1bC2z3/TnIvoeVH
         KEWSBH1Rxxvz9jWvjiyDPrm+GtthiEh3WBXVz+9cD1+R68STF2Y6TJNrTXASbTZ7zDrC
         HsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5M813YvuJieEDP4a9Z2+gybtWlsFlkFhEJWEismxLNs=;
        b=WBOIALy4iOANSPAqgxYP+qk4Aph7MBSeFaS6PxBpo01RQHKkMgKQTS6S5CBOQ7s2fb
         0H9wqU45M6Z4eYWE/ItYV61+//biHzXB4PxFm5xe2gprPhnz2Szm0+v1jO++2giVMII0
         LnBMj5yAkRIVAtLYsUmd+9R18/K9iTfX26XMWBo1NSMi3O6ST0SQSRAvw7SvdmYnaRRz
         2XaBpYW8f+yQARp4XBYoZE7N3dpZiW4WiQgFA8Afp1tJUPnmlPHKPiFZHnxduQWM+8/w
         vZm2XXZJ5v+sXKnDBS9ut6g9Un4ycoG5vR9+Gt3G76pUZw40GSiAmflSMSMxjZvhwseD
         APvg==
X-Gm-Message-State: AOAM531zB7TqDb05ncWD1ytMUXc4G/sOuzXlurkLouizbudUbYyLgNLk
        aZ94Bqxmy4lr+jQIoivM7Fzc5ZWW
X-Google-Smtp-Source: ABdhPJxL4AxHF15+3fLgjhqgR0HQKZfo/67R02YJmt5ZBPIFh3VoarAdj+sxhmyjJhS5X0ZZ07lfhg==
X-Received: by 2002:a17:90a:d244:: with SMTP id o4mr1408016pjw.186.1593146520996;
        Thu, 25 Jun 2020 21:42:00 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id x7sm2109771pfq.197.2020.06.25.21.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 21:41:59 -0700 (PDT)
Subject: Re: [fedora-arm] Banana Pi-R1 - kernel 5.6.0 and later broken - b43
 DSA
To:     Peter Robinson <pbrobinson@gmail.com>,
        Gerhard Wiesinger <lists@wiesinger.com>
Cc:     arm@lists.fedoraproject.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, filbar@centrum.cz
References: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
 <CALeDE9N0gbYRKbmoPYF73VNr=Q9UetP+fpYFbhWfVsUZL+GkWA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8e2040e2-9faa-cd95-c474-eb2fa2c7c6c0@gmail.com>
Date:   Thu, 25 Jun 2020 21:41:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALeDE9N0gbYRKbmoPYF73VNr=Q9UetP+fpYFbhWfVsUZL+GkWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/2020 4:23 PM, Peter Robinson wrote:
>> I'm having troubles with the Banana Pi-R1 router with newer kernels. No
>> config changes, config works well since a lot of lernel updates ...
>> Banana Pi-R1 is configured via systemd-networkd and uses the DSA
>> (Distributed Switch Architecture) with b53 switch. No visible difference
>> in interfaces, vlan config, bridge config, etc. Looks like actual
>> configuration in the switch in the hardware is broken.
>>
>> # OK: Last good known version (booting that version is also ok)
>> Linux bpi 5.5.18-200.fc31.armv7hl #1 SMP Fri Apr 17 17:25:00 UTC 2020
>> armv7l armv7l armv7l GNU/Linux
>>
>> # NOK: no network
>> Linux bpi 5.6.8-200.fc31.armv7hl #1 SMP Wed Apr 29 19:05:06 UTC 2020
>> armv7l armv7l armv7l GNU/Linux
>>
>> # NOK: no network
>> Linux bpi 5.6.0-300.fc32.armv7hl #1 SMP Mon Mar 30 16:37:50 UTC 2020
>> armv7l armv7l armv7l GNU/Linux
>>
>> # NOK: no network
>> Linux bpi 5.6.19-200.fc31.armv7hl #1 SMP Wed Jun 17 17:10:22 UTC 2020
>> armv7l armv7l armv7l GNU/Linux
>>
>> # NOK: no network
>> Linux bpi 5.7.4-200.fc32.armv7hl #1 SMP Fri Jun 19 00:52:22 UTC 2020
>> armv7l armv7l armv7l GNU/Linux
>>
>>
>> Saw that there were a lot of changes in the near past in the b53 driver:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/dsa/b53?h=v5.8-rc1+
> 
> So from your notes above it looks like something regressed between the
> 5.5.x series and the 5.6.0 release? If so I'm not sure what the
> context of the changed in 5.8 are here. If there's more changes to the
> driver in 5.8 dev cycle have you tried one of the Fedora rawhide 5.8
> rc1 or rc2 kernel builds to see if that resolves it?

See my response to Gerhard, there are changes expected to how the
network configuration should be done after:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fab459e69abfd04a66d76423d18ba853fced4ab

> 
> Failing that looking for the change in the 5.6 cycle would likely be
> the better bet so we can work out what broke it and report it to the
> upstream driver maintainer. Have you searched to see if others are
> seeing a similar issue or have reported a similar issue upstream?
> 

Gerhard is doing exactly this with his email.
-- 
Florian
