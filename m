Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SHORT_URL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235AC221E8
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgIJJ7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:59:25 -0400
Received: from marcansoft.com ([212.63.210.85]:48630 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbgIJJ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:58:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1551E419AD;
        Thu, 10 Sep 2020 09:57:49 +0000 (UTC)
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     James Hilliard <james.hilliard1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Lars Melin <larsm17@gmail.com>,
        Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de>
 <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
 <20200910080850.GD24441@localhost>
 <CADvTj4rDdj8KtLhGZEZP+XZcF4DTE4oW9sNf=zNWaRPzkny93A@mail.gmail.com>
 <20200910085541.GA1099591@kroah.com>
 <CADvTj4pYR9H1X1_f4DYTkb5ViXAdx9sO5yBgHgM5vFaDMs_miQ@mail.gmail.com>
From:   Hector Martin <hector@marcansoft.com>
Message-ID: <26a723e4-e166-6377-875a-f737a15dc6b1@marcansoft.com>
Date:   Thu, 10 Sep 2020 18:57:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CADvTj4pYR9H1X1_f4DYTkb5ViXAdx9sO5yBgHgM5vFaDMs_miQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2020 18.52, James Hilliard wrote:
> So I'm having trouble coming up with a reliable way to fix this in userspace,
> I've already got quite a few moving parts there as is and most of what I
> come up with seems like it would not work reliably, at least for automatically
> repairing the eeprom.

I'm confused as to why this is hard to fix in userspace. You already 
said you have userspace code binding to the proper VID/PID, so your code 
won't find the bricked device. Then it's just a matter of having a udev 
rule run the unbricker when it detects the bad device (which should 
issue a USB reset when it's done reprogramming, making the device appear 
as the right VID/PID), thus effectively doing the same thing the kernel 
does. If this is embedded and not using udev, then substitute whatever 
equivalent you have. If you're polling for the device at runtime instead 
and don't have a device manager, just poll for the VID 0 device too and 
apply the fix.

I can't think of a scenario where this would be difficult to fix in 
userspace...

-- 
Hector Martin (hector@marcansoft.com)
Public Key: https://mrcn.st/pub
