Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A49CC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1B8208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="lTVVuMBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgCKKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:33:12 -0400
Received: from vps.xff.cz ([195.181.215.36]:54436 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgCKKdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1583922789; bh=dRISzFx2JBnu+jblONlXo7Qz3C235IdzslaBDbRSJHw=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=lTVVuMBW551I+CuYrT2Oxr3TGIBNfsxiJ1SiQdI+OsJhMR+XiqK2ksEvOKHZ98q2H
         C2/OtC4nHLT7KTA4QTSDyYmzgcjKUxeUOpLsaYCgxlMh6Mwxw2c6AJlcL/K4faBiWd
         0usBx2r7fLnIWusnXeVqJdru43cWl2x3aWIF/yp0=
Date:   Wed, 11 Mar 2020 11:33:09 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] Writes stoped working on f2fs after the compression
 support was added
Message-ID: <20200311103309.m52hdut7mt7crt7g@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20200224143149.au6hvmmfw4ajsq2g@core.my.home>
 <39712bf4-210b-d7b6-cbb1-eb57585d991a@huawei.com>
 <20200225120814.gjm4dby24cs22lux@core.my.home>
 <20200225122706.d6pngz62iwyowhym@core.my.home>
 <72d28eba-53b9-b6f4-01a5-45b2352f4285@huawei.com>
 <20200226121143.uag224cqzqossvlv@core.my.home>
 <20200226180557.le2fr66fyuvrqker@core.my.home>
 <7b62f506-f737-9fb2-6e8e-4b1c454f03b2@huawei.com>
 <20200306120203.2p34ezryzxb2jeuk@core.my.home>
 <0ce08d13-ca00-2823-94eb-8274c332a8ef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ce08d13-ca00-2823-94eb-8274c332a8ef@huawei.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 11, 2020 at 05:02:10PM +0800, Chao Yu wrote:
> Hi,
> 
> Sorry for the delay.
> 
> On 2020/3/6 20:02, Ondřej Jirman wrote:
> > Hello,
> > 
> > On Thu, Feb 27, 2020 at 10:01:50AM +0800, Chao Yu wrote:
> >> On 2020/2/27 2:05, Ondřej Jirman wrote:
> >>>
> >>> No issue after 7h uptime either. So I guess this patch solved it for some
> >>> reason.
> >>
> >> I hope so as well, I will send a formal patch for this.
> > 
> > So I had it happen again, even with the patches. This time in f2fs_rename2:
> 
> Oops, it looks previous fix patch just cover the root cause... :(
> 
> Did this issue still happen frequently? If it is, would you please apply patch
> that prints log during down/up semaphore.

Not frequently. Just once. I couldn't afford FS corruption during update,
so I reverted the compression support shortly after.

But I wasn't stressing the system much with FS activity after applying the
initial fix.

> And once we revert compression support patch, this issue will disappear, right?

Yes, AFAIK. I reverted it and run a few cycles of install 500MiB worth of
packages, uninstall the packages with pacman. And it didn't re-occur. I never
saw any issues with compression support patch reverted.

> Btw, did you try other hardware which is not Arm v7?

Yes, but I didn't ever see it on anything else. Just on two 8 core cortexes A7.
(2 clusters)

regards,
	o.
