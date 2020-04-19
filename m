Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BC1C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCB7206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="kipdzsx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDSSaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 14:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgDSSaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 14:30:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5128EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:30:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so9348618wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmcqOEObTFQdLOt2UGQJN9HJojqis9n0w6pP7bmFv/M=;
        b=kipdzsx0Tpo/fTLe0XupzLUeI/oipi7lAyUTe7Y9vl8IL3yRx3Kj4woQduhVdMCQ8P
         /tg8obAXM2Ht88W3vGlUrStq0nlnlr9RjSZmJlg5F0sXwdApOR3KjWvb71oGDb4VkOOK
         Viqg5ARaRMi/83TWN/42CotoZfmdWP7vP5HXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CmcqOEObTFQdLOt2UGQJN9HJojqis9n0w6pP7bmFv/M=;
        b=HiyK6JBVEO3uJEGPfTDZYByu++vMGiamTHgpX3x69rFbfAm3j0juEkBVl9+8bWEVQs
         hZvWF1GbXwsjRFhbmBKcrmf+yDdSneK2rPNmdMCONSFrf9OM4RaUbE0MJmI3NtcE90WQ
         ajObuv8cLCrEf6Xz5U+1VaxGttNBiVFIzKGZ8EzWH5cCzjb6pTaLhhG7EMCYKEfWju2B
         dGDsIBTNmagB+vcTCsogTJf2dHB3ZIZmlZPqbKzgHPvCt75wSJgpfRy0EitQw65z+oda
         GhcT8YYW3rbPvDm8EHlgDoi28PcPwpIGsn6iStp/DanUbV5kT3EWz1UN0iYGkA39tu9O
         4aRQ==
X-Gm-Message-State: AGi0Pua+qxjaIcn/KjdiJl29U+1Koh7fg8mUOBApiTCMZzA8MAXlL6h9
        LjUdMV5nVSoIvaGWwwe6nh3srQ==
X-Google-Smtp-Source: APiQypJUCpgC5BOa1Y09jmDB/FPNpQ5TJRCtCM/8UQHxZh5vD8G9VuH0qgXWHVr2dOKh1H5Up2X25w==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr15268746wrm.187.1587320999047;
        Sun, 19 Apr 2020 11:29:59 -0700 (PDT)
Received: from carbon ([94.26.108.4])
        by smtp.gmail.com with ESMTPSA id 5sm16653274wmg.34.2020.04.19.11.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 11:29:58 -0700 (PDT)
Date:   Sun, 19 Apr 2020 21:29:57 +0300
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] WRITE_ONCE_INC() and friends
Message-ID: <20200419182957.GA36919@carbon>
Mail-Followup-To: David Laight <David.Laight@ACULAB.COM>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200419094439.GA32841@carbon>
 <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-19 18:02:50, David Laight wrote:
> From: Petko Manolov
> > Sent: 19 April 2020 10:45
> > Recently I started reading up on KCSAN and at some point I ran into stuff like:
> > 
> > WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> > WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
> 
> If all the accesses use READ/WRITE_ONCE() why not just mark the structure 
> field 'volatile'?

This is a bit heavy.  I guess you've read this one: 

	https://lwn.net/Articles/233479/

And no, i am not sure all accesses are through READ/WRITE_ONCE().  If, for 
example, all others are from withing spin_lock/unlock pairs then we _may_ not 
need READ/WRITE_ONCE().

I merely proposed the _INC() variant for better readability.


		Petko
