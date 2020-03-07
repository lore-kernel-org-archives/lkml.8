Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5C1C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370DE2051A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="mOkGDt3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCGJzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 04:55:51 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35930 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgCGJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:55:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id s1so3863424lfd.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 01:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ji/5/bt2XJ8xArwptxUIPsa40Bf1NEJkrKPYGi/BazA=;
        b=mOkGDt3zDt5ABNqQCXya1Tqs/c3KohphydAK7oT3wEo+qr98DsVY9zHJtubQ8OwgmD
         hDqKnoUNbZEG7xSHXEThQ47oxj/a/Ea3n1CL3s8Kl19qc+TVh6R8v8NFZPOMZASBE3qv
         bMxzbyIX77TxA3m4OCCKDZkowylP9h4f/9Qg/GablCJ/swiPsqDUckM2pl+nfI3+Oj3w
         AU0Z7jvUirz0Skocp/BLk7z3eX3sfE0/xzwSvQIYADlRF7utGjArjjrrYPu8QUUGoAli
         jCHQbiGivQT7xDj6//C3OAgaTkiKnnt63rShJ0sERTUhf27cM74n9i6wTzMCjOzfoXHl
         2GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ji/5/bt2XJ8xArwptxUIPsa40Bf1NEJkrKPYGi/BazA=;
        b=IKCzn8JIUvKtS8wrg++J1Oxb9P0NDnsou9IAggeaxc71guu6huVmRJlCtNC1dDcuDL
         AzEcOplvZi6SWqowUskLiEQyr9oDhrCFOgu2PRSLpeBBedz2LwLu1GuIq1+knW5qHWsH
         hxQ/kWC5SG7rBabRo26l9MiawC0aNr7yWL/fKUaOSsEph9lgOxFFML0yeHTSCpIfUqBU
         KruIrncN3JqxLgsvGBwEZ559Udw8LHshrLvIG/iw/zY9/U7WhXqHpVK0jefZjmKVK+V4
         YyVLegF0hMTjvTHM760jX2y6xEJ75wJ9m8oRF1JuWzyA33VQX+6VrMKECk7NnuDmOaqw
         B1xA==
X-Gm-Message-State: ANhLgQ0rPi5ZBAudBJHu1jl8ZI3Q7TatJWiMZk0MPpLu6/eS1uDLH0kV
        ZyGn9ULNgHRbQpy0iJr2wtXyhw==
X-Google-Smtp-Source: ADFU+vs5VZMdNVhnnQ/MNq4B4lQUnHvHzclPq0rH3MnhPTJv3B+KFGP8bulUYE8fr5KHb7cInABAEg==
X-Received: by 2002:a05:6512:246:: with SMTP id b6mr4326390lfo.175.1583574947544;
        Sat, 07 Mar 2020 01:55:47 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:402:864b:dd24:504:68eb:a9fe? ([2a00:1fa0:402:864b:dd24:504:68eb:a9fe])
        by smtp.gmail.com with ESMTPSA id z18sm14212386ljm.15.2020.03.07.01.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 01:55:45 -0800 (PST)
Subject: Re: [PATCH v4 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when present
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, Bjorn Helgaas <bhelgaas@google.com>
References: <20200306114348.5172-1-nsaenzjulienne@suse.de>
 <20200306114348.5172-4-nsaenzjulienne@suse.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <16c98273-a639-374d-e784-0d015aeee634@cogentembedded.com>
Date:   Sat, 7 Mar 2020 12:55:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306114348.5172-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.2020 14:43, Nicolas Saenz Julienne wrote:

> xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on
> RPi4's VideoCore firmware interface to be up and running. It's possible
> for both initializations to race, so make sure it's available prior
> starting.

     Prior to starting?

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
[...]

MBR, Sergei
