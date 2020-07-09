Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75268C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DC22074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WydzTG9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgGIId2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgGIId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:33:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD227C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 01:33:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ch3so784008pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Em239ZuAPE3JLveEebWL4wI5B1YGKhUb+MumEq3w2Wg=;
        b=WydzTG9x/LsiCaECMuBiMO39LwIj0KNOMzvd9sQ17HMcErmiPP9L4MnrK0FyjPdGMm
         nPBYgFwLiaipvvNG742rksAaAG5a2lWcs+0KAbhOK+BS/EeXq81rqUQnmcuccc1gWU8u
         fhj6EsV/v7lDKvS2CJDm3uGDmOOLC+TCwmEXOlIfkHJ9RFgf5gulFstR65GSQsETNT7O
         0wcnlLbPO44RTZLlDDf6zpgUAj9hg2p8oinbQGNAYNM8aHau9uQ5BUEGTqXMjnT1Qqm+
         zWQ27qvGrrSjfatOhjzZlKUAyOJ3p/XVR9XfgdRqLHdYdgS723ihpG2tFQ0W219defcb
         FIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Em239ZuAPE3JLveEebWL4wI5B1YGKhUb+MumEq3w2Wg=;
        b=VrLnve0LDmXnHpwDwgKJZSGdFwov8ufVl/zbNBt/uInbev/7UgHsEZeEvUflEuPhkX
         lRb1JojGr5c22CTbOFuaqzm/aSKn8wNL2fhPckV2tqVI8WN1MviRImqBfha9RCq03/S7
         FBKRI+6sxEqNSzh6OU/S2hGVMkCZ0Muq4bVXYZ8EFkcd2WDufyL+uruTDMMvKMzfEan8
         CXufDlQmE4g+xtWMZ0ICTBX+1CzRdCQgPspP1naS5nirMHiuCGYOxL/qcNAw7P7TBUpW
         y0v0s2yUv1wggGRNhW2jAdQbiL3mYsCMJPLOgr3GePNNE6xpxoSEveyLX02YNoQBjejJ
         FxbQ==
X-Gm-Message-State: AOAM532uiJifsH5U1s76vxUzqg85A3lYnnczBbe4kQt+qC1o9SOiHF++
        HW7RpUD5eeHfQUDsDYul0dU=
X-Google-Smtp-Source: ABdhPJx1/PNZIBJLRPe5BfqVCbVqL7U7YO0ZdoOiGJ9vvQ83LBHFATG8SEFnbwpHc+2Ho6M2yKwKLA==
X-Received: by 2002:a17:902:c408:: with SMTP id k8mr54921087plk.279.1594283606219;
        Thu, 09 Jul 2020 01:33:26 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id nl8sm1915963pjb.13.2020.07.09.01.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 01:33:25 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 9 Jul 2020 17:33:23 +0900
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
Message-ID: <20200709083323.GA572@jagdpanzerIV.localdomain>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709071411.GR3874@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/09 15:14), kernel test robot wrote:
[..]

Took me a while to find the FAIL-ed test:

> kmsg01.c:393: INFO: TEST: read returns EPIPE when messages get overwritten
> kmsg01.c:398: INFO: first seqno: 0
> kmsg01.c:411: INFO: first seqno now: 881
> kmsg01.c:425: FAIL: read returned: 77: SUCCESS (0)

So this is seq number related
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/logging/kmsg/kmsg01.c#L383

LTP writes a gazillion (roughly, maybe a bit less than that)
filler messages to /dev/kmsg in order to cause logbuf overlap:
...
19490 [  172.301584] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
19491 [  172.308730] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
19492 [  172.313852] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
19493 [  172.320988] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
19494 [  172.325618] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
...

	-ss
