Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B87FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E749A20A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596474620;
	bh=psQoZG7gfYyUaYaL5DFsyS0p7kLlR8fQlIL0nypkhRc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uJxIEFDdjg0f2oVB3OxoMr5WitLlZFt5rcLQ2OBVioU0kBJ0ypwCxf70P2ubgm5OV
	 jxAQPkF/j8yJRFs5tbMnu+xUQHHCwNCzHTX6nwzUhdH+LxXr+7DqFrMWewNyxgwDW/
	 GUvaMshKU+iM6tKV0BDFue588b6vfEbjo8zd70IE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgHCRKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgHCRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:10:19 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA075C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 10:10:18 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c2so21920278edx.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=p8aNm8/mUnu/gAw4YakqSlQsP8fz+OgAX9rnZfk2QHs=;
        b=IkWdmV0W1WhiYNAm4LOFetr7ISYvCT2ZacolkcrEuWknI/WQV4vKmgQn6rSc0tWU/z
         cA7MIs7xzV4ul2pwJ5ZXdR2276Qr9ucm8i4e0GrtXHzpOy98aseD7/gB5Tu96VVC7oYX
         YzsXNE/v7uS4oK1AY6DVjSnDgxEsUDNQf+EwW/ATNlrUPdDWvHjd5utKs6OV/9sBk2ae
         orWsR3h1hh2RaXL0qakqhb4+Fx6/m8kUjmK8aGxCux6IMqYO0oNwfjTo28ecaFaG3GsM
         0asN4lNTdLwxTlwtXRMr3pruH//Pkft9yQDjqv/NKn2FNLKaGpx/NKyzctOA6oSlhmj7
         J1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=p8aNm8/mUnu/gAw4YakqSlQsP8fz+OgAX9rnZfk2QHs=;
        b=nyYV8MXGok4y2rTvTwh2PA7EK9FX2XsOJagCo6cnkEIYAAxIRKWT2Hqyv1sqJhqvGk
         meaGEwpKdiLfZ/Y3qpOPxUg+MZ9gEkhhZ4vtTwyNr5rUjFjUpdU0QrkBC3xYDWI4WZRv
         owm0Bxacu7mTWdNkI1dlcVrRy23ab9789WpNO8xnYNHWakQW9TSvrrbD0B+xWpjOggMs
         8RlZnK1Bn8HNmDoN3HNS8ZXkFNYkyMl3LvCFXI/NRf/Rkm2utd0hfcGGX8P0NFzGRLRI
         ozyOqJZBYanAYDgCrFO9L0A3Sq1PR5hNjFk/ckZmn9Zmq8m4+s6SCsJa9Vf0O6tp6d7i
         EQxg==
X-Gm-Message-State: AOAM533iW+kkM+Nop7+ck5V9lBEXWSE31mpk773S2ODbwwOLAGD083Du
        dCJS3a4LI5e1IFcC5XywQ3oGrn20
X-Google-Smtp-Source: ABdhPJwlCZEGtMOI3uNlooY1aDhZhkUEdCYlkWlInknqIFgq/RJCeziDs6AcDvWuNHD/nevJl5gs8w==
X-Received: by 2002:a05:6402:7d5:: with SMTP id u21mr16326443edy.235.1596474617622;
        Mon, 03 Aug 2020 10:10:17 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s2sm16511511ejd.17.2020.08.03.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:10:17 -0700 (PDT)
Date:   Mon, 3 Aug 2020 19:10:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/build changes for v5.9
Message-ID: <20200803171015.GA882680@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/build git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2020-08-03

   # HEAD: 1d0e12fd3a848199f973d42677cde423b76cafaf x86/defconfigs: Refresh defconfig files

Misc changes: refresh defconfigs and simplify the boot image link stage.

 Thanks,

	Ingo

------------------>
Arvind Sankar (1):
      x86/build: Move max-page-size option to LDFLAGS_vmlinux

Ingo Molnar (1):
      x86/defconfigs: Refresh defconfig files

Sedat Dilek (1):
      x86/defconfigs: Remove CONFIG_CRYPTO_AES_586 from i386_defconfig


 arch/x86/Makefile                 | 32 +++++++-------
 arch/x86/configs/i386_defconfig   | 92 +++++++++++++-------------------------
 arch/x86/configs/x86_64_defconfig | 93 +++++++++++++--------------------------
 3 files changed, 79 insertions(+), 138 deletions(-)
