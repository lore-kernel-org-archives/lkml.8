Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C1CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B974020675
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OaIa4enx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFTIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:08:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFTIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=aNw1oLSnyY+IqFPK+mS6ULbOyaQHckbLBeD6OHOU1B0=; b=OaIa4enxq0qpBV1YJEBOGPT3JK
        oLaqb1aSglG+vJE2S/+NzW7SvENHmMmupUFNUBN3e7UehudigkZBNzcSo+8wiJEHwnA38faZXo9Xe
        e4R8iUUaoBLwilGi/LD2X+BYwgpn72GiJngTiWmmAL8dMBeGjcURtfvRgiUhU2NZUYkbul8yikp/G
        xubRP+hz/QqiaefkiH20j8P0VvRDmxFOdhR/3v4tRyFLLdlHqjb4i36uwCULvFoY1tF3MgcerSg4f
        syCTB84FOIDSJGIr/IRptaKb6eP8N7VNo9TgmUNIWliU8OvoWv/oLBBeaxFIv0qgGl0PViUkOE4FI
        3PGvz5qg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAIL5-00006F-DT; Fri, 06 Mar 2020 19:08:51 +0000
Subject: Re: [PATCH 2/2] tty: source all tty/*/Kconfig files from tty/Kconfig
To:     Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <a1118619-5b10-91e0-2914-fba4172f1eaa@infradead.org>
 <ee956a61-5401-0c57-e969-f27271945e6f@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f97c998-8959-0d89-56d6-dbfb413df39c@infradead.org>
Date:   Fri, 6 Mar 2020 11:08:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ee956a61-5401-0c57-e969-f27271945e6f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 11:19 PM, Jiri Slaby wrote:
> On 06. 03. 20, 0:45, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> 'source' (include) all of the tty/*/Kconfig files from
>> drivers/tty/Kconfig instead of from drivers/char/Kconfig.
>> This consolidates them both in source code and in menu
>> presentation to the user.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Follows [PATCH] char: group some /dev configs together and un-split tty configs
>> as [PATCH 2/2], where [PATCH (1/2)] is here:
>> https://lore.kernel.org/lkml/4e90d9af-c1ec-020f-b66b-a5a02e7fbe59@infradead.org/
>>
>>
>>  drivers/char/Kconfig |    5 -----
>>  drivers/tty/Kconfig  |    6 ++++++
>>  2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20200304.orig/drivers/char/Kconfig
>> +++ linux-next-20200304/drivers/char/Kconfig
>> @@ -7,9 +7,6 @@ menu "Character devices"
>>  
>>  source "drivers/tty/Kconfig"
>>  
>> -source "drivers/tty/serial/Kconfig"
>> -source "drivers/tty/serdev/Kconfig"
>> -
>>  config TTY_PRINTK
>>  	tristate "TTY driver to output user messages via printk"
>>  	depends on EXPERT && TTY
>> @@ -94,8 +91,6 @@ config PPDEV
>>  
>>  	  If unsure, say N.
>>  
>> -source "drivers/tty/hvc/Kconfig"
>> -
>>  config VIRTIO_CONSOLE
>>  	tristate "Virtio console"
>>  	depends on VIRTIO && TTY
>> --- linux-next-20200304.orig/drivers/tty/Kconfig
>> +++ linux-next-20200304/drivers/tty/Kconfig
>> @@ -478,3 +478,9 @@ config LDISC_AUTOLOAD
>>  	  only set the default value of this functionality.
>>  
>>  endif # TTY
>> +
>> +source "drivers/tty/serial/Kconfig"
>> +
>> +source "drivers/tty/serdev/Kconfig"
>> +
>> +source "drivers/tty/hvc/Kconfig"
> 
> Maybe sort them alphabetically? That way, you could move the hvc/Kconfig
> and serial/Kconfig inside the if-endif above and remove the whole-file
> if-TTYs in the 2.

Hi Jiri,

OK, I'll send a v2 with those changes.

thanks.
-- 
~Randy

