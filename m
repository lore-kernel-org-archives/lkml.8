Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A043C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642B3206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591031230;
	bh=YFw6DeAF2hREKR3+3zIxAeFCIJZ0tPz69IwFaI+9Etc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gdrU3w1I4sacEWQ0ZuVFvWKuybCFPETzsa/mCO1NmVh4Hf+S/uqlcSgDu8DjX92kf
	 hTvZU4bb4/Tug6nBLp4xKs917ifMN8hIhFp2DvGsB7mxMlI3PfUfLQl+JisncUr7eg
	 sQ3eg9CVAn4BGNEErEM7GPYn/4oMBHLuzkdLvTvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgFARHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFARHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:07:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C57AC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:07:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so604458wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FrkiojZkE+9k8w9AXDydKI4hYGt7fAbhh7e7VnKidC0=;
        b=FVXDoBjIZuNfRbRkQy7hLhnF7i9mQRNDSRDpN1vJDlfLCYCZ3kYlvhV5ZoEj8WeTFn
         /H5AKOguAoBbcIoY4fmqjfzRaR9LTP1FuvdVEMftIv27aSonAUO0LZXa8OkMle92IPY5
         aTj7mMMzU9d0upiJ1Kqx+MFBYMVoPcmra0d/3e9ouv6w8R1amKMolZNTTBQsqnfjnSoH
         5XRtVvX2MVB7/jaueW9vN8yfQ+rGRUr0JMC1d3dPw4uQWnFl4SWe3VD2OH5vr9nt66C7
         W1YD8Wt3ijCFZQfhoVqBYLOl/YBWNjXERsD5jq0Zrheaf0wTC/xqMXXCxX+aii4KWlTu
         Nu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=FrkiojZkE+9k8w9AXDydKI4hYGt7fAbhh7e7VnKidC0=;
        b=iXHe0U+lnIVA1afkGS/Sukddhge7O8iUdV2U7coYJOigdXyMnkLt5HOJJBs3jNLkB+
         iVNy6DBU5RopE6fVjcgUJ9KCYExhjcs+/hlAmN9wUslH5BJ/6R7ewcKn7M1bgERlV9Pf
         WSLwEY02riIU8IqM3wa0bjmD4Xxqa4e0ZBfeRUv0ZrhxDvv4ESAUsyOD5kPbEkxUiIAy
         Ol+AM+fBeGiAXMl8DnNl3CofBKVXSc8oYD0otwpH0lIYURBbsmpFFtzjCxrYXyels0ml
         Ui0ibasRoDNMgCMlljfzrRRDKb2HVDx0N2JzYWw6Aep3kB/1HPYGryXH3M7kYILmvk9P
         yl5w==
X-Gm-Message-State: AOAM533ba/aA7C3Htv56HD6/TxhseBBbMXgbZXHb67vlBKbV1E0yr9Uc
        aUhkeqm9VmUgpmSYxC9/yPw=
X-Google-Smtp-Source: ABdhPJzherwN2K+XJMpaRkOJLU/XRH1uIqQ4xGuGHNHjN2xN4tnf9LWkaMOD1GugZahGwTUX11Be9Q==
X-Received: by 2002:adf:f988:: with SMTP id f8mr24388113wrr.81.1591031227092;
        Mon, 01 Jun 2020 10:07:07 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q13sm30823wrn.84.2020.06.01.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:07:06 -0700 (PDT)
Date:   Mon, 1 Jun 2020 19:07:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/vdso updates for v5.8
Message-ID: <20200601170704.GA1438757@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/vdso git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vdso-2020-06-01

   # HEAD: cd2f45b7514cdddabbf3f81a98a20ae02f99efa1 x86/vdso/Makefile: Add vobjs32

Clean up various aspects of the vDSO code, no change in
functionality intended.

 Thanks,

	Ingo

------------------>
Dmitry Safonov (3):
      x86/vdso/vdso2c: Correct error messages on file open
      x86/vdso/vdso2c: Convert iterators to unsigned
      x86/vdso/Makefile: Add vobjs32


 arch/x86/entry/vdso/Makefile | 15 +++++----------
 arch/x86/entry/vdso/vdso2c.c |  4 ++--
 arch/x86/entry/vdso/vdso2c.h | 16 +++++++---------
 3 files changed, 14 insertions(+), 21 deletions(-)
