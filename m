Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B535C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E032146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="q1gWRADY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgCKLBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:01:52 -0400
Received: from vps.xff.cz ([195.181.215.36]:54858 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCKLBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1583924511; bh=P6XGe2Y/JfrAmfvHCCn6nLtRPNSYzKFV+VBM9UgB3m0=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=q1gWRADYxD/Lk+gYf4sKqAypi6n1psX3dYNFQY3jPlM1bX1aGg2FX2aR8js7PijZg
         vyfv2Qd3hOrxpv/6cp3zTHZLE+lSj1rHGQMKVQe7jgBg72Dh/JrbsEbQrn/qrA6Kmx
         r4G7Y0H4P2aIo8QDBjUgBBIxsHLRPconvVLPQTqE=
Date:   Wed, 11 Mar 2020 12:01:50 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] Writes stoped working on f2fs after the compression
 support was added
Message-ID: <20200311110150.ajywqttf7pyrpnau@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20200225120814.gjm4dby24cs22lux@core.my.home>
 <20200225122706.d6pngz62iwyowhym@core.my.home>
 <72d28eba-53b9-b6f4-01a5-45b2352f4285@huawei.com>
 <20200226121143.uag224cqzqossvlv@core.my.home>
 <20200226180557.le2fr66fyuvrqker@core.my.home>
 <7b62f506-f737-9fb2-6e8e-4b1c454f03b2@huawei.com>
 <20200306120203.2p34ezryzxb2jeuk@core.my.home>
 <0ce08d13-ca00-2823-94eb-8274c332a8ef@huawei.com>
 <20200311103309.m52hdut7mt7crt7g@core.my.home>
 <c3d53657-7c2a-9d2f-9111-048db6e30a7e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d53657-7c2a-9d2f-9111-048db6e30a7e@huawei.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 06:51:23PM +0800, Chao Yu wrote:
> Hi,
> 
> >> Oops, it looks previous fix patch just cover the root cause... :(
> >>
> >> Did this issue still happen frequently? If it is, would you please apply patch
> >> that prints log during down/up semaphore.
> > 
> > Not frequently. Just once. I couldn't afford FS corruption during update,
> 
> Alright.
> 
> > so I reverted the compression support shortly after.
> 
> What I can see is that filesystem was just stuck, rather than image became
> corrupted, I guess the condition is not such bad, anyway, it's okay to just
> revert compression support for now to keep fs stable.

Yes, to be precise, file writes were not completed and fs was stuck.
The system as a whole would probably become unbootable if this would
happen to core libraries necessary for systemd, or something like that,
but filesystem itself was not corrupted.

Re-writing the files was enough to recover the system.

I guess we'll see if there will be more reports after 5.6 is released,
or if it's just some quirk in my system.

I'll try to collect more information, once I'll have some time, to
get to the bottom of this.

thank you and regards,
	o.
