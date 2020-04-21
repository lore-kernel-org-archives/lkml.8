Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5379C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AECE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="PDAIgt2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgDUMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:10:56 -0400
Received: from smtp2.axis.com ([195.60.68.18]:57792 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbgDUMK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:10:56 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2020 08:10:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1056; q=dns/txt; s=axis-central1;
  t=1587471054; x=1619007054;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=e5l7Ey7eBk6W1PjZ+8XYrNk38uNUci4BU1Rlr0SxkAU=;
  b=PDAIgt2iNuzm1dBV1HwBpgbinmHHij+br805kbW5aQuCacjaaIuIRtki
   9s13zOx/WcqKrP/pE7Eb+tZ1CHjtT9yy1LgrrvsYZJwfLkFtg0R2DJl0k
   E9cfma5NV1/MsmiJkCVyZWDbDxG6sMpcSejdFW7oZSTf8Mbk3nrPo8f82
   Nqswau/s3H1w0x+A5b/UP6MC/PYdkVP9VYeQiM5dRNC/trV5L1UbaanBt
   13+4zczOc0JDM3lgL89sRBguhaDNW8f18T4FjJN17rFZk0WQK6FZPHfZV
   TZjwweUo9TFS/9XZKd1i5VPMDPUanmlC7oPkajQNDdMWghZo0sm6gAg3r
   A==;
IronPort-SDR: slkoKAD4j0YkY2zI+xu9W07GCchlGtfS7tGbFv/xAo8lxJWdBLtassZJcREGjd8nzt58hAXoxF
 2iLU1UWZSP7S8sbzH2A8LL4LnlIXEdcvjdKfbELCkpiWmz5WjY/uiDC2TQ5jL+FQdDKkJhX/wc
 ZZln1Lc2AMIg3UBGgLYwUphqWUibnOiwp3qUyxiLMpB5wZ6e2JEWJLcx7QR5aYOtsOuixVK+TD
 mYikWO76OVe3Oi3ysdUDaDTcjLMqhU9KmpM5CuEVpYZ/tQAOqtj97W5LpnvGc5asGhXHFpZStX
 7x8=
X-IronPort-AV: E=Sophos;i="5.72,410,1580770800"; 
   d="scan'208";a="7641338"
Subject: Re: [PATCH 1/2] i2c: slave-eeprom: initialize empty eeprom properly
To:     Wolfram Sang <wsa@the-dreams.de>,
        Patrick Williams <patrick@stwcx.xyz>
CC:     =?UTF-8?B?QmrDtnJuIEFyZMO2?= <bjornar@axis.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191001164009.21610-1-alpawi@amazon.com>
 <150599be-9125-4ab9-e2a6-e792b41910e6@axis.com>
 <20200420164349.GD3721@ninjato>
 <20200420203146.GC95151@heinlein.lan.stwcx.xyz>
 <20200420205325.GA1693@ninjato>
From:   Bjorn Ardo <bjorn.ardo@axis.com>
Message-ID: <adb03545-88db-689c-dbf7-9f746236adb4@axis.com>
Date:   Tue, 21 Apr 2020 14:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420205325.GA1693@ninjato>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX02.axis.com (10.0.5.16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 10:53 PM, Wolfram Sang wrote:

> On Mon, Apr 20, 2020 at 03:31:46PM -0500, Patrick Williams wrote:
>> On Mon, Apr 20, 2020 at 06:43:49PM +0200, Wolfram Sang wrote:
>>> On Wed, Oct 02, 2019 at 08:20:53AM +0200, Bjorn Ardo wrote:
>>>> Hi,
>>>>
>>>>
>>>> I sent in another patch earlier that added support for specifying a file in
>>>> devicetree to initilize the eeprom from, corresponding to the case of
>>>> pre-flashed eeprom. Maybe these two patches should be merged so this
>>>> initialization is only done if no file is specified?
>>> Yes, I agree.
>>>
>> It looks like Bjorn's referenced patches are still unmerged also?
> Yes, it might be easiest if he merges your patch (with attribution) into
> the else branch of his fw-load patch.
>

OK, so to summarize, I should update my patch to use 
device_property_read_string() instead and also init the memory to 0XFF 
if no file is present. And change name of the function to 
i2c_slave_init_eeprom_data.


I will look into that and let you know once I'm done.


/BA

