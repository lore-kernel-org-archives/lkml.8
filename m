Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A70C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDF424958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="pDY0Fio+";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="pDY0Fio+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgEHOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:22:25 -0400
Received: from node.akkea.ca ([192.155.83.177]:42034 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:22:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id A53EE4E2006;
        Fri,  8 May 2020 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1588947744; bh=0jec+jyyIGui6THZvYPbXVUAbTgjEq58la8/fReMJWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=pDY0Fio+N/ZYSgp4G4IWyN95erGxxsyJfMdlBlOBX8vIOX5l5lTiFQQKwW32teAun
         q7OLwm17UjAt7C49CYljidwoSF/byO56pNx3TC0iMsQhB6FV/GQvtvXDh+xmycEid7
         qjf/tAdA31ybShvUeoJgF8A0c2SK8ZZbBc2lzfmc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nL4lATXDCIRE; Fri,  8 May 2020 14:22:24 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 0751C4E2003;
        Fri,  8 May 2020 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1588947744; bh=0jec+jyyIGui6THZvYPbXVUAbTgjEq58la8/fReMJWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=pDY0Fio+N/ZYSgp4G4IWyN95erGxxsyJfMdlBlOBX8vIOX5l5lTiFQQKwW32teAun
         q7OLwm17UjAt7C49CYljidwoSF/byO56pNx3TC0iMsQhB6FV/GQvtvXDh+xmycEid7
         qjf/tAdA31ybShvUeoJgF8A0c2SK8ZZbBc2lzfmc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 May 2020 07:22:24 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     robh+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org, linux-usb-owner@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add TI tps6598x DT binding and probe
In-Reply-To: <20200508140132.GA1264047@kuha.fi.intel.com>
References: <20200507214733.1982696-1-bryan.odonoghue@linaro.org>
 <20200508140132.GA1264047@kuha.fi.intel.com>
Message-ID: <e1f5fac00b4d574edf187f2ccd19ebe2@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-05-08 07:01, Heikki Krogerus wrote:
> Hi,
> 
> On Thu, May 07, 2020 at 10:47:31PM +0100, Bryan O'Donoghue wrote:
>> V2:
>> - Put myself down as sole schema maintainer as suggested - Andy
>> - Fixed whitespace typo - Andy
>> - Removed ifdef and of_match_ptr() - Andy
>> 
>> V1:
>> This simple series adds DT binding yaml and a DT lookup table for the
>> tps6598x.
>> 
>> Its possible to use i2c id_table to match the 'compatible = 
>> "ti,tps6598x"
>> and probe that way, however I think it is worthwhile adding a specific 
>> OF
>> way of doing it and having an accompanying yaml as an example.
>> 
>> Bryan O'Donoghue (2):
>>   dt-bindings: usb: Add TI tps6598x device tree binding documentation
>>   usb: typec: tps6598x: Add OF probe binding
>> 
>>  .../devicetree/bindings/usb/ti,tps6598x.yaml  | 64 
>> +++++++++++++++++++
>>  drivers/usb/typec/tps6598x.c                  |  7 ++
>>  2 files changed, 71 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> 
> There was already a series from Angus [1] for this. The bindings
> looked a bit different, but I think we should use these, because in
> the DT bindings from Angus there appeared to be definitions for OF
> graph that was not used. Or maybe I got it wrong?
> 

I was trying to include optional components but was not sure of the 
syntax so that might have been wrong.

> Angus, is it OK if we use these patches instead the ones from you?
> 

Yeah these ones will work great for what we need.

Sorry Bryan I didn't realize there was a patch already in progress.

@Bryan, I'm going to send up some extcon patches for the tps6598x soon 
but maybe I should check and make sure you don't already have anything 
planned there.

It still needs to be retested after cleaning up but it's the top 9 
patches here:

https://source.puri.sm/angus.ainslie/linux-next/-/commits/next/extcon

Thanks
Angus

> [1] 
> https://lore.kernel.org/linux-usb/20200506191718.2144752-1-angus@akkea.ca/
> 
> thanks,
