Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D27C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F102145D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="gENt8TWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDSJop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 05:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgDSJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:44:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 02:44:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f13so8222025wrm.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=t1mUlJFBauJJoQI/4DdFu/qGHWg9ioYSq6sgs7YFWqs=;
        b=gENt8TWr1gdMLI6Tzc/z7QWwbdUWe9XNvTThzpSqOPygNthR0tc6mz1QytQ8M9p1aV
         +ZyIqdX3OFL5dsKkJgunv9riMFmDXdwUZhI8CQTgPesEi9Qj1keG6cRnL/uQxvhMWvjN
         oe8yA6GOev1LXrLwPV8dVP2EueVSKjHRkCF3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=t1mUlJFBauJJoQI/4DdFu/qGHWg9ioYSq6sgs7YFWqs=;
        b=ir4oslWtaCPcH5kfvPFGXaXbMMLf0k5fVvDmVdhhNKoaz0SX1RWjSS4vfHQ2F8xRvX
         4QHOEB4Yh+Ht9SGWpoPVnHKVxEf8UJsjT1R6US57LhYiBQ3a7KDPpF4jXkekh+192ODw
         JGXllDdjcaZ4VKyrg810vM0fgEVLgm8WaEZ4X8qJOFVgh36XVfucLRTxtpciD8eoMiaT
         0LxWsJQsnG+FEMRcTlH+/tgg5/do7PnNVePhJi0ZlS9GsdrCYp7bInNPr++CkgeDOs3B
         oMpENnPaLS8hnxDp3Ldp0VnZ4B/K7raBn0sbgoPj9fV3vaOpdALVZ18eRJIBlhgQEPPB
         7pcQ==
X-Gm-Message-State: AGi0Puax/4zUJvOSv3J4VOxQ6zJk0/ZiVgJD5MKkqeSU+/p7eBYzNMM1
        eki6As4Ow/yiN/HYkOG+AhaXW4qvRd0=
X-Google-Smtp-Source: APiQypJZUzeM3Iq2L+CGJWu+padO59JXwKeyNMKLc8UH8a3p7C0kY/xW5GknHRaMQ4PMqP/loQYq+g==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr12435117wru.376.1587289482742;
        Sun, 19 Apr 2020 02:44:42 -0700 (PDT)
Received: from carbon ([94.26.108.4])
        by smtp.gmail.com with ESMTPSA id h13sm27678202wrs.22.2020.04.19.02.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 02:44:42 -0700 (PDT)
Date:   Sun, 19 Apr 2020 12:44:39 +0300
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] WRITE_ONCE_INC() and friends
Message-ID: <20200419094439.GA32841@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Paul,

Recently I started reading up on KCSAN and at some point I ran into stuff like:

WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);

Some of these are a bit eye-watering for me and could easily be converted to:

WRITE_ONCE_INC(ssp->srcu_lock_nesting[idx]);
WRITE_ONCE_INC(p->mm->numa_scan_seq);

where the above macro could be either: 

#define	WRITE_ONCE_INC(x)	WRITE_ONCE(x, READ_ONCE(x) + 1)

or the more relaxed version:

#define	WRITE_ONCE_INC(x)	WRITE_ONCE(x, x + 1)

I personally like the stronger version better as a) it doesn't seem to increase 
code size (relative to the relaxed one), and b) should be less prone to load 
tearing, etc.  Given the growing popularity of KCSAN I expect a lot of 
concurrent code soon will get the READ_ONCE/WRITE_ONCE conversion.

If you think the above makes sense we could also do this:

#define	WRITE_ONCE_DEC(x)	WRITE_ONCE(x, READ_ONCE(x) - 1)
#define	WRITE_ONCE_ADD(x, v)	WRITE_ONCE(x, READ_ONCE(x) + v)
#define	WRITE_ONCE_SUB(x, v)	WRITE_ONCE(x, READ_ONCE(x) - v)


cheers,
Petko
