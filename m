Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75659C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406A921473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="EcEz/cx8";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Ave0rTF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEHQVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:21:45 -0400
Received: from node.akkea.ca ([192.155.83.177]:46260 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHQVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:21:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id F29744E2006;
        Fri,  8 May 2020 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1588954905; bh=qqdGiit1A1ccKcGEq/kEAeFk1oJVjJOp1JpLW3iPgxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=EcEz/cx8BIEt8g5kbz5qjUYua8PdPr1kRcZFGDkxhKwVBXGipdekwAYgv7zJrA+fg
         8ti4UQEExgK9xnWe4SjlPmYcOCWxMkFjwE5EjWGvRofc9pz8TUGyKKvASPtlX6RMkJ
         StuJjEvevvAnfx7rUdYlUMEvhho1Wmp6glqtv7pE=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id otSJD3v_rQyi; Fri,  8 May 2020 16:21:44 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 795CD4E2003;
        Fri,  8 May 2020 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1588954904; bh=qqdGiit1A1ccKcGEq/kEAeFk1oJVjJOp1JpLW3iPgxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Ave0rTF2XK1n8ErShLXUs856x+F7uVJIMGvA8OkgznGBlhzLyllEHxJpVjhXmobEA
         qI/OWB9ZTO1xL4o3GnxpxoB9xyJV5Co2e4OrBwNqmyIBsCvN1Na9TEyqvbIJjPVJ+Y
         0AFFgjip53RVimkzt/+RtnWJqlFGsCqA0QYH3a4A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 May 2020 09:21:44 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org, linux-usb-owner@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add TI tps6598x DT binding and probe
In-Reply-To: <f6bd2b0b-1eda-8ea4-abf2-e17131b944d4@linaro.org>
References: <20200507214733.1982696-1-bryan.odonoghue@linaro.org>
 <20200508140132.GA1264047@kuha.fi.intel.com>
 <e1f5fac00b4d574edf187f2ccd19ebe2@akkea.ca>
 <f6bd2b0b-1eda-8ea4-abf2-e17131b944d4@linaro.org>
Message-ID: <943b6c3fabcfc5da8e2ee170a5d6144b@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-08 07:47, Bryan O'Donoghue wrote:
> On 08/05/2020 15:22, Angus Ainslie wrote:
>> Hi,
>> 
>> On 2020-05-08 07:01, Heikki Krogerus wrote:
>> 
>>> Angus, is it OK if we use these patches instead the ones from you?
>>> 
>> 
>> Yeah these ones will work great for what we need.
>> 
>> Sorry Bryan I didn't realize there was a patch already in progress.
>> 
>> @Bryan, I'm going to send up some extcon patches for the tps6598x soon 
>> but maybe I should check and make sure you don't already have anything 
>> planned there.
>> 
>> It still needs to be retested after cleaning up but it's the top 9 
>> patches here:
>> 
>> https://source.puri.sm/angus.ainslie/linux-next/-/commits/next/extcon
> 
> Makes me glad I didn't try to touch the PDO stuff :)
> 
> That series looks fine to me.
> 
> The only other modification I have is here.
> 
> https://lore.kernel.org/linux-usb/20200507215938.1983363-2-bryan.odonoghue@linaro.org/T/#u
> 
> which is about data-role switching.

We have something similar but that one should work for us. I'll try and 
test that early next week.

Thanks
Angus

> 
> ---
> bod
