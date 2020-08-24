Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA873C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E768206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598293025;
	bh=QN3GnLsscsR8svGqnTbqMwMHQQ/bDpS/a2eA2g9QReo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xlOzZMCPiYPL/wsTHU/pEkDNzPtf6twafTK78Ul98nQY6uhGsvl5Mfn9B+EwCC0JD
	 bXP4re54QNIrB/sbQCbp48T0x6MJKu6gycDsOkviHXWlNPaKKNJimMJI33sFh8SKT/
	 2zCM4URos6tE21HbecYvZa1ZfewpwrjPpSt/v3N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHXSRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgHXSQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:16:58 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C501206BE;
        Mon, 24 Aug 2020 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598293017;
        bh=QN3GnLsscsR8svGqnTbqMwMHQQ/bDpS/a2eA2g9QReo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VjpynL60QoLTwzWlZN5zinIiAG0E1d50mScSwVQ45XMIwzJd+oUNJRzpCsC9/j0mt
         /864QiX79PnsTEQpJmsHEamETUShKdibWmLPcMN/C7OreR5WGPwoY0XncNN5R3+XTZ
         Q+6IIKuKJV7Jy7+nJPy6ZAfVC9iYmnnAaeKFpmzU=
Date:   Mon, 24 Aug 2020 11:16:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     davem@davemloft.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net: usb: Fix uninit-was-stored issue in
 asix_read_cmd()
Message-ID: <20200824111655.20a3193e@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200823082042.20816-1-himadrispandya@gmail.com>
References: <20200823082042.20816-1-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Aug 2020 13:50:42 +0530 Himadri Pandya wrote:
> Initialize the buffer before passing it to usb_read_cmd() function(s) to
> fix the uninit-was-stored issue in asix_read_cmd().
> 
> Fixes: KMSAN: kernel-infoleak in raw_ioctl

Regardless of the ongoing discussion - could you please make this line
a correct Fixes tag?

Right now integration scripts are complaining that it doesn't contain a
valid git hash.

> Reported by: syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com
> 

This empty line is unnecessary.

> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>

