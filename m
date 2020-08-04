Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C192C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5662086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUhchAfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgHDOgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgHDOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:35:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C26C06174A;
        Tue,  4 Aug 2020 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Kax4ttFtpEmDLGVL6+ZtmD/xFPRxbKpN/bI1MR622J0=; b=PUhchAfV17cUnQGR/ZMAU7Dj40
        ILIpogjQNNbUMOrwvXr1hwsV/5CjgTmbNT+ne15JFochwFI4VEC6z2ur/jRm7uhZ+ZXJx//yhtsOB
        o3bc76mXBFeMArjwXlU4UV95kk87xyr1IRHKKsiqFGs99Hv687RgMTF8HJSxJCxCQEEHeaSaWbYSG
        fclW4iIzShYf0CGKywQxREgxuEPk9A5lN7mf6u00bWkwKvZA53S6wKlSXqKinUUH4UE2g4z5v07H5
        WCPIv7YE0gzhEOZT10AmIAHfeXYImZB28IuXNGIr5EbXHyXmJY1SixumoINzaxK/Rt4THardEkToW
        IgQLw8Aw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2y2I-0005sc-NA; Tue, 04 Aug 2020 14:35:28 +0000
Subject: Re: linux-next: Tree for Aug 4 (fs/mount_notify.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <20200804184116.6da77785@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <24c5061c-9ad4-1e88-5522-4d40625715be@infradead.org>
Date:   Tue, 4 Aug 2020 07:35:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804184116.6da77785@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/20 1:41 AM, Stephen Rothwell wrote:
> Hi all,
> 

on i386 or x86_64:

../fs/mount_notify.c: In function 'notify_mount':
../fs/mount_notify.c:94:28: error: 'struct mount' has no member named 'mnt_unique_id'; did you mean 'mnt_group_id'?
  n.triggered_on = trigger->mnt_unique_id;
                            ^~~~~~~~~~~~~
                            mnt_group_id
../fs/mount_notify.c:109:28: error: 'struct mount' has no member named 'mnt_unique_id'; did you mean 'mnt_group_id'?
   n.auxiliary_mount = aux->mnt_unique_id;
                            ^~~~~~~~~~~~~
                            mnt_group_id


when CONFIG_FSINFO is not set/enabled.


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
