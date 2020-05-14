Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54526C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36327205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgENNzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:55:07 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8080 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgENNzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:55:07 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85ebd4da51e7-ea7f2; Thu, 14 May 2020 21:54:45 +0800 (CST)
X-RM-TRANSID: 2ee85ebd4da51e7-ea7f2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.101] (unknown[112.1.172.85])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65ebd4da1bca-3a1cb;
        Thu, 14 May 2020 21:54:44 +0800 (CST)
X-RM-TRANSID: 2ee65ebd4da1bca-3a1cb
Subject: Re: [PATCH v3] ipmi:bt-bmc: Fix error handling and status check
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200505102906.17196-1-tangbin@cmss.chinamobile.com>
 <20200505114907.GK9902@minyard.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <bfb981ec-eedc-3635-007c-4921c9307072@cmss.chinamobile.com>
Date:   Thu, 14 May 2020 21:55:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200505114907.GK9902@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey：

On 2020/5/5 19:49, Corey Minyard wrote:
> On Tue, May 05, 2020 at 06:29:06PM +0800, Tang Bin wrote:
> Ok, this is included in my tree.

I just checked that this patch has been merged into the linux-next 
branch, and I saw the modification of you

by this patch.  I have learned a lot from you through communication.

Thank you again!

Tang Bin





