Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB2CC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C621A22527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diyU7YTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgATSOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:14:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42145 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbgATSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:14:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so428051wro.9;
        Mon, 20 Jan 2020 10:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=pASj3PHz7/BmhyyPZk63EWRxJck53vekxxxhyP+qu28=;
        b=diyU7YTUUl14k4utEaRKx3JvG1pR3pE4U0+CX9/4He9byqa5qUL+aEJV5fD2CE8y3R
         nNjLWEUGgaa29WzFcAbk/sMRzl86c+xYJOk59m6pBUE75tGUO5iND1R+Ff05MwXZ5hmL
         KnbAwJ1bL2w9zxa8hNiU/Svw8I3a3DCKgjTTQNOmt5acuI6+gGS/8EBFEeQfLnzceGvQ
         B80gOcf4rczJJiutM5cdhZ0KtE1cxfoNBowqQy+2Q1TclujmU4VYiefdVOL5YdLQ93X+
         CmfBQIlyTFPbMlnNJtJ+ZSOx7qiCUW6neqtmDmqyujNJhX3Ls6dP+z4O5ZAdWesHGBx7
         2uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=pASj3PHz7/BmhyyPZk63EWRxJck53vekxxxhyP+qu28=;
        b=uMPGqEDGyZosI49+PelveMDuHKY6WZpl02kQk11LvaziT+JzHXg90FQfLyMjxCNGHW
         L4ergjEVL/q0nmiyab/lxqY3yx35eACOv1Gk9z8gUjCVKcJH/lIvUKavcZ45gN0le4SV
         WlAk3np1ujANugCp5bmd1Hg1SvTILUqzcGY8GuyCL1EmLkkrKhVe+LndD8VJJkL2u8cE
         glf0HIpJGdB+h3vWixhAC2lUKvARMwWmUlCXym7Q0JtonBWnTAA1M8rv4jmrDAfLSEcL
         5iGoqxKe5dFGoG8dq4GZXq6Wws8BkQiUEOjZ2PPOU0zohObBJw+Q4Ixt7K35M3whl35B
         JLNg==
X-Gm-Message-State: APjAAAWxMCQp2o0g4tpQyvjohZehkdgSGDqHwwDdR1hTgJ5oyiwwONVF
        04HliHCWm1qa9c1DMMdzcHA=
X-Google-Smtp-Source: APXvYqxEY2tx0CadRCPP17+yiUQwhYPkpud6UyNjhfjqJyCHb075vcZRf7OytV34VyJ1xdnLa2zAag==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr733279wrm.13.1579544090544;
        Mon, 20 Jan 2020 10:14:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:ec67:901a:8ee9:665d])
        by smtp.gmail.com with ESMTPSA id d14sm51909528wru.9.2020.01.20.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 10:14:49 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        brendan.d.gregg@gmail.com, corbet@lwn.net, mgorman@suse.de,
        dwmw@amazon.com, amit@kernel.org, rostedt@goodmis.org,
        sj38.park@gmail.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 0/8] Introduce Data Access MONitor (DAMON)
Date:   Mon, 20 Jan 2020 19:14:40 +0100
Message-Id: <20200120181440.7826-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120165551.codmosqc2pkcunpa@box> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 19:55:51 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Mon, Jan 20, 2020 at 05:27:49PM +0100, SeongJae Park wrote:
> > This patchset introduces a new kernel module for practical monitoring of
> > data accesses, namely DAMON.
> 
> Looks like it's not integrated with perf at all right? Why?
> Correlating measurements from different domains would help to see the
> bigger picture.

Right, it's not integrated with perf.  DAMON provides only its debugfs
interface.  Also I agree that correlating measurments will be helpful.  I do
not integrate DAMON with perf with this patchset for following reasons.

First of all, I think I have no deep understanding of perf, yet.  Partly for
the reason, I couldn't figure out the best way to integrate DAMON with perf.
Especially, I couldn't straightforwardly classify DAMON providing information
into one of the categories of the perf events I know.

Therefore, rather than integrating DAMON with perf in my arguable way and
increasing the complexity of the code, I decided to keep the interface as
simple and flexible as it can be for the first stage.  That said, I believe it
would be not too hard to integrate DAMON with perf in a future.


Thanks,
SeongJae Park

> 
> -- 
>  Kirill A. Shutemov
> 
> 
