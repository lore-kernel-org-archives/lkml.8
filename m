Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22546C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E96206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6EHQhR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgDFM7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:59:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42137 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgDFM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:59:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so14498154ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=klGEPOVDqn0bHzD1zMNsz5U+EKZKtsRBPVdGZkiUwzY=;
        b=L6EHQhR08UEDQVjIcRRQqpRuNU0ry8dFIxvNdiDx7xDskMUUR9Qij89a7fsB9R8P7c
         FNLySfsbN7kjbhIjoqxCQWkff9+tSezheTYzLGoyTc787WJvfO+zq7beUB8jcvIH6jtD
         b/Ju9d6IirvKLABMqN28hvLqxmmZdPdpKaNPzQ3C3eJsEsnsW3V/ny/DdlLq1ng9y9ME
         yxKZpt2sX44AEk3GjalOij6sT1SjoyhFTCz6zy+znvugFEM7l2xN7kQOlhM6PM3zQbfe
         WSd9k6Y/u0ADE004ob5NJ7j/qxLxw13ans4dEp/rcslIJkU5nXjdZdGI0H6f0fTc6Em4
         GZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=klGEPOVDqn0bHzD1zMNsz5U+EKZKtsRBPVdGZkiUwzY=;
        b=Mgs6Qmspqv8/awo01CBwyxnJflEo88HrPXAlAFVcZZY71sjrZIbd+mMgIZM/FTK4GG
         PAZoaFSDX550fh+5wMGsmC1BhPaPuBKT5Vh/MQ49ThPuCMz1Ip6dx++LBnFmwTfQ9F7t
         3HRPDyjyOi2TiKQ9dC5EFtA3taNXCtqxDbya8klmAw08yHkGFPu05GnlYj4Wwop6RNi3
         CwKmQNw9XDi8L1VtSpT2R+zcshdu0bv2GGN+rCOx2XVTHnOAGYAFtevq+/FHN/AILQEZ
         ROtXNkK+sY3ng4rbkMda8a66zZ98KkEAawRdkZx+3KW6HiEzKjwa8CUNafAM5xC8km7T
         TI/Q==
X-Gm-Message-State: AGi0PuaO8nXRJrCCaK9xO+lIvZUjCkiXRGyjxdtbuSEDtVpB24uoV6fF
        fUS4TBsOXovBl7GdWrRDROLQP6ZA4h4=
X-Google-Smtp-Source: APiQypIyvIV73lkHcnEsV82UaxQt9zdT0TXyQVEzlvxTzFOiCLsas0M8KBVZfMWG1nuc63LkYNeQXg==
X-Received: by 2002:a2e:9616:: with SMTP id v22mr11512135ljh.107.1586177976108;
        Mon, 06 Apr 2020 05:59:36 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id t24sm8822318lfk.90.2020.04.06.05.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 05:59:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 6 Apr 2020 14:59:28 +0200
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        jroedel@suse.de, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200406125928.GA23653@pc636>
References: <D25C4027-6EF9-44C2-AD4D-DDC785288B9A@oracle.com>
 <20200404185229.GA424@pc636>
 <EEB53CBF-0B3F-43E0-94F6-B001918BAC3E@oracle.com>
 <20200405172315.GA8404@pc636>
 <20200405192108.GA9429@pc636>
 <65663E36-DC60-4E6E-B6C6-3A0F6852543D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65663E36-DC60-4E6E-B6C6-3A0F6852543D@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 02:49:13PM -0600, William Kucharski wrote:
> That's fine.
> 
> One could still argue size should be sanitized earlier when start and end
> are, but it's a nit either way (though size is used before it's checked,
> it's not in any way that could fail with bad results.)
> 
Agree. Therefore i do not have a strong opinion here, so it
basically depends on how to look at it :)

--
Vlad Rezki
