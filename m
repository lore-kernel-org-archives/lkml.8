Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E31AC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F7F20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgDHNte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:49:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60260 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgDHNte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:49:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMB4a-00E49z-DG; Wed, 08 Apr 2020 13:48:56 +0000
Date:   Wed, 8 Apr 2020 14:48:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Eric Dumazet <edumazet@google.com>,
        Li RongQing <lirongqing@baidu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        David Howells <dhowells@redhat.com>, daniel@iogearbox.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] netns: dangling pointer on netns bind mount point.
Message-ID: <20200408134856.GB23230@ZenIV.linux.org.uk>
References: <20200407023512.GA25005@ubuntu>
 <20200407030504.GX23230@ZenIV.linux.org.uk>
 <20200407031318.GY23230@ZenIV.linux.org.uk>
 <CAM7-yPQas7hvTVLa4U80t0Em0HgLCk2whLQa4O3uff5J3OYiAA@mail.gmail.com>
 <20200407040354.GZ23230@ZenIV.linux.org.uk>
 <CAM7-yPRaQsNgZKjru40nM1N_u8HVLVKmJCAzu20DcPL=jzKjWQ@mail.gmail.com>
 <20200407182609.GA23230@ZenIV.linux.org.uk>
 <CAM7-yPS_xh54H9M7B8-tAmPM4+w0VgnruJhK509upsDgZvcNhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPS_xh54H9M7B8-tAmPM4+w0VgnruJhK509upsDgZvcNhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:59:17PM +0900, Yun Levi wrote:
> Thank you for great comments. Thanks to you I understand what i missed.
> 
> I try to generate problem on mainline But, as you explained that
> situation isn't happen,
> 
> Maybe my other things which I made generate some problem (freeing
> network namespace..)
> 
> Thanks for great answering and sharing.
> 
> If I meet the situation, at that time I'll share. Thank you very much!
> 
> P.S. If I have a question, Could I ask via e-mail like this?

Sure, no problem...
