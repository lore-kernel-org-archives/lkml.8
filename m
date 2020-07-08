Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D66206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgGHPkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:40:02 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:47886 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729022AbgGHPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:40:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CCC8B181D3026;
        Wed,  8 Jul 2020 15:40:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wood85_2f12d7c26ebe
X-Filterd-Recvd-Size: 2129
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 Jul 2020 15:40:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Jul 2020 08:39:59 -0700
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] usbip: Use fallthrough pseudo-keyword
In-Reply-To: <1b6b83f7-c749-6e0a-0001-2febbf01b603@linuxfoundation.org>
References: <20200707195214.GA3932@embeddedor>
 <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org>
 <8e08240671d65f1e92dbf5e1e066190149e0d074.camel@perches.com>
 <1b6b83f7-c749-6e0a-0001-2febbf01b603@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <dd532813cc28b6f27b2d0ed6bd3529f2@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [172.58.16.106]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-08 07:35, Shuah Khan wrote:
> On 7/7/20 7:56 PM, Joe Perches wrote:
>> On Tue, 2020-07-07 at 14:06 -0600, Shuah Khan wrote:
>>> On 7/7/20 1:52 PM, Gustavo A. R. Silva wrote:
>>>> Replace the existing /* fall through */ comments and its variants 
>>>> with
>>>> the new pseudo-keyword macro fallthrough[1]. Also, remove 
>>>> unnecessary
>>>> fall-through markings when it is the case.
>>>> 
>>>> [1] 
>>>> https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>>> 
>>> 
>>> Is fallthrough syntax supported on our min gcc version?
>> 
>> No.  Introduced in gcc 7.
>> 
> 
> Gustavo,
> 
> In which case, this patch would break usbip build on older gcc
> revisions.

No it will not.  Comment fall through was introduced in gcc 7 and this 
devolved into a do while 0
> thanks,
> -- Shuah
