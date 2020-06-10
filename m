Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2338DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D4C2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="OvZsfnmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgFJJVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFJJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:21:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3AEC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:21:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a25so1584091ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=23+iiOsH90npQiNR3ps23JQX9xIarhkMtgHXf80ZkjI=;
        b=OvZsfnmWeMFppV30C8OmPnNPBh8H3qR7jm2JTDO+Z+5ieP0haoDESFItogxILEfrRE
         p0wwUO+37uofpeY56pts1TIRdwk6C47pt3HpCJLpv8roUkr5Hp0WcB/7iqEIRE9Id5KE
         8ySDsiLxLjoLkK+cV+ZJWC0DbHa2yA5T71GO+jGXF1lQk+NX0Zy5qSZqNZrcNTzO3Rsb
         1MesZs0DMGC0sIz95KWpGVODAF0IDc3uL9v4HbvlCRt/yMgKVnjXK+LvUrKskLHUcIvU
         VQgrUer2Y3+NJ0lUBpveu+DvRVlHNW69SKoLmuPAEQ3ejgMYvVYrIjKYtr6nFBfjN3zG
         8A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=23+iiOsH90npQiNR3ps23JQX9xIarhkMtgHXf80ZkjI=;
        b=AUN0vKQVx225FjHqsCbXGYo8JUxCgr+kwEmqxorDTW0vrYdoKEWvG99U4W45ac9WXg
         NdwcBLcLaumSv7ZxBb2PCUBBTzwNJET3SRtK4wZGpo0AjTy5p/QBB/acFtOl6dPtwJe2
         ATjWu10S0twLor47q4XZHWx43IEpIjHEIWSY+M4cQZLk/2N3+jkXJLN4FuPhqVHsHU8z
         wEuqL71VnSP7W4nNPobnRNOklSQ5EQJCjY/B0wROdvhf0mASTSj9nDYGmxl5Qaslxx7x
         9ACt5fiwSSiN0y9zwWJRJ2hKnzpiPdJ6as74sgib4JXSxU7D/bVyy97ol/tZZZtRLTbi
         Vm/w==
X-Gm-Message-State: AOAM530mwy+ba+HvaOJpM5lqFM6tjK//PGrMzoYz6SFZYzJLts1kdMRo
        ThbWyhz0M+6cAmr2JVVcllu4t/RPyotwZg==
X-Google-Smtp-Source: ABdhPJy7mSTt4o8mEJOvvz/shV15r9ISy8PzaErKT4YGXs2IXm8khPEYLvIgs+gCZp86ZDeL/jGYIw==
X-Received: by 2002:a05:651c:1199:: with SMTP id w25mr1306889ljo.301.1591780891032;
        Wed, 10 Jun 2020 02:21:31 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8b6:350a:b96f:7066:1c4d:ff8d? ([2a00:1fa0:8b6:350a:b96f:7066:1c4d:ff8d])
        by smtp.gmail.com with ESMTPSA id o18sm4849528ljd.32.2020.06.10.02.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 02:21:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] USB: hub: Suspend and resume port with LPM enabled
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Qi Zhou <atmgnd@outlook.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        Keiya Nobuta <nobuta.keiya@fujitsu.com>,
        Jason Yan <yanaijie@huawei.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200610064231.9454-1-kai.heng.feng@canonical.com>
 <20200610064231.9454-2-kai.heng.feng@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <a6a241d4-309d-c022-b61b-050b90471324@cogentembedded.com>
Date:   Wed, 10 Jun 2020 12:21:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610064231.9454-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10.06.2020 9:42, Kai-Heng Feng wrote:

> USB2 devices with LPM enabled may interrupt the system suspend:
> [  932.510475] usb 1-7: usb suspend, wakeup 0
> [  932.510549] hub 1-0:1.0: hub_suspend
> [  932.510581] usb usb1: bus suspend, wakeup 0
> [  932.510590] xhci_hcd 0000:00:14.0: port 9 not suspended
> [  932.510593] xhci_hcd 0000:00:14.0: port 8 not suspended
> ..
> [  932.520323] xhci_hcd 0000:00:14.0: Port change event, 1-7, id 7, portsc: 0x400e03
> ..
> [  932.591405] PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
> [  932.591414] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x160 returns -16
> [  932.591418] PM: Device 0000:00:14.0 failed to suspend async: error -16
> 
> During system suspend, USB core will let HC suspends the device if it

    Suspend. Perhaps can be fixed while applying...

> doesn't have remote wakeup enabled and doesn't have any children.
> However, from the log above we can see that the usb 1-7 doesn't get bus
> suspended due to not in U0, because it requires a longer period for
> disabling LPM. After a while the port finished its U2 -> U0 transition,
> interrupts the suspend process.
> 
> Though PLC shouldn't be set for U2 -> U0 case, we can avoid all that by
> directly put the port from U0/U1/U2 to U3, and solves this issue.
            ^ putting                            ^ it?

> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
[...]

MBR, Sergei
