Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86519C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C70A2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590390739;
	bh=scAufNHngs6hMKDnhDoO+JyczIcBZeQ6rMtO40TfZA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ysadVLNGEekn7QTFdiWXe1vSLI7oLdqF6Vf3+YqXiwUalz8IDW4L90yeRQ5K+k2vF
	 aupiZUFYTPhyYMEl23A2L/qP6RWdrmFBrevigAQK9GxkR0puwaPFThDAA+ayUegNqZ
	 pvda5qKLsBJ0G5s8/ouzRK6dT8W93WpX2PfhLavQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbgEYHMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388948AbgEYHMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:12:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:12:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so16043992wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fn7jsPduf8G4ei+X8yvmSUKSAYkXewq7MhOwTlmSBJ8=;
        b=nJosHoyyXnWigvAvdFNKQOilMWrx2svwfxuSBAp7G/ILHeu9E6VMK9bK0O+sDnvEHm
         +mp1LYkqDn234bxK+co0z/cjIRSNO6udA2tH5kYEp/3Qhq/ImSpEml7iF/bLzYEHuKSA
         lvRZgBlMuntdIXkVYirgj3NECVd8gCYwU0K/nAWUfjZhiQjEVY+T6E5Y0o+5qPw7g/wJ
         Gb9ldPrwYG/zGU627wRLKWNC1xcfanXpL72ODUoo+mEFKZo+hTYRScr1ShusZxc6fJUQ
         zF2DZljMCH4P/7sLoIPc/r44JV8aMppN8WFvtyI3U39T2hqdeH+4Cf1apOpFUrYHW1Ux
         N/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Fn7jsPduf8G4ei+X8yvmSUKSAYkXewq7MhOwTlmSBJ8=;
        b=StwrC5sj4dBiCVU4wBRs/ZvD8z0e5Hq5IPsTgjtAEHQIOpZu7BYvA35GcwoTbsaqn9
         m+ckZIQE4gwD08KXsPf6MzSTNxXF2FqaBxfI2EuVe/nlOm3fxe/sDp3Fie3uE2ccD13N
         RI4TtENSJVGdVtwI/Tu4iQAdhLU323jivlaWAXcNhikluc++d9qoF9OVXDxx6BdO17Sk
         zqlJDZ/im9JDflij3MQtOJbF/EHPI4skyqe1ojEocYkIPMsmmsjRJg+oF/EM1M8NFHYD
         PBkaWgghzL0toacbhM63JEUUHuyyO5XaON+6A2+z+IrJdsvaG5i5zGmcnUxa+CbIyz0V
         xqgw==
X-Gm-Message-State: AOAM5313yfIPuQ8doB42xWgPpCAmaXBuV/fv5Hdau55vJe0+tRgp/4+9
        DzjPG5rOuRoSVW0mAdjDwC4=
X-Google-Smtp-Source: ABdhPJwhGI/xMbk/2BNulD8aJsijOq1nHV91w+3VaCvhnHNnO//NBtkhohcVh709UNq9gRmUNBk00g==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr14994720wrd.394.1590390736571;
        Mon, 25 May 2020 00:12:16 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u130sm4047669wmg.32.2020.05.25.00.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 00:12:15 -0700 (PDT)
Date:   Mon, 25 May 2020 09:12:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/7] locking: Introduce local_lock()
Message-ID: <20200525071214.GC329373@gmail.com>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-2-bigeasy@linutronix.de>
 <20200525070139.GB329373@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525070139.GB329373@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> ( The other departure from spinlocks is that the 'spinlock_t' name, 
>   without underscores, while making the API names such as spin_lock() 
>   with an underscore, was a conscious didactic choice. Applying that 
>   principle to local locks gives us the spinlock_t-equivalent name of 
>   'locallock_t' - but the double 'l' reads a bit weirdly in this 
>   context. So I think using 'local_lock_t' as the data structure is 
>   probably the better approach. )

BTW., along this argument, I believe we should rename the local-lock 
header file from <linux/locallock.h> to <linux/local_lock.h>.

The reason for the <linux/spinlock.h> naming is that the main data 
structure is spinlock_t.

Having <linux/locallock.h> for 'struct local_lock' or 'local_lock_t' 
would introduce an idiosyncratic namespace quirk for no good reason.

Thanks,

	Ingo
