Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C21AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8B9207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596483345;
	bh=MxGoaTAtolmfHKz4zS7NCIftpCcbidZF08AQUmOu+t8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kh9wyuLuYqfKbEp6zpck9bDpam4/tg2/09Feyzc7UNHVkPK3CrEIMBO51+o2g6TQ9
	 4OxKTsyDmH5R0gXYPBGZiD5ElSkZITidGi0+gdCgql5C4E9PKvMepuqqzLnSrQ9GiY
	 Ou6UqGDOvzORDIgwZcrFfRwZjPN5KM9BmJpF/C/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHCTfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgHCTfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:35:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF216C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:35:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so18601708eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UEsnFDOziY/SSigbmemZue+bgzYjtXS6TKGZJuhtS0M=;
        b=c3ymGK1EIA+piK2yhfbf46E6AQhrP7ulZr7ALLwb90NrwIaKpk1LXqj1m+v6fJPYNI
         dhSTmmrWWotGkCaEOArtFUIiaEy0Z7DKW3vrEu32uR1ZgX5/+epblHUSLTGcegXxiCua
         H0wbHNy1uosqCvAVu6CLOnhj56MR7jen8jRLP5xfZy1qzEz2TS/MeEYJRLWOqpOVybDp
         txkvCfZamy6At8PkFC26m+I+UXS/vRHIvonGpO9I5cEox2CYfMJTdigo00cxkrFzcXeG
         F2tMhY4DwclmOjImBIxo5Z4o/6Ngtjr6gFqxvwEE7NZ4orG6Bczy4iaK4WQyVDXnEZDR
         jVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=UEsnFDOziY/SSigbmemZue+bgzYjtXS6TKGZJuhtS0M=;
        b=ELtBaOhca0qEmxckxeimYGTe1h0WaBwEW+3w1wapdgTHMxnYZnT8ifM33NoXF08T2F
         60/em9VZYImUAwylr5t7HpPUKRKDcqWQvxGZ68ZKByo4dJNOsUQBzvBt9AfxM0l82jZe
         lsmW1Kd+PdwNS/+V/flEv459L32V4M6zD1bdUoGgjc2ESlz86UvdUf5/TiN0ZQEgXCzM
         LsQWyFilEw+Hj2dsgGGd8kMjoy43RH6Jp08N/ALSGmKQ7PCwtt59hA6bZkPT0NmrGEAH
         M0Pvgi0NWE6qw8N5NKwMEE5FS0QHXUmL9gQfR8oj1gvpF8Ap7JPA1vR+Mkr6kBKg62Qn
         v2tQ==
X-Gm-Message-State: AOAM530Eb2Uu/aFGdGkdJIC2nAv4wdV1+o2lFQcNoTaqGIlRWZ/+TxsH
        u9Z+4NZFTG8wwUB6G46WExc=
X-Google-Smtp-Source: ABdhPJyxIvwWnM/3rGv7HWBgGbBREBrVOK2PfPeVBiWnw2y4ltG9QTPHZ+roYFJBH3k8KaqabsAHSA==
X-Received: by 2002:a50:d1d8:: with SMTP id i24mr17816425edg.341.1596483342125;
        Mon, 03 Aug 2020 12:35:42 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n11sm16546091edv.39.2020.08.03.12.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:35:41 -0700 (PDT)
Date:   Mon, 3 Aug 2020 21:35:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/timers change for v5.9
Message-ID: <20200803193539.GA1411343@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/timers git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2020-08-03

   # HEAD: 898ec52d2ba05915aaedcdb21bff2e944c883cb8 x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()

A single commit which sets the X86_FEATURE_TSC_KNOWN_FREQ flag for Xen guests,
to avoid recalibration.

 Thanks,

	Ingo

------------------>
Hayato Ohhashi (1):
      x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()


 arch/x86/xen/time.c | 1 +
 1 file changed, 1 insertion(+)

