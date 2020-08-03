Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5849C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B254020719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qta2F5Ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHCK2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCK2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:28:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788CEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 03:28:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q76so13715851wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=wera6Uyhs3n9BVFUTcfSgmx3CiTiA8VGTYm4K/HGON4=;
        b=qta2F5YaeaL2dux1TY+QhrovZpd/nWVLNVeS04xtI6jnMOfLmla5kIafRXyh/sSG6C
         pr5C2DoZpVun3tRT4Cinin+ZL0afuonyNIKwfiR8RyVHH6J1GnRFS/4UfW6pRWOlkcwl
         eHl7+LbZiB6KFOwMlHH1TeIktM//2Jes/S9xvYeUj4NifPV078j3vHFgZoB9djsIu2xi
         d5DV8s3Cg1b1rj7pZZBfvHFLQZEQ5BkE8UKC2DTMipP7ASH8MO65tByQierjrq/kY4YT
         mE3fGnzsmFbjnBZYrnueYdgcdDHnAkMkKnqzYSAr7s8AIW5PM0TqMYVTLAMxtJ7NYN18
         8kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=wera6Uyhs3n9BVFUTcfSgmx3CiTiA8VGTYm4K/HGON4=;
        b=hL957l7CihjffSXmtXJYGLTJx9YtztdMT97P44xwNiqJLY+8lEX5xBGbZlsQvzQY9o
         8aPGg/R3l9DXgXGCvxYm//2yAWs0iyIwWUNCGwE+46OsJDAub11RPQIwYAO9GCRSrBRs
         ocd4RRoBg5r+CkCrLPR5/omUX06pL+JFXHUSUaskb5ILt978lxUMO2CUGPoLays1T4hb
         MfszAr4/wbZQvWz3ChGpsO3dDxKuybkw6nj70s+vtoLNh0C9ugdqRAFvW82EnaXN4IAD
         nzgv8jugfucegTkkMTy8KLCM+zlWCTgUqJ5AT/1nHBzEuzai1cK/gcRgS77h3uzBbJDP
         CPEA==
X-Gm-Message-State: AOAM531aZAvg2v36HzXFP3avk5ys/msiiTil2j++GZjoRzpwNv34NpvP
        A0l50Wp1ogj9fIaVZtMNRw==
X-Google-Smtp-Source: ABdhPJx8zKQPgAW5VKuEDyJMQrOxHklxvIvV9/3EeTiVpYaWnzhOWKoG+1y34Lnw7dYHuEPuvzpxfA==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr14897074wmj.84.1596450486979;
        Mon, 03 Aug 2020 03:28:06 -0700 (PDT)
Received: from localhost.localdomain (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id g188sm26307154wma.5.2020.08.03.03.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 03:28:06 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules@gmail.com>
Date:   Mon, 3 Aug 2020 11:27:54 +0100 (BST)
X-X-Sender: jules@localhost
To:     peterz@infradead.org
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4/4] context_tracking: uninitialize static variables
In-Reply-To: <20200803093751.GD2674@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.23.451.2008031117370.72290@localhost>
References: <0/4> <20200801184603.310769-1-jbi.octave@gmail.com> <20200801184603.310769-5-jbi.octave@gmail.com> <20200803093751.GD2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Aug 2020, peterz@infradead.org wrote:
 
> So personally I prefer having the '= false' there. It used to be that
> compilers were stupid and would put any initialized static variable in
> .data, even if it was initialized with 0. But AFAIK compilers are no
> longer that stupid.
> 
Thanks for the reply, I completely understand the precaution measure.  
