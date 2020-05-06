Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D677C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB592082E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgEFVhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:37:04 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:7880 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730006AbgEFVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:37:03 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046LIan2005458;
        Wed, 6 May 2020 21:36:52 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 30uqe0xcj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 21:36:52 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id DCA2F68;
        Wed,  6 May 2020 21:36:51 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 208B548;
        Wed,  6 May 2020 21:36:51 +0000 (UTC)
Date:   Wed, 6 May 2020 16:36:50 -0500
From:   Russ Anderson <rja@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dimitri Sivanich <sivanich@hpe.com>,
        Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: Re: x86/uv cleanups
Message-ID: <20200506213650.dva5xnq4oplxzn2o@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20200504171527.2845224-1-hch@lst.de>
 <20200505153944.GD2297@hpe.com>
 <87sggenfdr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sggenfdr.fsf@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-06_09:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=2 spamscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 01:14:40AM +0200, Thomas Gleixner wrote:
> Dimitri Sivanich <sivanich@hpe.com> writes:
> > Yes, we do see a need to clean up old code where it exists, but we would like
> > to assume this responsibility ourselves in order to ensure functional continuity
> > with externally available open-sourced modules that our customers rely on.  This
> > code supports current Superdome Flex systems, as well as forthcoming platforms
> > based on Intel Cooper Lake and Sapphire Rapids processors.  Some cleanup is
> > already being included as part of a forthcoming patchset in support of the
> > upcoming Sapphire Rapids platform.
> 
> That's a completely bogus argument.
> 
>  1) You could have cleaned up that code long ago
> 
>  2) The rule for code which is unused in the mainline kernel is that it
>     can be removed during spring cleaning unless there is a compelling
>     reason. I can't see one here.
> 
>  3) Out of tree modules are not supported independent of the license.
>     It's not our problem that you have code out of tree which you could
>     have upstreamed long ago.
> 
> Look at the history of platform/uv code. All we see from you guys is:
> 
>  - Drops of adding support for new platforms
> 
>  - Occasional fixes when we managed to break UV or you found some bug in
>    your precious code.
> 
> > Nacked-by: Dimitri Sivanich <sivanich@hpe.com>
> 
> I'm happy to add that tag when merging this cleanup.
> 
> Thanks,
> 
>         tglx

Thomas (and all)

Sorry.  We do need to do better.

In addition to Christoph's patches, we will soon be submitting
additional clean up patches.  Mike Travis is working on a patch
to remove old SGI UV1 code.  Dimitri Sivanich is working on a
sgi_rtc cleanup patch.  We are looking at additional cleanup
that should have been done previously.

Steve Wahl will be involved on an ongoing basis, so
you will see more from us.

Thanks.
-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
