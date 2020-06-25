Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C347C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1A3207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgFYCfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 22:35:52 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:50070 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389174AbgFYCfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 22:35:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D4C6F181D337B;
        Thu, 25 Jun 2020 02:35:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: swing04_4e0bd0626e49
X-Filterd-Recvd-Size: 879
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 02:35:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Jun 2020 19:35:50 -0700
From:   joe@perches.com
To:     Julia lawall <julia.lawall@lip6.fr>
Cc:     Kris Borer <kborer@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: cocci script from 2016 - assignment in if ?
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <3af82c36a9e7477566bf3c2e6ce013cd@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [47.151.133.149]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://lore.kernel.org/patchwork/patch/649705/

Any particular reason this wasn't applied?

I ask because I added something similar recently to checkpatch.
