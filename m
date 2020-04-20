Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D393C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7304C21744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDTQzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:55:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:57571 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTQzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:55:36 -0400
IronPort-SDR: qdFaSFmQ/uYOyur15uhdp5BUnzGQcdfANazoI08rVXQ+1RWVp5G6wiR0zftTMm5rrgY1lwpelV
 0RRbUw/4xI2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 09:55:36 -0700
IronPort-SDR: 3UC1k8qsd1AKrpAC0uDulmNXiCATFEgpunAMdoaBMGKIjUp8Sj8DtFiKpkISUgR0sCm382U3Pz
 vPV7qqE+4kSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="254997169"
Received: from spandruv-mobl3.jf.intel.com ([10.254.108.186])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2020 09:55:35 -0700
Message-ID: <969038ce47f5f0c054b8971c516b8b961a46b737.camel@linux.intel.com>
Subject: Re: [PATCH] intel-speed-select: Fix
 speed-select-base-freq-properties output on CLX-N
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date:   Mon, 20 Apr 2020 09:55:35 -0700
In-Reply-To: <d0bfcbfe-4834-624f-b590-1aa93970e5a4@redhat.com>
References: <20200420141054.26173-1-prarit@redhat.com>
         <CAHp75VfKCuX1CNMaVLeghdoP9-KHh3+1yuFVgU8qhRbKi69JNQ@mail.gmail.com>
         <d0bfcbfe-4834-624f-b590-1aa93970e5a4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-20 at 11:46 -0400, Prarit Bhargava wrote:
> 
> On 4/20/20 11:43 AM, Andy Shevchenko wrote:
> > On Mon, Apr 20, 2020 at 6:11 PM Prarit Bhargava <prarit@redhat.com>
> > wrote:
> > > On CLX-N, the perf-profile-level's output is terminated before
> > > the
> > > speed-select-base-freq-properties are output which results in a
> > > corrupt
> > > json file.
> > > 
> > > Adjust the output of speed-select-base-freq-properties by one on
> > > CLX-N.
> > > 
> > 
> > Thanks for the patch, it will be pulled from Srinivas' tree
> > whenever
> > he sends a PR to PDx86 mailing list.
> 
> Srinivas, OOC do you want these patches to be sent somewhere
> else?  FWIW, I'm
> running get_maintainers.pl to get the mailing list and cc.
This mailing list is fine.

I will take care of it once I test it out an apply to my tree.

Thanks,
Srinivas

> 
> P.
> 
> > 
> > > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: platform-driver-x86@vger.kernel.org
> > > ---
> > >  tools/power/x86/intel-speed-select/isst-display.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/power/x86/intel-speed-select/isst-display.c
> > > b/tools/power/x86/intel-speed-select/isst-display.c
> > > index 51dbaa5f02ec..f6e2ce181123 100644
> > > --- a/tools/power/x86/intel-speed-select/isst-display.c
> > > +++ b/tools/power/x86/intel-speed-select/isst-display.c
> > > @@ -470,7 +470,7 @@ void isst_ctdp_display_information(int cpu,
> > > FILE *outf, int tdp_level,
> > >                                 _isst_pbf_display_information(cpu
> > > , outf,
> > >                                                               tdp
> > > _level,
> > >                                                           &ctdp_l
> > > evel->pbf_info,
> > > -                                                             lev
> > > el + 1);
> > > +                                                             lev
> > > el + 2);
> > >                         continue;
> > >                 }
> > > 
> > > --
> > > 2.18.2
> > > 

