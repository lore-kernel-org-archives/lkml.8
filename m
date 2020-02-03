Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1FEC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D159E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580763894;
	bh=X5R2fPv88/MdUsacl6Ua7UxiCyEmXq1mVd+QfsPUcfk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vNpbBX2XHCB1GHjAdFaamww8KCW0PNWiYYQzFO6b20bR7FRMkvZMgHwh5LJLnSrxc
	 FEtWALgOCcRhuvImHlSHUEHaVicvTb/9u9BRgr1kHkFsiT92rwJt3Pe/rBy0MP4geC
	 Br5bd909KjTKCrgcc5Jc8wN84rC3SzvXQ5USH4eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBCVEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:04:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40650 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:04:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so6331134plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 13:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vyNNYPWQk9h02ZhB6qKtVaaQp9UclxRqVnPIxFZJ0Xg=;
        b=mIqS8qzHFI+s5woLN9YWR3D4KGS3todmG1mGvMlfrwG0O7Zvp5PBTCzdExV0OHamSv
         Eowm1AbjDBeeZMHqhE2YiGWBDjI3rRJYOy7mdAsaSinj0IOmSjXfBjQUTPz+JxJoOm08
         40GmMohHmDw71az8MMI/wcV5ib0aXdUrf9C1WJyBCPzxAtSYvBAu6NmNQc6/ODKh4rNo
         t87K6J4tDMkGpLy1glEayeV+KM1Udt8acljIAwYvKzGpEYVJMxlyOQxirwerbnEjz06c
         R9Y7cAUt1GLenF5+7pwkZRVutt3QqVlsr1fVMVdJ/hUNZfHQGJv0j88w+O4GKqFbDqvN
         bx3A==
X-Gm-Message-State: APjAAAXkDT3mPVHI/ij2fQiE2Ldx1StWfkGonQyysLVNk3w4zwravUWa
        zfsgCH/om+6j9ORsRwqikPQ=
X-Google-Smtp-Source: APXvYqxAc+JfYnIeiZ3l4QBGTk8ktRMRb0WhEJyp/cK6P4XpYNuXTMPbItEy0LRdFTU94m4K6dXnHQ==
X-Received: by 2002:a17:90b:243:: with SMTP id fz3mr1196684pjb.29.1580763892984;
        Mon, 03 Feb 2020 13:04:52 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3:1a15])
        by smtp.gmail.com with ESMTPSA id r28sm20736910pgk.39.2020.02.03.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:04:52 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:04:50 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.6-rc1
Message-ID: <20200203210450.GA25544@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request separates out variables that can be decrypted into
their own page anytime encryption can be enabled and fixes __percpu
annotations in asm-generic for sparse.

Thanks,
Dennis

The following changes since commit aedc0650f9135f3b92b39cbed1a8fe98d8088825:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2019-12-04 11:08:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.6

for you to fetch changes up to 264b0d2bee148073c117e7bbbde5be7125a53be1:

  percpu: Separate decrypted varaibles anytime encryption can be enabled (2020-01-31 11:15:59 -0800)

----------------------------------------------------------------
Erdem Aktas (1):
      percpu: Separate decrypted varaibles anytime encryption can be enabled

Luc Van Oostenryck (1):
      percpu: fix __percpu annotation in asm-generic

 include/asm-generic/percpu.h | 10 +++++-----
 include/linux/percpu-defs.h  |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index c2de013b2cf4..35e4a53b83e6 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -74,7 +74,7 @@ do {									\
 
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
 									\
 	*__p += val;							\
 	*__p;								\
@@ -82,7 +82,7 @@ do {									\
 
 #define raw_cpu_generic_xchg(pcp, nval)					\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
 	typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	*__p = nval;							\
@@ -91,7 +91,7 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
 	typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	if (__ret == (oval))						\
@@ -101,8 +101,8 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 ({									\
-	typeof(&(pcp1)) __p1 = raw_cpu_ptr(&(pcp1));			\
-	typeof(&(pcp2)) __p2 = raw_cpu_ptr(&(pcp2));			\
+	typeof(pcp1) *__p1 = raw_cpu_ptr(&(pcp1));			\
+	typeof(pcp2) *__p2 = raw_cpu_ptr(&(pcp2));			\
 	int __ret = 0;							\
 	if (*__p1 == (oval1) && *__p2  == (oval2)) {			\
 		*__p1 = nval1;						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index a6fabd865211..176bfbd52d97 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -175,8 +175,7 @@
  * Declaration/definition used for per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#if defined(CONFIG_VIRTUALIZATION) && defined(CONFIG_AMD_MEM_ENCRYPT)
-
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
 
