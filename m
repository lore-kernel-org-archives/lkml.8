Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10079C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59FE24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgA1HqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:46:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:58075 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgA1HqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:46:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 23:46:14 -0800
X-IronPort-AV: E=Sophos;i="5.70,372,1574150400"; 
   d="scan'208";a="308519690"
Received: from vinayver-mobl1.gar.corp.intel.com ([10.252.174.80])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 23:46:09 -0800
Message-ID: <6eba5e502636ec8a0be279f48097c7137a95aa13.camel@linux.intel.com>
Subject: Re: [PATCH v2] admin guide/pm: Admin guide for Intel Uncore
 Frequency limits
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     andy@infradead.org, dvhart@infradead.org, lenb@kernel.org,
        andy@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org
Date:   Mon, 27 Jan 2020 23:46:02 -0800
In-Reply-To: <20200124100039.70116459@lwn.net>
References: <20200113040143.1419770-1-srinivas.pandruvada@linux.intel.com>
         <20200124100039.70116459@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-24 at 10:00 -0700, Jonathan Corbet wrote:
> On Sun, 12 Jan 2020 20:01:43 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > Added documentation for the attributes to control uncore frequency
> > selection.
> > 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> > v2:
> >  - Split the documentation patch to another patch to merge via
> > different
> >     tree
> 
> Which tree did you have in mind?  PM stuff tends to go through
> Rafael's
> tree, normally, which is fine.
Linux PM tree is fine. I will add necessary --to and --cc to my next
version of the patch with the suggested changes from you.

Thanks,
Srinivas

> 
> >  Documentation/admin-guide/pm/intel_uncore.rst | 23
> > +++++++++++++++++++
> >  .../admin-guide/pm/working-state.rst          |  1 +
> >  2 files changed, 24 insertions(+)
> >  create mode 100644 Documentation/admin-guide/pm/intel_uncore.rst
> > 
> > diff --git a/Documentation/admin-guide/pm/intel_uncore.rst
> > b/Documentation/admin-guide/pm/intel_uncore.rst
> > new file mode 100644
> > index 000000000000..d75be65fb16a
> > --- /dev/null
> > +++ b/Documentation/admin-guide/pm/intel_uncore.rst
> > @@ -0,0 +1,23 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=========================================================
> > +Intel® Uncore Frequency Selection
> 
> I would really like to avoid adding ® symbols throughout the docs.  I
> get
> grief for non-ASCII symbols that actually have a need to be there;
> this
> isn't one of those.  
> 
> > +=========================================================
> > +
> > +The uncore frequency in the Intel(R) hardware is selected based on
> > internal heuristics, which uses the current selected performance
> > state and various system power constraints. In majority of the
> > cases this selection is the most optimal, so there is no need for
> > placing external constraints from the Operating System.
> 
> I would say that this violates the 80-character limit by a character
> or
> two...  The entire patch has this problem.
> 
> > +
> > +But there are some customers who wants less jitters from dynamic
> > uncore frequency selection. For them, power saving is much lower
> > priority than consistent performance. Currently these customers
> > uses MSR 0x620, to place hard limits on the maximum and the minimum
> > uncore frequency. They can now use Linux sysfs to place these
> > limits and also have additional capability to place hard limits
> > under power constraint scenario.
> 
> less jitter (singular)
> 
> > +
> > +The Uncore frequency section attributes are present under
> > "/sys/devices/system/cpu/intel_uncore_frequency".
> > +The scope of these attributes is per die in multi-die systems or
> > package wide in non multi-die systems. There is a unique folder for
> > each die or package. For example:
> > +"package_00_die_00" for package 0 and die 0.
> 
> This may not render as you would like; use an RST literal block here.
> 
> Thanks,
> 
> jon
> 

