Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD35C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7614020714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 05:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="MWCn/Pa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBLFpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:45:47 -0500
Received: from scoopta.email ([198.58.106.30]:35120 "EHLO scoopta.email"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgBLFpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:45:47 -0500
DKIM-Signature: a=rsa-sha256; b=MWCn/Pa0zxDqxlxOX1MY8bc4GT/DdP0hW9gXWU22aZtfHc6KR5WMYszHtGcZ7McrdVEYTBhPCzjr94+W08n1mWVR0xtPWbUNF6QIwP8XU7U4Ke8OOGGxy82Fkm+krVfQOmFlHVclHiaVN977flxtHU9JKbkKb0T3lP85dsUpYGqsqScyEZvcPN3U/GQkt2GSD+LE+1R6AFSn2o3OoxzBCze7d8w0nlK/SFZyV3n3AIsABs/JwxkTsH5s/zzIsshpz6vKjDI2lIG1ggYSu9iSEdDYFTXTLH2hKjuiqV4kwSftg1k7KNSrxLPzxre9BQajRJoMiRMw9bW9yHNXVOCAdmYcxgKYcXfeQWUuh88kBHMYDYAPjzs8263HdYV2vpr389UyppoW75FyYOasdzEO9jhLTXziCX6YGHzpQAtrzeOyupC/VSq6FJHD6eevVRgEJzObpcLxpmSS+n1OCIpmr6ZnISNqmdKtCmeFD5/kHL71LeOG304BJGMy/HPs3OXU62fQ5Za0adujDjB4amAbTjEB0OxAhd2zHNv/Envy1n78R0XhCZErNFCH3QvcbeskBxsZSH3Apye91EoOmx/NPPd0EvCp99TreDTmUn4OsJKqwJvNQkn/ktG0yB6GzEUMfl9wdrevbO/e1jWDNP2VEos2KQpJiKj0lj3fdGxeoMwejWjePheW4Qa3E+KfOUBfYsVRoGmIorHe2elRvkdMNeKiXJxAH0eOslZxt892CZh8Ae6cPEe9LzPU4O+eWks7IaKo9McvF+4OUl3AaTJILNq4RFAuYJWOzgiXF5A1tDvClO5y55YnqVO+fiN67vOgwKITPhePbTrtzpIDBJcr2g711nE92jjZKp9iH186Fuql/R/pUrK4S4iv7tC7GkAPq9JSvVuo/Scp0J/g1SbbYxYe7oUZzBTg2bmJKXjyLHePsSOGCXeDIFGmoLZKotZe6m1vjE
 qMO2V37z3dY5Xyb39TUwyzP26RNpdKov8UYXwajmtBTUWjjp0+k6g1wJ/erPBvxyUObCBaUhWOn1qkaT9ByVXpeYtcHx6rjPzyDZUPFxuJPI4dpTGjn8omx6+S5IgN6q0QEYsaQFQ7n47F2GGtnDrAP4s2lA0ukSzKZ+szWg4vdXu/ZORMwU3T1UifIAYsuPrxqARpysrnxTCrisffnvN3xwunlmXpKIGTyQar4b7ZSxmPC9CzJPMCf07lgJmZQIMTjxSfHbdT0hQm2kIpmiFFTtI6T5QcqeK65vrpIjXN849YMkEFNdqPcZPkv+cOTd5sVJPV0Jk4wGc/o75yZ2D/+P1sCg9daenSFMjkW6CqgJayr0xiE83gqZW6bxADxzCmi44MxKq/MMAPow==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=UsV02BXq7nmf9pJOt+IZXDyj/YmLSo9ThalTDQSShu4=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2600:1700:4810:f9ef:0:0:f0c5:cafe (EHLO [IPv6:2600:1700:4810:f9ef::f0c5:cafe]) ([2600:1700:4810:f9ef:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID 583260146
          for <linux-kernel@vger.kernel.org>;
          Tue, 11 Feb 2020 21:45:47 -0800 (PST)
Subject: Re: RX 5700 XT Issues
From:   Scoopta <mlist@scoopta.email>
To:     linux-kernel@vger.kernel.org
References: <8e09f86e-b241-971a-ea8c-8948b9e06d20@scoopta.email>
Message-ID: <3b2eff03-35b0-36f4-21a7-6a117733d4ad@scoopta.email>
Date:   Tue, 11 Feb 2020 21:45:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <8e09f86e-b241-971a-ea8c-8948b9e06d20@scoopta.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My previous statement doesn't appear to be correct syslog just wasn't
being flushed despite doing an REISUB. I'm getting a powerplay error.
Specifically it seems related to
https://gitlab.freedesktop.org/drm/amd/issues/900

On 2/11/20 7:13 PM, Scoopta wrote:
> When playing demanding games my RX 5700 XT will sometimes just stop. All
> my displays turn off but the system stays responsive. Audio keeps
> working and I can REISUB no problem, the card just stops. Fans turn off
> lm-sensors reports N/A as all information on the sensors and my monitors
> go into power save. syslog is also completely quiet. amdgpu doesn't seem
> to error or anything so I have no idea how to troubleshoot if this is a
> hardware issue or if it's a driver issue. I couldn't find a drm or GPU
> specific list so I'm sending it here. I want to be sure it's not a
> driver issue or other kernel issue before doing an RMA.
>
