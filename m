Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3862CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CA52076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596452989;
	bh=jzoG+X808HKaxfTqiQu6cTzQQVyPCM9vUIF/5Dzn0h0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ClMUuyFnogOBNsxCdLY149INcNdoziQR24ERlmoDpzD4HAAq905vX5usA9LXFnizv
	 qF4f23/vcKOHzKW1kKgn15o9naVGdcCkQJIeMyeOhpzHXZuSHrNLn3WxvhMeYDUHJ1
	 +EdkZdtHuu/NfjFjLPv5V+/X/urlbWOPjAZD42JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHCLJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:09:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03381C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:09:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id kq25so25220699ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lyCQPS6rIciQHzv33YDXzJSVo+NAl3dBoSt9Shzilh4=;
        b=deTSJixnDGI6Lt7b07n+Qo8HXr8dZumY0lcMAbJkkjBz+vgGAS7umneUGvlmH5fe1j
         oBk6AKugKhHNZZvn6fdLv+4tkcxn2WrLKqcfEsShrQax9tyTTzJEd9474j0d3H2ZqTcg
         EQhsOEucLaMyt5YzkYWs5eXVU9ziqnNQeFH5sgzfhTrbE39v3eBnO/qfShXkBdVAZdvH
         vDuJFqZf+gBLHr+f0taNm9Qgg88fk3JKWJ7Pn6tMfOZMq3tKneEbOJi7uuEoFl72yEpc
         TY9I62+1mSZFLyWG5TsVr1ZW51NEuPNv6NiffwO2nzzEbdL9FbRqDRvpL3YJseHuU4NX
         aOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=lyCQPS6rIciQHzv33YDXzJSVo+NAl3dBoSt9Shzilh4=;
        b=DhKuS4Qf65wqU887LXtp1UIn79dLtld9ntz6ZgRA1i1za7dBip9fM2Z0HYM9+5s/vv
         Bla7/ClhbQjnGkLKk6UBzcvJMepyY0WvcTtmHUcoTR9EC09uuFq5ZuKsfEitpp5+S2uH
         VZmB85qXIOLD8gyUdO9l2hizHdF4JATobvkHR8eWC2JVPUPZGg/tZn6e+HppS567gImB
         +mp1PYO07vOvo/B41tpbWWceukETj0N2uS3QdT5QN4GYbWEhggFAf/znFMAkDo80WXlV
         2EE9Xd4VeDq4ihq0zVprhudSdH3+EXH9K6B5ugphIiJuqOj0sPyPDv5k5CZ13c0Pc4L3
         8FIg==
X-Gm-Message-State: AOAM533OfcL/Qra9FcaPECRf9mfpZoUarZtH95oNGKFg6XY3rBG2WVb7
        GD5LSyCfpcvcFfjISxCqNzg=
X-Google-Smtp-Source: ABdhPJyfopSBZ5s1a39P98oJ46NowByttlUd/1Aite0LdEv7KvPLTSTLtb3ncqsfts23uduY291RGQ==
X-Received: by 2002:a17:906:7798:: with SMTP id s24mr15856628ejm.45.1596452986804;
        Mon, 03 Aug 2020 04:09:46 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g23sm15410713ejb.24.2020.08.03.04.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:09:46 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:09:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/debugobjects change for v5.9
Message-ID: <20200803110944.GA258423@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/debugobjects git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2020-08-03

   # HEAD: 0f85c4805184765ff35e0079b3241ee8f25d1b2b debugobjects: Convert to DEFINE_SHOW_ATTRIBUTE

A single commit which simplifies a debugfs attribute definition.

Note that depending on merge window order, there might be a conflict 
with the following pending -next commit in the set_fs tree:

  4d4901c6d748 ("seq_file: switch over direct seq_read method calls to seq_read_iter")

The correct resolution is I believe to discard the lib/debugobjects.c 
change from 4d4901c6d748, which got mooted by the cleanup in 
0f85c480518.

 Thanks,

	Ingo

------------------>
Qinglang Miao (1):
      debugobjects: Convert to DEFINE_SHOW_ATTRIBUTE


 lib/debugobjects.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)
