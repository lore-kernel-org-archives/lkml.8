Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE342072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="hnmvyk/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgETEgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgETEgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:36:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C6C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:36:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d10so867985pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z18eUcX9wumqAi1dZD97mqpztrpNBRW0eHw97u6ixxM=;
        b=hnmvyk/M83EsgHOqYGveBP5/xO9sKSMWadm584PNwZy+/Oph7HoRx8Ln2sEpjLU5qw
         xOWTiT2CEAUODRkg1aJNaUdrmEp3/fYLwuouPPQWxotBxYF6+pHp7Cvl3nkJxxLjT9JZ
         abO018U4u4MauIzN8h07kT81+XaoZl/+wOQAtMHPMqQ38OmBmBVRZCnDzPPl4vZxll9+
         urzIGK9Rx0rocxi/lsOK5HoPZbjGFO2mAyAhr8EvTdewc9sWCs6MgBNsfv2ZQT6/c4qk
         EEdgKI4X3/EtLJO7fnn/a/+meJ7+T5jaU8pNhnU02fr94zN+/I4ID5W6KR0y1fSmcawM
         sxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z18eUcX9wumqAi1dZD97mqpztrpNBRW0eHw97u6ixxM=;
        b=aeITk1zJsf3vuRMjPuzNdeaSDljdGh1nRg1sunpmKaGW7GtRYoFbFdEziWGb7E3uAl
         ZoySc0cLckecCeT5f+a1+y/GBMR/hJFpIfRUIxq+85fAvIfAnnPfIXiO55NkboBvBNlK
         hTAkGHl8tppo7P52i2zuAnBH8lMmuwft1WyTmEIWRiyodk8ddTEXSRcbU/YWuzpzrSiz
         n3jNuZjnZOwp8P+qFRj6Mo/M232jRWr0+joKoih4L26+/yjXrtgwFoKZyacylWeRBPne
         WsIlkQDqs7tA/KGme5aghPsp9Qcfarc5NUqAyAUt9PWPLvjREMUv/HqtICxL64yiVrjf
         injw==
X-Gm-Message-State: AOAM532+4vhZFoUOT4gnqoJBt/mAZKueJ4LPX+EvyTK0QPkhd634ApAp
        G8edzdEIAv50IsVD4igh74faew==
X-Google-Smtp-Source: ABdhPJwtRqanuNy5NN42n7ANp36PIBW5Zrc+UW5lghh91ZKUrjlYos3E7Sj4Rg2hzERL1tJEpETFaw==
X-Received: by 2002:a62:7996:: with SMTP id u144mr2368896pfc.86.1589949402274;
        Tue, 19 May 2020 21:36:42 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id y10sm876007pfb.53.2020.05.19.21.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 21:36:41 -0700 (PDT)
Date:   Tue, 19 May 2020 21:36:37 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>, tglx@linutronix.de,
        a.darwish@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, paulmck@kernel.org, bigeasy@linutronix.de,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 01/25] net: core: device_rename: Use rwsem instead of
 a seqcount
Message-ID: <20200519213637.4d874aad@hermes.lan>
In-Reply-To: <886041df-d889-3d88-59fe-e190d15f9c98@gmail.com>
References: <87v9kr5zt7.fsf@nanos.tec.linutronix.de>
        <20200519161141.5fbab730@hermes.lan>
        <87lfln5w61.fsf@nanos.tec.linutronix.de>
        <20200519.195722.1091264300612213554.davem@davemloft.net>
        <886041df-d889-3d88-59fe-e190d15f9c98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 20:18:19 -0700
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> On 5/19/20 7:57 PM, David Miller wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Date: Wed, 20 May 2020 01:42:30 +0200
> >   
> >> Stephen Hemminger <stephen@networkplumber.org> writes:  
> >>> On Wed, 20 May 2020 00:23:48 +0200
> >>> Thomas Gleixner <tglx@linutronix.de> wrote:  
> >>>> No. We did not. -ENOTESTCASE  
> >>>
> >>> Please try, it isn't that hard..
> >>>
> >>> # time for ((i=0;i<1000;i++)); do ip li add dev dummy$i type dummy; done
> >>>
> >>> real	0m17.002s
> >>> user	0m1.064s
> >>> sys	0m0.375s  
> >>
> >> And that solves the incorrectness of the current code in which way?  
> > 
> > You mentioned that there wasn't a test case, he gave you one to try.
> >   
> 
> I do not think this would ever use device rename, nor netdev_get_name()
> 
> None of this stuff is fast path really.
> 
> # time for ((i=1;i<1000;i++)); do ip li add dev dummy$i type dummy; done
> 
> real	0m1.127s
> user	0m0.270s
> sys	0m1.039s

Your right it is a weak test, and most of the overhead is in the syscall
and all netlink events that happen.

It does end up looking up the new name, so would exercise that.
Better test is to use %d syntax or create 1000 dummy's then rename every one.

This is more of a stress test
# for ((i=0;i<1000;i++)); do echo link add dev dummy%d type dummy; done | time ip -batch -
0.00user 0.29system 0:02.11elapsed 13%CPU (0avgtext+0avgdata 2544maxresident)k
0inputs+0outputs (0major+148minor)pagefaults 0swaps

# for ((i=999;i>=0;i--)); do echo link set dummy$i name dummy$((i+1)); done | time ip -batch -
0.00user 0.26system 0:54.98elapsed 0%CPU (0avgtext+0avgdata 2508maxresident)k
0inputs+0outputs (0major+145minor)pagefaults 0swaps

