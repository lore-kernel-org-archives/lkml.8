Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561FB206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 21:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuyjF4Lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgFUVKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 17:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbgFUVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 17:10:19 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E1C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 14:10:19 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r77so17406041ior.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SHsMfbTuB0Yetl9MiFWs6G1FL4YmCPukTkLx9wtrZzg=;
        b=AuyjF4Lq+gAU+oU6NBSLWlkS1kLJJgZYgffbJVDrjjkGVjdJwh468Led5Vi51GwdOg
         J5v5yJa/bfQVTumRebDnVNNXRAg4hkzyYV+gGCkO7nTqIUpEDr3fJoL0dZqIK04CPdJ8
         HlUF02/ju7WeXIV1GMeA5PtarMO6BFZkEkvndMs7/e4xhlu2aRZMmlq/UJVgkA3pQwWP
         YMNYCVjfzD5qVlbZ3hy7g7xImE3kvVeAWMo/4cSkoTiLPZGpz9IIHxTe9GpAIFj/kOtg
         nHBR9HYNj08iZYQvHF0HV2MBuGrz1/2enXRvcNvQrNgmUdwzJBt+mhAtFCkJWak7Qf5V
         uWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SHsMfbTuB0Yetl9MiFWs6G1FL4YmCPukTkLx9wtrZzg=;
        b=XOCReuhmVizjO4rWCbH2vhHzWaQyb6c+StNidxIOz6pdAOn3i48V+a4BT0E7vSRbpE
         KBA4SKlCjpouN3jypvTsOcbME2CkzlEJgK1OyqhOeEiq28Nev888Q34wYqBSI6tXqN1K
         +eJDSnWBkJ/1x7wPhoM+fQbeJO0/wePtCh780NX/lVd6jTcdgPwTl9CMw9MAXsqheG2N
         IVQ92bTiw0EeW/vmUvkZ8HZGA4FkVGuuk5hohIBfycSmv8iyZUQOpS+qjKMeMNv7Q2NM
         65Tc9GVwVUMQhr//k46chdwLZ0rhqLHHcj+4y7xPxSk6k8DwOD+RSGx9dHOngG4oe0Cf
         +T7A==
X-Gm-Message-State: AOAM531nkSPBsILoAvadkvd0BHSkg4FsVTeDrYPc08Yp5VWcZ5ToGBJg
        nRacIehw9l4aUQDt/rietZs=
X-Google-Smtp-Source: ABdhPJwNTH2zPKBGmRBZwtm1j7fFxM13AFcmUyFfFoyiwQjWD8O6pNaPzX6WM+RsDOLQGdn12JqXVA==
X-Received: by 2002:a05:6602:2c8b:: with SMTP id i11mr16021438iow.139.1592773818542;
        Sun, 21 Jun 2020 14:10:18 -0700 (PDT)
Received: from [192.168.1.2] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.googlemail.com with ESMTPSA id y2sm6815433ilg.69.2020.06.21.14.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 14:10:17 -0700 (PDT)
Subject: Re: Banana Pi-R1 - kernel 5.6.0 and later broken - b43 DSA
To:     Gerhard Wiesinger <lists@wiesinger.com>,
        arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, filbar@centrum.cz
References: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
 <12ed4a27-7773-98c4-c8ba-f9b0d53a5b5f@gmail.com>
 <6495b781-03a1-c655-90b2-71fe984ef02f@wiesinger.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <002b144c-3e71-4418-3a6b-ee17c2ce6b38@gmail.com>
Date:   Sun, 21 Jun 2020 14:10:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6495b781-03a1-c655-90b2-71fe984ef02f@wiesinger.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2020-06-20 à 12:37, Gerhard Wiesinger a écrit :
> Hello Florian,
> 
> On 20.06.2020 21:13, Florian Fainelli wrote:
>> Hi,
>>
>> On 6/20/2020 10:39 AM, Gerhard Wiesinger wrote:
>> Can you share your network configuration again with me? 
> 
> Find the network config below.
> 
> 
>>> # OK: Last good known version (booting that version is also ok)
>>> Linux bpi 5.5.18-200.fc31.armv7hl #1 SMP Fri Apr 17 17:25:00 UTC 2020
>>> armv7l armv7l armv7l GNU/Linux
>> OK, I suspect what has changed is this commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fab459e69abfd04a66d76423d18ba853fced4ab
>>
>>
>> which, if I remember your configuration correctly means that you now
>> have proper DSA interfaces and so all of the wan, lan1-lan4 interfaces
>> can now run a proper networking stack unlike before where you had to do
>> this via the DSA master network device (eth0). This also means that you
>> should run your DHCP server/client on the bridge master network device
>> now.
> 
> Yes, config should be a proper DSA config, see also below. IP config is
> only on brlan and brwan.
> 
> Do the changes need a config change?
> e.g. net: dsa: b53: Ensure the default VID is untagged
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/dsa/b53?id=d965a5432d4c3e6b9c3d2bc1d4a800013bbf76f6
> 

No that change does not require a configuration change, the one I
mentioned does, you should only have a single bridge for all LAN ports
and no bridge for the WAN port and no VLAN is necessary since now that
Broadcom tags are enabled, Linux can properly determine which source and
destination port should be used.

Please try that and let me know how it goes.
-- 
Florian
