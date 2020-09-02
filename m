Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DB2C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360E320767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgIBP3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:29:44 -0400
Received: from k17.unixstorm.org ([91.227.123.100]:34185 "EHLO
        k17.unixstorm.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIBP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:29:06 -0400
Received: from [127.0.0.1] (helo=k17.unixstorm.org)
        by k17.unixstorm.org with esmtpa (Exim 4.92.3)
        (envelope-from <kamil@re-ws.pl>)
        id 1kDUgy-0003B6-1o; Wed, 02 Sep 2020 17:28:56 +0200
MIME-Version: 1.0
Date:   Wed, 02 Sep 2020 17:28:55 +0200
From:   Kamil Lorenc <kamil@re-ws.pl>
To:     David Miller <davem@davemloft.net>
Cc:     jacmet@sunsite.dk, kuba@kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kamil@re-ws.pl
Subject: Re: [PATCH] net: usb: dm9601: Add USB ID of Keenetic Plus DSL
In-Reply-To: <20200901.154053.2048405039114618360.davem@davemloft.net>
References: <GENERATED-WASMISSING-1kDBz9-0002Lq-5x@k17.unixstorm.org>
 <20200901.154053.2048405039114618360.davem@davemloft.net>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <d5a70ede70581fe61fc093e8c6b9d8ea@re-ws.pl>
X-Sender: kamil@re-ws.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: kamil@re-ws.pl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 2020-09-02 00:40, David Miller napisał(a):
> From: Kamil Lorenc <kamil@re-ws.pl>
> Date:
> 
>> I received an error from Peter Korsgaard's mailserver informing that 
>> his
>> email address does not exist. Should I do something with that fact?
> 
> Probably need a MAINTAINERS update.  Is there any other email address 
> by
> which Peter can be reached?

Github pointed me to peter@korsgaard.com, but I haven't tried to reach 
him there.
