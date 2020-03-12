Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A710C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613BA206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="bEQKWd4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgCLL0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:26:41 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:38305 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgCLL0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:26:40 -0400
Received: from [192.168.2.10] ([46.9.234.233])
        by smtp-cloud8.xs4all.net with ESMTPA
        id CLz1jwjhEhVf8CLz4jML25; Thu, 12 Mar 2020 12:26:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1584012399; bh=2qFk2V2sepRRoMtdl/1VmSlkBK7fB2xthSUCK1rupjA=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=bEQKWd4tjmc2LnuBNYv8Q7uhVS1s3x4TrHGzoZiOrV4vQwSmQg53nAbCwUqbW6lFJ
         j++gmZRnn0r0VQTO3Lx6Np6tNPA1ayZ9n04LpN7XK2OO97srokQBvtK6t6eLNLoaJ5
         7dDlJvZH76iSG+uSIZDk6/PsBh1L7L78PLHfO+TimnPnctBh5y/awYW3e2Y/bcwRJn
         nFRMcH43jd6wgASQHvyRAm6StOEdHF4km8WyDOM11sBpF4SqMV6H+lIjCtKCLNC6kX
         3byFdvZbKirnMvphWSarA8He4nuwDFo0NB4io8sPFbKy64fHb4pge1yCr8MroBaFg/
         wy0rerq2vvQ6A==
Subject: Re: [PATCH 0/6] media: fix USB descriptor issues
To:     Johan Hovold <johan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200103163513.1229-1-johan@kernel.org>
 <20200214080254.GK4150@localhost> <20200312112330.GO14211@localhost>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <82e0041b-be4b-1681-c016-d4eeea37abea@xs4all.nl>
Date:   Thu, 12 Mar 2020 12:26:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312112330.GO14211@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOxkiH5ykgO0cjliwesEsdUguRX/HZ0kp+jjPNI4KHBM22HTH0YY64/BtrGWZbBHn4uNIADdK21BXKkOX110vJioaDGix6aJXFUNrBNd8ztWKLkJZXYq
 x085DShR6pP9ow1nvTiKZUrD5Y1g5c66L72BUttNGZxD62uikT1NU5EULJHg2khuMrTF/UwM1M+yTUUTGSvv0AOaf40lF7WvB98iNwJ0nFOeCUJIrocvhqJs
 dUTbqtgaOt8XiRJCkqbj9KPsZ3UPpjjbXLSoJAJwB0tfQX05PSLczHG9MlWwBkBmLD1UbQRyQNDx9EjTJEyI3zQ0n22j3HY9XtvyDUa0Uuo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 12:23 PM, Johan Hovold wrote:
> On Fri, Feb 14, 2020 at 09:02:54AM +0100, Johan Hovold wrote:
>> On Fri, Jan 03, 2020 at 05:35:07PM +0100, Johan Hovold wrote:
>>> This series fixes a number of issues due to missing or incomplete sanity
>>> checks that could lead to NULL-pointer dereferences, memory corruption
>>> or driver misbehaviour when a device has unexpected descriptors.
>>
>>> Johan Hovold (6):
>>>   media: flexcop-usb: fix endpoint sanity check
>>>   media: ov519: add missing endpoint sanity checks
>>>   media: stv06xx: add missing descriptor sanity checks
>>>   media: xirlink_cit: add missing descriptor sanity checks
>>>   media: dib0700: fix rc endpoint lookup
>>>   media: iguanair: fix endpoint sanity check
>>
>> Just sending a reminder about these as it seems only the last one has
>> made into mainline (and stable) yet.
> 
> Another month, another reminder. Three of the above patches still hasn't
> been applied.

I've delegated these to me and will make a PR today/tomorrow.

Regards,

	Hans
