Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5675C2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgHTFv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:51:59 -0400
Received: from verein.lst.de ([213.95.11.211]:40681 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgHTFv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:51:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F2D568BEB; Thu, 20 Aug 2020 07:51:54 +0200 (CEST)
Date:   Thu, 20 Aug 2020 07:51:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Fugate <david.fugate@linux.intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        david.fugate@intel.com
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820055154.GA5758@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com> <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de> <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com> <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk> <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com> <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com> <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 05:43:29PM -0600, David Fugate wrote:
> There were queries? My key takeaways were a maintainer NAK followed by
> instructions to make the Intel drive align with the driver by
> implementing NOIOB. While I disagree with the rejection as it appeared
> to be based entirely on politics, I can accept it as the quirk wasn't
> in the spec.

Stop the crap now please.  I'm really offended.  I'm offended by you
implying that I pay corporate poitics.  I'm primary a Linux developer,
and I stand for what I think is good for Linux.  I fight inside companies
that pay me what is good for Linux, I work hard with companies that do not
pay to convinve them what is right.  I waste a lot of precious time to sit
in standards meetings to do what is right for Linux.  And now you come
here with the politics arguments.  Stop, it please.

The Intel NOIOB quirk was in the driver since day 1, added by Matthew
probably with no bad intent, but we kept growing the lists and finally
got Intel to standardized because it was good for Linux, and to be
honest good for Intel as updating quirks in half a dozen drivers
simply does not scale.  We got a really nice trivial TP out of it.  But
we really should not see any new drivers that do not implement one damn
trivial field a long time after the TP has been publushed.  That is not
politics.

Making a fuzz and playing the corporate card on a Linux mailing list
is politics, really bad politics and you need to stop it.

> It's not fair to make this same "your drive should align with the
> driver" demand of Samsung because we *are* talking about a spec'ed
> feature here.

Huh.  Next time Dell or NetApp or Facebook are going to require an
optional NVMe feature, and OCP feature or even a vendor specific
feature you are going to go to them and say "you don't play fair"?

> Technical critques of their patches and real performance
> degrades observed are fair game and objective; "your company did
> the nastiest possible move violating the normal NVMe procedures to make
> it optional" is not.

It is pretty fair game if you know the background, that is that I spent
countless hours to make this feature fit the Linux I/O stack requirement
perfecty and worked that it is there.  We might as well rely on it.
