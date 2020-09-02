Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082CBC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0598206E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgIBP0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:26:24 -0400
Received: from k17.unixstorm.org ([91.227.123.100]:33434 "EHLO
        k17.unixstorm.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgIBPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:23:43 -0400
Received: from [127.0.0.1] (helo=k17.unixstorm.org)
        by k17.unixstorm.org with esmtpa (Exim 4.92.3)
        (envelope-from <kamil@re-ws.pl>)
        id 1kDUbD-0001je-2E; Wed, 02 Sep 2020 17:22:59 +0200
MIME-Version: 1.0
Date:   Wed, 02 Sep 2020 17:22:54 +0200
From:   Kamil Lorenc <kamil@re-ws.pl>
To:     David Miller <davem@davemloft.net>
Cc:     jacmet@sunsite.dk, kuba@kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: dm9601: Add USB ID of Keenetic Plus DSL
In-Reply-To: <20200901.153607.102288342952967095.davem@davemloft.net>
References: <20200901085738.27482-1-kamil@re-ws.pl>
 <20200901.153607.102288342952967095.davem@davemloft.net>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <271ee69ec1497368040c7251db037142@re-ws.pl>
X-Sender: kamil@re-ws.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: kamil@re-ws.pl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 2020-09-02 00:36, David Miller napisał(a):

> Applied, thanks.

You're welcome.
