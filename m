Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B11C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B6920709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589584063;
	bh=vz66ht54cMc3RYpWc41W0EyO97eRJNrUFQiUdZuTX8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dGjS1dXRvlQkplzh5XDNet1sTm6DEcGXzqzjkDQGroxx0w2DCrM9GlR1RkfTL6Jfw
	 A873/mwFt/xeEvGRpJbZHPdChUCxnI2vZ7RTHqz92wbcX166DSqfn1vIJ/iIAK/giR
	 Li9Is8MZSxpeM2ayfJGa1KowXueyjyH8TWDGiPts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgEOXHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 19:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOXHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 19:07:41 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54ACA205CB;
        Fri, 15 May 2020 23:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589584061;
        bh=vz66ht54cMc3RYpWc41W0EyO97eRJNrUFQiUdZuTX8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujca5DMsp5Ik4R1EtDjzKw0mhCv7WrtoYDRjqs8b0TI8lUUM8G7qPe/H4xd4N5O6X
         96zYkBHO3RrHizOqBG4L9Y1HqKjiW8woLZdB34jcoLQS4XbP2i6JwBmVx4oU3uajml
         koXsISBbdfq/IR/lpp7X5NoGZQxP5tTjFiiI+p9o=
Date:   Fri, 15 May 2020 19:07:40 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, hpa@zytor.com, dave.hansen@intel.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200515230740.GG29995@sasha-vm>
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <20200515175550.GP3538@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200515175550.GP3538@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 10:55:50AM -0700, Andi Kleen wrote:
>> Indeed, we've seen a few hacks that basically just enable FSGSBASE:
>>
>> - https://github.com/oscarlab/graphene-sgx-driver
>> - https://github.com/occlum/enable_rdfsbase
>>
>> And would very much like to get rid of them...
>
>These are insecure and open root holes without the patches
>used here.

It's sad that these hacks are being used alongside SGX on "secure"
systems.

-- 
Thanks,
Sasha
