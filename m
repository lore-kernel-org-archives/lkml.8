Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C54C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7851206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgDGDNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:13:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35410 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgDGDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 23:13:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLefu-00CjN9-CV; Tue, 07 Apr 2020 03:13:18 +0000
Date:   Tue, 7 Apr 2020 04:13:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Levi <ppbuk5246@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, gnault@redhat.com,
        nicolas.dichtel@6wind.com, edumazet@google.com,
        lirongqing@baidu.com, tglx@linutronix.de, johannes.berg@intel.com,
        dhowells@redhat.com, daniel@iogearbox.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] netns: dangling pointer on netns bind mount point.
Message-ID: <20200407031318.GY23230@ZenIV.linux.org.uk>
References: <20200407023512.GA25005@ubuntu>
 <20200407030504.GX23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407030504.GX23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 04:05:04AM +0100, Al Viro wrote:

> Could you post a reproducer, preferably one that would trigger an oops
> on mainline?

BTW, just to make sure - are we talking about analysis of existing
oops, or is it "never seen it happen, but looks like it should be
triggerable" kind of situation?
