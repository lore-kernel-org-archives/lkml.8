Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86305C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4AD20885
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHSXnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:43:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:31506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgHSXnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:43:31 -0400
IronPort-SDR: AJTslrbvMK2dlnx4tkx5qzYFL9uCWdJaDiC/yCFyLYhwdBcn21NXCxVrZowznfWUq5h/AvXevc
 2fDe8KspCbqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152817807"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="152817807"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 16:43:30 -0700
IronPort-SDR: O5tYOSNL62+SuASdmhJb8445k2uVVEXg0Cat/zdHSQN6aLC25N3+dLbxQfsJ3rnL525bEGHKbu
 /ck8bJ7GJjnA==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="497412099"
Received: from dfugate-mobl1.amr.corp.intel.com (HELO dwf-u18040) ([10.212.117.189])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 16:43:29 -0700
Message-ID: <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
From:   David Fugate <david.fugate@linux.intel.com>
Reply-To: david.fugate@linux.intel.com
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
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
Date:   Wed, 19 Aug 2020 17:43:29 -0600
In-Reply-To: <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
         <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
         <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
         <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
         <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
         <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
         <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
Organization: Intel
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-19 at 15:10 -0700, Keith Busch wrote:
> You're the one who left that thread dangling. You offered to have
> your
> firmware accommodate the Intel sponsored feature that makes your
> patch
> unnecessary in the first place. Your follow up made no sense and you
> have not responded to the queries about it.

There were queries? My key takeaways were a maintainer NAK followed by
instructions to make the Intel drive align with the driver by
implementing NOIOB. While I disagree with the rejection as it appeared
to be based entirely on politics, I can accept it as the quirk wasn't
in the spec.

It's not fair to make this same "your drive should align with the
driver" demand of Samsung because we *are* talking about a spec'ed
feature here. Technical critques of their patches and real performance
degrades observed are fair game and objective; "your company did
the nastiest possible move violating the normal NVMe procedures to make
it optional" is not.

