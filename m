Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F87422C9F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgGNSxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:53:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:12880 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730571AbgGNSw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:52:57 -0400
IronPort-SDR: 38F0vV1cM6SqScdKUC6l0ZafjIWp5B6L18+JTBbmsI7hdJMOjKC2n2I4G8Jf3JYlalnDUlSOAQ
 7HXtqf534dHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="149002058"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="149002058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 11:52:49 -0700
IronPort-SDR: a81X54LhkLa2IisbkBWZtq05E5qrWVUFll2OzsUdPfWyL252dJ2j5JxYp8KjGtGVt4PmeOvbRP
 e6iaiE8+19zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="317816694"
Received: from rrobinso-mobl.amr.corp.intel.com ([10.212.205.127])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jul 2020 11:52:47 -0700
Message-ID: <e33ebe71317b0a09ca40e97fb76ff57313c0444c.camel@linux.intel.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        tony.luck@intel.com, torvalds@linux-foundation.org, x86@kernel.org,
        kernel-team@fb.com, Matthew Garrett <matthewgarrett@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Date:   Tue, 14 Jul 2020 11:52:47 -0700
In-Reply-To: <20200714165621.GA3622@nazgul.tnic>
References: <20200615063837.GA14668@zn.tnic>
         <20200714121955.GA2080@chrisdown.name> <20200714154728.GA3101@nazgul.tnic>
         <20200714160448.GC2080@chrisdown.name> <20200714165621.GA3622@nazgul.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 18:56 +0200, Borislav Petkov wrote:
> On Tue, Jul 14, 2020 at 05:04:48PM +0100, Chris Down wrote:
> > Since the issue involves DPTF which is only supported via binary
> > blobs, I
> > can't say for certain what the issue is. As I understand it, when
> > the
> > throttling behaviour isn't explicitly configured by the OS kernel,
> > the
> > default policy is extremely overeager. Matthew also had a look at
> > it[0], but
> > I don't know if anything eventually happened there. I've cc'ed him.
> > 
> > Either way, again, this isn't really the point. :-) The point is
> > that there
> > _are_ currently widespread cases involving poking MSRs from
> > userspace,
> > however sacrilegious or ugly (which I agree with!), and while
> > people should
> > be told about that, it's excessive to have the potential to take up
> > 80% of
> > kmsg in the default configuration. It doesn't take thousands of
> > messages to
> > get the message across, that's what a custom printk ratelimit is
> > for.
> 
> Ok, feel free to suggest a fix, better yet send a patch. Otherwise,
> you'd have to wait for my vacation to end first. :-)
> 
> > 0: https://twitter.com/mjg59/status/1034132444201582596
> 
> As to the power issue, lemme CC some Intel folks I found in
> MAINTAINERS.
> 
> Intel folks, pls check the link above and upthread: Why TF do people
> need to use some luserspace daemon which pokes at MSRs which the
> kernel
> writes to too, in order to bypass some apparently too conservative
> throttling, AFAIU?
For issues related to thermal or power, we don't expect to poke MSRs
from user space by any daemon. We have sysfs interfaces for the
required controls. This is also true for controls via MMIO space.
Anytime if it is safe to add, we are adding controls via sysfs.

The tool in question from the link (not from Intel), when developed may
not have TCC or RAPL-MMIO controls via sysfs. We have sysfs interfaces
for a while. They can send email to me to justify other controls if
any.
 
Only time direct MSR access is required is for debug tools like
turbostat.

> 
> And why does this work on windoze reportedly?
This is not related to MSR or MMIO. This is related to some ACPI
tables. In Linux, thermald will adjust these knobs like Windows. It was
missing some ACPI details, which Matthew Garrett submitted patches to
kernel and getting merged with 5.8 series.

Thanks,
Srinivas


