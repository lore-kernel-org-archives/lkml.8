Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4414C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EBF20FC3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598972813;
	bh=LCDLVU8qJ08+iGKXvR5r+dlBm0nlk/9Y29X+1wE/JVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x1SHg52beUj4C0cbi6Mfh2SOxgKAnQwS3xCI05iyc4mmqmcC0ROjXq9AITZyGUdVj
	 549bMc1Vs2iHpl7rrU22qulU8SUuuEHrY67LK7eTBWlYIVY7yrePKMdSZG1XZu0Xzy
	 7+T7Zat48DPtpMIpvOkJStCZ0s8o+h7PkRtXhsOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgIAPGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbgIAPGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:06:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E80A20BED;
        Tue,  1 Sep 2020 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598972792;
        bh=LCDLVU8qJ08+iGKXvR5r+dlBm0nlk/9Y29X+1wE/JVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLK8Ef5foZZY9WpTlt3nC2+tsUSLEyQxiyf5H/RBoWYmwEO2QoYZ/eHVD2muJFJpg
         5WOKgM/vWtbB3NNEhXL/iQWnZVLCKyIAz1/MGSqIRO2Nv5dNEuM0cxu4VgqNBsowle
         Lvl53dXC9yzmzRRa6ukDJ4+J8VHvveL/geeqQAcQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A4AB540D3D; Tue,  1 Sep 2020 12:06:30 -0300 (-03)
Date:   Tue, 1 Sep 2020 12:06:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Al Grant <al.grant@foss.arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Message-ID: <20200901150630.GB1424523@kernel.org>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
 <20200901150225.GA1424523@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901150225.GA1424523@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 01, 2020 at 12:02:25PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 26, 2020 at 03:33:35PM +0100, Al Grant escreveu:
> > On 26/08/2020 15:26, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Aug 25, 2020 at 10:40:43AM -0700, Andi Kleen escreveu:
> > > > On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
> > > > > perf_event.h has macros that define the field offsets in the
> > > > > data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> > > > > were both 37. These are distinct fields, and the bitfield layout
> > > > > in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> > > > 
> > > > Looks good.
> > > > 
> > > > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > > > 
> > > > Probably should have a Fixes: header
> > > 
> > > Please do so, find the patch that introduced the error, add the Fixes
> > > tag, will help me not having to do it myself :-)
> > 
> > Fixes: 52839e653b562 ("perf tools: Add support for printing new mem_info
> > encodings")
> 
> Ok, I'll add that, thanks.
> 
> But you forgot to add your Signed-off-by:, can you please provide it?
> 
> There was also a minor problem in the patch, there was no separation of
> --- from the patch comment section to the patch itself, I'll fix that as
> well.

Also you mixed up tools/ with include/ things, the perf part of the
kernel is maintained by Ingo, PeterZ.

Peter, the patch is the one below, I'll collect the
tools/include/uapi/linux/perf_event.h bit as it fixes the tooling,
please consider taking the kernel part.

Thanks,

- Arnaldo

---

From:   Al Grant <al.grant@foss.arm.com>
Subject: [PATCH] perf: correct SNOOPX field offset
Message-ID: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
Date:   Mon, 24 Aug 2020 10:28:34 +0100

perf_event.h has macros that define the field offsets in the
data_src bitmask in perf records. The SNOOPX and REMOTE offsets
were both 37. These are distinct fields, and the bitfield layout
in perf_mem_data_src confirms that SNOOPX should be at offset 38.

Signed-off-by: Al Grant <al.grant@arm.com>

---

  include/uapi/linux/perf_event.h       | 2 +-
  tools/include/uapi/linux/perf_event.h | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

---

diff --git a/include/uapi/linux/perf_event.h 
b/include/uapi/linux/perf_event.h
index 077e7ee69e3d..3e5dcdd48a49 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {

  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
  /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT  37
+#define PERF_MEM_SNOOPX_SHIFT  38

  /* locked instruction */
  #define PERF_MEM_LOCK_NA       0x01 /* not available */
diff --git a/tools/include/uapi/linux/perf_event.h 
b/tools/include/uapi/linux/perf_event.h
index 077e7ee69e3d..3e5dcdd48a49 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {

  #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
  /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT  37
+#define PERF_MEM_SNOOPX_SHIFT  38

  /* locked instruction */
  #define PERF_MEM_LOCK_NA       0x01 /* not available */
