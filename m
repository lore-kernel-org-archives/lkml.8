Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B70208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbgF2TmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:42:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387848AbgF2Tlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:41:49 -0400
Received: from oxbsgw01.schlund.de ([172.19.248.2]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAwoL-1jfEO91yHZ-00BIvF; Mon, 29 Jun 2020 17:31:28 +0200
Date:   Mon, 29 Jun 2020 17:31:27 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Message-ID: <1069735883.1017676.1593444687939@mailbusiness.ionos.de>
In-Reply-To: <20200626200815.GC2454695@iweiny-DESK2.sc.intel.com>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <581f1761-e582-c770-169a-ee3374baf25c@intel.com>
 <84270660.632865.1593072688966@mailbusiness.ionos.de>
 <20200626200815.GC2454695@iweiny-DESK2.sc.intel.com>
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:dABFUE9hOYEeaSPGRIAHWnjrmhG8vVCmzLaqIdCeOnnh1tiEHQI
 vdkFa/eFxsOt4s3Zfi3svuvVqRBm3WW8D/fuRMTYhg+PL9WB0KdnpooNPV03KpC6qvD5E6g
 Gz4bVWEYiyJZEpcxqPirT+lx/Ub3foXXxtgVJLcrEM+GHCgPZqj+bG/loMydZA8pNh1ojXc
 XOv4GGvT9EdYNlpQdzTQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y7lIeaDHkvM=:jK0VZSZpSE43lB6t8f0jwC
 EKx9/u9HKjqiuANOvdCd5NxZJRSUdIeJZtKILBv9fh0Mez/Evkywa5SzbjiQ0DXCN/ggM3EI1
 NCZVsyM57982j1icauTCx+2Wy/aICTIufkT7DsdpbYdcyL8592YlOIh+rLpGjj4JyOqzVdqIZ
 kM/soseAEykH7IjIOG5bihBpxY3Clmuon/3WuKnBWYfMuwutepTt7KdFMNzkzUg7yfuDwXIZQ
 udjjWOztZnbRt6DgvF98Kgo/Cd9VvSb+GGyYbVbL548vW/c+imL2PmYjQ5Dwos/c64PYkPShL
 wzD1ltuxxUTeDrlNsUmPn00DtpxfOB3IXFh04dCjEHnwjgByUyIrxlzyaVAIhE7TLvThlE8U4
 5PAwjtPpMG5z05SjR9DS3KRY0bP3WGNQVTQlVh07FttswcCJoKYSmtSl50TdcFd6yb5SjeZpr
 Igf2JHv6faIYyQO/MqTsYPOBR4KuScVo9r76atNRA3jtflcPq3vA5YcJSgjXKSPXZ6q3KvQUS
 BjqTd9uDrNouQwhPHgD681/oNZ0khOCX9YTCKdU/gBR5oKY8nh1CIBqYShep0xYYh/DeAQKId
 ZF7oVAr+OOONzyKwxeRxWDvm6JO0r/mbHEGaafU7R4eX4NU1zY0nfU7KLUnmw9ojoHeLoKjqs
 W4VwPiUBrEUr6wN0pi/imb59dZj8A9TiDJPIIe5TOm5tde9S1mBNvinuSuwwhgJmdp4BmNRjY
 Ssi5nCiw5qwneZbD2hj/DwIwiK4QRxTFV9yxMN6WPz4V8fKBRNsM7OJIV4CKfsMHE8CJeCdse
 ibSoDv3AnozUoTGGDvYhspytf4eZ67bXlRYllLYCI+FAqgAPec=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 26 June 2020 at 22:08 Ira Weiny <ira.weiny@intel.com> wrote:
> 
> 
> On Thu, Jun 25, 2020 at 10:11:28AM +0200, Thomas Ruf wrote:
> > 
> > > On 25 June 2020 at 02:42 Dave Jiang <dave.jiang@intel.com> wrote:
> > > 
> > > 
> > > 
> > > 
> > > On 6/21/2020 12:24 AM, Vinod Koul wrote:
> > > > On 19-06-20, 16:31, Dave Jiang wrote:
> > > >>
> > > >>
> > > >> On 6/19/2020 3:47 PM, Federico Vaga wrote:
> > > >>> Hello,
> > > >>>
> > > >>> is there the possibility of using a DMA engine channel from userspace?
> > > >>>
> > > >>> Something like:
> > > >>> - configure DMA using ioctl() (or whatever configuration mechanism)
> > > >>> - read() or write() to trigger the transfer
> > > >>>
> > > >>
> > > >> I may have supposedly promised Vinod to look into possibly providing
> > > >> something like this in the future. But I have not gotten around to do that
> > > >> yet. Currently, no such support.
> > > > 
> > > > And I do still have serious reservations about this topic :) Opening up
> > > > userspace access to DMA does not sound very great from security point of
> > > > view.
> > > 
> > > What about doing it with DMA engine that supports PASID? That way the user can 
> > > really only trash its own address space and kernel is protected.
> > 
> > Sounds interesting! Not sure if this is really needed in that case...
> > I have already implemented checks of vm_area_struct for contiguous memory or even do a get_user_pages_fast for user memory to pin it (hope that is the correct term here). Of course i have to do that for every involved page.
> 
> FWIW there is a new pin_user_pages_fast()/unpin_user_page() interface now.

Thanks for that info. But at the moment we are mainly interested in a solution which can be easily backported to Xilinix Release 2020.1 with kernel 5.4.x where i could not find that new functionality.

> > But i will do some checks if my code is really suitable to avoid misusage.

Did some basic tests today and was not able to break out of my own checks done via follow_pfn() respectively get_user_pages_fast(). If this stands "advanced attacks" my proxy driver shouldn't be more dangerous as an ordinary memcpy, i know that there will always remain some doubts ;-)

best regards,
Thomas
