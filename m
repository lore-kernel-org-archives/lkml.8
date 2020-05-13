Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7476C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76BE20690
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxyVei8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgEMPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgEMPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:08:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B522C061A0C;
        Wed, 13 May 2020 08:08:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so12427376wrc.8;
        Wed, 13 May 2020 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VWRAGlUE58pZzy9cngU2gBHWI6hRPV4qJAq7Js3hLQM=;
        b=fxyVei8o92xYp2W45MEq20WpAtKItN0ZVI7QCX5zuer5dPU9RXHubrZZy5Sqpbg0RA
         SWodfxZ6paK8plPL7t0ef8pbtVKpGxKuJKI3oZEPbYmWWQkgxszW7o/lwSxBDqbu4chh
         5HciRUbHnUs8+x8jkF02JjdKMU7cE+A4OLw9b5cEp3SnhFGZ3RcyzmVKlNRhEHIEB3Hq
         aRzanvuLRkllUfK1HVQrm+lhdOFvi+VXzAKdanzgfbmuIWlE2qjV3D/cwXMHk90B9N69
         QmL+s5rlN6oNJzPqR8bDCB8fY4FsYP0j3RS9hLA57cP/SGmF7aGJ7VjwAc32wtt22tt1
         yrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VWRAGlUE58pZzy9cngU2gBHWI6hRPV4qJAq7Js3hLQM=;
        b=TLy18P05UJbQ1/JoGYJPil4YolWG+2MDhXXU+OiFEsYtbDHkMuSxbD5/rOfNW6Fyas
         GMuRkesmw+vvP/eSVlNtmf1MndQ3gKvST/JQmoiC5M0cEm7ueyeW2GAlcX+YarGbs+wh
         qmOqm0+R6pHJJ+lGPgladUa/KizaUvsjPnOp1GVlLgENyvzixHyb056U1lWY0lCqXQGL
         EqzkfiPQ/tiSLMUCRMpoRzmtqSCU+nd42BfgudAJXukzYFHnlVRzM3MR6vAkYKs/Pkdr
         +iKM93Vd1R4skHnJyqD0CIFhabyVvd5zmpOJCVBa+BKG8kvBciAMFe6vyrnmXW1QwSpS
         8mhw==
X-Gm-Message-State: AGi0PuYf0XzdfVyyQFjacGNWZx7FZFt16UlEQd3NtP2PPcF0H2p97hbO
        ACExQyR8OmHywDea0cUNUQs=
X-Google-Smtp-Source: APiQypLXg8ASZd+iA6265bHQHLtl29lOt/lFKSif4O+rOT+hi1gYBRKHdy6OxMxG+9OmQlKS1XYZtw==
X-Received: by 2002:adf:b301:: with SMTP id j1mr30897749wrd.221.1589382491668;
        Wed, 13 May 2020 08:08:11 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r9sm19085526wmg.47.2020.05.13.08.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 08:08:10 -0700 (PDT)
Subject: Re: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the
 Makefile
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200512150019.25903-1-alcooperx@gmail.com>
 <20200512150019.25903-2-alcooperx@gmail.com>
 <20200513122613.GA1023594@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7acc2a4c-caab-11e7-7b3f-4176f19c58cf@gmail.com>
Date:   Wed, 13 May 2020 08:08:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513122613.GA1023594@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2020 5:26 AM, Greg Kroah-Hartman wrote:
> On Tue, May 12, 2020 at 11:00:15AM -0400, Al Cooper wrote:
>> Some BRCMSTB USB chips have an XHCI, EHCI and OHCI controller
>> on the same port where XHCI handles 3.0 devices, EHCI handles 2.0
>> devices and OHCI handles <2.0 devices. Currently the Makefile
>> has XHCI linking at the bottom which will result in the XHIC driver
>> initalizing after the EHCI and OHCI drivers and any installed 3.0
>> device will be seen as a 2.0 device. Moving the XHCI linking
>> above the EHCI and OHCI linking fixes the issue.
> 
> What happens if all of these are modules and they are loaded in a
> different order?  This makefile change will not help with that, you need
> to have logic in the code in order to properly coordinate this type of
> mess, sorry.

I believe we should be using module soft dependencies to instruct the
module loaders to load the modules in the correct order, so something
like this would do (not tested) for xhci-plat-hcd.c:

MODULE_SOFTDEP("post: ehci-hcd ohci-hcd");

and I am not sure whether we need to add the opposite for ehci-hcd and
ohci-hcd:

MODULE_SOFTDEP("pre: xhci-plat-hcd");

Al, do you want to test that?
-- 
Florian
