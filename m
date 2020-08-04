Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3417FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1E2206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHDRyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:54:05 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:49980 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbgHDRyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:54:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A98CE181D303C;
        Tue,  4 Aug 2020 17:54:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: army50_54005e126fa8
X-Filterd-Recvd-Size: 1724
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue,  4 Aug 2020 17:54:01 +0000 (UTC)
Message-ID: <ce2ec5ce170b17a902074d111b28f8e924553a87.camel@perches.com>
Subject: Re: False positive in checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     "Kumar K, Anil" <anil.kumar.k@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 04 Aug 2020 10:54:00 -0700
In-Reply-To: <MWHPR11MB1712232275EA75228B5069FECE4A0@MWHPR11MB1712.namprd11.prod.outlook.com>
References: <MWHPR11MB1712232275EA75228B5069FECE4A0@MWHPR11MB1712.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-04 at 17:44 +0000, Kumar K, Anil wrote:
> Hi Joe,

Hello.

Please always cc linux-kernel@vger.kernel.org

> I noticed a false positive while executing checkpatch.pl. Checkpatch
> identifies the * as multiplication I guess. I saw there was some
> discussion about this before. Was there a workaround/fix for this ?
> Can u please share if so. Thanks for your time
> 
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #8195: FILE: src/soc/intel/abc/include/soc/romstage.h:21:
> +void mainboard_memory_init_params(FSPM_UPD *mupd);

Basically, avoid typedefs.

Either have the typedef available for checkpatch in the same
file or don't use typedefs at all.

If your project has multiple typedefs and these messages
annoy you, you could add --typedefsfile=<filepath> to the
checkpatch command line where <filepath> contains a
one entry per line list of the typedefs used.


