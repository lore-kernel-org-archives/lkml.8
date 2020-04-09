Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F37C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE1B20730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NjxzIf/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDIA1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:27:32 -0400
Received: from ozlabs.org ([203.11.71.1]:35731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgDIA1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:27:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 48yMRQ0WdXz9sSh; Thu,  9 Apr 2020 10:27:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1586392050; bh=PXWqFh1mTRtSfkLYqDCpfqsvhI4Y1xX85iXsAE9NlLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjxzIf/odfgyCxNtI8je4VE2dZ2Bzcz122kihpbHoAw/Ae2WQw2wa9wk7O+aYFVNn
         A/pmbHDporQyrH6Z09iBDfRcOoF9gE2q5nD2qofTLQjENjXdWq8ACrFs5CEnSFaLgb
         eXFkDf+H5DGMv0LXbg9ekVJym/ZQVOPzinKMiOq8HXJ5WlzZuSazi9wIACyerwj8aw
         Bq52rAudxqAmK8wbDOYyZH2UvCq5P3jTkvbL9bJYY6D4MRRBldrPwLCr+/BED1SkxV
         husjklN76TLvgkgYZRL8N9TAnvsgH58JzZqqLkKvRYJcOT6w7ShNKBJ2rjlpctCAzr
         qr7IsAxhKmEgA==
Date:   Thu, 9 Apr 2020 10:27:26 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, peterz@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/1] ppc/crash: Reset spinlocks during crash
Message-ID: <20200409002726.GA5135@blackberry>
References: <20200401000020.590447-1-leonardo@linux.ibm.com>
 <871rp6t9di.fsf@mpe.ellerman.id.au>
 <02e74be19534ab1db2f16a0c89ecb164e380c12a.camel@linux.ibm.com>
 <1585895551.7o9oa0ey62.astroid@bobo.none>
 <fb98f346a4d6a9d689ae64dae33cbd45d2f8b0df.camel@linux.ibm.com>
 <87v9majhh2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9majhh2.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:21:29PM +1000, Michael Ellerman wrote:
> 
> We should be able to just allocate the rtas_args on the stack, it's only
> ~80 odd bytes. And then we can use rtas_call_unlocked() which doesn't
> take the global lock.

Do we instantiate a 64-bit RTAS these days, or is it still 32-bit?
In the old days we had to make sure the RTAS argument buffer was
below the 4GB point.  If that's still necessary then perhaps putting
rtas_args inside the PACA would be the way to go.

Paul.
