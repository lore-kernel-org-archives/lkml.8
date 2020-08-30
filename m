Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BE5C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 01:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EA62076D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 01:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgH3BXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 21:23:19 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:34334 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728246AbgH3BXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:23:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 327F61802926E;
        Sun, 30 Aug 2020 01:23:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: alley64_00118ba27083
X-Filterd-Recvd-Size: 2815
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Aug 2020 01:23:14 +0000 (UTC)
Message-ID: <fbc74484451e2ef75fbb65665186035301550a1b.camel@perches.com>
Subject: Re: [PATCH RFC 0/2] simple sysfs wrappers for single values
From:   Joe Perches <joe@perches.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nayna Jain <nayna@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Aug 2020 18:23:13 -0700
In-Reply-To: <81c3499a5a09a82ddb4f3aa2bd9bfde1c0192b9e.camel@perches.com>
References: <20200829233720.42640-1-alex.dewar90@gmail.com>
         <81c3499a5a09a82ddb4f3aa2bd9bfde1c0192b9e.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 17:28 -0700, Joe Perches wrote:
> On Sun, 2020-08-30 at 00:37 +0100, Alex Dewar wrote:
> > Hi all,
> > 
> > I've noticed there seems to have been a fair amount of discussion around
> > the subject of possible helper methods for use in the context of sysfs
> > show methods (which I haven't had a chance to go through in detail yet
> > -- sorry!), so I thought I'd send out a couple of patches I've been
> > working on for this, in case it's of any interest to anyone.
> 
> If you really want to do this, I suggest you get use
> wrappers like sysfs_emit_string, sysfs_emit_int, sysfs_emit_u64
> though I don't see _that_ much value.

Just fyi:

the treewide converted sysfs_emit uses
end up with these integer outputs:

$ git grep -P -oh 'sysfs_emit\(buf, "%\d*[luixd]*\\n"' | \
  sort | uniq -c | sort -rn
   1482 sysfs_emit(buf, "%d\n"
    549 sysfs_emit(buf, "%u\n"
    118 sysfs_emit(buf, "%ld\n"
    100 sysfs_emit(buf, "%lu\n"
     78 sysfs_emit(buf, "%llu\n"
     62 sysfs_emit(buf, "%i\n"
     47 sysfs_emit(buf, "%x\n"
     24 sysfs_emit(buf, "%lld\n"
     12 sysfs_emit(buf, "%llx\n"
     12 sysfs_emit(buf, "%08x\n"
     12 sysfs_emit(buf, "%02x\n"
     10 sysfs_emit(buf, "%016llx\n"
      8 sysfs_emit(buf, "%04x\n"
      6 sysfs_emit(buf, "%lx\n"
      5 sysfs_emit(buf, "%02d\n"
      4 sysfs_emit(buf, "%04d\n"
      2 sysfs_emit(buf, "%08lx\n"
      1 sysfs_emit(buf, "%li\n"
      1 sysfs_emit(buf, "%4x\n"
      1 sysfs_emit(buf, "%0x\n"
      1 sysfs_emit(buf, "%06x\n"
      1 sysfs_emit(buf, "%03x\n"
      1 sysfs_emit(buf, "%01x\n"
> 

