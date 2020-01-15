Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7095C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC5724671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N9MbVpGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgAOQ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:26:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42551 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgAOQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:26:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so16244969qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BGhoOyu5VQ9UNwECtfExQGuAJzqWLNe3068aiRd3j68=;
        b=N9MbVpGjbi4k9kiTHfugxxCqckr+FEPgRaTd1X13kFFNn75b2OUvIFegFjnLjH4MET
         vYHvGAv/cOaMEmtOO8gVpi25xQTiXiYNaLyRqrx7nJ22WyoLjGEe9PnBvg0thLlOi5tN
         vLSwngsRsi6ngXhfvRJQMXOtScF1i499fQboIHbYUwdCcRHcrovwlqPNkoF8l5B8C6xk
         zwDNP+6+/F2wp5Ak918pWlHJF76FP6OC+sswqBL8ciBYxn0R5C/pVF4Y9JQCRnOJSIEw
         k+WkZdWPlT1Nlfh6HzUYA97cC9iZdhJFTeA66t2cEmmsVdLY6n3QrGD0L/KbrRmCllm/
         ehuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGhoOyu5VQ9UNwECtfExQGuAJzqWLNe3068aiRd3j68=;
        b=Asw9vTmvC1XSm08FUnX+tvTd/NMQgFWmZhkmrvVlYaRa20Epcufh0lj57OtY0DOXxa
         RjJ1Nad5BRt93eZDOZE/Ppp7Urby0wPuqYejUn5fh82a4ghDemCwULRrWmw+bRgWflhm
         nEDqRgTQ9tAzUY2aA8aTW7kLhVF2RUy63BGgIbeN0ghqA2yhmthaPy3EfY+xD+xvwnP8
         5+KPY8q/O8TFAbcvTn6szCrfTLXF/n5BBaeKDHfCh1EEAhrgbZu7PGSXR1OSMjxCHZYT
         5jddID21rz3HzTtSJvRgUkkeUkSz3y+Abi6gOf4RSJ3RMnk0ou3XO8f50agnKiMcTUsl
         gMKA==
X-Gm-Message-State: APjAAAVcOM5uwkru6z9q7+fuH5m/WP26u2dJOFTFG5aN/73aA6B7g8SV
        BJSUEHM9O8+b/dW9ulEMEohvbQ==
X-Google-Smtp-Source: APXvYqxK3fXxJYK2OHY5fNbL0IWIdwQXnxlcW9LltTOQTnJ8odVy9pqrM8Tc37VCTRCWaseM/4cyKQ==
X-Received: by 2002:ac8:4657:: with SMTP id f23mr4369118qto.378.1579105614247;
        Wed, 15 Jan 2020 08:26:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z141sm8675109qkb.63.2020.01.15.08.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 08:26:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irlVN-0001qT-27; Wed, 15 Jan 2020 12:26:53 -0400
Date:   Wed, 15 Jan 2020 12:26:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200115162653.GC25201@ziepe.ca>
References: <20200114161225.309792-1-hch@lst.de>
 <20200114192700.GC22037@ziepe.ca>
 <20200115065614.GC21219@lst.de>
 <20200115132428.GA25201@ziepe.ca>
 <20200115153614.GA31296@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115153614.GA31296@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:36:14PM +0100, Christoph Hellwig wrote:

> synchronous and currently hack that up, so a version of the percpu_ref
> that actually waits for the other references to away like we hacked
> up various places seems to exactly suit your requirements.

Ah, yes, sounds like a similar goal, many cases I'm thinking about
also hack up a kref to trigger a completion to make it
synchronous.

Jason
